local obj = self

local B = {}

local offsetXY = {
    Setup = "0 0",
    proxyPanel = "0 -215",
}

local function changeButtonState(button, activate)
    if activate then
        obj.UI.setAttribute(button, "active", "true")
        -- deactivating a button resets text color to black, we have to set it again
        obj.UI.setAttribute(button, "textColor", "#FFFFFF")
    else
        obj.UI.setAttribute(button, "active", "false")
    end
end

function B.setAttributeFacing(attribute, face_state)
    local up_rotation   = "0 180 0"
    local down_rotation = "0 0 0"
    local up_z          = "1"
    local down_z        = "-25"
    local base_xy       = offsetXY[attribute]

    local attributes    = {}
    if face_state == "Down" then
        attributes = {
            position = base_xy .. " " .. down_z,
            rotation = down_rotation,
        }
    elseif face_state == "Up" then
        attributes = {
            position = base_xy .. " " .. up_z,
            rotation = up_rotation,
        }
    end

    obj.UI.setAttributes(attribute, attributes)
end

function B.setProxyState(activate, cancellable, active_proxies)
    if activate then
        obj.UI.show("proxyPanel")
    else
        obj.UI.hide("proxyPanel")
    end

    changeButtonState("proxyCancelBtn", cancellable)

    --if not cancellable then
    --    changeButtonState("UndoBtn", not activate)
    --end

    if not active_proxies then
        obj.UI.setAttribute("proxyFrontBtn", "active", "false")
        obj.UI.setAttribute("proxyCenterBtn", "active", "false")
        obj.UI.setAttribute("proxyBackBtn", "active", "false")

        return
    end
    for position, guid in pairs(active_proxies) do
        local attribute_name = string.upper(position:sub(1, 1)) .. position:sub(2, -1)
        obj.UI.setAttribute("proxy" .. attribute_name .. "Btn", "onMouseEnter", guid .. "/onHoverEnter")
        obj.UI.setAttribute("proxy" .. attribute_name .. "Btn", "onMouseExit", guid .. "/onHoverLeave")
        obj.UI.setAttribute("proxy" .. attribute_name .. "Btn", "onClick", guid .. "/select")
        obj.UI.setAttribute("proxy" .. attribute_name .. "Btn", "active", "true")
    end
end

function B.setBarrelRollState(proxyMode, activate)
    if activate then
        obj.UI.setAttribute("BarrelRightFD", "active", "true")
        obj.UI.setAttribute("BarrelLeftFD", "active", "true")
        obj.UI.setAttribute("BarrelRBtn", "active", "true")
        obj.UI.setAttribute("BarrelLBtn", "active", "true")
    end

    local extra_buttons = tostring(not proxyMode)
    obj.UI.setAttribute("BarrelRFBtn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelRBBtn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelLFBtn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelLBBtn", "active", extra_buttons)
end

function B.setBarrelRoll2State(proxyMode, activate)
    if activate then
        obj.UI.setAttribute("BarrelRight2FD", "active", "true")
        obj.UI.setAttribute("BarrelLeft2FD", "active", "true")
        obj.UI.setAttribute("BarrelL2Btn", "active", "true")
        obj.UI.setAttribute("BarrelR2Btn", "active", "true")
    end

    local extra_buttons = tostring(not proxyMode)
    obj.UI.setAttribute("BarrelRF2Btn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelRB2Btn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelLF2Btn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelLB2Btn", "active", extra_buttons)
end

function B.setViperBarrelRollState(proxyMode, activate)
    if activate then
        obj.UI.setAttribute("BarrelRightFD", "active", "true")
        obj.UI.setAttribute("BarrelLeftFD", "active", "true")
    end
    local extra_buttons = tostring(proxyMode)
    obj.UI.setAttribute("BarrelVRUBtn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelVRDBtn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelVLUBtn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelVLDBtn", "active", extra_buttons)
end

function B.setTurnBarrelRollState(proxyMode, activate)
    if activate then
        obj.UI.setAttribute("BarrelRightFD", "active", "true")
        obj.UI.setAttribute("BarrelLeftFD", "active", "true")
    end
    local extra_buttons = tostring(proxyMode)
    obj.UI.setAttribute("BarrelVTRUBtn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelVTRDBtn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelVTLUBtn", "active", extra_buttons)
    obj.UI.setAttribute("BarrelVTLDBtn", "active", extra_buttons)
end

return B
