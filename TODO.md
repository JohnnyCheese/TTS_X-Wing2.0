# TODO List for TTS_X-Wing

## Scripting Changes

1. `ShipProxy.ttslua` shows as "unused" in `Global.ttslua`,
    but in reality it defines `MarkShip()` and `UnMarkShip()` in Global namespace.
1. `TTS_lib/Vector`: Many of these `Vector` functions are now TTS standard and could be replaced.
1. Add either a `Math` or `Vector` `distance()` function
1. `AOE_SensorBuoy` has an `onLoad()` but no `onSave()`. It also uses the wrong name in the `onLoad()`
1. Delete: `TTS_lib/Util/Util.ttslua`
1. ~~Add a `nearest ship` utility function for dropping/assigning tokens~~
1. Finish other AI-modes.
    1. **Flee AI** - on Flee token drop, once health drops 
        1. Create HyperDrive Token for jumping to Hyperspace
    1. **Escape AI** - targets a region of the board to leave from
        1. possibly scale an objective token or something to represent the region
    1. **Escort AI** - like Attack AI, but when in Range-1 of its 'Escort' Ship performs a Protect action (assigns it an Evade token)
    1. **Strike AI Target** Token (perhaps something like a bullseye/target image)
    1. Add the Barrel Roll to AI Swerve mechanics. If after movement, the ship is within Range-1 in Bullseye arc it should barrel roll to avoid hitting next turn.
    1. Add the AI avoid the edge at any cost mechanic.
    1. Initiative moving all AI Ships with 1-button.
1. Random Obstacle Setup
    Reference: 
    https://api.tabletopsimulator.com/events/#object-event-handlers
    <br/>`onObjectNumberTyped`
    https://api.tabletopsimulator.com/events/#onobjectnumbertyped
1. Make `DataPad` buttons and actions pluggable/extensible by other mods.
    1. Possibly to help with mission setup or external Mods
    1. Perhaps have the mission spawn "data disks" for each later turn with squad's approach vector, which can spawn the ships on that approach vector.
1. Double check these Global.call() functions 
    * 'DeleteShipProxies'
    * 'DialAPI_AssignSet'
    * 'DialDropped'
    * 'DialPickedUp'
1. Review my old repo directories for refactoring attempts. Delete em or try again.
1. Consider a `PrototypesBag` for storing objects to contain scripts for use when spawning objects.
1. Learn the XML UI:
    1. rotate the Imperial Deck Holder in HotAC mode
    1. externalize all the XML files to the repo, use `<include>` to bring em into the game.
1. Re-fix the StarForge's Layout issue. Remove the layout value.
1. Remove all the extra turrets and see what breaks.
1. Try using an external unit testing framework, the IDE and `require` to attempt to run tests within TTS.
    1. I'm wondering if the StarForge could emit a token with a button. The token actually does a `require()` on the testing framework and all of the game's tests. Runs the tests, then zeroes out the token's `require()`.
    2. I'm thinking we can bring the tests and the testing framework in, run everything make sure it passes then remove the bloat from the shipped mod.
2. See whether separating domain logic from TTS UI logic is useful. May be further validated by the XML UI.
3. Create videos for X-Wing Standard/HotAC/TTS Development
4. Turn-Phase Observer Event Model. For Planning through End phase.
    1. Things like Tracking Torpedo which move during the System Phase.
        1. Explode during the Engagement Phase, and
        2. Target Lock during the End phase
    2. Object might be registered for the Events then be polled to get input (or skip).
    3. The `showMe()` function might be useful for finding each object which needs to act.
5. Perhaps a Game console to help run HotAC and which can delineate the phase each turn.
6. Tags system for interaction:
   1. 'Targetable' = shows up in Range checks
   2. 'Ship' = implicitly has targetable, range finding, arc checking, moveable, etc.
   3. 'Remote' = obeys rules for Remotes
   4. 'AttackAI' = obeys Attack AI for movement and activation
   5. 'StrikeAI' = etc
7. Use PMD to find and refactor duplicate Lua code
   1. This will require renaming all `.ttslua` files to `.lua`
   2. Verify that `git` sees it as a `rename` to preserve history.
8. ~~Make sure assigned tokens move with the ship they're assigned to.~~
9. ~~Make targetable objects show up in target Arcs.~~


## Requires an updated Beta Save

1. Add damage tokens to HotAC mode.
1. Remove the base on the Star Forge.
1. Finish externalizing the scripts for the following objects: 
    DataPad
1. ~~Put "Probe" [Reversi Token] into Extra Asset Bag for dispensing from the Star Forge.~~
1. Give the Remotes better drop direction icons and movement icons (borrow from Dial)
1. Migrate the Initiative Token to a single object with a key press script and the initiative displayed with XML UI. (Notes from Flipster)
    1. Store the current initiative value as a variable.
    2. Set its name (setName) and the ui `self.UI.getAttribute("InitiativeLabel", "text")`.
    3. Then on the keystroke event implementation, overwrite the current initiative and call the setInitiative function which resets the name and UI attribute.
1. Generalize 'disappear on flip' and 'assign on drop' to Global event handlers and tag all objects which should get that behavior
    1. 'remove on flip' - tag all tokens you want to be removed when flipped
    2. 'assign on drop' - use the 'closest ship' logic to assign the token a ship
1. Aid to migrate HotAC-type games. Perhaps a Memory Bag type "Rebel Transport" (or "Bulk Freighter") to collect all player artifacts and transport them to a new release of the Unified Mod.
    1. Create a baseline of all default in-game objects - these don't have to be moved.
    1. Save player's objects and store in Transport Memory Bag.
    1. Save transport as an external object
    1. Load new version of the Unified Mod
    1. Redeploy transported game objects
1. TargetLocks have an owner and an assigned ship. Perhaps we can handle these behaviors with tags?
1. Create a HotAC & FGA Ship Builder based on Pilot level and available XP
    * Would be cool to have the buttons be the images of the upgrade icons
    * If I was looking for making a Hotac builder.
    * I would start from scratch mostly. Building it with XML gui.
    * Taking inspiration from parts of the DataPad.
    * It could be the first step to rewriting that thing.
    * The one advantage of the old ways is that its dynamic. And you can add another button whenever you need it.
    * In the xml gui all elements must be defined initially. But you can turn elements on and off.
    * But, this also forces you to reuse elements, and you need to think slightly different.
    * The gui could be moved away from the Control and Builder logic.
    * Building gui controllers, that accept generic content (list of ships + lambda functions).
    * And Control functions that alter these controllers.
    * When something is selected it modifies some data. And calls another control (view) function.
    * Something like this.
    * The gui controllers can this way be maintained for all needs. And the builder logic is maintained somewhere else.
    * And the builder does some very similar things over and over. It wouldn’t need that many controllers.

### Was this intended?

1. TrackingTorpedo.ttslua: 93:     spawnedRuler.lock()

### Anomalies from Reorg

1. 'No Stats Dice' has a lua script in it's .xml file

### Bugs

1. Verify AI Swerve for obstacles. Give chat messages to let players
   know what was considered so they know it's working when it runs over
   an obstacle.
   1. Check if board edge detection and avoidance works.
   1. Add barrel roll if obstacle is withing Range-1 and in Bullseye Arc.
2. Attachable Turrets don't attach.
3. Check AI control of Medium or Large base ships.
4. Does the game support ground assault and movement of the AT-AT.
5. AI Squadron Formation Tool may not be precisely correct. A tr2 from an (15-degree?) angle caused a collision.
