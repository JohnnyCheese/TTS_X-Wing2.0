# TODO List for things TTS_X-Wing related

1. `ShipProxy.ttslua` shows as "unused" in `Global.-1.ttslua`,
but in reality it defines `MarkShip()` and `UnMarkShip()` in Global namespace.
1. TTS_lib/Vector: Many of these Vector functions are now TTS standard and could be replaced.
1. Remove the base on the Star Forge.
1. Add either a Math or Vector distance() function
1. Add a nearest ship utility function for dropping/assigning tokens
1. Migrate the Initiative Token to a single object with a key press script and the initiative displayed with XML UI. (Notes from Flipster)
    1. Store the current initiative value as a variable.
    2. Set its name (setName) and the ui `self.UI.getAttribute("InitiativeLabel", "text")`.
    3. Then on the keystroke event implementation, overwrite the current initiative and call the setInitiative function which resets the name and UI attribute.
    Reference: 
    https://api.tabletopsimulator.com/events/#object-event-handlers
    <br/>`onObjectNumberTyped`
    https://api.tabletopsimulator.com/events/#onobjectnumbertyped


# Was this intended?
1. TrackingTorpedo.ttslua: 93:     spawnedRuler.lock()

