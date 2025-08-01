markers = nil
function onLoad()
    self.addContextMenuItem("Setup Aces High", toggleAcesHighSetup, false)
end

function toggleAcesHighSetup()
    if markers == nil then
        markers = {}
        self.takeObject({
            position          = { -15.25, 0.97, -4.90 },
            rotation          = { 0.00, 44.92, 0.00 },
            flip              = false,
            smooth            = false,
            callback_function = function(obj)
                obj.setLock(true)
                table.insert(markers, obj)
            end
        })
        local mark2 = self.takeObject({
            position          = { -32.36, 1.06, -11.83 },
            rotation          = { 0.00, 314.99, 180.00 },
            flip              = false,
            smooth            = false,
            callback_function = function(obj)
                obj.setLock(true)
                table.insert(markers, obj)
            end
        })
        local mark3 = self.takeObject({
            position          = { -25.21, 0.97, 4.80 },
            rotation          = { 0.00, 225.00, 0.00 },
            flip              = false,
            smooth            = false,
            callback_function = function(obj)
                obj = obj.setState(2)
                obj.setLock(true)
                table.insert(markers, obj)
            end
        })
        local mark4 = self.takeObject({
            position          = { -8.73, 1.06, 11.79 },
            rotation          = { 0.00, 134.98, 180.00 },
            flip              = false,
            smooth            = false,
            callback_function = function(obj)
                obj = obj.setState(2)
                obj.setLock(true)
                table.insert(markers, obj)
            end
        })
    else
        for _, marker in pairs(markers) do
            if marker ~= nil then
                marker.destruct()
            end
        end
        markers = nil
    end
end
