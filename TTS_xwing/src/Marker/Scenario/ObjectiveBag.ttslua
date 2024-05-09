function onLoad()
    self.addContextMenuItem("Place Objective", placeCenterObjective, false)
end

function placeCenterObjective()
    self.takeObject({
        position          = { -20.51, 1.1, 0.00 },
        rotation          = { 180.00, 0.0, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("CenterObjective")
            obj.setLock(true)
        end
    })
end
