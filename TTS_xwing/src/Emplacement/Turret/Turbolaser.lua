local Dim = require("Dim")

arcsOpen = false

rulers = {}
rulersType = nil

Data = { Size = "objective" }

function arc()
  checkArc("front", 4, false)
end

function checkArc(type, range, friendly)
  self.clearButtons()
  for _, ruler in pairs(rulers) do
    destroyObject(ruler)
  end
  rulers = {}
  if rulersType == type .. range then
    rulersType = nil
  else
    if type == "full" then
      printToAll("Checking for ships at range " .. tostring(range) .. " from " .. self.getName(),
        color(1.0, 1.0, 0.2, 0.9))
    end
    rulers = Global.call("CheckArc", { ship = self, arctype = type, range = range, include_friendly_ships = friendly })
  end
  if rulers and #rulers > 0 then
    rulersType = type .. range
    arcsOpen = true
    local rotation = Vector(0, -90, 0)
    local up = Vector(0, 1, 0)
    if self.is_face_down then
      up = -1 * up
      rotation = rotation + Vector(0, 0, 180)
    end
    local raise = 0.08 * up
    self.createButton({
      click_function = "removeArcs",
      function_owner = self,
      label          = "Remove",
      position       = raise,
      rotation       = rotation,
      width          = 580,
      height         = 450,
      font_size      = 100,
      font_color     = { 1, 1, 1 },
      color          = { 0.25, 0.25, 0.25 },
      tooltip        = "Remove the arc rulers."
    })
  else
    rulersType = nil
    arcsOpen = false
  end
end

function removeArcs()
  self.clearButtons()
  for _, ruler in pairs(rulers) do
    destroyObject(ruler)
    rulers = {}
  end
  rulersType = nil
  arcsOpen = false
end

-- require("Device.Remote.Commandos")

local MenuTree = require("TTS_lib.ContextMenuTree.ContextMenuTree")
_menu = nil
owningPlayer = Player.Black

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

function removeArcs()
  self.clearButtons()
  for _, ruler in pairs(rulers) do
    destroyObject(ruler)
    rulers = {}
  end
  rulerstype = nil
  arcsopen = false
end

-- ===== Ownership (claim/unclaim/persist) =====
function ClaimFor(color)
  if not color or color == "" then return end
  owningPlayer = color
  printToAll(string.format("[%s] Claimed by %s.", self.getName(), owningPlayer))
end

function Unclaim()
  local prev = owningPlayer
  owningPlayer = nil
  printToAll(string.format("[%s] Unclaimed%s.", prev and (" (was " .. prev .. ")") or "", self.getName()))
end

function onSave()
  local state = { owningPlayer = owningPlayer }
  return JSON.encode(state)
end

function onLoad(save_state)
  local state = JSON.decode(save_state)
  if state then
    owningPlayer = state.owningPlayer
  end
  _menu = SetupContextMenu()
  _menu:showRoot()
  Global.call("showMe", { self.guid })
end

local function sayTo(color, msg)
  local p = Player[color]
  if p and p.broadcast then p.broadcast(msg) else printToAll(msg) end
end

local function cm_claim(color) ClaimFor(color) end
local function cm_showOwner(color) sayTo(color, "[TL] Owner: " .. (owningPlayer or "(unclaimed)")) end
local function cm_setHost(_)
  owningPlayer = "Black"
  printToAll(string.format("[%s] Owner set: Black", self.getName()))
end


function SetupContextMenu()
  self.clearContextMenu()
  -- ... Top Menu ...
  local root = MenuTree.Menu.menu("Turbolaser")

  root:choice("Check Arc", arc)

  local owner = root:submenu("Claim Emplacement")
  owner:choice("Show Owning Player", cm_showOwner)
  owner:choice("Claim", cm_claim)
  owner:choice("Claim By Host", cm_setHost)

  return MenuTree.Cursor.new(self, root)
end
