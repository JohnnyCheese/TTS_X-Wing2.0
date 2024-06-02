# TODO List for things TTS_X-Wing related

1. `ShipProxy.ttslua` shows as "unused" in `Global.-1.ttslua`,
but in reality it defines `MarkShip()` and `UnMarkShip()` in Global namespace.
1. TTS_lib/Vector: Many of these Vector functions are now TTS standard and could be replaced.
1. Remove the base on the Star Forge.
1. Add either a Math or Vector distance() function
1. Add a nearest ship utility function for dropping/assigning tokens


# Was this intended?
1. TrackingTorpedo.ttslua: 93:     spawnedRuler.lock()

