-- StarForgeLayout.ttslua

StarForgeLayout = {
    epic = { x = -35, y = 2, z = -14 },
    start = { x = -35, y = 2, z = -14 },
    position = { x = 0, y = 0, z = 0 },
    count = 0,
    
    -- Calculate the next position based on count
    -- TODO: Could take the object to be placed and attempt to avoid collisions.
    nextPosition = function(self)
        self.count = self.count + 1
        self.position = {
            x = self.start.x + math.floor(self.count / 10) * 3.5,
            y = self.start.y,
            z = self.start.z + (self.count % 10) * 3
        }
        return self.position
    end,
    reset = function (self)
        self.count = 0
    end
}

return StarForgeLayout
