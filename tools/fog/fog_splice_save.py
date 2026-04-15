#!/usr/bin/env python3
import json
import re
import shutil
import sys
from pathlib import Path

SAVE = Path.home() / "Library" / "Tabletop Simulator" / "Saves" / "TS_Save_19.json"
BACKUP = SAVE.with_suffix(".json.fogbak")
NEW_BLOCK = Path("/tmp/fog_replacement.lua").read_text()

END_PATTERN = re.compile(
    r"--\s*Fog of War Module.*?function\s+API_ToggleFogOfWar\s*\(\s*\).*?\bend\b",
    re.DOTALL,
)


def main() -> int:
    data = json.loads(SAVE.read_text())
    lua = data.get("LuaScript", "")
    new_lua, n = END_PATTERN.subn(NEW_BLOCK, lua, count=1)
    if n != 1:
        print("ERROR: regex did not match", file=sys.stderr)
        return 3
    if not BACKUP.exists():
        shutil.copy(SAVE, BACKUP)
    data["LuaScript"] = new_lua
    SAVE.write_text(json.dumps(data, indent=2, ensure_ascii=False))
    print(f"OK: wrote save ({SAVE.stat().st_size} bytes), fog block {len(NEW_BLOCK)} bytes", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
