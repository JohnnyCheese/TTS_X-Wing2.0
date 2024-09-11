# TODO List for things TTS_X-Wing related

Scripting Changes
1. `ShipProxy.ttslua` shows as "unused" in `Global.ttslua`,
    but in reality it defines `MarkShip()` and `UnMarkShip()` in Global namespace.
1. TTS_lib/Vector: Many of these Vector functions are now TTS standard and could be replaced.
1. Add either a Math or Vector distance() function
1. AOE_SensorBuoy has an `onLoad()` but no `onSave()`. It also uses the wrong name in the `onLoad()`
1. Delete: `TTS_lib/Util/Util.ttslua`
1. Add a nearest ship utility function for dropping/assigning tokens
1. Flee AI - on Flee token drop, once health drops 
1. Escape AI - targets a region of the board to leave from
    1. possibly scale an objective token or something to represent the region
1. Escort AI - like Attack AI, but when in Range-1 of an Escorted Ship performs a Protect action (assigns it an Evade token)
1. Random Obstacle Setup
    Reference: 
    https://api.tabletopsimulator.com/events/#object-event-handlers
    <br/>`onObjectNumberTyped`
    https://api.tabletopsimulator.com/events/#onobjectnumbertyped
1. Make DataPad buttons and actions pluggable/extensible by other mods.
   2. Possibly to help with mission setup or external Mods
   3. Perhaps have the mission spawn data disks for each vector/squad, which can spawn the ships on that approach vector.
1. Double check these Global.call() functions 
   2. 'DeleteShipProxies'
      'DialAPI_AssignSet'
      'DialDropped'
      'DialPickedUp'
1. Review old repo directories for refactoring attempts. Delete em or try again.
2. Consider a PrototypesBag for storing objects to contain scripts for use when spawning objects.
3. Strike AI Target Token (perhaps something like a bullseye/target)
4. Learn the XML stuff
   5. rotate the Imperial Deck Holder in HotAC mode
   6. externalize all the XML files to the repo, use <include> to bring em into the game.
1. Re-fix the StarForge's Layout issue.
2. Move All AI Ships with 1-button.
3. Remove all the extra turrets and see what breaks
4. Try using an external unit testing framework, the IDE and require to attempt to run tests
5. See whether separating domain logic from TTS UI logic is doable.
6. Create videos for X-Wing Standard/HotAC/TTS Development

Requires an updated Beta Save
1. Add damage tokens to HotAC mode.
1. Remove the base on the Star Forge.
1. Finish externalizing the scripts for the following objects: 
    DataPad
1. Put "Probe" [Reversi Token] into Extra Asset Bag for dispensing from the Star Forge.
1. Migrate the Initiative Token to a single object with a key press script and the initiative displayed with XML UI. (Notes from Flipster)
    1. Store the current initiative value as a variable.
    2. Set its name (setName) and the ui `self.UI.getAttribute("InitiativeLabel", "text")`.
    3. Then on the keystroke event implementation, overwrite the current initiative and call the setInitiative function which resets the name and UI attribute.
1. Generalize 'disappear on flip' and 'assign on drop' to Global event handlers and tag all objects which should get that behavior
   1. 'remove on flip' - tag all tokens you want to be removed when flipped
   2. 'assign on drop' - use the 'closest ship' logic to assign the token a ship
1. Aid to migrate HotAC-type games. Perhaps a Memory Bag type "Transport" (or Bulk Freighter) to collect all player artifacts and transport them to a new release of the Unified Mod.
    1. baseline all in-game objects.
    1. Save player objects and store in Transport Memory Bag.
    1. save transport
    1. load new unified mod
    1. deploy transported game objects


# Was this intended?
1. TrackingTorpedo.ttslua: 93:     spawnedRuler.lock()

