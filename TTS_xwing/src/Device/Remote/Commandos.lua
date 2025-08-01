local Dim = require("Dim")
ObjectiveTokenData = require("Marker.Scenario.ObjectiveTokenData")

ship_drop_positions = {
    small = {
        right = { pos = vector(-20, 0, 0), rot = 90 },
        left = { pos = vector(20, 0, 0), rot = -90 },
        back = { pos = vector(0, 20, 0), rot = 180 }
    },
    medium = {
        right = { pos = vector(-30, 0, 0), rot = 90 },
        left = { pos = vector(30, 0, 0), rot = -90 },
        back = { pos = vector(0, 30, 0), rot = 180 }
    },
    large = {
        right = { pos = vector(-40, 0, 0), rot = 90 },
        left = { pos = vector(40, 0, 0), rot = -90 },
        back = { pos = vector(0, 40, 0), rot = 180 }
    },
    huge = {
        right = { pos = vector(-40, 0, 0), rot = 90 },
        left = { pos = vector(40, 0, 0), rot = -90 },
        back = { pos = vector(0, 80, 0), rot = 180 }
    },
}

backwards = false
dropOrigin = nil
dropped = false
stat = false
arcsOpen = false
side = "(A)"

rulers = {}
rulersType = nil

Data = { Size = "objective" }

function onLoad(save_state)
    local state = JSON.decode(save_state)
    if state then
        self.setVar("owningPlayer", state.owningPlayer)
        self.setVar("dropped", state.dropped or false)
    end
    SetupContextMenu()

    --[[local vector_lines = {}
    for i, segment in pairs(ObjectiveTokenData.arc_line_segments.right.segments) do
      table.insert(vector_lines, {
          points = {segment[1] + vector(0,0.025,0), segment[2] + vector(0,0.025,0)},
          color = {1,1,1},
          thickness = 0.005,
          rotation = vector(0,0,0)
      })
    end
    self.setVectorLines(vector_lines)]]
end

function onSave()
    local state = { owningPlayer = self.getVar("owningPlayer"), dropped = dropped }
    return JSON.encode(state)
end

function SetupContextMenu()
    self.clearContextMenu()
    self.addContextMenuItem("Check Range 1", checkRange1, false)
    self.addContextMenuItem("Check Range 2", checkRange2, false)
    self.addContextMenuItem("Check Arc", arc, false)
end

scale = 1 / self.getScale().x

function onDropped(playerColor)
    local spos = self.getPosition()
    local nearest = nil
    local nearest_loc = nil
    local nearest_pos = nil
    local minDist = Dim.Convert_mm_igu(80)
    dropOrigin = self.getPosition()
    for _, ship in pairs(getObjectsWithTag('Ship')) do
        local pos = ship.getPosition()
        for _, pos_rot in pairs(ship_drop_positions[ship.getTable('Data').Size or "small"]) do
            local drop_pos = pos
                + Dim.Convert_mm_igu(ship.getTransformRight() * pos_rot.pos.x)
                + Dim.Convert_mm_igu(ship.getTransformForward() * pos_rot.pos.y)
            local dist = math.sqrt(math.pow((spos[1] - drop_pos[1]), 2) + math.pow((spos[3] - drop_pos[3]), 2))
            if dist < minDist then
                nearest = ship
                nearest_loc = pos_rot
                nearest_pos = drop_pos
                minDist = dist
                --print("Closer pos: " .. loc .. " dist: " .. tostring(dist))
            end
        end
    end
    if nearest ~= nil then
        side = self.is_face_down and "(A)" or "(B)"
        printToAll('Mandalorian Commandos ' .. side .. ' ready to drop', color(1.0, 1.0, 0))
        local side_offset = vector(0, 0.05, 0)
        if self.is_face_down then
            side_offset = side_offset * -1
        end

        backwards = math.abs(math.fmod((self.getRotation().y + 90) - (nearest.getRotation().y + nearest_loc.rot), 360)) < 90

        local drop_rot = nearest.getRotation() + vector(0, nearest_loc.rot + 90, 0)
        if backwards then
            drop_rot = drop_rot + vector(0, 180, 0)
        end
        if self.is_face_down then
            drop_rot = drop_rot + vector(0, 0, 180)
        end
        self.setLock(true)
        self.setPositionSmooth(nearest_pos + vector(0, 0.25, 0), false, false)
        self.setRotationSmooth(drop_rot, false, false)

        droploc = nearest_loc
        dropvector = nearest.getTransformForward():rotateOver("y", nearest_loc.rot)

        showDropButtons()
    end
end

function onContextOpen(player_color)
    showBtn()
end

function showBtn()
    if stat == false and dropped and not arcsOpen then
        if self.is_face_down then
            --self.UI.setAttribute("btnPanel", "rotation", "180 0 180")
            self.UI.setAttribute("btnPanel", "rotation", "180 0 0")
            self.UI.setAttribute("btnPanel", "position", "0 0 3")
        else
            self.UI.setAttribute("btnPanel", "rotation", "0 0 180")
            self.UI.setAttribute("btnPanel", "position", "0 0 -3")
        end
        self.UI.show("btnPanel")
        stat = true
    end
end

function hideBtn()
    if stat == true then
        self.UI.hide("btnPanel")
        stat = false
    end
end

function arc()
    checkArc("front", 2, false)
end

function checkRange1()
    checkArc("full", 1, true)
end

function checkRange2()
    checkArc("full", 2, true)
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
        hideBtn()
        local rotation = vector(0, -90, 0)
        local up = vector(0, 1, 0)
        if self.is_face_down then
            up = -1 * up
            rotation = rotation + vector(0, 0, 180)
        end
        local raise = 0.03 * up
        self.createButton({
            click_function = "removeArcs",
            function_owner = self,
            label          = "Remove",
            position       = raise,
            rotation       = rotation,
            width          = 170,
            height         = 150,
            font_size      = 40
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

moves = {
    Left = vector(1.81, 0, 1.81),
    Straight = vector(4, 0, 0),
    Right = vector(1.81, 0, -1.81)
}

rotation = {
    Left = vector(0, -90, 0),
    Straight = vector(0, 0, 0),
    Right = vector(0, 90, 0),
}

function relocate(P, option, id)
    local forward = self.getTransformRight()
    local right = self.getTransformForward()
    local up = self.getTransformUp()
    if self.is_face_down then
        up = -1 * up
        forward = -1 * forward
    end

    local movePos = moves[id]
    local pos = self.getPosition() + forward * movePos.x + right * movePos.z
    Global.call("API_ClearPosition", { pos = pos, reach = 0.5 })
    self.setPositionSmooth(pos, false, false)
    self.setRotationSmooth(self.getRotation() + rotation[id], false, false)
    printToAll('Mandalorian Commandos ' .. side .. ' relocated ' .. id, color(1.0, 1.0, 0))
end

function onPickUp(playerColor)
    self.setVar("owningPlayer", playerColor)
    local color = Color.fromString(playerColor)
    dropped = false
    self.setColorTint(color)
end

function showDropButtons()
    self.clearButtons()
    local rotation = vector(0, -90, 0)
    local forward = vector(-1, 0, 0)
    local right = vector(0, 0, 1)
    local up = vector(0, 1, 0)
    if backwards then
        forward = forward * -1
        right = right * -1
        rotation = rotation + vector(0, 180, 0)
    end
    if self.is_face_down then
        up = -1 * up
        forward = forward * -1
        rotation = rotation + vector(0, 0, 180)
    end

    local raise = 0.03 * up

    self.createButton({
        click_function = "dropR",
        function_owner = self,
        label = "1R",
        position = -0.2 * right + raise + 0.3 * forward,
        rotation = vector(0, 45, 0) + rotation,
        width = 60,
        height = 60,
        font_size = 40
    })
    self.createButton({
        click_function = "drop2R",
        function_owner = self,
        label = "2R",
        position = -0.25 * right + raise + 0.45 * forward,
        rotation = vector(0, 45, 0) + rotation,
        width = 60,
        height = 60,
        font_size = 40
    })
    self.createButton({
        click_function = "dropS",
        function_owner = self,
        label          = "1s",
        position       = raise + 0.35 * forward,
        rotation       = rotation,
        width          = 60,
        height         = 60,
        font_size      = 40
    })
    self.createButton({
        click_function = "drop2S",
        function_owner = self,
        label          = "2S",
        position       = raise + 0.5 * forward,
        rotation       = rotation,
        width          = 60,
        height         = 60,
        font_size      = 40
    })
    self.createButton({
        click_function = "dropL",
        function_owner = self,
        label          = "1L",
        position       = 0.2 * right + raise + 0.3 * forward,
        rotation       = vector(0, -45, 0) + rotation,
        width          = 60,
        height         = 60,
        font_size      = 40
    })
    self.createButton({
        click_function = "drop2L",
        function_owner = self,
        label          = "2L",
        position       = 0.25 * right + raise + 0.45 * forward,
        rotation       = vector(0, -45, 0) + rotation,
        width          = 60,
        height         = 60,
        font_size      = 40
    })
    self.createButton({
        click_function = "cancelDrop",
        function_owner = self,
        label          = "Cancel",
        position       = raise + 0.05 * forward,
        rotation       = rotation,
        width          = 150,
        height         = 100,
        font_size      = 40
    })
end

function cancelDrop()
    self.setPositionSmooth(dropOrigin, false, false)
    self.setLock(false)
    self.clearButtons()
end

function dropR()
    printToAll('Mandalorian Commandos ' .. side .. ' dropped using a 1 right bank template', color(1.0, 1.0, 0))
    drop(vector(2.44, 0, -1.24), vector(0, 45, 0))
end

function drop2R()
    printToAll('Mandalorian Commandos ' .. side .. ' dropped using a 2 right bank template', color(1.0, 1.0, 0))
    drop(vector(3.73, 0, -1.77), vector(0, 45, 0))
end

function dropL()
    printToAll('Mandalorian Commandos ' .. side .. ' dropped using a 1 left bank template', color(1.0, 1.0, 0))
    drop(vector(2.44, 0, 1.24), vector(0, -45, 0))
end

function drop2L()
    printToAll('Mandalorian Commandos ' .. side .. ' dropped using a 2 left bank template', color(1.0, 1.0, 0))
    drop(vector(3.73, 0, 1.77), vector(0, -45, 0))
end

function dropS()
    printToAll('Mandalorian Commandos ' .. side .. ' dropped using a 1 straight template', color(1.0, 1.0, 0))
    drop(vector(2, 0, 0), vector(0, 0, 0))
end

function drop2S()
    printToAll('Mandalorian Commandos ' .. side .. ' dropped using a 2 straight template', color(1.0, 1.0, 0))
    drop(vector(3, 0, 0), vector(0, 0, 0))
end

function drop(position, rotation)
    local forward = self.getTransformRight()
    local right = self.getTransformForward()
    local up = self.getTransformUp()
    local upOffset = up * 0.30
    if backwards then
        forward = forward * -1
        right = right * -1
    end
    if self.is_face_down then
        up = -1 * up
        forward = forward * -1
        upOffset = up * 0.2
    end
    local pos = self.getPosition() + forward * position.x - upOffset + right * position.z
    self.setRotationSmooth(self.getRotation() + rotation, false, false)
    Global.call("API_ClearPosition", { pos = pos, reach = 0.5 })
    self.setPositionSmooth(pos, false, false)
    self.clearButtons()
    dropped = true
end
