return [[
announce_color = color(0.1,0.1,1.0)
lockcount = 0
local Configs = nil
previous_tint = Color.White

function onLoad(save_state)
  if save_state then
    state = JSON.decode(save_state)
    if state and state.ship_type then
      ship_type = state.ship_type
    end
    if state and state.configs then
      Configs = state.configs
    end
  end
  local has_base = false
  local has_config = false
  for _, attachment in pairs(self.getAttachments()) do
    if attachment.name == "customization base" then
      has_base = true
    elseif attachment.name == "config" then
      has_config = true
    end
  end

  -- spawning customization base
  if has_base == false then
    local spawnpos = self.getPosition()  + vector(0,-1.5, 0)
    local spawnrot = self.getRotation()
    self.setLock(true)
    lockcount = lockcount + 1
    base = spawnObject({
      type              = "Custom_Model",
      position          = spawnpos,
      rotation          = spawnrot,
      scale             = vector(1.2,1.2,1.2),
      callback_function = attachBaseAndUnlock,
      sound             = false,
      snap_to_grid      = false,
    })
    base.setCustomObject({
      mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/holo.obj',
      diffuse = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/holo.jpg'
    })
    base.setName("customization base")
  end

  if self.getTable("Configs") and self.getTable("Configs")[1] and has_config == false then
    local spawnpos = self.getPosition()
    local spawnrot = self.getRotation()
    local spawnscale = self.getScale()

    self.setLock(true)
    lockcount = lockcount + 1
    config = spawnObject({
      type              = "Custom_Model",
      position          = spawnpos,
      rotation          = spawnrot,
      scale             = spawnscale,
      callback_function = attachBaseAndUnlock,
      sound             = false,
      snap_to_grid      = false,
    })
    config.setCustomObject({
      mesh = self.getTable("Configs")[1],
      diffuse = self.getCustomObject().diffuse
    })
    config.setName("config")
  end

end


function attachBaseAndUnlock(base)
  if base.getName() == "config" then
    base.setColorTint(self.getColorTint())
  end
  self.addAttachment(base)
  lockcount = lockcount - 1
  if lockcount == 0 then
    self.setPositionSmooth(self.getPosition() + vector(0,2,0), false, true)
    self.setLock(false)
  end
end

function onSave()
  state = {
    ship_type = ship_type,
    configs = self.getTable("Configs")
  }
  return JSON.encode(state)
end

function onDrop(player_color)
  local found_ship = nil
  local min_distance = 5
  local my_pos = self.getPosition()
  for _, ship in pairs(getObjectsWithTag("Ship")) do
    local distance = my_pos:distance(ship.getPosition())
    if distance < min_distance then
      found_ship = ship
      min_distance = distance
    end
  end
  if found_ship and found_ship.getVar("setCustomization") then
    local custom_object = self.getCustomObject()
    found_ship.call("setCustomization", {model = custom_object.mesh, texture = custom_object.diffuse, configs = self.getTable("Configs"), tint = self.getColorTint() })
    printToAll("Applied customization to " .. found_ship.getName(), announce_color)
  end
  -- Find nearest ship of same type
end

function onUpdate()
  if previous_tint ~= self.getColorTint() then
    previous_tint = self.getColorTint()
    local attachments = self.getAttachments()
    for i = #attachments, 1, -1 do
      local attachment = attachments[i]
      if attachment.name == "config" then
        config = self.removeAttachment(attachment.index)
        config.setColorTint(previous_tint)
        self.addAttachment(config)
      end
    end
  end
end

]]
