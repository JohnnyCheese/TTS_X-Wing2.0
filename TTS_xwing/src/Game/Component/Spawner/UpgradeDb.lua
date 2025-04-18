masterUpgradesDB = {}
masterUpgradesDB['crackshot'] = {
    name = 'Crack Shot',
    XWS = 'crackshot',
    slot = 1,
    Charge = 1,
}

masterUpgradesDB['daredevil'] = {
    name = 'Daredevil',
    XWS = 'daredevil',
    slot = 1,
    addAction = { 'Dare' },
    restriction = { Size = { small = true } }
}

masterUpgradesDB['debrisgambit'] = {
    name = 'Debris Gambit',
    XWS = 'debrisgambit',
    slot = 1,
    addAction = { 'E' },
    restriction = { Size = { small = true, medium = true } }
}

masterUpgradesDB['elusive'] = {
    name = 'Elusive',
    XWS = 'elusive',
    slot = 1,
    Charge = 1,
    restriction = { Size = { small = true, medium = true } }
}

masterUpgradesDB['experthandling'] = {
    name = 'Expert Handling',
    XWS = 'experthandling',
    slot = 1,
}

masterUpgradesDB['fearless'] = {
    name = 'Fearless',
    XWS = 'fearless',
    slot = 1,
    restriction = {
        Faction = { [3] = true }
    }
}

masterUpgradesDB['intimidation'] = {
    name = 'Intimidation',
    XWS = 'intimidation',
    slot = 1,
}

masterUpgradesDB['juke'] = {
    name = 'Juke',
    XWS = 'juke',
    slot = 1,
    restriction = { Size = { small = true, medium = true } }
}

masterUpgradesDB['lonewolf'] = {
    name = 'Lone Wolf',
    XWS = 'lonewolf',
    slot = 1,
    Charge = 1,
}

masterUpgradesDB['marksmanship'] = {
    name = 'Marksmanship',
    XWS = 'marksmanship',
    slot = 1,
}

masterUpgradesDB['outmaneuver'] = {
    name = 'Outmaneuver',
    XWS = 'outmaneuver',
    slot = 1,
}

masterUpgradesDB['predator'] = {
    name = 'Predator',
    XWS = 'predator',
    slot = 1,
}

masterUpgradesDB['ruthless'] = {
    name = 'Ruthless',
    XWS = 'ruthless',
    slot = 1,
    restriction = {
        Faction = { [2] = true }
    }
}

masterUpgradesDB['saturationsalvo'] = {
    name = 'Saturation Salvo',
    XWS = 'saturationsalvo',
    slot = 1,
}

masterUpgradesDB['selfless'] = {
    name = 'Selfless',
    XWS = 'selfless',
    slot = 1,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['squadleader'] = {
    name = 'Squad Leader',
    XWS = 'squadleader',
    slot = 1,
}

masterUpgradesDB['swarmtactics'] = {
    name = 'Swarm Tactics',
    XWS = 'swarmtactics',
    slot = 1,
}

masterUpgradesDB['trickshot'] = {
    name = 'Trick Shot',
    XWS = 'trickshot',
    slot = 1,
}

masterUpgradesDB['heightenedperception'] = {
    name = 'Heightened Perception',
    XWS = 'heightenedperception',
    slot = 17,
}

masterUpgradesDB['instinctiveaim'] = {
    name = 'Instinctive Aim',
    XWS = 'instinctiveaim',
    slot = 17,
}

masterUpgradesDB['sense'] = {
    name = 'Sense',
    XWS = 'sense',
    slot = 17,
}

masterUpgradesDB['supernaturalreflexes'] = {
    name = 'Supernatural Reflexes',
    XWS = 'supernaturalreflexes',
    slot = 17,
    addAction = { 'B', 'BR' },
    restriction = { Size = { small = true } }
}

masterUpgradesDB['advancedsensors'] = {
    name = 'Advanced Sensors',
    XWS = 'advancedsensors',
    slot = 2,
}

masterUpgradesDB['collisiondetector'] = {
    name = 'Collision Detector',
    XWS = 'collisiondetector',
    slot = 2,
    Charge = 2
}

masterUpgradesDB['firecontrolsystem'] = {
    name = 'Fire-Control System',
    XWS = 'firecontrolsystem',
    slot = 2,
}

masterUpgradesDB['trajectorysimulator'] = {
    name = 'Trajectory Simulator',
    XWS = 'trajectorysimulator',
    slot = 2,
}

masterUpgradesDB['heavylasercannon'] = {
    name = 'Heavy Laser Cannon',
    XWS = 'heavylasercannon',
    slot = 3,
}

masterUpgradesDB['ioncannon'] = {
    name = 'Ion Cannon',
    XWS = 'ioncannon',
    slot = 3,
}

masterUpgradesDB['jammingbeam'] = {
    name = 'Jamming Beam',
    XWS = 'jammingbeam',
    slot = 3,
}

masterUpgradesDB['tractorbeam'] = {
    name = 'Tractor Beam',
    XWS = 'tractorbeam',
    slot = 3,
}


masterUpgradesDB['dorsalturret'] = {
    name = 'Dorsal Turret',
    XWS = 'dorsalturret',
    slot = 4,
    arcs = { turret = { name = 'dorsal turret', range = 2, type = { 'singleturret' } } }
}

masterUpgradesDB['ioncannonturret'] = {
    name = 'Ion Cannon Turret',
    XWS = 'ioncannonturret',
    slot = 4,
    arcs = { turret = { name = 'ion cannon turret', range = 2, type = { 'singleturret' } } }
}

masterUpgradesDB['advprotontorpedoes'] = {
    name = 'Adv. Proton Torpedoes',
    XWS = 'advprotontorpedoes',
    slot = 5,
    Charge = 1
}

masterUpgradesDB['iontorpedoes'] = {
    name = 'Ion Torpedoes',
    XWS = 'iontorpedoes',
    slot = 5,
    Charge = 2
}

masterUpgradesDB['protontorpedoes'] = {
    name = 'Proton Torpedoes',
    XWS = 'protontorpedoes',
    slot = 5,
    Charge = 2,
}

masterUpgradesDB['barragerockets'] = {
    name = 'Barrage Rockets',
    XWS = 'barragerockets',
    slot = 6,
    remSlot = { 6 },
    Charge = 5,
    cardB = cardBackDB['6b'],
}

masterUpgradesDB['clustermissiles'] = {
    name = 'Cluster Missiles',
    XWS = 'clustermissiles',
    slot = 6,
    Charge = 4
}

masterUpgradesDB['concussionmissiles'] = {
    name = 'Concussion Missiles',
    XWS = 'concussionmissiles',
    slot = 6,
    Charge = 3
}

masterUpgradesDB['homingmissiles'] = {
    name = 'Homing Missiles',
    XWS = 'homingmissiles',
    slot = 6,
    Charge = 2
}

masterUpgradesDB['ionmissiles'] = {
    name = 'Ion Missiles',
    XWS = 'ionmissiles',
    slot = 6,
    Charge = 3
}

masterUpgradesDB['protonrockets'] = {
    name = 'Proton Rockets',
    XWS = 'protonrockets',
    slot = 6,
    Charge = 1
}

masterUpgradesDB['freelanceslicer'] = {
    name = 'Freelance Slicer',
    XWS = 'freelanceslicer',
    slot = 8,
}

masterUpgradesDB['gnkgonkdroid'] = {
    name = 'GNK "Gonk" Droid',
    XWS = 'gnkgonkdroid',
    slot = 8,
    Charge = 1
}

masterUpgradesDB['informant'] = {
    name = 'Informant',
    XWS = 'informant',
    Condition = "Listening Device",
    slot = 8,
}

masterUpgradesDB['novicetechnician'] = {
    name = 'Novice Technician',
    XWS = 'novicetechnician',
    slot = 8,
}

masterUpgradesDB['perceptivecopilot'] = {
    name = 'Perceptive Copilot',
    XWS = 'perceptivecopilot',
    slot = 8,
}

masterUpgradesDB['seasonednavigator'] = {
    name = 'Seasoned Navigator',
    XWS = 'seasonednavigator',
    slot = 8,

    restriction = {},
    executeOptions = function(list, pilotid)
        exopts = {}
        nextdiff = { b = "w", w = "r" }
        if pilotid == 0 then
            return {}
        end
        for _, man in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].moveSet) do
            local Char = man:find("%d")
            local speed = tonumber(man:sub(Char, Char))
            local exopt = { man }
            for _, man2 in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].moveSet) do
                local diff = man2:sub(1, 1)
                Char = man2:find("%d")
                local thisspeed = tonumber(man2:sub(Char, Char))
                if (thisspeed == speed) and (nextdiff[diff] ~= nil) and (man ~= man2) then
                    --print(man .. " " .. man2 .. " " .. tostring(thisspeed))
                    exopt[#exopt + 1] = nextdiff[diff] .. man2:sub(2)
                end
            end
            if #exopt > 1 then
                --table.print(exopt)
                exopts[man] = exopt
            end
        end
        return exopts
    end
}

masterUpgradesDB['tacticalofficer'] = {
    name = 'Tactical Officer',
    XWS = 'tacticalofficer',
    slot = 8,
}

masterUpgradesDB['hotshotgunner'] = {
    name = 'Hotshot Gunner',
    XWS = 'hotshotgunner',
    slot = 16,
}

masterUpgradesDB['skilledbombardier'] = {
    name = 'Skilled Bombardier',
    XWS = 'skilledbombardier',
    slot = 16,
}

masterUpgradesDB['veterantailgunner'] = {
    name = 'Veteran Tail Gunner',
    XWS = 'veterantailgunner',
    slot = 16,
}

masterUpgradesDB['veteranturretgunner'] = {
    name = 'Veteran Turret Gunner',
    XWS = 'veteranturretgunner',
    slot = 16,
}

masterUpgradesDB['r2astromech'] = {
    name = 'R2 Astromech',
    XWS = 'r2astromech',
    slot = 10,
    Charge = 2
}

masterUpgradesDB['r3astromech'] = {
    name = 'R3 Astromech',
    XWS = 'r3astromech',
    slot = 10,
}

masterUpgradesDB['r4astromech'] = {
    name = 'R4 Astromech',
    XWS = 'r4astromech',
    slot = 10,
    restriction = { Size = { small = true } }
}

masterUpgradesDB['r5astromech'] = {
    name = 'R5 Astromech',
    XWS = 'r5astromech',
    slot = 10,
    Charge = 2
}

masterUpgradesDB['cloakingdevice'] = {
    name = 'Cloaking Device',
    XWS = 'cloakingdevice',
    slot = 13,
    limited = 1,
    addAction = { 'CL' },
    Charge = 2,
    restriction = { Size = { small = true, medium = true } }
}

masterUpgradesDB['contrabandcybernetics'] = {
    name = 'Contraband Cybernetics',
    XWS = 'contrabandcybernetics',
    slot = 13,
    Charge = 1
}

masterUpgradesDB['deadmansswitch'] = {
    name = "Deadman's Switch",
    XWS = 'deadmansswitch',
    slot = 13,
}

masterUpgradesDB['feedbackarray'] = {
    name = 'Feedback Array',
    XWS = 'feedbackarray',
    slot = 13,
}

masterUpgradesDB['inertialdampeners'] = {
    name = 'Inertial Dampeners',
    XWS = 'inertialdampeners',
    slot = 13,
}

masterUpgradesDB['riggedcargochute'] = {
    name = 'Rigged Cargo Chute',
    XWS = 'riggedcargochute',
    slot = 13,
    Bomb = true,
    Charge = 1,
    restriction = { Size = { large = true, medium = true } }
}

masterUpgradesDB['ablativeplating'] = {
    name = 'Ablative Plating',
    XWS = 'ablativeplating',
    slot = 14,
    Charge = 2,
    restriction = { Size = { large = true, medium = true } }
}

masterUpgradesDB['advancedslam'] = {
    name = 'Advanced SLAM',
    XWS = 'advancedslam',
    slot = 14,
}


masterUpgradesDB['afterburners'] = {
    name = 'Afterburners',
    XWS = 'afterburners',
    addAction = { 'B' },
    slot = 14,
    Charge = 2,
    restriction = {
        Size = { small = true }
    }
}

masterUpgradesDB['electronicbaffle'] = {
    name = 'Electronic Baffle',
    XWS = 'electronicbaffle',
    slot = 14,
}

masterUpgradesDB['engineupgrade'] = {
    name = 'Engine Upgrade',
    XWS = 'engineupgrade',
    slot = 14,
}

masterUpgradesDB['hullupgrade'] = {
    name = 'Hull Upgrade',
    XWS = 'hullupgrade',
    slot = 14,
    Hull = 1,
    restriction = {}
}
masterUpgradesDB['munitionsfailsafe'] = {
    name = 'Munitions Failsafe',
    XWS = 'munitionsfailsafe',
    slot = 14,
}

masterUpgradesDB['shieldupgrade'] = {
    name = 'Shield Upgrade',
    XWS = 'shieldupgrade',
    slot = 14,
    shd = 1
}

masterUpgradesDB['staticdischargevanes'] = {
    name = 'Static Discharge Vanes',
    XWS = 'staticdischargevanes',
    slot = 14,
}

masterUpgradesDB['stealthdevice'] = {
    name = 'Stealth Device',
    XWS = 'stealthdevice',
    slot = 14,
    Charge = 1
}

masterUpgradesDB['tacticalscrambler'] = {
    name = 'Tactical Scrambler',
    XWS = 'tacticalscrambler',
    slot = 14,
    restriction = { Size = { large = true, medium = true } }
}

masterUpgradesDB['bazemalbus'] = {
    name = 'Baze Malbus',
    XWS = 'bazemalbus',
    slot = 8,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['c3po'] = {
    name = 'C-3PO',
    XWS = 'c3po',
    slot = 8,
    addAction = { 'C' },
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['cassianandor'] = {
    name = 'Cassian Andor',
    XWS = 'cassianandor',
    slot = 8,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['chewbacca'] = {
    name = 'Chewbacca',
    XWS = 'chewbacca',
    slot = 8,
    Charge = 2,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['chopper-crew'] = {
    name = '"Chopper"',
    XWS = 'chopper-crew',
    slot = 8,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['herasyndulla'] = {
    name = 'Hera Syndulla',
    XWS = 'herasyndulla',
    slot = 8,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['jynerso'] = {
    name = 'Jyn Erso',
    XWS = 'jynerso',
    slot = 8,
    limited = 1,
    addSqdAction = { 'E' },
    restriction = { Faction = { [1] = true } }
}


masterUpgradesDB['kananjarrus'] = {
    name = 'Kanan Jarrus',
    XWS = 'kananjarrus',
    slot = 8,
    limited = 1,
    Force = 1,
    restriction = { Faction = { [1] = true } }
}


masterUpgradesDB['landocalrissian'] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian',
    slot = 8,
    addAction = { 'F', 'E' },
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['leiaorgana'] = {
    name = 'Leia Organa',
    XWS = 'leiaorgana',
    slot = 8,
    Charge = 3,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['magvayarro'] = {
    name = 'Magva Yarro',
    XWS = 'magvayarro',
    slot = 8,
    addAction = { 'TL' },
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['niennunb'] = {
    name = 'Nien Nunb',
    XWS = 'niennunb',
    slot = 8,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['r2d2-crew'] = {
    name = 'R2-D2',
    XWS = 'r2d2-crew',
    slot = 8,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['sabinewren'] = {
    name = 'Sabine Wren',
    XWS = 'sabinewren',
    slot = 8,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['sawgerrera'] = {
    name = 'Saw Gerrera',
    XWS = 'sawgerrera',
    slot = 8,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['zeborrelios'] = {
    name = '"Zeb" Orrelios',
    XWS = 'zeborrelios',
    slot = 8,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['bistan'] = {
    name = 'Bistan',
    XWS = 'bistan',
    slot = 16,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['ezrabridger'] = {
    name = 'Ezra Bridger',
    XWS = 'ezrabridger',
    slot = 16,
    Force = 1,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['hansolo'] = {
    name = 'Han Solo',
    XWS = 'hansolo',
    slot = 16,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['lukeskywalker'] = {
    name = 'Luke Skywalker',
    XWS = 'lukeskywalker',
    slot = 16,
    Force = 1,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['chopper'] = {
    name = '"Chopper"',
    XWS = 'chopper',
    slot = 10,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['r2d2'] = {
    name = 'R2-D2',
    XWS = 'r2d2',
    slot = 10,
    Charge = 3,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['r5d8'] = {
    name = 'R5-D8',
    XWS = 'r5d8',
    slot = 10,
    Charge = 3,
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['ghost'] = {
    name = 'Ghost',
    XWS = 'ghost',
    slot = 15,
    restriction = { Faction = { [1] = true }, ship = { ['vcx100lightfreighter'] = true } }
}

masterUpgradesDB['millenniumfalcon'] = {
    name = 'Millennium Falcon',
    XWS = 'millenniumfalcon',
    limited = 1,
    slot = 15,
    addAction = { 'E' },
    restriction = { Faction = { [1] = true }, ship = { ['modifiedyt1300lightfreighter'] = true } }
}

masterUpgradesDB['moldycrow'] = {
    name = 'Moldy Crow',
    XWS = 'moldycrow',
    limited = 1,
    slot = 15,
    restriction = {
        Faction = { [1] = true, [3] = true },
        ship = { ['hwk290lightfreighter'] = true }
    },
    arcs = { fixed = { range = 3, type = { 'front' } } }
}

masterUpgradesDB['outrider'] = {
    name = 'Outrider',
    XWS = 'outrider',
    slot = 15,
    restriction = { ship = { ['yt2400lightfreighter'] = true } }
}

masterUpgradesDB['phantom'] = {
    name = 'Phantom',
    XWS = 'phantom',
    slot = 15,
    restriction = { Faction = { [1] = true }, ship = { ['attackshuttle'] = true, ['sheathipedeclassshuttle'] = true } }
}

masterUpgradesDB['pivotwing'] = {
    name = 'Pivot Wing',
    XWS = 'pivotwing',
    slot = 18,
    addAction = { 'Piv' },
    dual = true,
    restriction = { Faction = { [1] = true }, ship = { ['ut60duwing'] = true } }
}

masterUpgradesDB['servomotorsfoils'] = {
    name = 'Servomotor S-Foils',
    XWS = 'servomotorsfoils',
    slot = 18,
    addAction = { 'B' },
    dual = true,
    restriction = { Faction = { [1] = true }, ship = { ['t65xwing'] = true } }
}


masterUpgradesDB['admiralsloane'] = {
    name = 'Admiral Sloane',
    XWS = 'admiralsloane',
    slot = 8,
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['agentkallus'] = {
    name = 'Agent Kallus',
    XWS = 'agentkallus',
    Condition = "Hunted",
    slot = 8,
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['cienaree'] = {
    name = 'Ciena Ree',
    XWS = 'cienaree',
    slot = 8,
    limited = 1,
    addSqdAction = { 'Piv' },
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['darthvader'] = {
    name = 'Darth Vader',
    XWS = 'darthvader',
    slot = 8,
    limited = 1,
    Force = 1,
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['deathtroopers'] = {
    name = 'Death Troopers',
    XWS = 'deathtroopers',
    slot = 8,
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['directorkrennic'] = {
    name = 'Director Krennic',
    XWS = 'directorkrennic',
    Condition = "Optimized Prototype",
    slot = 8,
    limited = 1,
    addAction = { 'TL' },
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['emperorpalpatine'] = {
    name = 'Emperor Palpatine',
    XWS = 'emperorpalpatine',
    slot = 8,
    remSlot = { 8 },
    Force = 1,
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['grandinquisitor'] = {
    name = 'Grand Inquisitor',
    XWS = 'grandinquisitor',
    slot = 8,
    Force = 1,
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['grandmofftarkin'] = {
    name = 'Grand Moff Tarkin',
    XWS = 'grandmofftarkin',
    slot = 8,
    Charge = 2,
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['isbslicer'] = {
    name = 'ISB Slicer',
    XWS = 'isbslicer',
    slot = 8,
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['ministertua'] = {
    name = 'Minister Tua',
    XWS = 'ministertua',
    slot = 8,
    limited = 1,
    addAction = { 'R' },
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['moffjerjerrod'] = {
    name = 'Moff Jerjerrod',
    XWS = 'moffjerjerrod',
    slot = 8,
    limited = 1,
    addSqdAction = { 'B' },
    Charge = 2,
    restriction = { Faction = { [2] = true } }
}


masterUpgradesDB['seventhsister'] = {
    name = 'Seventh Sister',
    XWS = 'seventhsister',
    slot = 8,
    Force = 1,
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['fifthbrother'] = {
    name = 'Fifth Brother',
    XWS = 'fifthbrother',
    slot = 16,
    Force = 1,
    restriction = { Faction = { [2] = true } }
}

masterUpgradesDB['dauntless'] = {
    name = 'Dauntless',
    XWS = 'dauntless',
    slot = 15,
    restriction = { Faction = { [2] = true }, ship = { ['vt49decimator'] = true } }
}

masterUpgradesDB['os1arsenalloadout'] = {
    name = 'Os-1 Arsenal Loadout',
    XWS = 'os1arsenalloadout',
    slot = 18,
    addSlot = { 5, 6 },
    restriction = { Faction = { [2] = true }, ship = { ['alphaclassstarwing'] = true } }
}

masterUpgradesDB['xg1assaultconfiguration'] = {
    name = 'Xg-1 Assault Configuration',
    XWS = 'xg1assaultconfiguration',
    slot = 18,
    addSlot = { 3 },
    restriction = { Faction = { [2] = true }, ship = { ['alphaclassstarwing'] = true } }
}

masterUpgradesDB['000'] = {
    name = '0-0-0',
    XWS = '000',
    slot = 8,
    addAction = { 'C' },
    restriction = { Faction = { [2] = true, [3] = true }, keywords = { 'Darth Vader' } }
}

masterUpgradesDB['4lom'] = {
    name = '4-LOM',
    XWS = '4lom',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['bobafett'] = {
    name = 'Boba Fett',
    XWS = 'bobafett',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['cadbane'] = {
    name = 'Cad Bane',
    XWS = 'cadbane',
    slot = 8,
    limited = 1,
    addAction = { 'B' },
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['cikatrovizago'] = {
    name = 'Cikatro Vizago',
    XWS = 'cikatrovizago',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['ig88d'] = {
    name = 'IG-88D',
    XWS = 'ig88d',
    slot = 8,
    limited = 1,
    addAction = { 'C' },
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['jabbathehutt'] = {
    name = 'Jabba the Hutt',
    XWS = 'jabbathehutt',
    slot = 8,
    remSlot = { 8 },
    Charge = 4,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['ketsuonyo'] = {
    name = 'Ketsu Onyo',
    XWS = 'ketsuonyo',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['lattsrazzi'] = {
    name = 'Latts Razzi',
    XWS = 'lattsrazzi',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['maul'] = {
    name = 'Maul',
    title = "Original",
    XWS = 'maul',
    slot = 8,
    Force = 1,
    --restriction = {Func = function(list) Faction = {[1]=true,[3]=true}}
}

masterUpgradesDB['unkarplutt'] = {
    name = 'Unkar Plutt',
    XWS = 'unkarplutt',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['zuckuss'] = {
    name = 'Zuckuss',
    XWS = 'zuckuss',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['bossk'] = {
    name = 'Bossk',
    XWS = 'bossk',
    slot = 16,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['bt1'] = {
    name = 'BT-1',
    XWS = 'bt1',
    slot = 16,
    restriction = { Faction = { [2] = true, [3] = true } }
}

masterUpgradesDB['dengar'] = {
    name = 'Dengar',
    XWS = 'dengar',
    slot = 16,
    Charge = 1,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['greedo'] = {
    name = 'Greedo',
    XWS = 'greedo',
    slot = 16,
    Charge = 1,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['genius'] = {
    name = '"Genius"',
    XWS = 'genius',
    slot = 10,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['r5p8'] = {
    name = 'R5-P8',
    XWS = 'r5p8',
    slot = 10,
    Charge = 3,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['r5tk'] = {
    name = 'R5-TK',
    XWS = 'r5tk',
    slot = 10,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['andrasta'] = {
    name = 'Andrasta',
    XWS = 'andrasta',
    slot = 15,
    addSlot = { 12 },
    restriction = { Faction = { [3] = true }, ship = { ['firesprayclasspatrolcraft'] = true } }
}

masterUpgradesDB['havoc'] = {
    name = 'Havoc',
    XWS = 'havoc',
    slot = 15,
    addSlot = { 2, 10 },
    remSlot = { 8 },
    restriction = { Faction = { [3] = true }, ship = { ['scurrgh6bomber'] = true } }
}

masterUpgradesDB['houndstooth'] = {
    name = "Hound's Tooth",
    XWS = 'houndstooth',
    Docking = true,
    slot = 15,
    restriction = { Faction = { [3] = true }, ship = { ['yv666lightfreighter'] = true } }
}


masterUpgradesDB['ig2000'] = {
    name = 'IG-2000',
    XWS = 'ig2000',
    slot = 15,
    restriction = {
        Faction = { [3] = true },
        ship = { ['aggressorassaultfighter'] = true }
    },
    executeOptions = function(list, me)
        for k, pid in pairs(list.Pilots) do
            pilot = masterPilotDB[pid]
            if pid ~= me and pilot.name == "IG-88D" then
                for _, uid in pairs(list.Upgrades[k]) do
                    if masterUpgradesDB[uid].name == "IG-2000" then
                        return {
                            rbl3s = { [1] = 'rtl3s', [2] = 'rbl3s', [3] = 'rk3' },
                            rbr3s = { [1] = 'rk3', [2] = 'rbr3s', [3] = 'rtr3s' }
                        }
                    end
                end
            end
        end
        return {}
    end
}

masterUpgradesDB['marauder'] = {
    name = 'Marauder',
    XWS = 'marauder',
    slot = 15,
    addSlot = { 16 },
    restriction = { Faction = { [3] = true }, ship = { ['firesprayclasspatrolcraft'] = true } }
}

masterUpgradesDB['misthunter'] = {
    name = 'Mist Hunter',
    XWS = 'misthunter',
    slot = 15,
    limited = 1,
    addAction = { 'BR' },
    addSlot = { 3 },
    restriction = { Faction = { [3] = true }, ship = { ['g1astarfighter'] = true } }
}

masterUpgradesDB['punishingone'] = {
    name = 'Punishing One',
    XWS = 'punishingone',
    slot = 15,
    addSlot = { 10 },
    remSlot = { 8 },
    restriction = { Faction = { [3] = true }, ship = { ['jumpmaster5000'] = true } }
}

masterUpgradesDB['shadowcaster'] = {
    name = 'Shadow Caster',
    XWS = 'shadowcaster',
    slot = 15,
    restriction = { Faction = { [3] = true }, ship = { ['lancerclasspursuitcraft'] = true } }
}

masterUpgradesDB['slavei'] = {
    name = 'Slave I',
    XWS = 'slavei',
    title = "Boba's ride",
    slot = 15,
    addSlot = { 5 },
    executeOptions = function(list, pid)
        return {
            bbl1 = { [1] = 'bbl1', [2] = 'bbr1' },
            wbl2 = { [1] = 'wbl2', [2] = 'wbr2' },
            wbl3 = { [1] = 'wbl3', [2] = 'wbr3' },
            bbr1 = { [1] = 'bbr1', [2] = 'bbl1' },
            wbr2 = { [1] = 'wbr2', [2] = 'wbl2' },
            wbr3 = { [1] = 'wbr3', [2] = 'wbl3' },
            wtl1 = { [1] = 'wtl1', [2] = 'wtr1' },
            wtl2 = { [1] = 'wtl2', [2] = 'wtr2' },
            wtr1 = { [1] = 'wtr1', [2] = 'wtl1' },
            wtr2 = { [1] = 'wtr2', [2] = 'wtl2' },
        }
    end,

    restriction = {
        Faction = { [3] = true },
        ship = { ['firesprayclasspatrolcraft'] = true }
    }
}
masterUpgradesDB['virago'] = {
    name = 'Virago',
    XWS = 'virago',
    slot = 15,
    Charge = 2,
    shd = 1,
    addSlot = { 14 },
    restriction = { ship = { ['starviperclassattackplatform'] = true } }
}

masterUpgradesDB['composure'] = {
    name = 'Composure',
    XWS = 'composure',
    slot = 1,
    addAction = { 'F' },
}

masterUpgradesDB['chewbacca-crew'] = {
    name = 'Chewbacca',
    XWS = 'chewbacca-crew',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['l337'] = {
    name = 'L3-37',
    XWS = 'l337',
    dual = true,
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['landocalrissian-crew'] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian-crew',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['tobiasbeckett'] = {
    name = 'Tobias Beckett',
    XWS = 'tobiasbeckett',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['qira'] = {
    name = "Qi'ra",
    XWS = 'qira',
    slot = 8,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['agilegunner'] = {
    name = 'Agile Gunner',
    XWS = 'agilegunner',
    slot = 16,
}

masterUpgradesDB['hansolo-gunner'] = {
    name = 'Han Solo',
    XWS = 'hansolo-gunner',
    slot = 16,
    restriction = { Faction = { [3] = true } }
}

masterUpgradesDB['landosmillenniumfalcon'] = {
    name = "Lando's Millennium Falcon",
    XWS = 'landosmillenniumfalcon',
    slot = 15,
    restriction = { Faction = { [3] = true }, ship = { ['customizedyt1300lightfreighter'] = true } }
}

masterUpgradesDB['st321'] = {
    name = 'ST-321',
    XWS = 'st321',
    slot = 15,
    limited = 1,
    addAction = { 'TL' },
    restriction = { Faction = { [2] = true }, ship = { ['lambdaclasst4ashuttle'] = true } }
}

masterUpgradesDB['bombletgenerator'] = {
    name = 'Bomblet Generator',
    XWS = 'bombletgenerator',
    slot = 12,
    remSlot = { 12 },
    Bomb = true,
    Charge = 2,
    cardB = cardBackDB['12b']
}

masterUpgradesDB['connernets'] = {
    name = 'Conner Nets',
    XWS = 'connernets',
    slot = 12,
    Bomb = true,
    Charge = 1
}

masterUpgradesDB['protonbombs'] = {
    name = 'Proton Bombs',
    XWS = 'protonbombs',
    slot = 12,
    Bomb = true,
    Charge = 2
}

masterUpgradesDB['proximitymines'] = {
    name = 'Proximity Mines',
    XWS = 'proximitymines',
    slot = 12,
    Bomb = true,
    Charge = 2
}

masterUpgradesDB['seismiccharges'] = {
    name = 'Seismic Charges',
    XWS = 'seismiccharges',
    slot = 12,
    Bomb = true,
    Charge = 2
}

masterUpgradesDB['fanatical'] = {
    name = "Fanatical",
    XWS = 'fanatical',
    slot = 1,
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['advancedoptics'] = {
    name = "Advanced Optics",
    XWS = 'advancedoptics',
    slot = 19,
}

masterUpgradesDB['hyperspacetrackingdata'] = {
    name = "Hyperspace Tracking Data",
    XWS = 'hyperspacetrackingdata',
    slot = 19,
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['patternanalyzer'] = {
    name = "Pattern Analyzer",
    XWS = 'patternanalyzer',
    slot = 19,
}

masterUpgradesDB['primedthrusters'] = {
    name = "Primed Thrusters",
    XWS = 'primedthrusters',
    slot = 19,
}

masterUpgradesDB['targetingsynchronizer'] = {
    name = "Targeting Synchronizer",
    XWS = 'targetingsynchronizer',
    slot = 19,
}

masterUpgradesDB['captainphasma'] = {
    name = "Captain Phasma",
    XWS = 'captainphasma',
    slot = 8,
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['generalhux'] = {
    name = "General Hux",
    XWS = 'generalhux',
    slot = 8,
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['kyloren'] = {
    name = "Kylo Ren",
    XWS = 'kyloren',
    Condition = "I'll Show You the Dark Side",
    slot = 8,
    Force = 1,
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['pettyofficerthanisson'] = {
    name = "Petty Officer Thanisson",
    XWS = 'pettyofficerthanisson',
    slot = 8,
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['supremeleadersnoke'] = {
    name = "Supreme Leader Snoke",
    XWS = 'supremeleadersnoke',
    slot = 8,
    remSlot = { 8 },
    Force = 1,
    cardB = cardBackDB['8b'],
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['specialforcesgunner'] = {
    name = "Special Forces Gunner",
    XWS = 'specialforcesgunner',
    slot = 16,
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['heroic'] = {
    name = "Heroic",
    XWS = 'heroic',
    slot = 1,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['c3po-crew'] = {
    name = "C-3PO",
    XWS = 'c3po-crew',
    slot = 8,
    addAction = { 'C' },
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['chewbacca-crew-swz19'] = {
    name = "Chewbacca",
    XWS = 'chewbacca-crew-swz19',
    slot = 8,
    Charge = 2,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['hansolo-crew'] = {
    name = "Han Solo",
    XWS = 'hansolo-crew',
    slot = 8,
    addAction = { 'E' },
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['rosetico'] = {
    name = "Rose Tico",
    XWS = 'rosetico',
    slot = 8,
    addAction = { 'TL' },
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['finn'] = {
    name = "Finn",
    XWS = 'finn',
    slot = 16,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['paigetico'] = {
    name = "Paige Tico",
    XWS = 'paigetico',
    slot = 16,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['rey-gunner'] = {
    name = "Rey",
    XWS = 'rey-gunner',
    slot = 16,
    Force = 1,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['bb8'] = {
    name = "BB-8",
    XWS = 'bb8',
    slot = 10,
    addAction = { 'BR' },
    Charge = 2,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['bbastromech'] = {
    name = "BB Astromech",
    XWS = 'bbastromech',
    slot = 10,
    addAction = { 'BR' },
    Charge = 2,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['m9g8'] = {
    name = "M9-G8",
    XWS = 'm9g8',
    slot = 10,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['r2ha'] = {
    name = "R2-HA",
    XWS = 'r2ha',
    slot = 10,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['r5x3'] = {
    name = "R5-X3",
    XWS = 'r5x3',
    slot = 10,
    Charge = 2,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['blackone'] = {
    name = "Black One",
    XWS = 'blackone',
    slot = 15,
    Charge = 1,
    restriction = { ship = { ['t70xwing'] = true } }
}

masterUpgradesDB['reysmillenniumfalcon'] = {
    name = "Rey's Millennium Falcon",
    XWS = 'reysmillenniumfalcon',
    slot = 15,
    restriction = { ['ship'] = { ['scavengedyt1300lightfreighter'] = true } }
}

masterUpgradesDB['integratedsfoils'] = {
    name = "Integrated S-foils",
    XWS = 'integratedsfoils',
    dual = true,
    slot = 18,
    addAction = { 'BR' },
    restriction = { Faction = { [4] = true }, ship = { ['t70xwing'] = true } }
}

masterUpgradesDB['ferrospherepaint'] = {
    name = "Ferrosphere Paint",
    XWS = 'ferrospherepaint',
    slot = 19,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['hate'] = {
    name = "Hate",
    XWS = 'hate',
    slot = 17,
    restriction = { keywords = { 'Dark Side' } }
}

masterUpgradesDB['predictiveshot'] = {
    name = "Predictive Shot",
    XWS = 'predictiveshot',
    slot = 17,
}

masterUpgradesDB['biohexacryptcodes'] = {
    name = "Biohexacrypt Codes",
    XWS = 'biohexacryptcodes',
    slot = 19,
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['dedicated'] = {
    name = "Dedicated",
    XWS = 'dedicated',
    slot = 1,
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['treacherous'] = {
    name = "Treacherous",
    XWS = 'treacherous',
    slot = 1,
    Charge = 1,
    restriction = { Faction = { [7] = true } }
}

masterUpgradesDB['tv94'] = {
    name = "TV-94",
    XWS = 'tv94',
    slot = 20,
    restriction = { Faction = { [7] = true } }
}

masterUpgradesDB['kraken'] = {
    name = "Kraken",
    XWS = 'kraken',
    slot = 20,
    addAction = { 'C' },
    restriction = { Faction = { [7] = true } }
}

masterUpgradesDB['energyshellcharges'] = {
    name = "Energy-Shell Charges",
    XWS = 'energyshellcharges',
    slot = 6,
    Charge = 1,
    restriction = { Faction = { [7] = true } }
}

masterUpgradesDB['soullessone'] = {
    name = "Soulless One",
    XWS = 'soullessone',
    slot = 15,
    restriction = { ship = { ['belbulab22starfighter'] = true } }
}

masterUpgradesDB['imperviumplating'] = {
    name = "Impervium Plating",
    XWS = 'imperviumplating',
    slot = 14,
    Charge = 2,
    restriction = { ship = { ['belbulab22starfighter'] = true } }
}


masterUpgradesDB['brilliantevasion'] = {
    name = "Brilliant Evasion",
    XWS = 'brilliantevasion',
    slot = 17,
}

masterUpgradesDB['k2b4'] = {
    name = "K2-B4",
    XWS = 'k2b4',
    slot = 20,
    restriction = { Faction = { [7] = true } }
}


masterUpgradesDB['countdooku'] = {
    name = "Count Dooku",
    XWS = 'countdooku',
    slot = 8,
    Force = 1,
    restriction = { Faction = { [7] = true } }
}

masterUpgradesDB['generalgrievous'] = {
    name = "General Grievous",
    XWS = 'generalgrievous',
    slot = 8,
    Charge = 1,
    restriction = { Faction = { [7] = true } }
}

masterUpgradesDB['drk1probedroids'] = {
    name = "DRK-1 Probe Droids",
    XWS = 'drk1probedroids',
    Condition = 'DRK-1 Probe Droid',
    slot = 12,
    Charge = 2,
    restriction = { Faction = { [7] = true } }
}

masterUpgradesDB['scimitar'] = {
    name = "Scimitar",
    XWS = 'scimitar',
    slot = 15,
    limited = 1,
    addAction = { 'CL' },
    restriction = { ship = { ['sithinfiltrator'] = true } }
}


masterUpgradesDB['discordmissiles'] = {
    name = "Discord Missiles",
    XWS = 'discordmissiles',
    remotes = { "Buzz Droid Swarm" },
    limited = 3,
    slot = 6,
    Charge = 1,
    restriction = {
        Faction = { [7] = true }
    }
}
masterUpgradesDB['battlemeditation'] = {
    name = "Battle Meditation",
    XWS = 'battlemeditation',
    slot = 17,
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['r4pastromech'] = {
    name = "R4-P Astromech",
    XWS = 'r4pastromech',
    slot = 10,
    Charge = 2,
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['r4p17'] = {
    name = "R4-P17",
    XWS = 'r4p17',
    slot = 10,
    Charge = 2,
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['delta7b'] = {
    name = "Delta-7B",
    XWS = 'delta7b',
    slot = 18,
    shd = 2,
    restriction = { ship = { ['delta7aethersprite'] = true } }
}

masterUpgradesDB['calibratedlasertargeting'] = {
    name = "Calibrated laser Targeting",
    XWS = 'calibratedlasertargeting',
    slot = 18,
    remSlot = { 14 },
    cardB = cardBackDB.mc,
    restriction = { ship = { ['delta7aethersprite'] = true } }
}

masterUpgradesDB['sparepartscanisters'] = {
    name = "Spare Parts Canisters",
    XWS = 'sparepartscanisters',
    slot = 14,
    Charge = 1
}

masterUpgradesDB['r4p44'] = {
    name = "R4-P44",
    XWS = 'r4p44',
    slot = 10,
    limited = 1,
    addAction = { 'C' },
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['clonecommandercody'] = {
    name = "Clone Commander Cody",
    XWS = 'clonecommandercody',
    slot = 16,
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['seventhfleetgunner'] = {
    name = "Seventh Fleet Gunner",
    XWS = 'seventhfleetgunner',
    slot = 16,
    Charge = 1,
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['synchronizedconsole'] = {
    name = "Synchronized Console",
    XWS = 'synchronizedconsole',
    slot = 14,
    addSqdAction = { 'TL' },
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['grapplingstruts'] = {
    name = "Grappling Struts",
    XWS = 'grapplingstruts',
    dual = true,
    slot = 18,
    addAction = { 'Piv' },
    executeOptions = function(moves)
        return {
            rk1   = { [1] = 'rk1', [2] = 'bs0' },
            wtl1  = { [1] = 'wtl1', [2] = 'btl0' },
            wtr1  = { [1] = 'wtr1', [2] = 'btr0' },
            wbl2  = { [1] = 'wbl2', [2] = 'btl0' },
            wbr2  = { [1] = 'wbr2', [2] = 'btr0' },
            btl2  = { [1] = 'btl2', [2] = 'btl0' },
            btr2  = { [1] = 'btr2', [2] = 'btr0' },
            rtl2t = { [1] = 'rtl2t', [2] = 'btl0' },
            rtr2t = { [1] = 'rtr2t', [2] = 'btr0' },
            rbl3  = { [1] = 'rbl3', [2] = 'btl0' },
            rbr3  = { [1] = 'rbr3', [2] = 'btr0' },
            wtl3  = { [1] = 'wtl3', [2] = 'btl0' },
            wtr3  = { [1] = 'wtr3', [2] = 'btr0' },
            bs3   = { [1] = 'bs3', [2] = 'bs0' },
            bs4   = { [1] = 'bs4', [2] = 'bs0' },
            ws5   = { [1] = 'ws5', [2] = 'bs0' },
        }
    end,
    restriction = { ship = { ['vultureclassdroidfighter'] = true } }
}


masterUpgradesDB['chancellorpalpatine'] = {
    name = "Chancellor Palpatine",
    XWS = 'chancellorpalpatine',
    slot = 8,
    limited = 1,
    addSqdAction = { 'F' },
    Force = 1,
    dual = true,
    restriction = { Faction = { [6] = true, [7] = true } }
}

masterUpgradesDB['passivesensors'] = {
    name = "Passive Sensors",
    XWS = 'passivesensors',
    slot = 2,
    addAction = { 'C', 'TL' },
    Charge = 1,
    restriction = {}
}

masterUpgradesDB['autoblasters'] = {
    name = "Autoblasters",
    XWS = 'autoblasters',
    slot = 3,
}

masterUpgradesDB['plasmatorpedoes'] = {
    name = "Plasma Torpedoes",
    XWS = 'plasmatorpedoes',
    slot = 5,
    Charge = 2,
}

masterUpgradesDB['diamondboronmissiles'] = {
    name = "Diamond-Boron Missiles",
    XWS = 'diamondboronmissiles',
    slot = 6,
    Charge = 3
}
masterUpgradesDB['amilynholdo'] = {
    name = "Amilyn Holdo",
    XWS = 'amilynholdo',
    slot = 8,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['ga97'] = {
    name = "GA-97",
    XWS = 'ga97',
    slot = 8,
    limited = 1,
    addAction = { 'C' },
    Charge = 5,
    restriction = { Faction = { [4] = true } },
    Condition = "It's the Resistance",
}

masterUpgradesDB['kaydelconnix'] = {
    name = "Kaydel Connix",
    XWS = 'kaydelconnix',
    slot = 8,
    restriction = {
        Faction = { [4] = true }
    },
    executeOptions = function(list, pilotid)
        exopts = {}
        nextdiff = { b = "w", w = "r", r = "r", p = "p" }
        basicman = {
            [0] = { "tl1", "bl1", "s1", "br1", "tr1" },
            [1] = { "tl2", "bl2", "s2", "br2", "tr2" },
            [2] = { "tl3", "bl3", "s3", "br3", "tr3" },
            [3] = { "s4" },
            [4] = { "s5" },
            [5] = {}
        }
        if pilotid == 0 then
            return {}
        end
        for _, man in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].moveSet) do
            local Char = man:find("%d")
            local speed = tonumber(man:sub(Char, Char))
            --print("Man:" .. man .. " lower:" .. lower .. " higher:" .. higher)
            exopt = { man }
            for _, man2 in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].moveSet) do
                local diff = man2:sub(1, 1)
                if nextdiff[diff] ~= nil then
                    for _, bman in pairs(basicman[speed]) do
                        if man2:sub(2) == bman then
                            exopt[#exopt + 1] = nextdiff[diff] .. bman
                        end
                    end
                end
            end
            if #exopt > 1 then
                --table.print(exopt)
                exopts[man] = exopt
            end
        end
        return exopts
    end
}

masterUpgradesDB['korrsella'] = {
    name = "Korr Sella",
    XWS = 'korrsella',
    slot = 8,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['larmadacy'] = {
    name = "Larma D'Acy",
    XWS = 'larmadacy',
    slot = 8,
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['leiaorgana-resistance'] = {
    name = "Leia Organa",
    XWS = 'leiaorgana-resistance',
    slot = 8,
    remSlot = { 8 },
    Force = 1,
    cardB = cardBackDB['8b'],
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['pz4co'] = {
    name = "PZ-4CO",
    XWS = 'pz4co',
    slot = 8,
    limited = 1,
    addAction = { 'C' },
    restriction = { Faction = { [4] = true } }
}

masterUpgradesDB['r2a6'] = {
    name = "R2-A6",
    XWS = 'r2a6',
    slot = 10,
    executeOptions = function(list, pilotid)
        exopts = {}
        if pilotid ~= 0 then
            for _, man in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].moveSet) do
                local Char = man:find("%d")
                local speed = tonumber(man:sub(Char, Char))
                local lower = man:sub(2, Char - 1) .. tostring(speed - 1) .. man:sub(Char + 1)
                local higher = man:sub(2, Char - 1) .. tostring(speed + 1) .. man:sub(Char + 1)
                --print("Man:" .. man .. " lower:" .. lower .. " higher:" .. higher)
                exopt = { man }
                for _, man2 in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].moveSet) do
                    if man2:sub(2) == lower then
                        exopt[#exopt + 1] = man2
                    end
                    if man2:sub(2) == higher then
                        exopt[#exopt + 1] = man2
                    end
                    if #exopt > 1 then
                        --table.print(exopt)
                        exopts[man] = exopt
                    end
                end
            end
        end
        return exopts
    end,
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['r2c4'] = {
    name = "R2-C4",
    XWS = 'r2c4',
    slot = 10,
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['ta175'] = {
    name = "TA-175",
    XWS = 'ta175',
    slot = 20,
    restriction = { Faction = { [7] = true } }
}

masterUpgradesDB['electroprotonbomb'] = {
    name = "Electro-Proton Bomb",
    XWS = 'electroprotonbomb',
    slot = 12,
    Bomb = true,
    Charge = 1,
    remSlot = { 14 },
}

masterUpgradesDB['delayedfuses'] = {
    name = "Delayed Fuses",
    XWS = 'delayedfuses',
    slot = 14,
}

masterUpgradesDB['angleddeflectors'] = {
    name = "Angled Deflectors",
    XWS = 'angleddeflectors',
    slot = 14,
    addAction = { 'R' },
    shd = -1,
    restriction = { Size = { small = true, medium = true } }
}

masterUpgradesDB['landingstruts'] = {
    name = "Landing Struts",
    XWS = 'landingstruts',
    slot = 18,
    addAction = { 'Piv' },
    executeOptions = function(moves)
        return {
            ws1   = { [1] = 'ws1', [2] = 'bs0' },
            rbl1  = { [1] = 'rbl1', [2] = 'btl0' },
            rbr1  = { [1] = 'rbr1', [2] = 'btr0' },
            wtl1  = { [1] = 'wtl1', [2] = 'btl0' },
            wtr1  = { [1] = 'wtr1', [2] = 'btr0' },
            wbl2  = { [1] = 'wbl2', [2] = 'btl0' },
            wbr2  = { [1] = 'wbr2', [2] = 'btr0' },
            btl2  = { [1] = 'btl2', [2] = 'btl0' },
            btr2  = { [1] = 'btr2', [2] = 'btr0' },
            rk2   = { [1] = 'rk2', [2] = 'bs0' },
            rtl2t = { [1] = 'rtl2t', [2] = 'btl0' },
            rtr2t = { [1] = 'rtr2t', [2] = 'btr0' },
            wtl3  = { [1] = 'wtl3', [2] = 'btl0' },
            wtr3  = { [1] = 'wtr3', [2] = 'btr0' },
            bs3   = { [1] = 'bs3', [2] = 'bs0' },
            ws4   = { [1] = 'ws4', [2] = 'bs0' },
            rs5   = { [1] = 'rs5', [2] = 'bs0' },
        }
    end,
    dual = true,
    restriction = { Faction = { [7] = true }, ship = { ['hyenaclassdroidbomber'] = true } }
}

masterUpgradesDB['foresight'] = {
    name = "Foresight",
    XWS = 'foresight',
    slot = 17,
}

masterUpgradesDB['precognitivereflexes'] = {
    name = "Precognitive Reflexes",
    XWS = 'precognitivereflexes',
    slot = 17,
    restriction = { Size = { small = true } }
}

masterUpgradesDB['targetingcomputer'] = {
    name = "Targeting Computer",
    XWS = 'targetingcomputer',
    slot = 14,
    addAction = { 'TL' },
}

masterUpgradesDB['snapshot'] = {
    name = "Snap Shot",
    XWS = 'snapshot',
    slot = 1,
}

masterUpgradesDB['ensnare'] = {
    name = "Ensnare",
    XWS = 'ensnare',
    slot = 1,
    restriction = { ship = { ['nantexclassstarfighter'] = true } }
}

masterUpgradesDB['graviticdeflection'] = {
    name = "Gravitic Deflection",
    XWS = 'graviticdeflection',
    slot = 1,
    restriction = { ship = { ['nantexclassstarfighter'] = true } }
}

masterUpgradesDB['c110p'] = {
    name = "C1-10P",
    XWS = 'c110p',
    slot = 10,
    addAction = { 'E' },
    dual = true,
    Charge = 2,
    restriction = { Faction = { [6] = true } }
}


masterUpgradesDB['c3po-republic'] = {
    name = "C-3PO",
    XWS = 'c3po-republic',
    slot = 8,
    addAction = { 'C' },
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['ahsokatano'] = {
    name = "Ahsoka Tano",
    XWS = 'ahsokatano',
    slot = 16,
    Force = 1,
    restriction = { Faction = { [6] = true } }
}

masterUpgradesDB['r1j5'] = {
    name = "R1-J5",
    XWS = 'r1j5',
    slot = 10,
    limited = 1,
    Charge = 3,
    restriction = { Faction = { [4] = true } }
}


masterUpgradesDB['stabilizedsfoils'] = {
    name = "Stabilized S-Foils",
    XWS = 'stabilizedsfoils',
    dual = true,
    slot = 18,
    addAction = { 'E' },
    restriction = { ship = { ['asf01bwing'] = true } }
}


masterUpgradesDB['k2so'] = {
    name = "K-2SO",
    XWS = 'k2so',
    slot = 8,
    limited = 1,
    addAction = { 'C' },
    restriction = { Faction = { [1] = true } }
}

masterUpgradesDB['clustermines'] = {
    name = 'Cluster Mines',
    XWS = 'clustermines',
    slot = 12,
    Bomb = true,
    Charge = 1
}

masterUpgradesDB['ionbombs'] = {
    name = 'Ion Bombs',
    XWS = 'ionbombs',
    slot = 12,
    Bomb = true,
    Charge = 2
}

masterUpgradesDB['coaxiumhyperfuel'] = {
    name = "Coaxium Hyperfuel",
    XWS = 'coaxiumhyperfuel',
    slot = 13,
}

masterUpgradesDB['magpulsewarheads'] = {
    name = "Mag-Pulse Warheads",
    XWS = 'magpulsewarheads',
    slot = 6,
    Charge = 2
}

masterUpgradesDB['proudtradition'] = {
    name = "Proud Tradition",
    XWS = 'proudtradition',
    dual = true,
    slot = 1,
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['deuteriumpowercells'] = {
    name = "Deuterium Power Cells",
    XWS = 'deuteriumpowercells',
    slot = 19,
    Charge = 2,
    remSlot = { 14 },
    restriction = { Faction = { [5] = true } }
}

masterUpgradesDB['kazsfireball'] = {
    name = "Kaz's Fireball",
    XWS = 'kazsfireball',
    slot = 15,
    restriction = { ship = { ['fireball'] = true } }
}

masterUpgradesDB['deadeyeshot'] = {
    name = "Deadeye Shot",
    XWS = 'deadeyeshot',
    slot = 1,
    restriction = {
        Size = { small = true, medium = true }
    }
}

masterUpgradesDB['automatedtargetpriority'] = {
    name = "Automated Target Priority",
    XWS = 'automatedtargetpriority',
    slot = 19,
    restriction = {
        -- todo int 3 or less
    }
}

masterUpgradesDB['sensorbuoysuite'] = {
    name = "Sensor Buoy Suite",
    XWS = 'sensorbuoysuite',
    slot = 19,
    restriction = {
        Faction = { [5] = true },
        Size = { medium = true, large = true }
    },
    remotes = { 'Sensor Buoy (Red)', 'Sensor Buoy (Blue)' }
}

masterUpgradesDB['multimissilepods'] = {
    name = "Multi-Missile Pods",
    XWS = 'multimissilepods',
    slot = 6,
    remSlot = { 6 },
    Charge = 5,
    restriction = {},
}

masterUpgradesDB['syncedlasercannons'] = {
    name = "Synced Laser Cannons",
    XWS = 'syncedlasercannons',
    slot = 3,
    remSlot = { 3 },
    cardB = cardBackDB['3b'],
    restriction = {}
}

masterUpgradesDB['aaylasecura'] = {
    name = "Aayla Secura",
    XWS = 'aaylasecura',
    Force = 1,
    limited = 1,
    slot = 8,
    restriction = {
        Faction = { [6] = true }
    }
}

masterUpgradesDB['kitfisto'] = {
    name = "Kit Fisto",
    XWS = 'kitfisto',
    Force = 1,
    limited = 1,
    addAction = { 'E' },
    slot = 8,
    restriction = {
        Faction = { [6] = true }
    }
}


masterUpgradesDB['plokoon'] = {
    name = "Plo Koon",
    XWS = 'plokoon',
    Force = 1,
    limited = 1,
    slot = 8,
    addAction = { 'R' },
    restriction = {
        Faction = { [6] = true }
    }
}

masterUpgradesDB['yoda'] = {
    name = "Yoda",
    XWS = 'yoda',
    Force = 2,
    limited = 1,
    slot = 8,
    restriction = {
        Faction = { [6] = true }
    }
}

masterUpgradesDB['fives'] = {
    name = '"Fives"',
    XWS = 'fives',
    limited = 1,
    slot = 8,
    restriction = {
        Faction = { [6] = true }
    }
}

masterUpgradesDB['wolfpack'] = {
    name = "Wolfpack",
    XWS = 'wolfpack',
    limited = 1,
    slot = 16,
    remSlot = { 8 },
    restriction = {
        Faction = { [6] = true }
    }
}

masterUpgradesDB['ghostcompany'] = {
    name = "Ghost Company",
    XWS = 'ghostcompany',
    limited = 1,
    slot = 16,
    addAction = { 'F' },
    remSlot = { 8 },
    restriction = {
        Faction = { [6] = true }
        -- Todo: Add rotate requirement
    }
}

masterUpgradesDB['kalani'] = {
    name = "Kalani",
    XWS = 'kalani',
    limited = 1,
    slot = 20,
    addAction = { 'C' },
    Charge = 3,
    restriction = {
        Faction = { [7] = true }
    },
}

masterUpgradesDB['commandermalarus'] = {
    name = "Commander Malarus",
    XWS = 'commandermalarus',
    dual = true,
    slot = 8,
    limited = 1,
    restriction = {
        Faction = { [5] = true }
    }
}

masterUpgradesDB['agentterex'] = {
    name = "Agent Terex",
    XWS = 'agentterex',
    dual = true,
    slot = 8,
    limited = 1,
    addSqdAction = { 'C' },
    restriction = {
        Faction = { [5] = true }
    }
}

masterUpgradesDB['commanderpyre'] = {
    name = 'Commander Pyre',
    XWS = 'commanderpyre',
    slot = 8,
    limited = 1,
    restriction = {
        Faction = { [5] = true }
    }
}

masterUpgradesDB['clonecaptainrex'] = {
    name = "Clone Captain Rex",
    XWS = 'clonecaptainrex',
    limited = 1,
    slot = 16,
    restriction = {
        Faction = { [6] = true }
    }
}

masterUpgradesDB['suppressivegunner'] = {
    name = "Suppressive Gunner",
    XWS = 'suppressivegunner',
    slot = 16,
    restriction = {}
}

masterUpgradesDB['concussionbombs'] = {
    name = "Concussion Bombs",
    XWS = 'concussionbombs',
    slot = 12,
    Charge = 3,
    cardB = cardBackDB['12b'],
    restriction = {},
    Bomb = true
}


masterUpgradesDB['repulsorliftstabilizers'] = {
    name = "Repulsorlift Stabilizers",
    XWS = 'repulsorliftstabilizers',
    dual = true,
    slot = 18,
    restriction = {
        ship = { ['hmpdroidgunship'] = true }
    },
    executeOptions = function()
        return {
            rbl1 = { 'rbl1', 'rbl1z' },
            rbr1 = { 'rbr1', 'rbr1z' },
            btl2 = { 'btl2', 'btl2z' },
            wbl2 = { 'wbl2', 'wbl2z' },
            wbr2 = { 'wbr2', 'wbr2z' },
            btr2 = { 'btr2', 'btr2z' },
            wtl3 = { 'wtl3', 'wtl3z' },
            rbl3 = { 'rbl3', 'rbl3z' },
            rbr3 = { 'rbr3', 'rbr3z' },
            wtr3 = { 'wtr3', 'wtr3z' }
        }
    end
}

masterUpgradesDB['maneuverassistmgk300'] = {
    name = "Maneuver-Assist MGK-300",
    XWS = 'maneuverassistmgk300',
    slot = 18,
    restriction = {
        ship = { ['tierbheavy'] = true }
    },
}

masterUpgradesDB['targetassistmgk300'] = {
    name = "Target-Assist MGK-300",
    XWS = 'targetassistmgk300',
    slot = 18,
    restriction = {
        ship = { ['tierbheavy'] = true }
    },
}

masterUpgradesDB['ionlimiteroverride'] = {
    name = "Ion Limiter Override",
    XWS = 'ionlimiteroverride',
    slot = 1,
    addAction = { 'BR' },
    restriction = {
        keywords = { 'TIE' }
    },
}

masterUpgradesDB['backwardstailslide'] = {
    name = "Backwards Tailslide",
    XWS = 'backwardstailslide',
    slot = 1,
    addAction = { 'E' },
    restriction = {
        keywords = { 'X-Wing' }
    },
}

masterUpgradesDB['overdrivethruster'] = {
    name = "Overdrive Thruster",
    XWS = 'overdrivethruster',
    limited = 1,
    slot = 14,
    addAction = { '2B', '2BR' },
    restriction = {
        ship = { ['t70xwing'] = true }
    },
}

masterUpgradesDB['r2d2-resistance'] = {
    name = "R2-D2",
    XWS = 'r2d2-resistance',
    limited = 1,
    slot = 10,
    Charge = 4,
    restriction = {
        Faction = { [4] = true },
    },
}

masterUpgradesDB['r6d8'] = {
    name = "R6-D8",
    XWS = 'r6d8',
    limited = 1,
    slot = 10,
    restriction = {
        Faction = { [4] = true },
    },
}

masterUpgradesDB['underslungblastercannon'] = {
    name = "Underslung Blaster Cannon",
    XWS = 'underslungblastercannon',
    slot = 3,
    restriction = {
        Faction = { [4] = true },
        ship = { ['t70xwing'] = true }
    },
    arcs = { turret = { name = 'underslung blaster cannon', range = 1, type = { 'singleturret' } } }
}

masterUpgradesDB['starbirdslash'] = {
    name = "Starbird Slash",
    XWS = 'starbirdslash',
    slot = 1,
    restriction = {
        keywords = { 'A-Wing' }
    },
    movethrough = true,
}

masterUpgradesDB['extrememaneuvers'] = {
    name = "Extreme Maneuvers",
    XWS = 'extrememaneuvers',
    slot = 17,
    addAction = { 'Dare' },
    restriction = {
        Size = { small = true },
        -- Todo: add boost requirement
    },
}

masterUpgradesDB['jedicommander'] = {
    name = "Jedi Commander",
    XWS = 'jedicommander',
    slot = 21,
    wingleader = true,
    dual = true,
    restriction = {
        Ship = { ['eta2actis'] = true, ['delta7aethersprite'] = true }
    },
}

masterUpgradesDB['r2d2-republic'] = {
    name = "R2-D2",
    XWS = 'r2d2-republic',
    limited = 1,
    slot = 10,
    Charge = 2,
    restriction = {
        Faction = { [6] = true },
    }
}

masterUpgradesDB['patience'] = {
    name = "Patience",
    XWS = 'patience',
    slot = 17,
    restriction = { keywords = { 'Light Side' } }
}

masterUpgradesDB['alpha3bbesh'] = {
    name = 'Alpha-3B "Besh"',
    XWS = 'alpha3bbesh',
    slot = 18,
    addSlot = { 12 },
    restriction = {
        ship = {
            ['nimbusclassvwing'] = true,
        },
    }
}

masterUpgradesDB['alpha3eesk'] = {
    name = 'Alpha-3E "Esk"',
    XWS = 'alpha3eesk',
    slot = 18,
    Charge = 2,
    restriction = {
        ship = {
            ['nimbusclassvwing'] = true,
        },
    }
}

masterUpgradesDB['thermaldetonators'] = {
    name = 'Thermal Detonators',
    XWS = 'thermaldetonators',
    slot = 12,
    Charge = 4,
    Bomb = true,
}

masterUpgradesDB['r7a7'] = {
    name = 'R7-A7',
    XWS = 'r7a7',
    limited = 1,
    slot = 10,
    Charge = 3,
    restriction = {
        Faction = { [6] = true },
    }
}

masterUpgradesDB['precisionionengines'] = {
    name = 'Precision Ion Engines',
    XWS = 'precisionionengines',
    slot = 14,
    Charge = 2,
    executeOptions = function(list, pid)
        return {
            rk1 = { [1] = 'rk1', [2] = 'rbl1s', [3] = 'rbr1s' },
            rk2 = { [1] = 'rk2', [2] = 'rbl2s', [3] = 'rbr2s' },
            rk3 = { [1] = 'rk3', [2] = 'rbl3s', [3] = 'rbr3s' },
            wk1 = { [1] = 'wk1', [2] = 'wbl1s', [3] = 'wbr1s' },
            wk2 = { [1] = 'wk2', [2] = 'wbl2s', [3] = 'wbr2s' },
            wk3 = { [1] = 'wk3', [2] = 'wbl3s', [3] = 'wbr3s' },
        }
    end,
    restriction = {
        ship = {
            keywords = { 'TIE' }
        },
    }
}

masterUpgradesDB['q7astromech'] = {
    name = 'Q7 Astromech',
    XWS = 'q7astromech',
    slot = 10,
    restriction = {
        Faction = { [6] = true },
    }
}

masterUpgradesDB['interceptbooster'] = {
    name = 'Intercept Booster',
    XWS = 'interceptbooster',
    slot = 18,
    Charge = 3,
    addAction = { 'TL' },
    dual = true,
    restriction = {
        Faction = { [7] = true },
        ship = { ['droidtrifighter'] = true }
    }
}

masterUpgradesDB['xx23sthreadtracers'] = {
    name = 'XX-23 S-Thread Tracers',
    XWS = 'xx23sthreadtracers',
    slot = 6,
    Charge = 2,
}

masterUpgradesDB['margsablclosure'] = {
    name = 'Marg Sabl Closure',
    XWS = 'margsablclosure',
    slot = 1,
    restriction = {
        Size = {
            small = true,
            medium = true
        },
    },
    movethrough = true,
}

masterUpgradesDB['independentcalculations'] = {
    name = 'Independent Calculations',
    XWS = 'independentcalculations',
    slot = 14,
    restriction = {
        ship = {
            ['vultureclassdroidfighter'] = true,
            ['hyenaclassdroidbomber'] = true,
            ['droidtrifighter'] = true
        } -- Network calculations
    },
}

masterUpgradesDB['jangofett'] = {
    name = 'Jango Fett',
    XWS = 'jangofett',
    limited = 1,
    slot = 8,
    restriction = {
        Faction = { [3] = true, [7] = true },
    },
}

masterUpgradesDB['zamwesell'] = {
    name = 'Zam Wesell',
    XWS = 'zamwesell',
    limited = 1,
    Condition = 'Zam Wesell',
    slot = 8,
    Charge = 2,
    restriction = {
        Faction = { [3] = true, [7] = true },
    },
}

masterUpgradesDB['hondoohnaka'] = {
    name = 'Hondo Ohnaka',
    XWS = 'hondoohnaka',
    limited = 1,
    slot = 8,
}

masterUpgradesDB['slavei-swz82'] = {
    name = 'Slave I',
    XWS = 'slavei-swz82',
    title = "Jango's ride",
    slot = 15,
    addSlot = { 16 },
    restriction = {
        Faction = {
            [3] = true,
            [7] = true
        },
        ship = { ['firesprayclasspatrolcraft'] = true }
    }
}

masterUpgradesDB['bobafett-gunner'] = {
    name = 'Boba Fett',
    XWS = 'bobafett-gunner',
    limited = 1,
    slot = 16,
    restriction = {
        Faction = {
            [3] = true,
            [7] = true
        }
    }
}

masterUpgradesDB['weaponssystemsofficer'] = {
    name = 'Weapons Systems Officer',
    XWS = 'weaponssystemsofficer',
    slot = 16,
}

masterUpgradesDB['falsetranspondercodes'] = {
    name = 'False Transponder Codes',
    XWS = 'falsetranspondercodes',
    slot = 13,
    Charge = 1,
}

masterUpgradesDB['admiralozzel'] = {
    name = "Admiral Ozzel",
    XWS = 'admiralozzel',
    slot = 21,
    remSlot = { 8 },
    restriction = {
        Faction = { [2] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['azmorigan'] = {
    name = "Azmorigan",
    XWS = 'azmorigan',
    slot = 21,
    remSlot = { 8 },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Faction = { [3] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['captainneeda'] = {
    name = "Captain Needa",
    XWS = 'captainneeda',
    slot = 21,
    remSlot = { 8 },
    Charge = 4,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Faction = { [2] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['carlistrieekan'] = {
    name = "Carlist Rieekan",
    XWS = 'carlistrieekan',
    slot = 21,
    addAction = { 'E' },
    remSlot = { 8 },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Faction = { [1] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['jandodonna'] = {
    name = "Jan Dodonna",
    XWS = 'jandodonna',
    slot = 21,
    remSlot = { 8 },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Faction = { [1] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['raymusantilles'] = {
    name = "Raymus Antilles",
    XWS = 'raymusantilles',
    slot = 21,
    remSlot = { 8 },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Faction = { [1] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['stalwartcaptain'] = {
    name = "Stalwart Captain",
    XWS = 'stalwartcaptain',
    slot = 21,
    remSlot = { 8 },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Size = { huge = true }
    }
}
masterUpgradesDB['agentoftheempire'] = {
    name = "Agent of the Empire",
    XWS = 'agentoftheempire',
    wingleader = true,
    slot = 21,
    restriction = {
        Faction = { [2] = true },
        ship = { ['tieadvancedx1'] = true, ['tieadvancedv1'] = true }
    }
}
masterUpgradesDB['firstorderelite'] = {
    name = "First Order Elite",
    XWS = 'firstorderelite',
    wingleader = true,
    slot = 21,
    restriction = {
        Faction = { [5] = true },
        ship = { ['tiesffighter'] = true, ['tievnsilencer'] = true }
    }
}
masterUpgradesDB['veteranwingleader'] = {
    name = "Veteran Wing Leader",
    XWS = 'veteranwingleader',
    wingleader = true,
    slot = 21,
    restriction = {
        Size = { small = true }
    }
}
masterUpgradesDB['dreadnoughthunter'] = {
    name = "Dreadnought hunter",
    XWS = 'dreadnoughthunter',
    slot = 21,
    restriction = {
        Size = { small = true },
        InitiativeGreaterThan = 3
    }
}

masterUpgradesDB['ioncannonbattery'] = {
    name = "Ion Cannon Battery",
    XWS = 'ioncannonbattery',
    slot = 24,
    dual = true,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/IonCannonBattery(Offline).png',
    restriction = {},
    arcs = { turret = { name = 'ion cannon', range = 4, type = { 'singleturret' } } }
}

masterUpgradesDB['targetingbattery'] = {
    name = "Targeting Battery",
    XWS = 'targetingbattery',
    slot = 24,
    dual = true,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/TargetingBattery(Offline).png',
    restriction = {},
    arcs = { turret = { name = 'targeting', range = 5, type = { 'singleturret' } } }
}

masterUpgradesDB['ordnancetubes'] = {
    name = "Ordnance Tubes",
    XWS = 'ordnancetubes',
    slot = 24,
    dual = true,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/OrdnanceTubes(Offline).png',
    restriction = {}
}

masterUpgradesDB['pointdefensebattery'] = {
    name = "Point-Defense Battery",
    XWS = 'pointdefensebattery',
    slot = 24,
    dual = true,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/PointDefenseBattery(Offline).png',
    restriction = {},
    arcs = { turret = { name = 'point defence', range = 2, type = { 'doubleturret' } } }
}

masterUpgradesDB['turbolaserbattery'] = {
    name = "Turbolaser Battery",
    XWS = 'turbolaserbattery',
    slot = 24,
    dual = true,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/TurbolaserBattery(Offline).png',
    restriction = {
        -- TODO: Add restriction energy 5 or higher
    },
    arcs = { turret = { name = 'turbolaser', range = 5, type = { 'singleturret' } } }
}

masterUpgradesDB['bombardmentspecialists'] = {
    name = "Bombardment Specialists",
    XWS = 'bombardmentspecialists',
    slot = 23,
    addAction = { 'TL', 'C' },

    restriction = {}
}

masterUpgradesDB['commsteam'] = {
    name = "Comms Team",
    XWS = 'commsteam',
    slot = 23,
    addAction = { 'C' },
    restriction = {}
}

masterUpgradesDB['igrmdroids'] = {
    name = "IG-RM Droids",
    XWS = 'igrmdroids',
    slot = 23,
    addAction = { 'C' },
    restriction = {
        Faction = { [3] = true }
    }
}

masterUpgradesDB['gunneryspecialists'] = {
    name = "Gunnery Specialists",
    XWS = 'gunneryspecialists',
    slot = 23,
    addAction = { 'C' },
    restriction = {}
}

masterUpgradesDB['damagecontrolteam'] = {
    name = "Damage Control Team",
    XWS = 'damagecontrolteam',
    slot = 23,
    addAction = { 'R', 'C' },
    restriction = {}
}

masterUpgradesDB['ordnanceteam'] = {
    name = "Ordnance Team",
    XWS = 'ordnanceteam',
    slot = 23,
    addAction = { 'C' },

    restriction = {}
}

masterUpgradesDB['sensorexperts'] = {
    name = "Sensor Experts",
    XWS = 'sensorexperts',
    slot = 23,
    addAction = { 'TL', 'C' },
    restriction = {}
}

masterUpgradesDB['quickreleaselocks'] = {
    name = "Quick-Release Locks",
    XWS = 'quickreleaselocks',
    slot = 13,
    Charge = 2,
    restriction = {
        Size = { huge = true }
    }
}
masterUpgradesDB['saboteursmap'] = {
    name = "Saboteur's Map",
    XWS = 'saboteursmap',
    slot = 13,
    restriction = {
        Size = { huge = true }
    }
}
masterUpgradesDB['scannerbaffler'] = {
    name = "Scanner Baffler",
    XWS = 'scannerbaffler',
    slot = 13,
    restriction = {
        Size = { huge = true }
    }
}
-- Cargo
masterUpgradesDB['adaptiveshields'] = {
    name = "Adaptive Shields",
    XWS = 'adaptiveshields',
    slot = 22,
    restriction = {}
}
masterUpgradesDB['boostedscanners'] = {
    name = "Boosted Scanners",
    XWS = 'boostedscanners',
    slot = 22,
    restriction = {}
}

masterUpgradesDB['optimizedpowercore'] = {
    name = "Optimized Power Core",
    XWS = 'optimizedpowercore',
    slot = 22,
    restriction = {}
}

masterUpgradesDB['tibannareserves'] = {
    name = "Tibanna Reserves",
    XWS = 'tibannareserves',
    slot = 22,
    Charge = 3,
    restriction = {}
}

masterUpgradesDB['torynfarr'] = {
    name = "Toryn Farr",
    XWS = 'torynfarr',
    slot = 8,
    addAction = { 'TL' },
    restriction = {
        Faction = { [1] = true },
        Size = { huge = true }
    }
}

masterUpgradesDB['dodonnaspride'] = {
    name = "Dodonna's Pride",
    XWS = 'dodonnaspride',
    limited = 1,
    slot = 15,
    addAction = { 'E', 'F' },
    shd = -2,
    addSlot = { 23, 22 },
    restriction = {
        Faction = { [1] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['jainaslight'] = {
    name = "Jaina's Light",
    XWS = 'jainaslight',
    slot = 15,
    limited = 1,
    shd = 1,
    Energy = -1,
    restriction = {
        Faction = { [1] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['liberator'] = {
    name = "Liberator",
    XWS = 'liberator',
    slot = 15,
    Energy = 1,
    Docking = true,
    restriction = {
        Faction = { [1] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['tantiveiv'] = {
    name = "Tantive IV",
    XWS = 'tantiveiv',
    slot = 15,
    addSlot = { 8, 8 },
    restriction = {
        Faction = { [1] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['thunderstrike'] = {
    name = "Thunderstrike",
    XWS = 'thunderstrike',
    slot = 15,
    addSlot = { 16 },
    shd = -3,
    Hull = 3,
    restriction = {
        Faction = { [1] = true },
        ship = { ['cr90corvette'] = true }
    }
}
masterUpgradesDB['brighthope'] = {
    name = "Bright Hope",
    XWS = 'brighthope',
    slot = 15,
    restriction = {
        Faction = { [1] = true },
        ship = { ['gr75mediumtransport'] = true }
    }
}
masterUpgradesDB['luminous'] = {
    name = "Luminous",
    XWS = 'luminous',
    slot = 15,
    shd = -1,
    Energy = 2,
    restriction = {
        Faction = { [1] = true },
        ship = { ['gr75mediumtransport'] = true }
    }
}
masterUpgradesDB['quantumstorm'] = {
    name = "Quantum Storm",
    XWS = 'quantumstorm',
    slot = 15,
    Energy = 1,
    addSlot = { 23, 22 },
    restriction = {
        Faction = { [1] = true },
        ship = { ['gr75mediumtransport'] = true }
    }
}
masterUpgradesDB['assailer'] = {
    name = "Assailer",
    XWS = 'assailer',
    slot = 15,
    limited = 1,
    shd = -2,
    Hull = 2,
    addSlot = { 16 },
    restriction = {
        Faction = { [2] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}
masterUpgradesDB['corvus'] = {
    name = "Corvus",
    XWS = 'corvus',
    slot = 15,
    limited = 1,
    addAction = { 'C' },
    Docking = true,
    restriction = {
        Faction = { [2] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}

masterUpgradesDB['impetuous'] = {
    name = "Impetuous",
    XWS = 'impetuous',
    slot = 15,
    limited = 1,
    shd = -2,
    Energy = 2,
    addSlot = { 8 },
    restriction = {
        Faction = { [2] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}
masterUpgradesDB['instigator'] = {
    name = "Instigator",
    XWS = 'instigator',
    slot = 15,
    limited = 1,
    addSlot = { 23 },
    restriction = {
        Faction = { [2] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}
masterUpgradesDB['bloodcrow'] = {
    name = "Blood Crow",
    XWS = 'bloodcrow',
    slot = 15,
    limited = 1,
    Energy = 2,
    shd = -1,
    addSlot = { 16 },
    restriction = {
        Faction = { [2] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['requiem'] = {
    name = "Requiem",
    XWS = 'requiem',
    slot = 15,
    limited = 1,
    restriction = {
        Faction = { [2] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['suppressor'] = {
    name = "Suppressor",
    XWS = 'suppressor',
    slot = 15,
    limited = 1,
    shd = 2,
    Hull = -2,
    addSlot = { 2 },
    restriction = {
        Faction = { [2] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['vector'] = {
    name = "Vector",
    XWS = 'vector',
    slot = 15,
    limited = 1,
    addSqdAction = { 'E', 'B' },
    addSlot = { 8, 22 },
    restriction = {
        Faction = { [2] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['brokenhorn'] = {
    name = "Broken Horn",
    XWS = 'brokenhorn',
    slot = 15,
    limited = 1,
    addSlot = { 8, 13 },
    restriction = {
        Faction = { [3] = true },
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['merchantone'] = {
    name = "Merchant One",
    XWS = 'merchantone',
    slot = 15,
    limited = 1,
    addAction = { 'E' },
    addSlot = { 4, 23, 22 },
    restriction = {
        Faction = { [3] = true },
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['insatiableworrt'] = {
    name = "Insatiable Worrt",
    XWS = 'insatiableworrt',
    slot = 15,
    shd = -1,
    Energy = -1,
    Hull = 3,
    addSlot = { 22 },
    restriction = {
        Faction = { [3] = true },
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['corsairrefit'] = {
    name = "Corsair Refit",
    XWS = 'corsairrefit',
    slot = 18,
    shd = -2,
    Energy = 1,
    Hull = 2,
    addSlot = { 3, 4, 6 },
    restriction = {
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['strategiccommander'] = {
    name = "Strategic Commander",
    XWS = 'strategiccommander',
    slot = 21,
    remSlot = { 8 },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Size = { huge = true }
    }
}

masterUpgradesDB['vectoredcannonsrz1'] = {
    name = "Vectored Cannons (RZ-1)",
    XWS = 'vectoredcannonsrz1',
    slot = 18,
    restriction = {
        ship = { ['rz1awing'] = true }
    },
    arcs = { turret = { name = 'primary', type = { 'front', 'back' } } },
}

masterUpgradesDB['b6bladewingprototype1'] = {
    name = "B6 Blade Wing Prototype",
    XWS = 'b6bladewingprototype1',
    slot = 15,
    limited = 1,
    addSlot = { 16 },
    restriction = {
        Faction = { [1] = true },
        ship = { ['asf01bwing'] = true }
    },
}

masterUpgradesDB['b6bladewingprototype'] = {
    name = "B6 Blade Wing Prototype",
    XWS = 'b6bladewingprototype',
    slot = 21,
    limited = 1,
    addSlot = { 16 },
    remSlot = { 15 },
    restriction = {
        Faction = { [1] = true },
        ship = { ['asf01bwing'] = true }
    },
}

masterUpgradesDB['hopeful'] = {
    name = "Hopeful",
    XWS = 'hopeful',
    slot = 1,
    restriction = {
        Faction = { [1] = true }
    },
    addAction = { 'B', 'F' },
}

masterUpgradesDB['sabinewren-gunner'] = {
    name = "Sabine Wren",
    XWS = 'sabinewren-gunner',
    slot = 16,
    limited = 1,
    restriction = {
        Faction = { [1] = true }
    },
}

masterUpgradesDB['phoenixsquadron'] = {
    name = "Phoenix Squadron",
    XWS = 'phoenixsquadron',
    slot = 21,
    limited = 1,
    wingleader = true,
    dual = true,
    restriction = {
        Faction = { [1] = true },
        ship = { ['vcx100lightfreighter'] = true }
    },
}

masterUpgradesDB['disciplined'] = {
    name = "Disciplined",
    XWS = 'disciplined',
    slot = 1,
    restriction = {
        Faction = { [2] = true }
    },
    addAction = { 'TL', 'BR' },
}


masterUpgradesDB['sensitivecontrols'] = {
    name = "Sensitive Controls",
    XWS = 'sensitivecontrols',
    slot = 18,
    restriction = {
        ship = {
            ['tieininterceptor'] = true,
            ['tievnsilencer'] = true
        }
    }
}

masterUpgradesDB['skystrikeacademyclass'] = {
    name = "Skystrike Academy Class",
    XWS = 'skystrikeacademyclass',
    slot = 21,
    limited = 2,
    wingleader = true,
    dual = true,
    restriction = {
        Faction = { [2] = true },
        ship = {
            ['tielnfighter'] = true,     --TIE fighter
            ['tieininterceptor'] = true, --TIE interceptor
        }
    },
}

masterUpgradesDB['shadowwing'] = {
    name = "Shadow Wing",
    XWS = 'shadowwing',
    slot = 21,
    limited = 1,
    wingleader = true,
    dual = true,
    restriction = {
        Faction = { [2] = true },
        ship = {
            ['tielnfighter'] = true,     --TIE fighter
            ['tieininterceptor'] = true, --TIE interceptor
            ['tiesabomber'] = true,      --TIE bomber
        }
    },
}

masterUpgradesDB['gamutkey'] = {
    name = "Gamut Key",
    XWS = 'gamutkey',
    slot = 8,
    Charge = 2,
    addAction = { 'TL' },
    restriction = {
        Faction = { [3] = true }
    }
}


masterUpgradesDB['cutthroat'] = {
    name = "Cutthroat",
    XWS = 'cutthroat',
    slot = 1,
    restriction = {
        Faction = { [3] = true }
    },
}

masterUpgradesDB['bounty'] = {
    name = "Bounty",
    XWS = 'bounty',
    dual = true,
    slot = 21,
    restriction = {
        Faction = { [3] = true }
    },
}

masterUpgradesDB['initforthemoney'] = {
    name = "In It For The Money",
    XWS = 'initforthemoney',
    dual = true,
    slot = 21,
    restriction = {
        Faction = { [3] = true }
    },
}

masterUpgradesDB['interloperturn'] = {
    name = "Interloper Turn",
    XWS = 'interloperturn',
    slot = 1,
    restriction = {
        ship = { ['tiededefender'] = true }
    },
    addAction = { 'TL', 'BR' },
}

masterUpgradesDB['protectorategleb'] = {
    name = "Protectorate Gleb",
    XWS = 'protectorategleb',
    slot = 8,
    restriction = {
        Faction = { [2] = true, [3] = true, [5] = true }
    }
}

masterUpgradesDB['r4b11'] = {
    name = "R4-B11",
    XWS = 'r4b11',
    slot = 10,
    restriction = {
        Faction = { [3] = true }
    }
}

masterUpgradesDB['tiedefenderelite'] = {
    name = "TIE Defender Elite",
    XWS = 'tiedefenderelite',
    slot = 18,
    restriction = {
        Faction = { [2] = true },
        ship = { ['tiededefender'] = true }
    }
}

masterUpgradesDB['tierfonbellyrun'] = {
    name = "Tierfon Belly Run",
    XWS = 'tierfonbellyrun',
    slot = 1,
    restriction = {
        ship = { ['btla4ywing'] = true }
    }
}


masterUpgradesDB['asajjventress'] = {
    name = "Asajj Ventress",
    XWS = 'asajjventress',
    Force = 1,
    slot = 21,
    remSlot = { 8 },
    limited = 1,
    addAction = { "F" },
    restriction = {
        Size = { huge = true },
        Faction = { [3] = true, [7] = true }
    }
}

masterUpgradesDB['rifftamson'] = {
    name = "Riff Tamson",
    XWS = 'rifftamson',
    slot = 21,
    remSlot = { 8 },
    limited = 1,
    restriction = {
        Size = { huge = true },
        Faction = { [7] = true }
    }
}

masterUpgradesDB['generalgrievous-command'] = {
    name = "General Grievous",
    XWS = 'generalgrievous-command',
    slot = 21,
    remSlot = { 8 },
    limited = 1,
    restriction = {
        Size = { huge = true },
        Faction = { [7] = true }
    }
}

masterUpgradesDB['tractortechnicians'] = {
    name = "Tractor Technicians",
    XWS = 'tractortechnicians',
    slot = 23,
}

masterUpgradesDB['hondoohnaka-command'] = {
    name = "Hondo Ohnaka",
    XWS = 'hondoohnaka-command',
    slot = 21,
    limite = 1,
    remSlot = { 8 },
    Charge = 2,
    restriction = {
        Size = { huge = true },
    }
}

masterUpgradesDB['corsaircrew'] = {
    name = "Corsair Crew",
    XWS = 'corsaircrew',
    slot = 23,
    remSlot = { 16 },
    restriction = {
        Faction = { [3] = true },
    }
}

masterUpgradesDB['martuuk'] = {
    name = "Mar Tuuk",
    XWS = 'martuuk',
    slot = 21,
    limited = 1,
    remSlot = { 8 },
    restriction = {
        Faction = { [7] = true },
        Size = { huge = true },
    }
}

masterUpgradesDB['zealouscaptain'] = {
    name = "Zealous Captain",
    XWS = 'zealouscaptain',
    slot = 21,
    limited = 1,
    remSlot = { 8 },
    restriction = {
        Size = { huge = true },
    }
}

masterUpgradesDB['tractortentacles'] = {
    name = "Tractor Tentacles",
    XWS = 'tractortentacles',
    slot = 24,
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['drillbeak'] = {
    name = "Drill Beak",
    XWS = 'drillbeak',
    slot = 24,
    remSlot = { 22 },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['enhancedpropulsion'] = {
    name = "Enhanced Propulsion",
    XWS = 'enhancedpropulsion',
    slot = 24,
    remSlot = { 22 },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['protoncannonbattery'] = {
    name = "Proton Cannon Battery",
    XWS = 'protoncannonbattery',
    slot = 24,
    remSlot = { 22 },
    restriction = {
        Size = { huge = true },
    }
}

masterUpgradesDB['droidcrew'] = {
    name = "Droid Crew",
    XWS = 'droidcrew',
    slot = 23,
    addAction = { 'C', 'TL' },
    restriction = {
        Faction = { [7] = true },
    }
}

masterUpgradesDB['grappler'] = {
    name = "Grappler",
    XWS = 'grappler',
    limited = 1,
    slot = 15,
    Shield = -1,
    Hull = 2,
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['nautolansrevenge'] = {
    name = "Nautolan's Revenge",
    XWS = 'nautolansrevenge',
    slot = 15,
    limited = 1,
    Shield = 1,
    Hull = -2,
    Energy = 1,
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
        Faction = { [3] = true }
    }
}

masterUpgradesDB['neimoidiangrasp'] = {
    name = "Neimoidian Grasp",
    XWS = 'neimoidiangrasp',
    slot = 15,
    limited = 1,
    Hull = -2,
    addAction = { "E" },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
        Faction = { [7] = true }
    }
}

masterUpgradesDB['trident'] = {
    name = "Trident",
    XWS = 'trident',
    slot = 15,
    limited = 1,
    Energy = 1,
    addAction = { "E" },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
        Faction = { [7] = true }
    }
}

masterUpgradesDB['trackingtorpedoes'] = {
    name = "Tracking Torpedoes",
    XWS = 'trackingtorpedoes',
    slot = 5,
    limited = 1,
    Charge = 3,
    restriction = {
        Size = { huge = true }
    }
}

masterUpgradesDB['feedbackping'] = {
    name = "Feedback Ping",
    XWS = 'feedbackping',
    slot = 1,
    restriction = {                   -- Tie, Reload
        ship = {
            ['tiesabomber'] = true,   -- Tie/sa Bomber
            ['tiecepunisher'] = true, -- Tie Punisher
            ['tiesebomber'] = true,   -- Tie/Se Bomber
        },
    }
}

masterUpgradesDB['sensorscramblers'] = {
    name = "Sensor Scramblers",
    XWS = 'sensorscramblers',
    slot = 19,
    restriction = {
        ship = {
            ['tiewiwhispermodifiedinterceptor'] = true, -- Tie Whisper
            ['tievnsilencer'] = true,                   -- Tie Silencer
        },
    }
}

masterUpgradesDB['enhancedjammingsuite'] = {
    name = "Enhanced Jamming Suite",
    XWS = 'enhancedjammingsuite',
    slot = 18,
    remSlot = { 19 },
    restriction = {
        ship = {
            ['tiewiwhispermodifiedinterceptor'] = true, -- Tie Whisper
        },
    }
}

masterUpgradesDB['l4er5'] = {
    name = "L4E-R5",
    XWS = 'l4er5',
    slot = 10,
    limited = 1,
    addAction = { 'C' },
    restriction = {
        Faction = { [4] = true }
    },
}

masterUpgradesDB['overtunedmodulators'] = {
    name = "Overtuned Modulators",
    XWS = 'overtunedmodulators',
    slot = 13,
    Charge = 1,
    addAction = { 'C' },
}

masterUpgradesDB['wartimeloadout'] = {
    name = "Wartime Loadout",
    XWS = 'wartimeloadout',
    slot = 18,
    remSlot = { 14 },
    addSlot = { 5, 6 },
    shd = 2,
    addAction = { 'TL' },
    restriction = {
        ship = {
            ['btanr2ywing'] = true, -- Res Y-Wing
        },
    }
}

masterUpgradesDB['watchfulastromech'] = {
    name = "Watchful Astromech",
    XWS = 'watchfulastromech',
    slot = 10,
    addAction = { 'C' },
}

masterUpgradesDB['dt798'] = {
    name = "DT-798",
    XWS = 'dt798',
    slot = 16,
    restriction = {
        Faction = { [5] = true }
    },
}

masterUpgradesDB['electrochaffmissiles'] = {
    name = "Electro-Chaff Missiles",
    XWS = 'electrochaffmissiles',
    limited = 2,
    slot = 6,
    Charge = 1,
    Bomb = true,
    remSlot = { 12 },
}

masterUpgradesDB['firstorderordnancetech'] = {
    name = "First Order Ordnance Tech",
    XWS = 'firstorderordnancetech',
    slot = 16,
    addAction = { 'TL' },
    restriction = {
        Faction = { [5] = true }
    },
}

masterUpgradesDB['babufrik'] = {
    name = "Babu Frik",
    XWS = 'babufrik',
    limited = 1,
    Charge = 3,
    slot = 13,
    restriction = {
        Faction = { [3] = true, [4] = true }
    },
}

masterUpgradesDB['compassion'] = {
    name = "Compassion",
    XWS = 'compassion',
    slot = 17,
    restriction = {
        keywords = { 'Light Side' }
    },
}

masterUpgradesDB['malice'] = {
    name = "Malice",
    XWS = 'malice',
    slot = 17,
    restriction = {
        keywords = { 'Dark Side' }
    },
}

masterUpgradesDB['shatteringshot'] = {
    name = "Shattering Shot",
    XWS = 'shatteringshot',
    slot = 17,
}

-- Pride of Mandalore reinforcement pack

masterUpgradesDB['ahsokatano-crew'] = {
    name = "Ahsoka Tano",
    limited = 1,
    XWS = 'ahsokatano-crew',
    slot = 8,
    Force = 1,
    addSqdAction = { 'F' },
    restriction = {
        Faction = { [3] = true, [6] = true }
    },
}

masterUpgradesDB['primeministeralmec'] = {
    name = "Prime Minister Almec",
    limited = 1,
    XWS = 'primeministeralmec',
    slot = 8,
    dual = true,
    addSqdAction = { 'C' },
    restriction = {
        Faction = { [3] = true, [6] = true }
    },
}

masterUpgradesDB['bokatankryze'] = {
    name = "Bo-Katan Kryze",
    limited = 1,
    XWS = 'bokatankryze',
    slot = 8,
    restriction = {
        Faction = { [6] = true, [7] = true }
    },
}

masterUpgradesDB['bokatankryze-rebel-scum'] = {
    name = "Bo-Katan Kryze",
    limited = 1,
    XWS = 'bokatankryze-rebel-scum',
    slot = 8,
    restriction = {
        Faction = { [1] = true, [3] = true }
    },
}

masterUpgradesDB['korkiekryze'] = {
    name = "Korkie Kryze",
    limited = 1,
    XWS = 'korkiekryze',
    slot = 8,
    restriction = {
        Faction = { [6] = true }
    },
}

masterUpgradesDB['maul-crew'] = {
    name = "Maul",
    title = "Mandalore",
    limited = 1,
    XWS = 'maul-crew',
    slot = 8,
    remSlot = { 8 },
    addSlot = { 13 },
    Force = 1,
    restriction = {
        Faction = { [3] = true }
    },
}

masterUpgradesDB['previzsla'] = {
    name = "Pre Vizsla",
    limited = 1,
    XWS = 'previzsla',
    slot = 8,
    restriction = {
        Faction = { [3] = true, [7] = true }
    },
}

masterUpgradesDB['rookkast'] = {
    name = "Rook Kast",
    limited = 1,
    XWS = 'rookkast',
    slot = 8,
    addAction = { 'TL' },
    restriction = {
        Faction = { [3] = true }
    },
}

masterUpgradesDB['savageopress'] = {
    name = "Savage Opress",
    limited = 1,
    Force = 1,
    XWS = 'savageopress',
    slot = 8,
    restriction = {
        Faction = { [3] = true, [7] = true }
    },
}

masterUpgradesDB['talmerrik'] = {
    name = "Tal Merrik",
    limited = 1,
    XWS = 'talmerrik',
    slot = 8,
    restriction = {
        Faction = { [7] = true }
    },
    Condition = "False Friend",
}

masterUpgradesDB['sabinewren-crew'] = {
    name = "Sabine Wren",
    limited = 1,
    XWS = 'sabinewren-crew',
    slot = 8,
    restriction = {
        Faction = { [1] = true },
        Size = { small = true, medium = true, large = true }
    },
    Condition = "Trials of the Darksaber",
}

masterUpgradesDB['captainhark'] = {
    name = "Captain Hark",
    limited = 1,
    XWS = 'captainhark',
    slot = 8,
    Charge = 2,
    restriction = {
        Faction = { [2] = true },
    },
}

masterUpgradesDB['fennrau'] = {
    name = "Fenn Rau",
    limited = 1,
    XWS = 'fennrau',
    slot = 8,
    restriction = {
        Faction = { [1] = true, [3] = true },
    },
}

masterUpgradesDB['garsaxon'] = {
    name = "Gar Saxon",
    limited = 1,
    XWS = 'garsaxon',
    slot = 8,
    restriction = {
        Faction = { [2] = true },
    },
}

masterUpgradesDB['obiwankenobi'] = {
    name = "Obi-Wan Kenobi",
    limited = 1,
    XWS = 'obiwankenobi',
    slot = 8,
    Force = 1,
    restriction = {
        Faction = { [6] = true },
    },
}

masterUpgradesDB['satinekryze'] = {
    name = "Satine Kryze",
    limited = 1,
    XWS = 'satinekryze',
    slot = 8,
    Charge = 2,
    restriction = {
        Faction = { [6] = true },
    },
}

masterUpgradesDB['kuiil'] = {
    name = "Kuiil",
    limited = 1,
    XWS = 'kuiil',
    slot = 8,
    restriction = {
        Faction = { [3] = true },
    },
}

masterUpgradesDB['tristanwren'] = {
    name = "Tristan Wren",
    limited = 1,
    XWS = 'tristanwren',
    slot = 8,
    Charge = 1,
    restriction = {
        Faction = { [1] = true },
        keywords = { 'Gar Saxon' }
    },
}

masterUpgradesDB['ursawren'] = {
    name = "Ursa Wren",
    limited = 1,
    XWS = 'ursawren',
    slot = 8,
    restriction = {
        Faction = { [1] = true },
    },
}

masterUpgradesDB['garsaxon-gunner'] = {
    name = "Gar Saxon",
    limited = 1,
    XWS = 'garsaxon-gunner',
    slot = 16,
    restriction = {
        Faction = { [3] = true },
        Size = { large = true, huge = true }
    },
}

masterUpgradesDB['tibersaxon'] = {
    name = "Tiber Saxon",
    limited = 1,
    XWS = 'tibersaxon',
    slot = 16,
    Charge = 2,
    restriction = {
        Faction = { [2] = true }
    },
}

masterUpgradesDB['ursawren-gunner'] = {
    name = "Ursa Wren",
    limited = 1,
    XWS = 'ursawren-gunner',
    slot = 16,
    restriction = {
        Faction = { [6] = true, [7] = true }
    },
}


masterUpgradesDB['clantraining'] = {
    name = "Clan Training",
    XWS = 'clantraining',
    slot = 1,
    Charge = 1,
    restriction = {
        keywords = { 'Mandalorian' }
    },
}

masterUpgradesDB['blazerbomb'] = {
    name = "Blazer Bomb",
    XWS = 'blazerbomb',
    slot = 12,
    Charge = 1,
    Bomb = true,
}

masterUpgradesDB['beskarreinforcedplating'] = {
    name = "Beskar Reinforced Plating",
    XWS = 'beskarreinforcedplating',
    slot = 14,
    Charge = 2,
    restriction = {
        keywords = { 'Mandalorian' }
    },
}

masterUpgradesDB['mandalorianoptics'] = {
    name = "Mandalorian Optics",
    XWS = 'mandalorianoptics',
    slot = 14,
    Charge = 2,
    restriction = {
        keywords = { 'Mandalorian' }
    },
}

masterUpgradesDB['gauntlet'] = {
    name = "Gauntlet",
    XWS = 'gauntlet',
    limited = 1,
    slot = 15,
    remSlot = { 18 },
    addSlot = { 8 },
    Charge = 2,
    restriction = {
        Faction = { [6] = true, [7] = true },
        ship = { ['gauntletfighter'] = true }
    }
}

masterUpgradesDB['nightbrother'] = {
    name = "Nightbrother",
    XWS = 'nightbrother',
    limited = 1,
    slot = 15,
    remSlot = { 18 },
    addSlot = { 8 },
    Charge = 2,
    restriction = {
        Faction = { [1] = true, [3] = true },
        ship = { ['gauntletfighter'] = true }
    }
}

masterUpgradesDB['razorcrest'] = {
    name = "Razor Crest",
    XWS = 'razorcrest',
    limited = 1,
    slot = 15,
    addAction = { 'E', 'BR' },
    restriction = {
        ship = { ['st70assaultship'] = true }
    }
}

masterUpgradesDB['trackingfob'] = {
    name = "Tracking Fob",
    XWS = 'trackingfob',
    limited = 3,
    slot = 13,
    restriction = {
        keywords = { 'Bounty Hunter' }
    },
    Condition = "Marked for Elimination",
}

masterUpgradesDB['ig11'] = {
    name = "IG-11",
    XWS = 'ig11',
    limited = 1,
    slot = 8,
    addAction = { 'C' },
    restriction = {
        Faction = { [3] = true },
    },
    dual = true,
}

masterUpgradesDB['burnoutthrusters'] = {
    name = "Burnout Thrusters",
    XWS = 'burnoutthrusters',
    Charge = 1,
    slot = 14,
    restriction = {
        Faction = { [3] = true },
        Size = { small = true, medium = true }
    },
}

masterUpgradesDB['thechild'] = {
    name = "The Child",
    XWS = 'thechild',
    Force = 2,
    slot = 8,
    restriction = {
        Faction = { [1] = true, [2] = true, [3] = true },
    },
    Condition = "Merciless Pursuit",
}

masterUpgradesDB['themandalorian'] = {
    name = "The Mandalorian",
    XWS = 'themandalorian',
    slot = 8,
    addAction = { 'R' },
    restriction = {
        Faction = { [3] = true },
    },
}

masterUpgradesDB['swivelwing'] = {
    name = "Swivel Wing",
    XWS = 'swivelwing',
    slot = 18,
    restriction = {
        ship = { ['gauntletfighter'] = true }
    },
    dual = true,
}


masterUpgradesDB['clanwrencommandos'] = {
    name = "Clan Wren Commandos",
    XWS = 'clanwrencommandos',
    remotes = { "Clan Wren Commandos (A)", "Clan Wren Commandos (B)" },
    limited = 1,
    slot = 8,
    remSlot = { 8 },
    Charge = 2,
    restriction = {
        Faction = { [1] = true },
        Size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['imperialsupercommandos'] = {
    name = "Imperial Super Commandos",
    XWS = 'imperialsupercommandos',
    remotes = { "Imperial Super Commandos (A)", "Imperial Super Commandos (B)" },
    limited = 1,
    slot = 8,
    remSlot = { 8 },
    Charge = 2,
    restriction = {
        Faction = { [2] = true },
        Size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['mandaloriansupercommandos'] = {
    name = "Mandalorian Super Commandos",
    XWS = 'mandaloriansupercommandos',
    remotes = { "Mandalorian Super Commandos (A)", "Mandalorian Super Commandos (B)" },
    limited = 1,
    slot = 8,
    remSlot = { 8 },
    Charge = 2,
    restriction = {
        Faction = { [3] = true },
        Size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['niteowlcommandos'] = {
    name = "Nite Owl Commandos",
    XWS = 'niteowlcommandos',
    remotes = { "Nite Owl Commandos (A)", "Nite Owl Commandos (B)" },
    limited = 1,
    slot = 8,
    remSlot = { 8 },
    Charge = 2,
    restriction = {
        Faction = { [6] = true },
        Size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['deathwatchcommandos'] = {
    name = "Death Watch Commandos",
    XWS = 'deathwatchcommandos',
    remotes = { "Death Watch Commandos (A)", "Death Watch Commandos (B)" },
    limited = 1,
    slot = 8,
    remSlot = { 8 },
    Charge = 2,
    restriction = {
        Faction = { [7] = true },
        Size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['dropseatbay'] = {
    name = "Drop-Seat bay",
    XWS = 'dropseatbay',
    slot = 14,
    restriction = {
        ship = { ['gauntletfighter'] = true }
    },
}

masterUpgradesDB['homingtorpedoes'] = {
    name = 'Homing Torpedoes',
    XWS = 'homingtorpedoes',
    slot = 5,
    Charge = 2,
}

masterUpgradesDB['notorious'] = {
    name = "Notorious",
    XWS = 'notorious',
    slot = 1,
    Charge = 2,
    restriction = {
        -- equipped: illicit
    },
}

masterUpgradesDB['enduring'] = {
    name = "Enduring",
    XWS = 'enduring',
    slot = 1,
}

masterUpgradesDB['pelimotto'] = {
    name = "Peli Motto",
    XWS = 'pelimotto',
    restriction = {
        Faction = { [3] = true },
        Size = { medium = true, large = true }
    },
    slot = 8,
    limited = 1,
}

masterUpgradesDB['greefkarga'] = {
    name = "Greef Karga",
    XWS = 'greefkarga',
    restriction = {
        Faction = { [3] = true }
    },
    slot = 8,
    limited = 1,
}

masterUpgradesDB['migsmayfeld'] = {
    name = "Migs Mayfeld",
    XWS = 'migsmayfeld',
    restriction = {
        Faction = { [2] = true, [3] = true }
    },
    slot = 16,
    limited = 1,
}

masterUpgradesDB['hotshottailblaster'] = {
    name = "Hotshot Tail Blaster",
    XWS = 'hotshottailblaster',
    Charge = 2,
    slot = 14,
    restriction = {
        Size = { medium = true, large = true }
    },
}

masterUpgradesDB['xanadublood'] = {
    name = "Xanadu Blood",
    XWS = 'xanadublood',
    slot = 15,
    restriction = {
        ship = { ['rogueclassstarfighter'] = true }
    },
}

masterUpgradesDB['protoncannons'] = {
    name = "Proton Cannons",
    XWS = 'protoncannons',
    slot = 3,
    remSlot = { 3 },
    cardB = cardBackDB['3b'],
    Charge = 2
}

masterUpgradesDB['combatboardingtube'] = {
    name = "Combat Boarding Tube",
    XWS = 'combatboardingtube',
    slot = 18,
    remSlot = { 21 },
    restriction = {
        ship = { ['gauntletfighter'] = true }
    },
}

-- The YASB epic pack Upgrades
masterUpgradesDB['newrecruit'] = {
    name = "New Recruit",
    XWS = 'newrecruit',
    limited = 3,
    slot = 21,
    PointModifier = -1,
}

masterUpgradesDB['lockedturretspecialist'] = {
    name = "Locked-Turret Specialist",
    XWS = 'lockedturretspecialist',
    slot = 21,
    Charge = 2,
    addAction = { 'B' },
    restriction = {
        -- action: rotate
    },
}

masterUpgradesDB['heavyreinforcedvanguard'] = {
    name = "Heavy Reinforced Vanguard",
    XWS = 'heavyreinforcedvanguard',
    slot = 21,
    limited = 1,
    PointModifier = 1,
    Hull = 2,
}

masterUpgradesDB['evasiveinterceptor'] = {
    name = "Evasive Interceptor",
    XWS = 'evasiveinterceptor',
    slot = 21,
    limited = 1,
    Hull = -1,
    PointModifier = -1,
    --Agility = 1,
    restriction = { Size = { small = true } }
}

masterUpgradesDB['countermeasuresspecialist'] = {
    name = "Countermeasures Specialist",
    XWS = 'countermeasuresspecialist',
    slot = 21,
    limited = 1,
    Charge = 2,
    --addAction = {'Jam'}
    restriction = { Size = { small = true } }
}

masterUpgradesDB['combatveteran'] = {
    name = "Combat Veteran",
    XWS = 'combatveteran',
    slot = 21,
    limited = 1,
    PointModifier = 1,
    restriction = {
        HasForce = false,
        IsLimited = true,
        InitiativeGreaterThan = 3
    },
    addSlot = { 1, 14 },
}

masterUpgradesDB['forceadeptpilot'] = {
    name = "Force Adept Pilot",
    XWS = 'forceadeptpilot',
    slot = 21,
    limited = 1,
    PointModifier = 1,
    restriction = {
        HasForce = true,
    },
    addSlot = { 17 },
    executeOptions = function(moves)
        return {
            rtl1 = { [1] = 'rtl1', [2] = 'rtl1z' },
            rtl2 = { [1] = 'rtl2', [2] = 'rtl2z' },
            rtl3 = { [1] = 'rtl3', [2] = 'rtl3z' },
            rtr1 = { [1] = 'rtr1', [2] = 'rtr1z' },
            rtr2 = { [1] = 'rtr2', [2] = 'rtr2z' },
            rtr3 = { [1] = 'rtr3', [2] = 'rtr3z' },

            rbl1 = { [1] = 'rbl1', [2] = 'rbl1z' },
            rbl2 = { [1] = 'rbl2', [2] = 'rbl2z' },
            rbl3 = { [1] = 'rbl3', [2] = 'rbl3z' },
            rbr1 = { [1] = 'rbr1', [2] = 'rbr1z' },
            rbr2 = { [1] = 'rbr2', [2] = 'rbr2z' },
            rbr3 = { [1] = 'rbr3', [2] = 'rbr3z' },

            wtl1 = { [1] = 'wtl1', [2] = 'rtl1z' },
            wtl2 = { [1] = 'wtl2', [2] = 'rtl2z' },
            wtl3 = { [1] = 'wtl3', [2] = 'rtl3z' },
            wtr1 = { [1] = 'wtr1', [2] = 'rtr1z' },
            wtr2 = { [1] = 'wtr2', [2] = 'rtr2z' },
            wtr3 = { [1] = 'wtr3', [2] = 'rtr3z' },

            wbl1 = { [1] = 'wbl1', [2] = 'rbl1z' },
            wbl2 = { [1] = 'wbl2', [2] = 'rbl2z' },
            wbl3 = { [1] = 'wbl3', [2] = 'rbl3z' },
            wbr1 = { [1] = 'wbr1', [2] = 'rbr1z' },
            wbr2 = { [1] = 'wbr2', [2] = 'rbr2z' },
            wbr3 = { [1] = 'wbr3', [2] = 'rbr3z' },

            btl1 = { [1] = 'btl1', [2] = 'rtl1z' },
            btl2 = { [1] = 'btl2', [2] = 'rtl2z' },
            btl3 = { [1] = 'btl3', [2] = 'rtl3z' },
            btr1 = { [1] = 'btr1', [2] = 'rtr1z' },
            btr2 = { [1] = 'btr2', [2] = 'rtr2z' },
            btr3 = { [1] = 'btr3', [2] = 'rtr3z' },

            bbl1 = { [1] = 'bbl1', [2] = 'rbl1z' },
            bbl2 = { [1] = 'bbl2', [2] = 'rbl2z' },
            bbl3 = { [1] = 'bbl3', [2] = 'rbl3z' },
            bbr1 = { [1] = 'bbr1', [2] = 'rbr1z' },
            bbr2 = { [1] = 'bbr2', [2] = 'rbr2z' },
            bbr3 = { [1] = 'bbr3', [2] = 'rbr3z' },


        }
    end,
}

masterUpgradesDB['adaptablepilot'] = {
    name = "Adaptable Pilot",
    XWS = 'adaptablepilot',
    slot = 21,
    limited = 2,
    PointModifier = 1,
    LoadoutModifier = 10
}


return masterUpgradesDB
