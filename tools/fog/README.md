# Fog of War — dev tooling

The shipping Fog of War module currently lives **inlined inside Global.lua**
(between `-- Fog of War Module` and the closing `end` of `API_ToggleFogOfWar`)
rather than as a `require("Ship.FogOfWar")` module, because the iteration loop
during development was against the TS_Save_19.json file on disk instead of
through a mod-bundler pipeline.

Files here:

- `fog_inline.lua` — the current inlined fog block (build `fog-0.26-directpoll`).
  Drop-in replacement for the existing `-- Fog of War Module` section of
  Global.lua in save 19.

- `fog_splice_save.py` — reads `fog_inline.lua`, finds the `-- Fog of War
  Module ... function API_ToggleFogOfWar() ... end` block inside
  `~/Library/Tabletop Simulator/Saves/TS_Save_19.json`, and overwrites it with
  the new block. Makes a `.fogbak` on the first run. Usage:
  ```
  python3 tools/fog/fog_splice_save.py
  ```

## Rules implemented (v0.26)

**Visibility**
1. Ship visible to enemy if any of that player's team ships is within R4
   (closest-point distance).
2. Cloaked ships (cloak token assigned) spotted at R3 instead of R4.
3. Target lock on a ship → visible to lock owner regardless of range/LOS.
4. LOS block: asteroid / debris / gas cloud / spare parts / cargo / chaff
   between viewer and target hides the target completely, even at R1.
5. Gas cloud concealment: ship within R1 of gas cloud hidden from everyone,
   unless an enemy is also within R1 of that ship.
6. Claim R1 vision: player who claimed an objective gains R1 vision around it
   for their team. Detected via objective tint color matching player RGB.

**Reveal tokens**
7. Ship is always visible when a token named `Crate`, `Ancient Knowledge`, or
   `Energy` is assigned to it (via TokenModule) or placed within ~60mm of it.

**Vision partners (spectator sharing)**
8. Purple sees what Red sees (and vice versa).
9. Orange sees what Blue sees (and vice versa).

**Hides alongside the ship**
10. Ship UI nameplate.
11. Whitelisted tokens owned by the ship: cloak, stress, strain, ion, force,
    deplete, calculate, evade, reinforce, focus, disarm. Ownership determined
    via TokenModule, `assignedShip` var, or R4 proximity fallback.

**Never hidden**
12. Objectives, obstacles, dials, templates, damage deck, cards, dice, decks,
    boards, saved objects, anything not in the hideable-token whitelist.
13. Spectators (Grey / Black / White) always see everything (TTS limitation —
    `setInvisibleTo` only applies to seated player colors).

**Triggers (event-driven, no passive polling)**
14. Toggle fog on.
15. Manual ship drop (`onObjectDropped`).
16. Hideable token drop, reveal token drop, objective drop.
17. 0.5s position poll to detect dial/template scripted ship moves (which
    don't fire `onObjectDropped`).
18. 0.5s tint poll to detect context-menu claim/unclaim on objectives.

## Performance notes

Key optimizations in 0.26:

- Classification scan (ships / objectives / obstacles / gas clouds / cloak
  tokens / hideable tokens / reveal-named objects) cached for 10s or until a
  spawn/destroy event.
- Persistent pairwise distance cache keyed on ship positions — invalidated
  only when a ship moves more than ~0.1 IGU.
- Persistent pairwise LOS cache with the same keying. `Physics.cast` is the
  slowest single call in TTS by a wide margin.
- Phase 1 (per-ship hiding) short-circuits entirely when no ship has moved
  and the previous result exists.
- Phase 2 (token hiding) short-circuits entirely when no ship's hide list
  changed since last tick.
- Phase 2 iterates only the pre-filtered `hideableTokens` bucket.
- `Wait.time(FogOfWar.fog_check, 0.3, -1)` in Global's init is now a no-op
  (fog_check is intentionally empty). All work is driven by the activity
  poller + event handlers.
