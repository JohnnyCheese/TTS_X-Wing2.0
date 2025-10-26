require("Device.Remote.Commandos")
-- === Ship-like API shim for remote/structure targets =========================

-- Configure how this emplacement “mounts” its weapon, using your schema.
-- Allowed: "front", "left", "back", "right", "leftright", "frontback", "turret"
local REMOTE_MOUNT = "turret"

-- Typical long-range emplacement bounds; tweak per mission.
local REMOTE_RANGE_MIN, REMOTE_RANGE_MAX = 2, 4

local _ARCS_CACHE, _RANGE_CACHE

local function getArcMap()
  -- Try to reuse the project-wide table if it’s global; fall back locally.
  local g = getObjectFromGUID and Global or nil
  local arcMap = g and g.getTable and g.getTable("mountDirectionToArcs") or nil
  if arcMap then return arcMap end

  -- Local fallback mirrors your mapping and adds "turret" = all four.
  return {
    front     = { "front" },
    left      = { "left" },
    back      = { "back" },
    right     = { "right" },
    leftright = { "left", "right" },
    frontback = { "front", "back" },
    turret    = { "front", "left", "right", "back" },
  }
end

-- Exported: AI expects this name and a TABLE back (never nil).
function GetAllArcs()
  if _ARCS_CACHE then return _ARCS_CACHE end
  local map = getArcMap()
  local names = map[REMOTE_MOUNT] or {}
  local arcs = {}
  for _, name in ipairs(names) do
    -- Keep the payload minimal; most AI just needs keys to exist/iterate.
    arcs[name] = { name = name }
  end
  _ARCS_CACHE = arcs
  return _ARCS_CACHE
end

-- Optional, but helps some AI heuristics; also must never be nil.
function GetAttackRanges()
  if _RANGE_CACHE then return _RANGE_CACHE end
  _RANGE_CACHE = { min = REMOTE_RANGE_MIN, max = REMOTE_RANGE_MAX }
  return _RANGE_CACHE
end

-- Optional clarity if any code branches on this.
function IsRemoteTarget() return true end

-- ============================================================================
