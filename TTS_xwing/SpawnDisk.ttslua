self.createButton({
    click_function = 'spawnerCaller',
    function_owner = self,
    label          = 'Spawn',
    position       = { 0, 0.02, 0.35 },
    rotation       = { 0, 0, 0 },
    scale          = { 0.1, 0.1, 0.1 },
    width          = 2000,
    height         = 500,
    font_size      = 400,
    color          = 'Black',
    font_color     = 'White',
    tooltip        = 'Click here to spawn the saved list',
})

customizing = true

function spawnerCaller()
    spawnTable = self.getTable("List")
    spawnTable.spawnCard = self
    Global.call('newSpawner', spawnTable)
    spawnTable = nil
end

function onSave()
    if state == nil then
        local state = { cardData = self.getTable("List") }
        return JSON.encode(state)
    end
end

function onObjectDrop(player_color, dropped_object)
    if customizing then
        local relpos = self.positionToLocal(dropped_object.getPosition())
        local distance = math.sqrt(relpos[1] * relpos[1] + relpos[2] * relpos[2] + relpos[3] * relpos[3])
        if distance < 1 then
            if (dropped_object.tag == 'Figurine') and (dropped_object.getVar("__XW_Ship") == true) then
                printToAll(self.getName() .. " gets the customization of " .. dropped_object.getName(), color(1.0, 0.5, 0.0))
                local customobj = dropped_object.getCustomObject()
                customization = List.Customization[dropped_object.getName()] or {}
                customization.model = customobj.mesh
                customization.texture = customobj.diffuse
                customization.modeltint = dropped_object.getColorTint()
                for i, attachment in pairs(dropped_object.getAttachments()) do
                    if attachment.name == "ColorId" then
                        id = dropped_object.removeAttachment(attachment.index)
                        customization.tint = id.getColorTint(tint)
                        dropped_object.addAttachment(id)
                    end
                end
                List.Customization[dropped_object.getName()] = customization
            elseif dropped_object.tag == 'Card' then
                printToAll(self.getName() .. " gets the customization of " .. dropped_object.getName() .. " card", color(1.0, 0.5, 0.0))
                customization = List.Customization[dropped_object.getName()] or {}
                customization.face = dropped_object.getCustomObject().face
                customization.back = dropped_object.getCustomObject().back
                List.Customization[dropped_object.getName()] = customization
            end
        end
    end
end

-- Restore self state
function onLoad(savedData)
    --print("OnLoad: ".. self.getName() .. " " .. savedData)
    if savedData ~= "" then
        self.setTable("List", JSON.decode(savedData).cardData)
    end
end
