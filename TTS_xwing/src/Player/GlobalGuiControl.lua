local GlobalGuiControl = {
    playerTable = {},
    shown = {
        showMouseOverGui = true,
    }
}

GlobalGuiControl.getPlayerConfig = function(playerColor)
    if not GlobalGuiControl.playerTable[playerColor] then
        GlobalGuiControl.playerTable[playerColor] = { panels = { hover = false } }
    end
    return GlobalGuiControl.playerTable[playerColor]
end

GlobalGuiControl.showForPlayer = function(params)
    local panel = params.panel
    local color = params.color
    local opened = self.UI.getAttribute(panel, "visibility")
    if opened == nil then opened = "" end

    if params.close then
        opened = opened:gsub("|" .. color, "")
        opened = opened:gsub(color .. "|", "")
        opened = opened:gsub(color, "")
        self.UI.setAttribute(panel, "visibility", opened)
        if opened == "" then
            self.UI.setAttribute(panel, "active", "false")
            GlobalGuiControl.shown[panel] = false
        end
    else
        if GlobalGuiControl.shown[panel] ~= true then
            self.UI.setAttribute(panel, "active", "true")
            self.UI.setAttribute(panel, "visibility", color)
            GlobalGuiControl.shown[panel] = true
        else
            self.UI.setAttribute(panel, "visibility", opened .. "|" .. color)
        end
    end
end

GlobalGuiControl.recreateHoverPanels = function()
    local xml = Global.UI.getXmlTable()
    for i = #xml, 1, -1 do
        if xml[i].attributes.id and xml[i].attributes.id:find("HoverPanel") then
            table.remove(xml, i)
        end
    end

    for player, config in pairs(GlobalGuiControl.playerTable) do
        if config.panels.hover then
            print("PlayerPanel: " .. player)
            local playerPanel = {
                tag = "Panel",
                attributes = {
                    visibility = player,
                    id = player .. "HoverPanel",
                    class = "HoverPanel",
                    width = "300",
                    childAlignment = "MiddleRight"
                },

                children = {
                    tag = "HorizontalLayout",
                    attributes = {
                        childForceExpandHeight = false,
                        childForceExpandWidth = false,
                        childAlignment = "MiddleRight"
                    },
                    children = {
                        {
                            tag = "Button",
                            attributes = {
                                textColor = "#FFFFFF",
                                onClick = "mark",
                                minWidth = "250",
                                id = "iniEntry"
                            },
                            value = " - "
                        },
                        -- TODO: This is unexpected in X-Wing
                        {
                            tag = "Button",
                            attributes = {
                                onClick = "getMonsterAC",
                                text = "▶",
                                id = "MonsterAbilityCard",
                                minWidth = "23",
                                maxWidth = "23",
                                minHeight = "25",
                                fontSize = "12",
                                onClick = "hideMouseOverGui(" .. player .. ")"
                            }
                        }
                    }
                }

            }
            table.insert(xml, playerPanel)
        end
    end
    Global.UI.setXmlTable(xml)
end

function showMouseOverGui(player, opt, id)
    player_config = GlobalGuiControl.getPlayerConfig(player.color)
    player_config.panels.hover = true
    GlobalGuiControl.showForPlayer({ color = player.color, panel = "showMouseOverGui", close = true })
    GlobalGuiControl.recreateHoverPanels()
end

function hideMouseOverGui(player, opt, id)
    player_config = GlobalGuiControl.getPlayerConfig(player.color)
    player_config.panels.hover = false
    GlobalGuiControl.showForPlayer({ color = player.color, panel = "showMouseOverGui", close = false })
    GlobalGuiControl.recreateHoverPanels()
end

return GlobalGuiControl
