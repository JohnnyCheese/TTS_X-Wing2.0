#!/usr/bin/env python3
"""
Spawn a Custom_Tile placard into save 19 displaying the fog rules image,
plus a clickable Fog of War toggle button just above the placard.
Idempotent — removes any previous auto-spawned placard / button first.
"""
import json
import shutil
import sys
import uuid
from pathlib import Path

SAVE = Path.home() / "Library" / "Tabletop Simulator" / "Saves" / "TS_Save_19.json"
BACKUP = SAVE.with_suffix(".json.placard_bak")
# Bundled with the repo and served via GitHub raw HTTPS so multiplayer clients
# can pull it without local-file warnings or insecure HTTP.
IMAGE = ("https://raw.githubusercontent.com/charlie-n-hill/TTS_X-Wing2.0/"
         "feature/fog-of-war/tools/fog/assets/rules-1MAY.png")
MARKER = "FogPlacardAuto"
BUTTON_MARKER = "FogToggleButtonAuto"

# Placard position (where the user moved it to).
SCALE_X = 5.0
SCALE_Z = 5.0
SCALE_Y = 1.0
POS = (-63.6343079, -0.05887509, 29.10424)
ROT_Y = 90.02352

# Toggle button sits above the placard. With placard rotY=90, "above" in screen
# space corresponds to smaller world X. Place it well clear of the placard top.
# Captured from save 19 after manual placement.
BUTTON_POS = (-69.40262, -0.0338752642, 28.847847)
BUTTON_ROT_Y = 90.02872

BUTTON_LUA = """\
function onLoad()
    self.createButton({
        click_function = "toggleFog",
        function_owner = self,
        label          = "FOG OF WAR",
        position       = { 0, 0.3, 0 },
        rotation       = { 0, 0, 0 },
        width          = 1909,
        height         = 600,
        font_size      = 200,
        color          = { 0.10, 0.10, 0.13, 1 },
        font_color     = { 1.0, 0.55, 0.15, 1 },
    })
end

function toggleFog()
    Global.call("API_ToggleFogOfWar")
end
"""


def make_placard():
    x, y, z = POS
    return {
        "GUID": uuid.uuid4().hex[:6],
        "Name": "Custom_Tile",
        "Transform": {
            "posX": x, "posY": y, "posZ": z,
            "rotX": 0, "rotY": ROT_Y, "rotZ": 0,
            "scaleX": SCALE_X, "scaleY": SCALE_Y, "scaleZ": SCALE_Z,
        },
        "Nickname": "Fog of War Rules",
        "Description": "Quick reference for the fog of war system.",
        "GMNotes": MARKER,
        "ColorDiffuse": {"r": 1.0, "g": 1.0, "b": 1.0},
        "Tags": ["FogPlacard"],
        "CustomImage": {
            "ImageURL": IMAGE,
            "ImageSecondaryURL": "",
            "ImageScalar": 1.0,
            "WidthScale": 0.0,
            "CustomTile": {
                "Type": 0,  # 0 = Square/Rectangle (1 is Hex)
                "Thickness": 0.1,
                "Stackable": False,
                "Stretch": True,
            },
        },
        "Locked": True,
        "Grid": True,
        "Snap": True,
        "IgnoreFoW": False,
        "MeasureMovement": False,
        "DragSelectable": True,
        "Autoraise": True,
        "Sticky": True,
        "Tooltip": True,
        "GridProjection": False,
        "HideWhenFaceDown": False,
        "Hands": False,
    }


def make_button():
    x, y, z = BUTTON_POS
    return {
        "GUID": uuid.uuid4().hex[:6],
        "Name": "BlockSquare",
        "Transform": {
            "posX": x, "posY": y, "posZ": z,
            "rotX": 0, "rotY": BUTTON_ROT_Y, "rotZ": 0,
            # Wide along the button's local X (where the label reads), thin Y,
            # narrow local Z. After rotY=90 this puts width along world Z.
            "scaleX": 1.6, "scaleY": 0.05, "scaleZ": 0.5,
        },
        "Nickname": "Fog of War Toggle",
        "Description": "Click to toggle Fog of War mode.",
        "GMNotes": BUTTON_MARKER,
        "ColorDiffuse": {"r": 0.18, "g": 0.18, "b": 0.22, "a": 0.85},
        "Tags": ["FogToggleButton", "DoNotHide"],
        "LuaScript": BUTTON_LUA,
        "LuaScriptState": "",
        "Locked": True,
        "Grid": True,
        "Snap": True,
        "IgnoreFoW": False,
        "MeasureMovement": False,
        "DragSelectable": True,
        "Autoraise": True,
        "Sticky": True,
        "Tooltip": True,
        "GridProjection": False,
        "HideWhenFaceDown": False,
        "Hands": False,
    }


def main() -> int:
    data = json.loads(SAVE.read_text())
    states = data.get("ObjectStates", [])
    before = len(states)
    states = [o for o in states
              if o.get("GMNotes") != MARKER and o.get("GMNotes") != BUTTON_MARKER]
    removed = before - len(states)
    states.append(make_placard())
    states.append(make_button())
    data["ObjectStates"] = states

    if not BACKUP.exists():
        shutil.copy(SAVE, BACKUP)
        print(f"Backup: {BACKUP}", file=sys.stderr)
    SAVE.write_text(json.dumps(data, indent=2, ensure_ascii=False))
    print(f"OK: removed {removed} old auto-spawn(s); placard at {POS}, "
          f"button at {BUTTON_POS}", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
