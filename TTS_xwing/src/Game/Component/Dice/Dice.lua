dicecolor = dicecolor or "Green"
diceValues = {
    Red = {"Blank", "Eye", "Hit", "Hit", "Blank", "Eye", "Hit", "Crit"},
    Green = {"Blank", "Eye", "Evade", "Evade", "Blank", "Eye", "Evade", "Blank"}
}

function onNumberTyped(playerColor, number)
    if not self.resting then
        printToAll("WARNING! " .. playerColor .. " modified a dice to " .. diceValues[dicecolor][number] .. " while rolling!", color(1,0,0,1))
    else
        printToAll(playerColor .. " modified a dice from " .. self.getRotationValue() .. " to " .. diceValues[dicecolor][number])
    end
end
