# Fog of War — dev tooling

The shipping Fog of War module currently lives **inlined inside Global.lua**
(between `-- Fog of War Module` and the closing `end` of `API_ToggleFogOfWar`)
rather than as a `require("Ship.FogOfWar")` module, because the iteration loop
during development was against the `TS_Save_19.json` file on disk instead of
through a mod-bundler pipeline.

Files here:

- `fog_inline.lua` — the current inlined fog block
  (build `fog-0.45-r2-filter`). Source of truth for the LuaScript section that
  gets spliced into save 19's `Global.lua`.

- `fog_splice_save.py` — reads `fog_inline.lua` (sibling file) and overwrites
  the `-- Fog of War Module ... function API_ToggleFogOfWar() ... end` block in
  `~/Library/Tabletop Simulator/Saves/TS_Save_19.json` with it. Backs the save
  up to `.fogbak` on first run. Usage:
  ```
  python3 tools/fog/fog_splice_save.py
  ```

- `spawn_placard.py` — spawns the rules placard, the `FOG OF WAR` toggle button,
  and the auto-spawned custom Crate marker into save 19. Idempotent — removes
  any prior auto-spawns first.

- `assets/rules-1MAY.png` — the rules image rendered on the placard. Loaded via
  GitHub raw URL so multiplayer clients can pull it without local-file warnings.

## Rules implemented (v0.45)

### Detection ranges
- **Standard**: enemy ship visible if any of that player's team ships is within
  **R3** (300mm) of it, base-to-base (closest-point).
- **Large / huge bases**: detection range **R4** (400mm) instead of R3.
- **Cloaked ships** (any ship with a Cloak token assigned): detection range
  drops to **R2** (200mm).

### Reveal sources (always visible to everyone)
- Active **target lock** on a ship → visible to the lock owner regardless of
  range or LOS.
- **Reveal tokens** assigned to a ship (or dropped within ~60mm of it):
  `Crate`, `Ancient Knowledge`, `Energy`. Once revealed the ship stays visible
  for the rest of that token's lifetime.

### Line of sight
- Any obstacle (`Obstacle` tag, or name containing `asteroid` / `debris` /
  `cloud` / `spare` / `cargo` / `chaff`) between the viewer and the target
  blocks visibility completely, even at R1.
- **Large / huge bases bypass LOS entirely** — they're seen through obstacles
  when within R4.
- **Vulture-class droid fighters and Hyena-class droid bombers** see through
  obstacles they overlap. One-way: enemies still cannot see the strut droid
  through that same obstacle. Detected via `LuaScriptState.shipData.shipId`
  containing `vulture` or `hyena`.

### Gas cloud concealment
- A ship whose base is **completely within R1** of a gas cloud is hidden from
  all enemies regardless of LOS, **unless** an enemy is also completely within
  R1 of that ship (close-combat exception).
- Large / huge bases are immune to gas concealment.

### Objective claim vision
- A player who has claimed an objective (the marker takes their player tint)
  gains **R1 vision** around it for their team. Detected via objective tint
  matching seat-color RGB; persisted on the objective via `claimedBy`.

### Vision partners (spectator sharing)
- **Purple sees what Red sees** (and vice versa).
- **Orange sees what Blue sees** (and vice versa).
- Applied as a post-pass on each ship's `hide_from`: if a partner color is
  seated and not in `hide_from`, its paired color is also removed.

### What gets hidden
- The ship itself via `setInvisibleTo`.
- The ship's name plate (matching the ship's hide list).
- **Phase 2 R3 sweep**: every object inside the playmat bounds is hidden from
  any seat color whose team has no ship within R3 of it.

### What is never hidden
- Ships (handled in Phase 1, not Phase 2).
- Objectives, `CenterObjective`, obstacles.
- Reveal tokens (Crate / Ancient Knowledge / Energy).
- Persistent ship-stat tokens (`Shield`, `Charge`, `Hull`, `Force`) detected
  via `__XW_TokenType`.
- Dials (already private face-down; the fog explicitly clears any prior hide
  on every assigned dial each tick).
- Structural containers and UI by tag (`Board`, `Deck`, `Card`, `Dice`, `Bag`,
  `Infinite`, `Stack`, `Tablet`, `Notecard`, `3DText`, `Tile`, `Scripting`,
  `Calculator`, plus tagged: `Layout`, `UI`, `Config`, `Controller`,
  `TempLayoutElement`, `ConfigCard`, `FogPlacard`, `DataPad`, `ScenarioCard`,
  `TokenBag`, `Saved`, `SavedObject`, `Spawner`, `DoNotHide`, `Global`,
  `Button`).
- Locked objects (typically fixtures).
- Anything outside the playmat bounds (`PlayerBoardEdge`-derived, recomputed
  every check so layout switches like Epic still fit).
- Spectators (Grey / Black / White) always see everything — TTS limitation,
  `setInvisibleTo` only applies to seated player colors.

### Movement
- The fog overrides `MoveModule.MoveShip` while enabled: pre-hides the moving
  ship from enemies *before* invoking the standard `setPositionSmooth`
  pipeline, so the destination-preview ghost doesn't leak the planned endpoint.
  Owner / teammates still see the smooth animation.
- Proxy ghosts spawned for boost / barrel-roll setup (objects tagged
  `ProxyInstance`) are hidden from all colors and parked at y=-500 so they
  don't leak adjustment intent.

### Triggers (event-driven, with one lightweight position poller)
- Toggle on → immediate synchronous fog check.
- `onObjectDropped` → schedule check for: ships, objectives, hideable tokens,
  reveal tokens, obstacles (also flushes the LOS cache).
- `onObjectSpawned` → if a hideable / cloak token spawns inside playmat
  bounds, hide it immediately against the parent ship's hide list.
- `onObjectDestroyed` → cloak removal, hideable / reveal token removal, and
  ship deletion all invalidate the classification scan and reschedule.
- `TokenModule.onObjectDestroyed` is wrapped to also reschedule when an
  assigned token (especially cloak) is destroyed.
- `API_AssignToken` is wrapped to immediately apply the parent ship's hide
  list to the freshly-assigned hideable token (only if the token sits inside
  playmat bounds).
- 0.5s **activity poller**: walks ship positions and managed-token positions;
  if anything moved, schedule a check. Catches scripted moves (dial /
  template) that don't fire `onObjectDropped`. Also polls objective tints to
  catch context-menu claim / unclaim.

## Performance notes

Key optimizations in 0.45:

- **Classification scan** (ships, objectives, obstacles, gas clouds, cloak
  tokens, hideable tokens, reveal-named objects) cached for 10s, invalidated
  on spawn/destroy events.
- **Persistent pairwise distance cache** keyed on ship positions — invalidated
  only when a ship moves more than ~0.1 IGU.
- **Persistent pairwise LOS cache** with the same keying. `Physics.cast` is the
  slowest single call in TTS by a wide margin. Cache is also flushed on every
  obstacle drop so moved asteroids force a re-cast.
- **Idle short-circuit** in `fog_check_impl`: if no ship has moved since last
  tick and a previous `_shipHide` exists and `_forceNext` is false, return
  early and skip both phases.
- **Phase 2** sweeps `getAllObjects()` once per check, but bounds-gates every
  object on its `getPosition()` first, so off-mat objects bail before any
  expensive name / tag inspection.
- The legacy `Wait.time(FogOfWar.fog_check, 0.3, -1)` in Global's init is a
  no-op (`fog_check` intentionally empty). All work runs through the activity
  poller + event handlers.
