#!/usr/bin/env python3
"""
Spawn a Custom_Tile placard into save 19 displaying the fog rules image.
Idempotent — removes any previous FogPlacardAuto spawn first.
"""
import json
import shutil
import sys
import uuid
from pathlib import Path

SAVE = Path.home() / "Library" / "Tabletop Simulator" / "Saves" / "TS_Save_19.json"
BACKUP = SAVE.with_suffix(".json.placard_bak")
IMAGE = "https://files.catbox.moe/nlobe4.png"
MARKER = "FogPlacardAuto"

# Image is 2816x1536 (aspect ~1.833). Natural rectangular tile in TTS has a
# 4:3 ratio by default; WidthScale lets us override. We'll set WidthScale = 0
# (default) and scale X bigger than Z to match the aspect ratio.
# Size on table ~ 8 igu wide, 4.36 igu tall → readable without blocking play.
SCALE_X = 5.0
SCALE_Z = 5.0
SCALE_Y = 1.0

# Position: above and slightly back of the playmat edge, lifted off the table.
POS = (-76.72316, -0.0588750541, 26.24882)
ROT_Y = 90.01019


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


def main() -> int:
    data = json.loads(SAVE.read_text())
    states = data.get("ObjectStates", [])
    before = len(states)
    states = [o for o in states if o.get("GMNotes") != MARKER]
    removed = before - len(states)
    states.append(make_placard())
    data["ObjectStates"] = states

    if not BACKUP.exists():
        shutil.copy(SAVE, BACKUP)
        print(f"Backup: {BACKUP}", file=sys.stderr)
    SAVE.write_text(json.dumps(data, indent=2, ensure_ascii=False))
    print(f"OK: removed {removed} old placard(s), added 1 at {POS}", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
