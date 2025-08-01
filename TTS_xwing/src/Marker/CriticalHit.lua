-------------------------------------------------------------
--- Original Script and Art by Joshmoe554---------------------
-------------------------------------------------------------
---Adapted to work with Custom Damage Decks by Crazy Vulcan--
-------------------------------------------------------------

-- The images for each individual crit.
Images =
{
    CriticalHit = 'http://cloud-3.steamusercontent.com/ugc/1017194853900822818/FBCDC3FF46CDD3BFCE5D2E3F3019BE682D4656D6/',
    BlindedPilot =
    'http://cloud-3.steamusercontent.com/ugc/1017194853900831678/EB80F1EFB24BD1D2A19FDA566297E96F54EB18FB/',
    ConsoleFire = 'http://cloud-3.steamusercontent.com/ugc/1017194853900841247/4EAB9AFF4F73ED463CB2A9BE972A0F975581C9DF/',
    DamagedEngine =
    'http://cloud-3.steamusercontent.com/ugc/1017194853900846085/F0A18A9E6181782FBB3D93767C2B405EFF7D718F/',
    DamagedSensorArray =
    'http://cloud-3.steamusercontent.com/ugc/1017194853900847700/FAFB80301297A40001A0913509253528EC8A0749/',
    DisabledPowerRegulator =
    'http://cloud-3.steamusercontent.com/ugc/1017194853900848990/96A11517CF861E7135BC96FEA1AEA3EB75AA8D1E/',
    FuelLeak = 'http://cloud-3.steamusercontent.com/ugc/1017194853900850869/592384D4BE032B5FE772C10B87A538BA44EE574E/',
    HullBreach = 'http://cloud-3.steamusercontent.com/ugc/1017194853900852244/741E571E2C3B61F1A3D2DB7EF5345F7161E8DB44/',
    LooseStabilizer =
    'http://cloud-3.steamusercontent.com/ugc/1017194853900853454/DD25852419E960F0F25837F7F037468C5752E526/',
    StructuralDamage =
    'http://cloud-3.steamusercontent.com/ugc/1017194853900854946/12B5247AEA9D457D4568BC34C30C61328CDC0DC9/',
    StunnedPilot =
    'http://cloud-3.steamusercontent.com/ugc/1017194853900855951/CBF054AF3E3313902C6F863FCED2CC185D9859AB/',
    WeaponsFailure =
    'http://cloud-3.steamusercontent.com/ugc/1017194853900857431/98C766CA3827FA1F94E6B0062D47AC3FF4C01141/',
    WoundedPilot =
    'http://cloud-3.steamusercontent.com/ugc/1017194853900859087/C2DED547D22D44E76CB005250E32BAB0D8B9D9C0/'
}

-- Removed for now.  For now, this will just assume a card is a damage card.  The damage card backs are only
-- used to identify decks that are using a different crit order.
--DamageCardBack = 'http://cloud-3.steamusercontent.com/ugc/919176040734153013/698D86D59D895E81014C563124F02588FC9C7F41/'

-- The backs of the faction damage decks.
REB_DamageCardBack =
'http://cloud-3.steamusercontent.com/ugc/1021700505297731217/E90648B79A41C9422866EAEEB61091E8AAC18A17/'
IMP_DamageCardBack =
'http://cloud-3.steamusercontent.com/ugc/1021700308760157467/0FCF207040A77E7CD02D83A543F4968499F530D4/'
SCUM_DamageCardBack =
'http://cloud-3.steamusercontent.com/ugc/1021700505297740500/413E9084E880E86ABE297C05D05F56E5BA01BAF6/'
RIS_DamageCardBack =
'http://cloud-3.steamusercontent.com/ugc/1021700308760233507/8DC53DF987FDD4A47FA25ABF8E55FED045557FD6/'
FO_DamageCardBack =
'http://cloud-3.steamusercontent.com/ugc/1021700505297719267/01067DDCA8602EF038050E79573A15408F04B9FA/'
GRP_DamageCardBack =
'http://cloud-3.steamusercontent.com/ugc/1021700308760057332/D053AF6145BAAE2AE39E04D205128D6A7A4FEC03/'
CIS_DamageCardBack =
'http://cloud-3.steamusercontent.com/ugc/1021700308759725288/38037546D88D2CD0E2B91FB5EE6261CC83E00136/'

-- The indexed crit names used to name the tokens and adjust the image.
CritNames =
{
    ['00'] = 'CriticalHit', -- Panicked Pilot
    ['01'] = 'CriticalHit',
    ['02'] = 'BlindedPilot',
    ['03'] = 'BlindedPilot',
    ['04'] = 'WoundedPilot',
    ['05'] = 'WoundedPilot',
    ['06'] = 'StunnedPilot',
    ['07'] = 'StunnedPilot',
    ['08'] = 'ConsoleFire',
    ['09'] = 'ConsoleFire',
    ['10'] = 'DamagedEngine',
    ['11'] = 'DamagedEngine',
    ['12'] = 'WeaponsFailure',
    ['13'] = 'WeaponsFailure',
    ['14'] = 'HullBreach',
    ['15'] = 'HullBreach',
    ['16'] = 'StructuralDamage',
    ['17'] = 'StructuralDamage',
    ['18'] = 'DamagedSensorArray',
    ['19'] = 'DamagedSensorArray',
    ['20'] = 'LooseStabilizer',
    ['21'] = 'LooseStabilizer',
    ['22'] = 'DisabledPowerRegulator',
    ['23'] = 'DisabledPowerRegulator',
    ['24'] = 'FuelLeak',
    ['25'] = 'FuelLeak',
    ['26'] = 'FuelLeak',
    ['27'] = 'FuelLeak',
    ['28'] = 'CriticalHit', -- Direct Hit
    ['29'] = 'CriticalHit',
    ['30'] = 'CriticalHit',
    ['31'] = 'CriticalHit',
    ['32'] = 'CriticalHit',
}

AltCritNames =
{
    ['00'] = 'BlindedPilot',
    ['01'] = 'BlindedPilot',
    ['02'] = 'ConsoleFire',
    ['03'] = 'ConsoleFire',
    ['04'] = 'DamagedEngine',
    ['05'] = 'DamagedEngine',
    ['06'] = 'DamagedSensorArray',
    ['07'] = 'DamagedSensorArray',
    ['08'] = 'CriticalHit', -- Direct Hit
    ['09'] = 'CriticalHit',
    ['10'] = 'CriticalHit',
    ['11'] = 'CriticalHit',
    ['12'] = 'CriticalHit',
    ['13'] = 'DisabledPowerRegulator',
    ['14'] = 'DisabledPowerRegulator',
    ['15'] = 'FuelLeak',
    ['16'] = 'FuelLeak',
    ['17'] = 'FuelLeak',
    ['18'] = 'FuelLeak',
    ['19'] = 'HullBreach',
    ['20'] = 'HullBreach',
    ['21'] = 'LooseStabilizer',
    ['22'] = 'LooseStabilizer',
    ['23'] = 'CriticalHit', -- Panicked Pilot
    ['24'] = 'CriticalHit',
    ['25'] = 'StructuralDamage',
    ['26'] = 'StructuralDamage',
    ['27'] = 'StunnedPilot',
    ['28'] = 'StunnedPilot',
    ['29'] = 'WeaponsFailure',
    ['30'] = 'WeaponsFailure',
    ['31'] = 'WoundedPilot',
    ['32'] = 'WoundedPilot',
}

AltCritNamesCIS =
{
    ['00'] = 'CriticalHit', -- Panicked Pilot
    ['01'] = 'CriticalHit', -- Direct Hit
    ['02'] = 'CriticalHit',
    ['03'] = 'CriticalHit',
    ['04'] = 'CriticalHit',
    ['05'] = 'CriticalHit',
    ['06'] = 'FuelLeak',
    ['07'] = 'FuelLeak',
    ['08'] = 'FuelLeak',
    ['09'] = 'FuelLeak',
    ['10'] = 'DisabledPowerRegulator',
    ['11'] = 'DisabledPowerRegulator',
    ['12'] = 'LooseStabilizer',
    ['13'] = 'LooseStabilizer',
    ['14'] = 'DamagedSensorArray',
    ['15'] = 'DamagedSensorArray',
    ['16'] = 'StructuralDamage',
    ['17'] = 'StructuralDamage',
    ['18'] = 'HullBreach',
    ['19'] = 'HullBreach',
    ['20'] = 'WeaponsFailure',
    ['21'] = 'WeaponsFailure',
    ['22'] = 'DamagedEngine',
    ['23'] = 'DamagedEngine',
    ['24'] = 'ConsoleFire',
    ['25'] = 'ConsoleFire',
    ['26'] = 'StunnedPilot',
    ['27'] = 'StunnedPilot',
    ['28'] = 'WoundedPilot',
    ['29'] = 'WoundedPilot',
    ['30'] = 'BlindedPilot',
    ['31'] = 'BlindedPilot',
    ['32'] = 'CriticalHit', -- Panicked Pilot
}

-- Variable to prevent it from updating multiple times on a collision.
setToken = false

-- Variable to check if this is one of the crit tokens.
IsCritToken = true

function onPickUp(color)
    setToken = true
end

-- When this collides with a damage card, check what card it is and
-- update the image and name.
function onCollisionEnter(collisionInfo)
    if setToken then
        local obj = collisionInfo.collision_object

        local critNameTable = CritNames

        local objData = obj.getCustomObject()
        if objData.back ~= nil and obj.is_face_down == false then
            -- If this is Crazy Vulcan's faction damage decks, they use a different card order
            -- then the crit order so we are using different tables for those decks.
            if objData.back == REB_DamageCardBack or objData.back == IMP_DamageCardBack or
                objData.back == SCUM_DamageCardBack or objData.back == RIS_DamageCardBack or
                objData.back == FO_DamageCardBack or objData.back == GRP_DamageCardBack then
                critNameTable = AltCritNames
            elseif objData.back == CIS_DamageCardBack then
                critNameTable = AltCritNamesCIS
            end

            local cardId = getCardID(obj)

            if cardId ~= nil then
                local critName = critNameTable[string.sub(cardId, -2)]

                if critName ~= nil then
                    -- Set token name
                    self.setName(splitCamel(critName))

                    -- Set token image
                    local customTable = self.getCustomObject()
                    customTable.diffuse = Images[critName]
                    self.setCustomObject(customTable)
                    self.reload()

                    setToken = false
                end
            end
        end
    end
end

-- Convert the camelcase name to a multi-word name.
function splitCamel(s)
    local function split(char)
        return " " .. char
    end

    return (s:gsub("[A-Z]", split):gsub("^.", string.upper))
end

-- Get the card's ID to figure out which crit it is.
function getCardID(card)
    local cardData = JSON.decode(card.getJSON())
    return cardData['CardID']
end

-- Debug function to display the values of a table into the chat.
function displayTable(arg)
    output = ""
    for key, value in pairs(arg) do
        output = output .. "\n" .. key .. ": ";
        if type(value) == "table" then
            output = output .. displayTable(value)
        elseif type(value) == 'boolean' then
            if value then
                output = output .. "true"
            else
                output = output .. "false"
            end
        else
            output = output .. value
        end
    end

    return output
end
