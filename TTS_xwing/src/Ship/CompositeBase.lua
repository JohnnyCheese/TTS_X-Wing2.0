-- Standard libraries extentions
require("TTS_Lib.Util.Math")
require("TTS_Lib.Util.Table")
require("TTS_Lib.Util.String")

local customizer_script = require("Ship.ShipCustomizer")

__XW_Ship = true
interactable = false
isHiding = false

function initContextMenu()
    self.clearContextMenu()
    if finished_setup then
        if self.getTable("Data") then
            for type, arc in pairs(self.getTable("Data").arcs or {}) do
                if type == 'fixed' then
                    for _, fixedarc in pairs(arc.type or {}) do
                        self.addContextMenuItem("FireArc - " .. Global.getTable('arcNames')[fixedarc],
                            function(argument) self.setDescription(Global.getTable('arcToCmnd')[fixedarc]) end, false)
                    end
                elseif type == 'turret' then
                    for mount, turret in pairs(arc) do
                        local idx = Global.getTable('mountToIndex')[mount]
                        self.addContextMenuItem("FireArc - " .. turret.name,
                            function(argument) self.setDescription('turret' .. idx) end, false)
                    end
                    for mount, turret in pairs(arc) do
                        local idx = Global.getTable('mountToIndex')[mount]
                        if (turret.type[1] == 'doubleturret') or (#turret.type == 2) then
                            self.addContextMenuItem("Rot - " .. turret.name,
                                function(argument) self.setDescription('rot' .. idx) end, false)
                        else
                            self.addContextMenuItem("Rot L - " .. turret.name,
                                function(argument) self.setDescription('rotl' .. idx) end, false)
                            self.addContextMenuItem("Rot R - " .. turret.name,
                                function(argument) self.setDescription('rotr' .. idx) end, false)
                        end
                    end
                end
            end
            local config = self.getTable("Data").Config
            if config then
                self.addContextMenuItem(config.ContextText, function() self.call('SetConfiguration') end, false)
            end

            self.addContextMenuItem("Mark ship", function(argument) Global.call("MarkShip", { ship = self }) end, false)

            if Global.getVar('test_AI') or self.getVar('isAi') then
                self.addContextMenuItem("AI move and action",
                    function(argument) Global.call("PerformAIManeuver", { ['ship'] = self, ['take_action'] = true }) end,
                    false)
                self.addContextMenuItem("AI move",
                    function(argument) Global.call("PerformAIManeuver", { ['ship'] = self, ['take_action'] = false }) end,
                    false)
            end
        end
    else
        self.addContextMenuItem("Next Texture", NextTexture, true)
        self.addContextMenuItem("Toggle Peg", TogglePeg, true)
        self.addContextMenuItem("Spawn Customizer", SpawnCustomizer, false)
    end
end

assigned_tokens = {}

-- Add token
function AddToken(args)
    assigned_tokens[args.token.getGUID()] = args.token
end

-- Remove token
function RemoveToken(args)
    assigned_tokens[args.token.getGUID()] = nil
end

-- Get Tokens
function GetTokens(args)
    local tokens = {}
    for guid, token in pairs(assigned_tokens) do
        if token == nil then
            assigned_tokens[guid] = nil
        elseif ((args == nil) or (args.type == nil) or (args.type == token.getVar("__XW_TokenType"))) or token.hasTag(args.type) then
            table.insert(tokens, assigned_tokens[guid])
        end
    end
    return tokens
end

current_config = 1

function SetConfiguration(args)
    if not args or not args.ConfigId then
        current_config = (current_config % #self.getTable("Data").Config.States) + 1
    else
        current_config = args.ConfigId
    end
    --Flip config card
    for _, card in pairs(getObjectsWithTag("ConfigCard")) do
        if card.getGUID() == self.getTable("Data").Config.CardGUID then
            if current_config ~= (card.is_face_down and 2 or 1) then
                card.flip()
            end
        end
    end

    --flip config token
    for _, token in pairs(GetTokens({ type = "config" })) do
        if current_config ~= (token.is_face_down and 2 or 1) then
            token.flip()
        end
    end

    local attachments = self.getAttachments()
    for i = #attachments, 1, -1 do
        local attachment = attachments[i]
        if attachment.name == "Config" then
            local scale = Vector(0.0001, 0.0001, 0.0001)
            if attachment.description == tostring(current_config) then
                scale = Vector(0.629, 0.629, 0.629)
                printToAll(self.getName() .. self.getTable("Data").Config.States[current_config].Message)
            end
            id = self.removeAttachment(attachment.index)
            id.setScale(scale)
            self.addAttachment(id)
        end
    end
    Wait.frames(DisableAttachedColliders, 2)
end

arc_indicators = {}

function DisableAttachedColliders()
    --print("DisableAttachedColliders: " .. self.getName())
    for _, child in ipairs(self.getChildren()) do
        --print("Child ".. tostring(i)..":" .. child.name)
        if child.name ~= "New Game Object" then -- The compounded collission mesh seems to be named this.
            DisableColliderInComponent(child, " ")
        end
    end
end

function DisableColliderInComponent(comp, prefix)
    if comp.getComponent("MeshCollider") then
        comp.getComponent("MeshCollider").set("enabled", false)
    end
    if comp.getComponent("BoxCollider") then
        comp.getComponent("BoxCollider").set("enabled", false)
    end

    for _, child in ipairs(comp.getChildren()) do
        --print(prefix .. child.name)
        DisableColliderInComponent(child, prefix .. " ")
    end
end

function SetProximityHiding(enabled)
    if enabled ~= isHiding then
        isHiding = enabled
        local attachments = self.getAttachments()
        for i = #attachments, 1, -1 do
            local attachment = attachments[i]
            if attachment.name == "Config" or attachment.name == "Ship" then
                local model = self.removeAttachment(attachment.index)
                local tint = model.getColorTint()
                if enabled then
                    tint[4] = 0.2
                else
                    tint[4] = 1.0
                end
                model.setColorTint(tint)
                self.addAttachment(model)
            end
        end
        Wait.frames(function() DisableAttachedColliders() end, 2)
    end
end

function AttachArcIndicator(args)
    local turret_mount = args.mount or 'main'
    local default_direction = args.indicator.getVar("default_arc_direction") or 'front'
    arc_indicators[turret_mount] = {
        arc = default_direction,
        double_arc = args.indicator.getVar("double_arc") or false,
        color_by_id = args.indicator.getVar("color_by_id") or false
    }
    args.indicator.setDescription(turret_mount)
    args.indicator.setRotation(self.getRotation() + Global.getTable('mountRotations')[default_direction] or Vector(0, 0,
        0))
    Wait.frames(DisableAttachedColliders, 2)


    for _, attachment in pairs(self.getAttachments()) do
        if attachment.name:find("Arc Indicator") and (attachment.description == turret_mount) then
            id = self.removeAttachment(attachment.index)
            destroyObject(id)
        end
    end
end

function DeleteArcIndicator(args)
    local turret_mount = args.mount or 'main'
    for _, attachment in pairs(self.getAttachments()) do
        if attachment.name:find("Arc Indicator") and (attachment.description == turret_mount) then
            id = self.removeAttachment(attachment.index)
            destroyObject(id)
        end
    end
end

function GetNextValidRotation(mount, rotate_direction)
    local direction = arc_indicators[mount].arc
    local arcs = self.getTable('Data').arcs.turret[mount].type or { direction }
    for _ = 1, 4, 1 do
        direction = Global.getTable('nextMountDirection')[rotate_direction][direction]
        if direction == arc_indicators[mount].arc then
            return direction
        end
        for _, arc in pairs(arcs) do
            if (arc == direction) or (arc == "singleturret") or (arc == "doubleturret") then
                return direction
            end
        end
    end
    return arc_indicators[mount].arc
end

function RotateAttachedArcIndicator(args)
    local turret_mount = args.mount or 'main'
    for _, attachment in pairs(self.getAttachments()) do
        if attachment.name:find("Arc Indicator") and (attachment.description == turret_mount) then
            local next_direction = GetNextValidRotation(turret_mount, args.direction)
            id = self.removeAttachment(attachment.index)
            arc_indicators[turret_mount].arc = next_direction
            id.setRotation(self.getRotation() + Global.getTable('mountRotations')[next_direction] or Vector(0, 0, 0))
            self.addAttachment(id)
            Wait.frames(DisableAttachedColliders, 2)
            return
        end
    end
end

function GetAvailableMountPositions(args)
    local mount_positions = self.getTable('Data').mountingPoints or { main = { 0, 0 } }

    for _, attachment in pairs(self.getAttachments()) do
        if attachment.name:find("Arc Indicator") then
            mount_positions[attachment.description] = nil
        end
    end

    local ship_position = self.getPosition()
    local ship_rotation = math.rad(self.GetRotation().y) * -1
    for location, position in pairs(mount_positions) do
        local transformed_position = Vector(
            ship_position.x + math.cos(ship_rotation) * position[1] - math.sin(ship_rotation) * position[2],
            ship_position.y,
            ship_position.z + math.sin(ship_rotation) * position[1] + math.cos(ship_rotation) * position[2]
        )
        mount_positions[location] = transformed_position
    end
    return mount_positions
end

function GetMountingPosition(args)
    local turret_mount = args.mount or 'main'
    local mount_position = self.getTable('Data').mountingPoints[turret_mount] or { 0, 0 }
    local ship_position = self.getPosition()
    local ship_rotation = math.rad(self.GetRotation().y) * -1
    return Vector(
        ship_position.x + math.cos(ship_rotation) * mount_position[1] - math.sin(ship_rotation) * mount_position[2],
        ship_position.y,
        ship_position.z + math.sin(ship_rotation) * mount_position[1] + math.cos(ship_rotation) * mount_position[2]
    )
end

function GetFixedArcs(args)
    local fixed = self.getTable("Data").arcs.fixed or {}
    return fixed.type or {}
end

function GetAllTurretArcs(args)
    local turret_arcs = {}
    -- For attached arc indicators
    for _, arc_indicator in pairs(arc_indicators) do
        --print("GetAllTurretArcs: arc_indicator " .. arc_indicator.arc)
        local new_turret_arcs = Global.getTable("mountDirectionToArcs")[arc_indicator.arc] or {}
        for _, new_arc in pairs(new_turret_arcs) do
            --print("GetAllTurretArcs arc " .. new_arc)
            local found = false
            for _, existing_arc in pairs(turret_arcs) do
                if new_arc == existing_arc then
                    found = true
                    break
                end
            end

            if found == false then
                table.insert(turret_arcs, new_arc)
            end
        end
    end

    return turret_arcs
end

function GetAllArcs(args)
    local arcs = GetFixedArcs()
    local turret_arcs = GetAllTurretArcs()

    for _, turret_arc in pairs(turret_arcs) do
        local found = false
        for _, existing_arc in pairs(arcs) do
            if turret_arc == existing_arc then
                found = true
                break
            end
        end

        if found == false then
            table.insert(arcs, turret_arc)
        end
    end

    return arcs
end

function GetAssignedMounts()
    local assigned_mounts = {}
    for _, attachment in pairs(self.getAttachments()) do
        if attachment.name:find("Arc Indicator") then
            table.insert(assigned_mounts, attachment.description)
        end
    end
    return assigned_mounts
end

function GetTurretArcs(args)
    local turret_mount = args.mount or 'main'
    if arc_indicators[turret_mount] ~= nil then
        return Global.getTable("mountDirectionToArcs")[arc_indicators[turret_mount].arc]
    end
    return {}
end

function GetTurretArc(args)
    local turret_mount = args.mount or 'main'
    if arc_indicators[turret_mount] then
        return arc_indicators[turret_mount].arc
    end
    return nil
end

function GetTurretRange(args)
    local turret_mount = args.mount or 'main'
    local turret = self.getTable('Data').arcs.turret[turret_mount]
    if turret.range then
        return turret.range
    end
    return nil
end

function SetTurretArc(args)
    local turret_mount = args.mount or 'main'
    if arc_indicators[turret_mount] then
        arc_indicators[turret_mount].arc = args.arc
        for _, attachment in pairs(self.getAttachments()) do
            if attachment.name:find("Arc Indicator") and (attachment.description == turret_mount) then
                id = self.removeAttachment(attachment.index)
                id.setRotation(self.getRotation() + Global.getTable('mountRotations')[args.arc] or Vector(0, 0, 0))
                self.addAttachment(id)
                Wait.frames(DisableAttachedColliders, 2)
            end
        end
    end
end

function GetTurretType(args)
    local turret_mount = args.mount or 'main'
    local turret = self.getTable('Data').arcs.turret[turret_mount]
    if turret then
        return turret.type
    end
    return nil;
end

shipIconPos = {
    small = "78 -50 0",
    medium = "135 -110 0",
    large = "180 -152 0",
    huge = "180 -550 0",
}

initiativeIconPos = {
    small = "-78 -50 0",
    medium = "-135 -110 0",
    large = "-180 -152 0",
    huge = "-180 -550 0",
}

NamePos = {
    small = "0 -88 0",
    medium = "0 -145 0",
    large = "0 -198 0",
    huge = "0 -593 0",
}

function setCustomization(args)
    local attachments = self.getAttachments()
    for i = #attachments, 1, -1 do
        local attachment = attachments[i]
        if attachment.name == "Config" or attachment.name == "Ship" then
            local model = self.removeAttachment(attachment.index)
            if args.tint then
                model.setColorTint(args.tint)
            end
            local custom = model.getCustomObject()
            custom.diffuse = args.texture
            if attachment.name == "Ship" then
                custom.mesh = args.model
                model.setCustomObject(custom)
                model = model.reload()
                self.addAttachment(model)
            elseif args.configs then
                if args.configs[tonumber(attachment.description)] then
                    custom.mesh = args.configs[tonumber(attachment.description)]
                    model.setCustomObject(custom)
                    model = model.reload()
                    self.addAttachment(model)
                else
                    destroyObject(model)
                end
            else
                model.setCustomObject(custom)
                model = model.reload()
                self.addAttachment(model)
            end
        end
    end
    DisableAttachedColliders()
    Wait.time(DisableAttachedColliders, 5)
end

function setupUI()
    if self.getTable("UiData") then
        local size = self.getTable("Data").Size or "small"
        self.UI.setAttribute("ShipIcon", "image", self.getTable("UiData").icon)
        self.UI.setAttribute("ShipIcon", "position", shipIconPos[size])
        self.UI.setAttribute("InitiativeIcon", "image", self.getTable("UiData").init)
        self.UI.setAttribute("InitiativeIcon", "position", initiativeIconPos[size])
        self.UI.setValue("Name", self.getTable("UiData").name)
        self.UI.setAttribute("Name", "position", NamePos[size])
        self.setName(self.getTable("UiData").name)
    end
    DisableAttachedColliders()
    Wait.time(DisableAttachedColliders, 5)
end

function NextTexture()
    local data = self.getTable("Data")
    local next_texture = nil
    local select_next = false
    for texture, url in pairs(data.textures) do
        if next_texture == nil then
            next_texture = texture
        end
        if select_next then
            next_texture = texture
            break
        end
        if texture == data.texture then
            select_next = true
        end
    end
    data.texture = next_texture
    self.setTable('Data', data)
    local texture_url = data.textures[next_texture]
    setCustomization({ texture = texture_url })
end

function TogglePeg()
    local attachments = self.getAttachments()
    for i = #attachments, 1, -1 do
        local attachment = attachments[i]
        if attachment.name == "Peg" then
            local model = self.removeAttachment(attachment.index)
            local tint = model.getColorTint()
            if tint[4] == 1.0 then
                tint[4] = 0
            else
                tint[4] = 1.0
            end
            model.setColorTint(tint)
            self.addAttachment(model)
        end
    end
    Wait.frames(function() DisableAttachedColliders() end, 2)
end

function SpawnCustomizer()
    local sizemod = { small = 1.0, medium = 0.75, large = 0.5 }
    local data = self.getTable('Data')
    local customizer = nil
    customizer = spawnObject({
        type         = "Custom_Model",
        position     = self.getPosition() - self.getTransformRight() * 3.5,
        rotation     = self.getRotation(),
        scale        = self.getScale() * sizemod[data.Size],
        sound        = false,
        snap_to_grid = false,
    })
    local texture_url = data.textures[data.texture]
    customizer.setCustomObject({
        type = 0,
        material = 3,
        mesh = data.mesh or
            'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/minisculebox.obj',
        diffuse = texture_url,
    })
    local configs = {}
    if data.Config then
        for _, config in pairs(data.Config.States) do
            table.insert(configs, config.Model)
        end
    end
    local tint = Color.White
    for _, attachment in pairs(self.getAttachments()) do
        if attachment.name == "Config" or attachment.name == "Ship" then
            part = self.removeAttachment(attachment.index)
            tint = part.getColorTint()
            self.addAttachment(part)
            break
        end
    end
    customizer.setColorTint(tint)
    customizer.setTable("Configs", configs)
    customizer.setLuaScript(customizer_script)
end

function SetInitiative(args)
    local uitable = self.getTable("UiData")
    uitable.init = "init" .. tostring(tonumber(args.init))
    self.setTable('UiData', uitable)
    setupUI()
end

function SetName(args)
    local uitable = self.getTable("UiData")
    if uitable == nil then
        return
    end
    uitable.name = replaceStarWithDot(args.name)
    self.setTable('UiData', uitable)
    setupUI()
end

-- Replaces "•" with "*"
function replaceDotWithStar(name)
    if name then
        return name:gsub('•', function(char) if char == '•' then return '*' end end)
    end
end

-- Replaces "*" back to "•"
function replaceStarWithDot(name)
    if name then
        return name:gsub("%*", "•")
    end
end

function removeQuotes(name)
    if name then
        return name:gsub('"', "")
    end
end

-- Save self state
function onSave()
    self.setName(removeQuotes(self.getName()))
    local state = { shipData = self.getTable("Data"), arcIndicators = self.getTable("arc_indicators") }
    state.finishedSetup = self.getVar("finished_setup")
    state.tokenData = { tokens = {} }
    state.owningPlayer = self.getVar("owningPlayer")
    state.isAi = self.getVar("isAi")
    state.strikeTargets = self.getTable("StrikeTargets")
    state.uiData = self.getTable("UiData")

    if state.uiData and state.uiData.name then
        state.uiData.name = replaceDotWithStar(state.uiData.name)
    end

    state.interactable = self.interactable
    for guid, _ in pairs(assigned_tokens) do
        table.insert(state.tokenData.tokens, guid)
    end

    return JSON.encode(state)
end

-- Restore self state
function onLoad(savedData)
    if savedData ~= "" and Data == nil then
        local state = JSON.decode(savedData)
        self.setTable("Data", state.shipData)
        self.setTable("arc_indicators", state.arcIndicators)
        self.setTable("UiData", state.uiData)
        if UiData then
            UiData['name'] = replaceStarWithDot(UiData['name'])
        end
        self.setVar("finished_setup", state.finishedSetup)
        self.setVar("owningPlayer", state.owningPlayer)
        self.setVar("isAi", state.isAi)
        self.setTable("StrikeTargets", state.strikeTargets)
        self.interactable = state.interactable or false
        for _, guid in ipairs(state.tokenData.tokens) do
            Global.call('API_AssignToken', { token = getObjectFromGUID(guid), ship = self })
        end
    end
    local function hasLoadFinished()
        return (not self.spawning) and (not self.UI.loading) and (not self.loading_custom)
    end
    Wait.condition(function()
        initContextMenu()
        setupUI()
    end, hasLoadFinished)
end
