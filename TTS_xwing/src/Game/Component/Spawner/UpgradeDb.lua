masterUpgradesDB = {}
masterUpgradesDB['crackshot'] = {
    name = 'Crack Shot',
    XWS = 'crackshot',
    slot = 'Talent',
    Charge = 1,
}

masterUpgradesDB['daredevil'] = {
    name = 'Daredevil',
    XWS = 'daredevil',
    slot = 'Talent',
    addAction = { 'Dare' },
    restriction = { Size = { small = true } }
}

masterUpgradesDB['debrisgambit'] = {
    name = 'Debris Gambit',
    XWS = 'debrisgambit',
    slot = 'Talent',
    addAction = { 'E' },
    restriction = { Size = { small = true, medium = true } }
}

masterUpgradesDB['elusive'] = {
    name = 'Elusive',
    XWS = 'elusive',
    slot = 'Talent',
    Charge = 1,
    restriction = { Size = { small = true, medium = true } }
}

masterUpgradesDB['experthandling'] = {
    name = 'Expert Handling',
    XWS = 'experthandling',
    slot = 'Talent',
}

masterUpgradesDB['fearless'] = {
    name = 'Fearless',
    XWS = 'fearless',
    slot = 'Talent',
    restriction = {
        Faction = { ['scumandvillainy'] = true }
    }
}

masterUpgradesDB['intimidation'] = {
    name = 'Intimidation',
    XWS = 'intimidation',
    slot = 'Talent',
}

masterUpgradesDB['juke'] = {
    name = 'Juke',
    XWS = 'juke',
    slot = 'Talent',
    restriction = { Size = { small = true, medium = true } }
}

masterUpgradesDB['lonewolf'] = {
    name = 'Lone Wolf',
    XWS = 'lonewolf',
    slot = 'Talent',
    Charge = 1,
}

masterUpgradesDB['marksmanship'] = {
    name = 'Marksmanship',
    XWS = 'marksmanship',
    slot = 'Talent',
}

masterUpgradesDB['outmaneuver'] = {
    name = 'Outmaneuver',
    XWS = 'outmaneuver',
    slot = 'Talent',
}

masterUpgradesDB['predator'] = {
    name = 'Predator',
    XWS = 'predator',
    slot = 'Talent',
}

masterUpgradesDB['ruthless'] = {
    name = 'Ruthless',
    XWS = 'ruthless',
    slot = 'Talent',
    restriction = {
        Faction = { ['galacticempire'] = true }
    }
}

masterUpgradesDB['saturationsalvo'] = {
    name = 'Saturation Salvo',
    XWS = 'saturationsalvo',
    slot = 'Talent',
}

masterUpgradesDB['selfless'] = {
    name = 'Selfless',
    XWS = 'selfless',
    slot = 'Talent',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['squadleader'] = {
    name = 'Squad Leader',
    XWS = 'squadleader',
    slot = 'Talent',
}

masterUpgradesDB['swarmtactics'] = {
    name = 'Swarm Tactics',
    XWS = 'swarmtactics',
    slot = 'Talent',
}

masterUpgradesDB['trickshot'] = {
    name = 'Trick Shot',
    XWS = 'trickshot',
    slot = 'Talent',
}

masterUpgradesDB['heightenedperception'] = {
    name = 'Heightened Perception',
    XWS = 'heightenedperception',
    slot = 'Force Power',
}

masterUpgradesDB['instinctiveaim'] = {
    name = 'Instinctive Aim',
    XWS = 'instinctiveaim',
    slot = 'Force Power',
}

masterUpgradesDB['sense'] = {
    name = 'Sense',
    XWS = 'sense',
    slot = 'Force Power',
}

masterUpgradesDB['supernaturalreflexes'] = {
    name = 'Supernatural Reflexes',
    XWS = 'supernaturalreflexes',
    slot = 'Force Power',
    addAction = { 'B', 'BR' },
    restriction = { Size = { small = true } }
}

masterUpgradesDB['advancedsensors'] = {
    name = 'Advanced Sensors',
    XWS = 'advancedsensors',
    slot = 'Sensor',
}

masterUpgradesDB['collisiondetector'] = {
    name = 'Collision Detector',
    XWS = 'collisiondetector',
    slot = 'Sensor',
    Charge = 2
}

masterUpgradesDB['firecontrolsystem'] = {
    name = 'Fire-Control System',
    XWS = 'firecontrolsystem',
    slot = 'Sensor',
}

masterUpgradesDB['trajectorysimulator'] = {
    name = 'Trajectory Simulator',
    XWS = 'trajectorysimulator',
    slot = 'Sensor',
}

masterUpgradesDB['heavylasercannon'] = {
    name = 'Heavy Laser Cannon',
    XWS = 'heavylasercannon',
    slot = 'Cannon',
    arcs = {
        weapon = {
            name = 'Heavy Laser Cannon',
            range = 3,
            type = { 'front' }
        }
    }
}

masterUpgradesDB['ioncannon'] = {
    name = 'Ion Cannon',
    XWS = 'ioncannon',
    slot = 'Cannon',
    arcs = {
        weapon = {
            name = 'Ion Cannon',
            range = 3,
            type = { 'front' },
            ion = true
        }
    }
}

masterUpgradesDB['jammingbeam'] = {
    name = 'Jamming Beam',
    XWS = 'jammingbeam',
    slot = 'Cannon',
    arcs = {
        weapon = {
            name = 'Jamming Beam',
            range = 3,
            type = { 'front' }
        }
    }
}

masterUpgradesDB['tractorbeam'] = {
    name = 'Tractor Beam',
    XWS = 'tractorbeam',
    slot = 'Cannon',
    arcs = {
        weapon = {
            name = 'Tractor Beam',
            range = 3,
            type = { 'front' }
        }
    }
}


masterUpgradesDB['dorsalturret'] = {
    name = 'Dorsal Turret',
    XWS = 'dorsalturret',
    slot = 'Turret',
    arcs = { turret = { name = 'dorsal turret', range = 2, type = { 'singleturret' } } }
}

masterUpgradesDB['ioncannonturret'] = {
    name = 'Ion Cannon Turret',
    XWS = 'ioncannonturret',
    slot = 'Turret',
    arcs = { turret = { name = 'ion cannon turret', range = 2, type = { 'singleturret' }, ion = true } }
}

masterUpgradesDB['advprotontorpedoes'] = {
    name = 'Adv. Proton Torpedoes',
    XWS = 'advprotontorpedoes',
    slot = 'Torpedo',
    Charge = 1
}

masterUpgradesDB['iontorpedoes'] = {
    name = 'Ion Torpedoes',
    XWS = 'iontorpedoes',
    slot = 'Torpedo',
    Charge = 2
}

masterUpgradesDB['protontorpedoes'] = {
    name = 'Proton Torpedoes',
    XWS = 'protontorpedoes',
    slot = 'Torpedo',
    Charge = 2,
}

masterUpgradesDB['barragerockets'] = {
    name = 'Barrage Rockets',
    XWS = 'barragerockets',
    slot = 'Missile',
    remSlot = { 'Missile' },
    Charge = 5,
    cardB = cardBackDB['Missile Dual'],
}

masterUpgradesDB['clustermissiles'] = {
    name = 'Cluster Missiles',
    XWS = 'clustermissiles',
    slot = 'Missile',
    Charge = 4
}

masterUpgradesDB['concussionmissiles'] = {
    name = 'Concussion Missiles',
    XWS = 'concussionmissiles',
    slot = 'Missile',
    Charge = 3
}

masterUpgradesDB['homingmissiles'] = {
    name = 'Homing Missiles',
    XWS = 'homingmissiles',
    slot = 'Missile',
    Charge = 2
}

masterUpgradesDB['ionmissiles'] = {
    name = 'Ion Missiles',
    XWS = 'ionmissiles',
    slot = 'Missile',
    Charge = 3
}

masterUpgradesDB['protonrockets'] = {
    name = 'Proton Rockets',
    XWS = 'protonrockets',
    slot = 'Missile',
    Charge = 1
}

masterUpgradesDB['freelanceslicer'] = {
    name = 'Freelance Slicer',
    XWS = 'freelanceslicer',
    slot = 'Crew',
}

masterUpgradesDB['gnkgonkdroid'] = {
    name = 'GNK "Gonk" Droid',
    XWS = 'gnkgonkdroid',
    slot = 'Crew',
    Charge = 1
}

masterUpgradesDB['informant'] = {
    name = 'Informant',
    XWS = 'informant',
    Condition = "Listening Device",
    slot = 'Crew',
}

masterUpgradesDB['novicetechnician'] = {
    name = 'Novice Technician',
    XWS = 'novicetechnician',
    slot = 'Crew',
}

masterUpgradesDB['perceptivecopilot'] = {
    name = 'Perceptive Copilot',
    XWS = 'perceptivecopilot',
    slot = 'Crew',
}

masterUpgradesDB['seasonednavigator'] = {
    name = 'Seasoned Navigator',
    XWS = 'seasonednavigator',
    slot = 'Crew',

    restriction = {},
    executeOptions = function(list, pilotid)
        exopts = {}
        nextdiff = { b = "w", w = "r" }
        if pilotid == 0 or pilotid == '' then
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
    slot = 'Crew',
}

masterUpgradesDB['hotshotgunner'] = {
    name = 'Hotshot Gunner',
    XWS = 'hotshotgunner',
    slot = 'Gunner',
}

masterUpgradesDB['skilledbombardier'] = {
    name = 'Skilled Bombardier',
    XWS = 'skilledbombardier',
    slot = 'Gunner',
}

masterUpgradesDB['veterantailgunner'] = {
    name = 'Veteran Tail Gunner',
    XWS = 'veterantailgunner',
    slot = 'Gunner',
}

masterUpgradesDB['veteranturretgunner'] = {
    name = 'Veteran Turret Gunner',
    XWS = 'veteranturretgunner',
    slot = 'Gunner',
}

masterUpgradesDB['r2astromech'] = {
    name = 'R2 Astromech',
    XWS = 'r2astromech',
    slot = 'Astromech',
    Charge = 2
}

masterUpgradesDB['r3astromech'] = {
    name = 'R3 Astromech',
    XWS = 'r3astromech',
    slot = 'Astromech',
}

masterUpgradesDB['r4astromech'] = {
    name = 'R4 Astromech',
    XWS = 'r4astromech',
    slot = 'Astromech',
    restriction = { Size = { small = true } }
}

masterUpgradesDB['r5astromech'] = {
    name = 'R5 Astromech',
    XWS = 'r5astromech',
    slot = 'Astromech',
    Charge = 2
}

masterUpgradesDB['cloakingdevice'] = {
    name = 'Cloaking Device',
    XWS = 'cloakingdevice',
    slot = 'Illicit',
    limited = 1,
    addAction = { 'CL' },
    Charge = 2,
    restriction = { Size = { small = true, medium = true } }
}

masterUpgradesDB['contrabandcybernetics'] = {
    name = 'Contraband Cybernetics',
    XWS = 'contrabandcybernetics',
    slot = 'Illicit',
    Charge = 1
}

masterUpgradesDB['deadmansswitch'] = {
    name = "Deadman's Switch",
    XWS = 'deadmansswitch',
    slot = 'Illicit',
}

masterUpgradesDB['feedbackarray'] = {
    name = 'Feedback Array',
    XWS = 'feedbackarray',
    slot = 'Illicit',
}

masterUpgradesDB['inertialdampeners'] = {
    name = 'Inertial Dampeners',
    XWS = 'inertialdampeners',
    slot = 'Illicit',
}

masterUpgradesDB['riggedcargochute'] = {
    name = 'Rigged Cargo Chute',
    XWS = 'riggedcargochute',
    slot = 'Illicit',
    Bomb = true,
    Charge = 1,
    restriction = { Size = { large = true, medium = true } }
}

masterUpgradesDB['ablativeplating'] = {
    name = 'Ablative Plating',
    XWS = 'ablativeplating',
    slot = 'Modification',
    Charge = 2,
    restriction = { Size = { large = true, medium = true } }
}

masterUpgradesDB['advancedslam'] = {
    name = 'Advanced SLAM',
    XWS = 'advancedslam',
    slot = 'Modification',
}


masterUpgradesDB['afterburners'] = {
    name = 'Afterburners',
    XWS = 'afterburners',
    addAction = { 'B' },
    slot = 'Modification',
    Charge = 2,
    restriction = {
        Size = { small = true }
    }
}

masterUpgradesDB['electronicbaffle'] = {
    name = 'Electronic Baffle',
    XWS = 'electronicbaffle',
    slot = 'Modification',
}

masterUpgradesDB['engineupgrade'] = {
    name = 'Engine Upgrade',
    XWS = 'engineupgrade',
    slot = 'Modification',
}

masterUpgradesDB['hullupgrade'] = {
    name = 'Hull Upgrade',
    XWS = 'hullupgrade',
    slot = 'Modification',
    Hull = 1,
    restriction = {}
}
masterUpgradesDB['munitionsfailsafe'] = {
    name = 'Munitions Failsafe',
    XWS = 'munitionsfailsafe',
    slot = 'Modification',
}

masterUpgradesDB['shieldupgrade'] = {
    name = 'Shield Upgrade',
    XWS = 'shieldupgrade',
    slot = 'Modification',
    shd = 1
}

masterUpgradesDB['staticdischargevanes'] = {
    name = 'Static Discharge Vanes',
    XWS = 'staticdischargevanes',
    slot = 'Modification',
}

masterUpgradesDB['stealthdevice'] = {
    name = 'Stealth Device',
    XWS = 'stealthdevice',
    slot = 'Modification',
    Charge = 1
}

masterUpgradesDB['tacticalscrambler'] = {
    name = 'Tactical Scrambler',
    XWS = 'tacticalscrambler',
    slot = 'Modification',
    restriction = { Size = { large = true, medium = true } }
}

masterUpgradesDB['bazemalbus'] = {
    name = 'Baze Malbus',
    XWS = 'bazemalbus',
    slot = 'Crew',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['c3po'] = {
    name = 'C-3PO',
    XWS = 'c3po',
    slot = 'Crew',
    addAction = { 'C' },
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['cassianandor'] = {
    name = 'Cassian Andor',
    XWS = 'cassianandor',
    slot = 'Crew',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['chewbacca'] = {
    name = 'Chewbacca',
    XWS = 'chewbacca',
    slot = 'Crew',
    Charge = 2,
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['chopper-crew'] = {
    name = '"Chopper"',
    XWS = 'chopper-crew',
    slot = 'Crew',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['herasyndulla'] = {
    name = 'Hera Syndulla',
    XWS = 'herasyndulla',
    slot = 'Crew',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['jynerso'] = {
    name = 'Jyn Erso',
    XWS = 'jynerso',
    slot = 'Crew',
    limited = 1,
    addSqdAction = { 'E' },
    restriction = { Faction = { ['rebelalliance'] = true } }
}


masterUpgradesDB['kananjarrus'] = {
    name = 'Kanan Jarrus',
    XWS = 'kananjarrus',
    slot = 'Crew',
    limited = 1,
    Force = 1,
    restriction = { Faction = { ['rebelalliance'] = true } }
}


masterUpgradesDB['landocalrissian'] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian',
    slot = 'Crew',
    addAction = { 'F', 'E' },
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['leiaorgana'] = {
    name = 'Leia Organa',
    XWS = 'leiaorgana',
    slot = 'Crew',
    Charge = 3,
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['magvayarro'] = {
    name = 'Magva Yarro',
    XWS = 'magvayarro',
    slot = 'Crew',
    addAction = { 'TL' },
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['niennunb'] = {
    name = 'Nien Nunb',
    XWS = 'niennunb',
    slot = 'Crew',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['r2d2-crew'] = {
    name = 'R2-D2',
    XWS = 'r2d2-crew',
    slot = 'Crew',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['sabinewren'] = {
    name = 'Sabine Wren',
    XWS = 'sabinewren',
    slot = 'Crew',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['sawgerrera'] = {
    name = 'Saw Gerrera',
    XWS = 'sawgerrera',
    slot = 'Crew',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['zeborrelios'] = {
    name = '"Zeb" Orrelios',
    XWS = 'zeborrelios',
    slot = 'Crew',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['bistan'] = {
    name = 'Bistan',
    XWS = 'bistan',
    slot = 'Gunner',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['ezrabridger'] = {
    name = 'Ezra Bridger',
    XWS = 'ezrabridger',
    slot = 'Gunner',
    Force = 1,
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['hansolo'] = {
    name = 'Han Solo',
    XWS = 'hansolo',
    slot = 'Gunner',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['lukeskywalker'] = {
    name = 'Luke Skywalker',
    XWS = 'lukeskywalker',
    slot = 'Gunner',
    Force = 1,
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['chopper'] = {
    name = '"Chopper"',
    XWS = 'chopper',
    slot = 'Astromech',
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['r2d2'] = {
    name = 'R2-D2',
    XWS = 'r2d2',
    slot = 'Astromech',
    Charge = 3,
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['r5d8'] = {
    name = 'R5-D8',
    XWS = 'r5d8',
    slot = 'Astromech',
    Charge = 3,
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['ghost'] = {
    name = 'Ghost',
    XWS = 'ghost',
    slot = 'Title',
    restriction = { Faction = { ['rebelalliance'] = true }, ship = { ['vcx100lightfreighter'] = true } }
}

masterUpgradesDB['millenniumfalcon'] = {
    name = 'Millennium Falcon',
    XWS = 'millenniumfalcon',
    limited = 1,
    slot = 'Title',
    addAction = { 'E' },
    restriction = { Faction = { ['rebelalliance'] = true }, ship = { ['modifiedyt1300lightfreighter'] = true } }
}

masterUpgradesDB['moldycrow'] = {
    name = 'Moldy Crow',
    XWS = 'moldycrow',
    limited = 1,
    slot = 'Title',
    restriction = {
        Faction = { ['rebelalliance'] = true, ['scumandvillainy'] = true },
        ship = { ['hwk290lightfreighter'] = true }
    },
    arcs = { fixed = { range = 3, type = { 'front' } } }
}

masterUpgradesDB['outrider'] = {
    name = 'Outrider',
    XWS = 'outrider',
    slot = 'Title',
    restriction = { ship = { ['yt2400lightfreighter'] = true } }
}

masterUpgradesDB['phantom'] = {
    name = 'Phantom',
    XWS = 'phantom',
    slot = 'Title',
    restriction = { Faction = { ['rebelalliance'] = true }, ship = { ['attackshuttle'] = true, ['sheathipedeclassshuttle'] = true } }
}

masterUpgradesDB['pivotwing'] = {
    name = 'Pivot Wing',
    XWS = 'pivotwing',
    slot = 'Configuration',
    addAction = { 'Piv' },
    dual = true,
    restriction = { Faction = { ['rebelalliance'] = true }, ship = { ['ut60duwing'] = true } }
}

masterUpgradesDB['servomotorsfoils'] = {
    name = 'Servomotor S-Foils',
    XWS = 'servomotorsfoils',
    slot = 'Configuration',
    addAction = { 'B' },
    dual = true,
    restriction = { Faction = { ['rebelalliance'] = true }, ship = { ['t65xwing'] = true } }
}


masterUpgradesDB['admiralsloane'] = {
    name = 'Admiral Sloane',
    XWS = 'admiralsloane',
    slot = 'Crew',
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['agentkallus'] = {
    name = 'Agent Kallus',
    XWS = 'agentkallus',
    Condition = "Hunted",
    slot = 'Crew',
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['cienaree'] = {
    name = 'Ciena Ree',
    XWS = 'cienaree',
    slot = 'Crew',
    limited = 1,
    addSqdAction = { 'Piv' },
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['darthvader'] = {
    name = 'Darth Vader',
    XWS = 'darthvader',
    slot = 'Crew',
    limited = 1,
    Force = 1,
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['deathtroopers'] = {
    name = 'Death Troopers',
    XWS = 'deathtroopers',
    slot = 'Crew',
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['directorkrennic'] = {
    name = 'Director Krennic',
    XWS = 'directorkrennic',
    Condition = "Optimized Prototype",
    slot = 'Crew',
    limited = 1,
    addAction = { 'TL' },
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['emperorpalpatine'] = {
    name = 'Emperor Palpatine',
    XWS = 'emperorpalpatine',
    slot = 'Crew',
    remSlot = { 'Crew' },
    Force = 1,
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['grandinquisitor'] = {
    name = 'Grand Inquisitor',
    XWS = 'grandinquisitor',
    slot = 'Crew',
    Force = 1,
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['grandmofftarkin'] = {
    name = 'Grand Moff Tarkin',
    XWS = 'grandmofftarkin',
    slot = 'Crew',
    Charge = 2,
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['isbslicer'] = {
    name = 'ISB Slicer',
    XWS = 'isbslicer',
    slot = 'Crew',
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['ministertua'] = {
    name = 'Minister Tua',
    XWS = 'ministertua',
    slot = 'Crew',
    limited = 1,
    addAction = { 'R' },
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['moffjerjerrod'] = {
    name = 'Moff Jerjerrod',
    XWS = 'moffjerjerrod',
    slot = 'Crew',
    limited = 1,
    addSqdAction = { 'B' },
    Charge = 2,
    restriction = { Faction = { ['galacticempire'] = true } }
}


masterUpgradesDB['seventhsister'] = {
    name = 'Seventh Sister',
    XWS = 'seventhsister',
    slot = 'Crew',
    Force = 1,
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['fifthbrother'] = {
    name = 'Fifth Brother',
    XWS = 'fifthbrother',
    slot = 'Gunner',
    Force = 1,
    restriction = { Faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['dauntless'] = {
    name = 'Dauntless',
    XWS = 'dauntless',
    slot = 'Title',
    restriction = { Faction = { ['galacticempire'] = true }, ship = { ['vt49decimator'] = true } }
}

masterUpgradesDB['os1arsenalloadout'] = {
    name = 'Os-1 Arsenal Loadout',
    XWS = 'os1arsenalloadout',
    slot = 'Configuration',
    addSlot = { 'Torpedo', 'Missile' },
    restriction = { Faction = { ['galacticempire'] = true }, ship = { ['alphaclassstarwing'] = true } }
}

masterUpgradesDB['xg1assaultconfiguration'] = {
    name = 'Xg-1 Assault Configuration',
    XWS = 'xg1assaultconfiguration',
    slot = 'Configuration',
    addSlot = { 'Cannon' },
    restriction = { Faction = { ['galacticempire'] = true }, ship = { ['alphaclassstarwing'] = true } }
}

masterUpgradesDB['000'] = {
    name = '0-0-0',
    XWS = '000',
    slot = 'Crew',
    addAction = { 'C' },
    restriction = { Faction = { ['galacticempire'] = true, ['scumandvillainy'] = true }, keywords = { 'Darth Vader' } }
}

masterUpgradesDB['4lom'] = {
    name = '4-LOM',
    XWS = '4lom',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['bobafett'] = {
    name = 'Boba Fett',
    XWS = 'bobafett',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['cadbane'] = {
    name = 'Cad Bane',
    XWS = 'cadbane',
    slot = 'Crew',
    limited = 1,
    addAction = { 'B' },
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['cikatrovizago'] = {
    name = 'Cikatro Vizago',
    XWS = 'cikatrovizago',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['ig88d'] = {
    name = 'IG-88D',
    XWS = 'ig88d',
    slot = 'Crew',
    limited = 1,
    addAction = { 'C' },
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['jabbathehutt'] = {
    name = 'Jabba the Hutt',
    XWS = 'jabbathehutt',
    slot = 'Crew',
    remSlot = { 'Crew' },
    Charge = 4,
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['ketsuonyo'] = {
    name = 'Ketsu Onyo',
    XWS = 'ketsuonyo',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['lattsrazzi'] = {
    name = 'Latts Razzi',
    XWS = 'lattsrazzi',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['maul'] = {
    name = 'Maul',
    title = "Original",
    XWS = 'maul',
    slot = 'Crew',
    Force = 1,
    --restriction = {Func = function(list) Faction = {['rebelalliance'] = true,['scumandvillainy'] = true}}
}

masterUpgradesDB['unkarplutt'] = {
    name = 'Unkar Plutt',
    XWS = 'unkarplutt',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['zuckuss'] = {
    name = 'Zuckuss',
    XWS = 'zuckuss',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['bossk'] = {
    name = 'Bossk',
    XWS = 'bossk',
    slot = 'Gunner',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['bt1'] = {
    name = 'BT-1',
    XWS = 'bt1',
    slot = 'Gunner',
    restriction = { Faction = { ['galacticempire'] = true, ['scumandvillainy'] = true } }
}

masterUpgradesDB['dengar'] = {
    name = 'Dengar',
    XWS = 'dengar',
    slot = 'Gunner',
    Charge = 1,
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['greedo'] = {
    name = 'Greedo',
    XWS = 'greedo',
    slot = 'Gunner',
    Charge = 1,
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['genius'] = {
    name = '"Genius"',
    XWS = 'genius',
    slot = 'Astromech',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['r5p8'] = {
    name = 'R5-P8',
    XWS = 'r5p8',
    slot = 'Astromech',
    Charge = 3,
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['r5tk'] = {
    name = 'R5-TK',
    XWS = 'r5tk',
    slot = 'Astromech',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['andrasta'] = {
    name = 'Andrasta',
    XWS = 'andrasta',
    slot = 'Title',
    addSlot = { 'Payload' },
    restriction = { Faction = { ['scumandvillainy'] = true }, ship = { ['firesprayclasspatrolcraft'] = true } }
}

masterUpgradesDB['havoc'] = {
    name = 'Havoc',
    XWS = 'havoc',
    slot = 'Title',
    addSlot = { 'Sensor', 'Astromech' },
    remSlot = { 'Crew' },
    restriction = { Faction = { ['scumandvillainy'] = true }, ship = { ['scurrgh6bomber'] = true } }
}

masterUpgradesDB['houndstooth'] = {
    name = "Hound's Tooth",
    XWS = 'houndstooth',
    Docking = true,
    slot = 'Title',
    restriction = { Faction = { ['scumandvillainy'] = true }, ship = { ['yv666lightfreighter'] = true } }
}


masterUpgradesDB['ig2000'] = {
    name = 'IG-2000',
    XWS = 'ig2000',
    slot = 'Title',
    restriction = {
        Faction = { ['scumandvillainy'] = true },
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
    slot = 'Title',
    addSlot = { 'Gunner' },
    restriction = { Faction = { ['scumandvillainy'] = true }, ship = { ['firesprayclasspatrolcraft'] = true } }
}

masterUpgradesDB['misthunter'] = {
    name = 'Mist Hunter',
    XWS = 'misthunter',
    slot = 'Title',
    limited = 1,
    addAction = { 'BR' },
    addSlot = { 'Cannon' },
    restriction = { Faction = { ['scumandvillainy'] = true }, ship = { ['g1astarfighter'] = true } }
}

masterUpgradesDB['punishingone'] = {
    name = 'Punishing One',
    XWS = 'punishingone',
    slot = 'Title',
    addSlot = { 'Astromech' },
    remSlot = { 'Crew' },
    restriction = { Faction = { ['scumandvillainy'] = true }, ship = { ['jumpmaster5000'] = true } }
}

masterUpgradesDB['shadowcaster'] = {
    name = 'Shadow Caster',
    XWS = 'shadowcaster',
    slot = 'Title',
    restriction = { Faction = { ['scumandvillainy'] = true }, ship = { ['lancerclasspursuitcraft'] = true } }
}

masterUpgradesDB['slavei'] = {
    name = 'Slave I',
    XWS = 'slavei',
    title = "Boba's ride",
    slot = 'Title',
    addSlot = { 'Torpedo' },
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
        Faction = { ['scumandvillainy'] = true },
        ship = { ['firesprayclasspatrolcraft'] = true }
    }
}
masterUpgradesDB['virago'] = {
    name = 'Virago',
    XWS = 'virago',
    slot = 'Title',
    Charge = 2,
    shd = 1,
    addSlot = { 'Modification' },
    restriction = { ship = { ['starviperclassattackplatform'] = true } }
}

masterUpgradesDB['composure'] = {
    name = 'Composure',
    XWS = 'composure',
    slot = 'Talent',
    addAction = { 'F' },
}

masterUpgradesDB['chewbacca-crew'] = {
    name = 'Chewbacca',
    XWS = 'chewbacca-crew',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['l337'] = {
    name = 'L3-37',
    XWS = 'l337',
    dual = true,
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['landocalrissian-crew'] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian-crew',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['tobiasbeckett'] = {
    name = 'Tobias Beckett',
    XWS = 'tobiasbeckett',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['qira'] = {
    name = "Qi'ra",
    XWS = 'qira',
    slot = 'Crew',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['agilegunner'] = {
    name = 'Agile Gunner',
    XWS = 'agilegunner',
    slot = 'Gunner',
}

masterUpgradesDB['hansolo-gunner'] = {
    name = 'Han Solo',
    XWS = 'hansolo-gunner',
    slot = 'Gunner',
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['landosmillenniumfalcon'] = {
    name = "Lando's Millennium Falcon",
    XWS = 'landosmillenniumfalcon',
    slot = 'Title',
    restriction = { Faction = { ['scumandvillainy'] = true }, ship = { ['customizedyt1300lightfreighter'] = true } }
}

masterUpgradesDB['st321'] = {
    name = 'ST-321',
    XWS = 'st321',
    slot = 'Title',
    limited = 1,
    addAction = { 'TL' },
    restriction = { Faction = { ['galacticempire'] = true }, ship = { ['lambdaclasst4ashuttle'] = true } }
}

masterUpgradesDB['bombletgenerator'] = {
    name = 'Bomblet Generator',
    XWS = 'bombletgenerator',
    slot = 'Payload',
    remSlot = { 'Payload' },
    Bomb = true,
    Charge = 2,
    cardB = cardBackDB['Payload Dual']
}

masterUpgradesDB['connernets'] = {
    name = 'Conner Nets',
    XWS = 'connernets',
    slot = 'Payload',
    Bomb = true,
    Charge = 1
}

masterUpgradesDB['protonbombs'] = {
    name = 'Proton Bombs',
    XWS = 'protonbombs',
    slot = 'Payload',
    Bomb = true,
    Charge = 2
}

masterUpgradesDB['proximitymines'] = {
    name = 'Proximity Mines',
    XWS = 'proximitymines',
    slot = 'Payload',
    Bomb = true,
    Charge = 2
}

masterUpgradesDB['seismiccharges'] = {
    name = 'Seismic Charges',
    XWS = 'seismiccharges',
    slot = 'Payload',
    Bomb = true,
    Charge = 2
}

masterUpgradesDB['fanatical'] = {
    name = "Fanatical",
    XWS = 'fanatical',
    slot = 'Talent',
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['advancedoptics'] = {
    name = "Advanced Optics",
    XWS = 'advancedoptics',
    slot = 'Tech',
}

masterUpgradesDB['hyperspacetrackingdata'] = {
    name = "Hyperspace Tracking Data",
    XWS = 'hyperspacetrackingdata',
    slot = 'Tech',
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['patternanalyzer'] = {
    name = "Pattern Analyzer",
    XWS = 'patternanalyzer',
    slot = 'Tech',
}

masterUpgradesDB['primedthrusters'] = {
    name = "Primed Thrusters",
    XWS = 'primedthrusters',
    slot = 'Tech',
}

masterUpgradesDB['targetingsynchronizer'] = {
    name = "Targeting Synchronizer",
    XWS = 'targetingsynchronizer',
    slot = 'Tech',
}

masterUpgradesDB['captainphasma'] = {
    name = "Captain Phasma",
    XWS = 'captainphasma',
    slot = 'Crew',
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['generalhux'] = {
    name = "General Hux",
    XWS = 'generalhux',
    slot = 'Crew',
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['kyloren'] = {
    name = "Kylo Ren",
    XWS = 'kyloren',
    Condition = "I'll Show You the Dark Side",
    slot = 'Crew',
    Force = 1,
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['pettyofficerthanisson'] = {
    name = "Petty Officer Thanisson",
    XWS = 'pettyofficerthanisson',
    slot = 'Crew',
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['supremeleadersnoke'] = {
    name = "Supreme Leader Snoke",
    XWS = 'supremeleadersnoke',
    slot = 'Crew',
    remSlot = { 'Crew' },
    Force = 1,
    cardB = cardBackDB['Crew Dual'],
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['specialforcesgunner'] = {
    name = "Special Forces Gunner",
    XWS = 'specialforcesgunner',
    slot = 'Gunner',
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['heroic'] = {
    name = "Heroic",
    XWS = 'heroic',
    slot = 'Talent',
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['c3po-crew'] = {
    name = "C-3PO",
    XWS = 'c3po-crew',
    slot = 'Crew',
    addAction = { 'C' },
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['chewbacca-crew-swz19'] = {
    name = "Chewbacca",
    XWS = 'chewbacca-crew-swz19',
    slot = 'Crew',
    Charge = 2,
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['hansolo-crew'] = {
    name = "Han Solo",
    XWS = 'hansolo-crew',
    slot = 'Crew',
    addAction = { 'E' },
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['rosetico'] = {
    name = "Rose Tico",
    XWS = 'rosetico',
    slot = 'Crew',
    addAction = { 'TL' },
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['finn'] = {
    name = "Finn",
    XWS = 'finn',
    slot = 'Gunner',
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['paigetico'] = {
    name = "Paige Tico",
    XWS = 'paigetico',
    slot = 'Gunner',
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['rey-gunner'] = {
    name = "Rey",
    XWS = 'rey-gunner',
    slot = 'Gunner',
    Force = 1,
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['bb8'] = {
    name = "BB-8",
    XWS = 'bb8',
    slot = 'Astromech',
    addAction = { 'BR' },
    Charge = 2,
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['bbastromech'] = {
    name = "BB Astromech",
    XWS = 'bbastromech',
    slot = 'Astromech',
    addAction = { 'BR' },
    Charge = 2,
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['m9g8'] = {
    name = "M9-G8",
    XWS = 'm9g8',
    slot = 'Astromech',
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['r2ha'] = {
    name = "R2-HA",
    XWS = 'r2ha',
    slot = 'Astromech',
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['r5x3'] = {
    name = "R5-X3",
    XWS = 'r5x3',
    slot = 'Astromech',
    Charge = 2,
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['blackone'] = {
    name = "Black One",
    XWS = 'blackone',
    slot = 'Title',
    Charge = 1,
    restriction = { ship = { ['t70xwing'] = true } }
}

masterUpgradesDB['reysmillenniumfalcon'] = {
    name = "Rey's Millennium Falcon",
    XWS = 'reysmillenniumfalcon',
    slot = 'Title',
    restriction = { ['ship'] = { ['scavengedyt1300lightfreighter'] = true } }
}

masterUpgradesDB['integratedsfoils'] = {
    name = "Integrated S-foils",
    XWS = 'integratedsfoils',
    dual = true,
    slot = 'Configuration',
    addAction = { 'BR' },
    restriction = { Faction = { ['resistance'] = true }, ship = { ['t70xwing'] = true } }
}

masterUpgradesDB['ferrospherepaint'] = {
    name = "Ferrosphere Paint",
    XWS = 'ferrospherepaint',
    slot = 'Tech',
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['hate'] = {
    name = "Hate",
    XWS = 'hate',
    slot = 'Force Power',
    restriction = { keywords = { 'Dark Side' } }
}

masterUpgradesDB['predictiveshot'] = {
    name = "Predictive Shot",
    XWS = 'predictiveshot',
    slot = 'Force Power',
}

masterUpgradesDB['biohexacryptcodes'] = {
    name = "Biohexacrypt Codes",
    XWS = 'biohexacryptcodes',
    slot = 'Tech',
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['dedicated'] = {
    name = "Dedicated",
    XWS = 'dedicated',
    slot = 'Talent',
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['treacherous'] = {
    name = "Treacherous",
    XWS = 'treacherous',
    slot = 'Talent',
    Charge = 1,
    restriction = { Faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['tv94'] = {
    name = "TV-94",
    XWS = 'tv94',
    slot = 'Relay',
    restriction = { Faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['kraken'] = {
    name = "Kraken",
    XWS = 'kraken',
    slot = 'Relay',
    addAction = { 'C' },
    restriction = { Faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['energyshellcharges'] = {
    name = "Energy-Shell Charges",
    XWS = 'energyshellcharges',
    slot = 'Missile',
    Charge = 1,
    restriction = { Faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['soullessone'] = {
    name = "Soulless One",
    XWS = 'soullessone',
    slot = 'Title',
    restriction = { ship = { ['belbulab22starfighter'] = true } }
}

masterUpgradesDB['imperviumplating'] = {
    name = "Impervium Plating",
    XWS = 'imperviumplating',
    slot = 'Modification',
    Charge = 2,
    restriction = { ship = { ['belbulab22starfighter'] = true } }
}


masterUpgradesDB['brilliantevasion'] = {
    name = "Brilliant Evasion",
    XWS = 'brilliantevasion',
    slot = 'Force Power',
}

masterUpgradesDB['k2b4'] = {
    name = "K2-B4",
    XWS = 'k2b4',
    slot = 'Relay',
    restriction = { Faction = { ['separatistalliance'] = true } }
}


masterUpgradesDB['countdooku'] = {
    name = "Count Dooku",
    XWS = 'countdooku',
    slot = 'Crew',
    Force = 1,
    restriction = { Faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['generalgrievous'] = {
    name = "General Grievous",
    XWS = 'generalgrievous',
    slot = 'Crew',
    Charge = 1,
    restriction = { Faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['drk1probedroids'] = {
    name = "DRK-1 Probe Droids",
    XWS = 'drk1probedroids',
    Condition = 'DRK-1 Probe Droid',
    slot = 'Payload',
    Charge = 2,
    restriction = { Faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['scimitar'] = {
    name = "Scimitar",
    XWS = 'scimitar',
    slot = 'Title',
    limited = 1,
    addAction = { 'CL' },
    restriction = { ship = { ['sithinfiltrator'] = true } }
}


masterUpgradesDB['discordmissiles'] = {
    name = "Discord Missiles",
    XWS = 'discordmissiles',
    remotes = { "Buzz Droid Swarm" },
    limited = 3,
    slot = 'Missile',
    Charge = 1,
    restriction = {
        Faction = { ['separatistalliance'] = true }
    }
}
masterUpgradesDB['battlemeditation'] = {
    name = "Battle Meditation",
    XWS = 'battlemeditation',
    slot = 'Force Power',
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['r4pastromech'] = {
    name = "R4-P Astromech",
    XWS = 'r4pastromech',
    slot = 'Astromech',
    Charge = 2,
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['r4p17'] = {
    name = "R4-P17",
    XWS = 'r4p17',
    slot = 'Astromech',
    Charge = 2,
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['delta7b'] = {
    name = "Delta-7B",
    XWS = 'delta7b',
    slot = 'Configuration',
    shd = 2,
    restriction = { ship = { ['delta7aethersprite'] = true } }
}

masterUpgradesDB['calibratedlasertargeting'] = {
    name = "Calibrated laser Targeting",
    XWS = 'calibratedlasertargeting',
    slot = 'Configuration',
    remSlot = { 'Modification' },
    cardB = cardBackDB.mc,
    restriction = { ship = { ['delta7aethersprite'] = true } }
}

masterUpgradesDB['sparepartscanisters'] = {
    name = "Spare Parts Canisters",
    XWS = 'sparepartscanisters',
    slot = 'Modification',
    Charge = 1
}

masterUpgradesDB['r4p44'] = {
    name = "R4-P44",
    XWS = 'r4p44',
    slot = 'Astromech',
    limited = 1,
    addAction = { 'C' },
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['clonecommandercody'] = {
    name = "Clone Commander Cody",
    XWS = 'clonecommandercody',
    slot = 'Gunner',
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['seventhfleetgunner'] = {
    name = "Seventh Fleet Gunner",
    XWS = 'seventhfleetgunner',
    slot = 'Gunner',
    Charge = 1,
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['synchronizedconsole'] = {
    name = "Synchronized Console",
    XWS = 'synchronizedconsole',
    slot = 'Modification',
    addSqdAction = { 'TL' },
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['grapplingstruts'] = {
    name = "Grappling Struts",
    XWS = 'grapplingstruts',
    dual = true,
    slot = 'Configuration',
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
    slot = 'Crew',
    limited = 1,
    addSqdAction = { 'F' },
    Force = 1,
    dual = true,
    restriction = { Faction = { ['galacticrepublic'] = true, ['separatistalliance'] = true } }
}

masterUpgradesDB['passivesensors'] = {
    name = "Passive Sensors",
    XWS = 'passivesensors',
    slot = 'Sensor',
    addAction = { 'C', 'TL' },
    Charge = 1,
    restriction = {}
}

masterUpgradesDB['autoblasters'] = {
    name = "Autoblasters",
    XWS = 'autoblasters',
    slot = 'Cannon',
    arcs = {
        weapon = {
            name = 'Autoblasters',
            range = 1,
            type = { 'front' }
        }
    }
}

masterUpgradesDB['plasmatorpedoes'] = {
    name = "Plasma Torpedoes",
    XWS = 'plasmatorpedoes',
    slot = 'Torpedo',
    Charge = 2,
}

masterUpgradesDB['diamondboronmissiles'] = {
    name = "Diamond-Boron Missiles",
    XWS = 'diamondboronmissiles',
    slot = 'Missile',
    Charge = 3
}
masterUpgradesDB['amilynholdo'] = {
    name = "Amilyn Holdo",
    XWS = 'amilynholdo',
    slot = 'Crew',
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['ga97'] = {
    name = "GA-97",
    XWS = 'ga97',
    slot = 'Crew',
    limited = 1,
    addAction = { 'C' },
    Charge = 5,
    restriction = { Faction = { ['resistance'] = true } },
    Condition = "It's the Resistance",
}

masterUpgradesDB['kaydelconnix'] = {
    name = "Kaydel Connix",
    XWS = 'kaydelconnix',
    slot = 'Crew',
    restriction = {
        Faction = { ['resistance'] = true }
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
        if pilotid == 0 or pilotid == '' then
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
    slot = 'Crew',
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['larmadacy'] = {
    name = "Larma D'Acy",
    XWS = 'larmadacy',
    slot = 'Crew',
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['leiaorgana-resistance'] = {
    name = "Leia Organa",
    XWS = 'leiaorgana-resistance',
    slot = 'Crew',
    remSlot = { 'Crew' },
    Force = 1,
    cardB = cardBackDB['Crew Dual'],
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['pz4co'] = {
    name = "PZ-4CO",
    XWS = 'pz4co',
    slot = 'Crew',
    limited = 1,
    addAction = { 'C' },
    restriction = { Faction = { ['resistance'] = true } }
}

masterUpgradesDB['r2a6'] = {
    name = "R2-A6",
    XWS = 'r2a6',
    slot = 'Astromech',
    executeOptions = function(list, pilotid)
        exopts = {}
        if pilotid ~= 0 and pilotid ~= '' then
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
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['r2c4'] = {
    name = "R2-C4",
    XWS = 'r2c4',
    slot = 'Astromech',
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['ta175'] = {
    name = "TA-175",
    XWS = 'ta175',
    slot = 'Relay',
    restriction = { Faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['electroprotonbomb'] = {
    name = "Electro-Proton Bomb",
    XWS = 'electroprotonbomb',
    slot = 'Payload',
    Bomb = true,
    Charge = 1,
    remSlot = { 'Modification' },
}

masterUpgradesDB['delayedfuses'] = {
    name = "Delayed Fuses",
    XWS = 'delayedfuses',
    slot = 'Modification',
}

masterUpgradesDB['angleddeflectors'] = {
    name = "Angled Deflectors",
    XWS = 'angleddeflectors',
    slot = 'Modification',
    addAction = { 'R' },
    shd = -1,
    restriction = { Size = { small = true, medium = true } }
}

masterUpgradesDB['landingstruts'] = {
    name = "Landing Struts",
    XWS = 'landingstruts',
    slot = 'Configuration',
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
    restriction = { Faction = { ['separatistalliance'] = true }, ship = { ['hyenaclassdroidbomber'] = true } }
}

masterUpgradesDB['foresight'] = {
    name = "Foresight",
    XWS = 'foresight',
    slot = 'Force Power',
}

masterUpgradesDB['precognitivereflexes'] = {
    name = "Precognitive Reflexes",
    XWS = 'precognitivereflexes',
    slot = 'Force Power',
    restriction = { Size = { small = true } }
}

masterUpgradesDB['targetingcomputer'] = {
    name = "Targeting Computer",
    XWS = 'targetingcomputer',
    slot = 'Modification',
    addAction = { 'TL' },
}

masterUpgradesDB['snapshot'] = {
    name = "Snap Shot",
    XWS = 'snapshot',
    slot = 'Talent',
}

masterUpgradesDB['ensnare'] = {
    name = "Ensnare",
    XWS = 'ensnare',
    slot = 'Talent',
    restriction = { ship = { ['nantexclassstarfighter'] = true } }
}

masterUpgradesDB['graviticdeflection'] = {
    name = "Gravitic Deflection",
    XWS = 'graviticdeflection',
    slot = 'Talent',
    restriction = { ship = { ['nantexclassstarfighter'] = true } }
}

masterUpgradesDB['c110p'] = {
    name = "C1-10P",
    XWS = 'c110p',
    slot = 'Astromech',
    addAction = { 'E' },
    dual = true,
    Charge = 2,
    restriction = { Faction = { ['galacticrepublic'] = true } }
}


masterUpgradesDB['c3po-republic'] = {
    name = "C-3PO",
    XWS = 'c3po-republic',
    slot = 'Crew',
    addAction = { 'C' },
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['ahsokatano'] = {
    name = "Ahsoka Tano",
    XWS = 'ahsokatano',
    slot = 'Gunner',
    Force = 1,
    restriction = { Faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['r1j5'] = {
    name = "R1-J5",
    XWS = 'r1j5',
    slot = 'Astromech',
    limited = 1,
    Charge = 3,
    restriction = { Faction = { ['resistance'] = true } }
}


masterUpgradesDB['stabilizedsfoils'] = {
    name = "Stabilized S-Foils",
    XWS = 'stabilizedsfoils',
    dual = true,
    slot = 'Configuration',
    addAction = { 'E' },
    restriction = { ship = { ['asf01bwing'] = true } }
}


masterUpgradesDB['k2so'] = {
    name = "K-2SO",
    XWS = 'k2so',
    slot = 'Crew',
    limited = 1,
    addAction = { 'C' },
    restriction = { Faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['clustermines'] = {
    name = 'Cluster Mines',
    XWS = 'clustermines',
    slot = 'Payload',
    Bomb = true,
    Charge = 1
}

masterUpgradesDB['ionbombs'] = {
    name = 'Ion Bombs',
    XWS = 'ionbombs',
    slot = 'Payload',
    Bomb = true,
    Charge = 2
}

masterUpgradesDB['coaxiumhyperfuel'] = {
    name = "Coaxium Hyperfuel",
    XWS = 'coaxiumhyperfuel',
    slot = 'Illicit',
}

masterUpgradesDB['magpulsewarheads'] = {
    name = "Mag-Pulse Warheads",
    XWS = 'magpulsewarheads',
    slot = 'Missile',
    Charge = 2
}

masterUpgradesDB['proudtradition'] = {
    name = "Proud Tradition",
    XWS = 'proudtradition',
    dual = true,
    slot = 'Talent',
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['deuteriumpowercells'] = {
    name = "Deuterium Power Cells",
    XWS = 'deuteriumpowercells',
    slot = 'Tech',
    Charge = 2,
    remSlot = { 'Modification' },
    restriction = { Faction = { ['firstorder'] = true } }
}

masterUpgradesDB['kazsfireball'] = {
    name = "Kaz's Fireball",
    XWS = 'kazsfireball',
    slot = 'Title',
    restriction = { ship = { ['fireball'] = true } }
}

masterUpgradesDB['deadeyeshot'] = {
    name = "Deadeye Shot",
    XWS = 'deadeyeshot',
    slot = 'Talent',
    restriction = {
        Size = { small = true, medium = true }
    }
}

masterUpgradesDB['automatedtargetpriority'] = {
    name = "Automated Target Priority",
    XWS = 'automatedtargetpriority',
    slot = 'Tech',
    restriction = {
        -- todo int 3 or less
    }
}

masterUpgradesDB['sensorbuoysuite'] = {
    name = "Sensor Buoy Suite",
    XWS = 'sensorbuoysuite',
    slot = 'Tech',
    restriction = {
        Faction = { ['firstorder'] = true },
        Size = { medium = true, large = true }
    },
    remotes = { 'Sensor Buoy (Red)', 'Sensor Buoy (Blue)' }
}

masterUpgradesDB['multimissilepods'] = {
    name = "Multi-Missile Pods",
    XWS = 'multimissilepods',
    slot = 'Missile',
    remSlot = { 'Missile' },
    Charge = 5,
    restriction = {},
}

masterUpgradesDB['syncedlasercannons'] = {
    name = "Synced Laser Cannons",
    XWS = 'syncedlasercannons',
    slot = 'Cannon',
    remSlot = { 'Cannon' },
    cardB = cardBackDB['Cannon Dual'],
    restriction = {},
    arcs = {
        weapon = {
            name = 'Synced Laser Cannons',
            range = 3,
            type = { 'front' }
        }
    }
}

masterUpgradesDB['aaylasecura'] = {
    name = "Aayla Secura",
    XWS = 'aaylasecura',
    Force = 1,
    limited = 1,
    slot = 'Crew',
    restriction = {
        Faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['kitfisto'] = {
    name = "Kit Fisto",
    XWS = 'kitfisto',
    Force = 1,
    limited = 1,
    addAction = { 'E' },
    slot = 'Crew',
    restriction = {
        Faction = { ['galacticrepublic'] = true }
    }
}


masterUpgradesDB['plokoon'] = {
    name = "Plo Koon",
    XWS = 'plokoon',
    Force = 1,
    limited = 1,
    slot = 'Crew',
    addAction = { 'R' },
    restriction = {
        Faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['yoda'] = {
    name = "Yoda",
    XWS = 'yoda',
    Force = 2,
    limited = 1,
    slot = 'Crew',
    restriction = {
        Faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['fives'] = {
    name = '"Fives"',
    XWS = 'fives',
    limited = 1,
    slot = 'Crew',
    restriction = {
        Faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['wolfpack'] = {
    name = "Wolfpack",
    XWS = 'wolfpack',
    limited = 1,
    slot = 'Gunner',
    remSlot = { 'Crew' },
    restriction = {
        Faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['ghostcompany'] = {
    name = "Ghost Company",
    XWS = 'ghostcompany',
    limited = 1,
    slot = 'Gunner',
    addAction = { 'F' },
    remSlot = { 'Crew' },
    restriction = {
        Faction = { ['galacticrepublic'] = true }
        -- Todo: Add rotate requirement
    }
}

masterUpgradesDB['kalani'] = {
    name = "Kalani",
    XWS = 'kalani',
    limited = 1,
    slot = 'Relay',
    addAction = { 'C' },
    Charge = 3,
    restriction = {
        Faction = { ['separatistalliance'] = true }
    },
}

masterUpgradesDB['commandermalarus'] = {
    name = "Commander Malarus",
    XWS = 'commandermalarus',
    dual = true,
    slot = 'Crew',
    limited = 1,
    restriction = {
        Faction = { ['firstorder'] = true }
    }
}

masterUpgradesDB['agentterex'] = {
    name = "Agent Terex",
    XWS = 'agentterex',
    dual = true,
    slot = 'Crew',
    limited = 1,
    addSqdAction = { 'C' },
    restriction = {
        Faction = { ['firstorder'] = true }
    }
}

masterUpgradesDB['commanderpyre'] = {
    name = 'Commander Pyre',
    XWS = 'commanderpyre',
    slot = 'Crew',
    limited = 1,
    restriction = {
        Faction = { ['firstorder'] = true }
    }
}

masterUpgradesDB['clonecaptainrex'] = {
    name = "Clone Captain Rex",
    XWS = 'clonecaptainrex',
    limited = 1,
    slot = 'Gunner',
    restriction = {
        Faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['suppressivegunner'] = {
    name = "Suppressive Gunner",
    XWS = 'suppressivegunner',
    slot = 'Gunner',
    restriction = {}
}

masterUpgradesDB['concussionbombs'] = {
    name = "Concussion Bombs",
    XWS = 'concussionbombs',
    slot = 'Payload',
    Charge = 3,
    cardB = cardBackDB['Payload Dual'],
    restriction = {},
    Bomb = true
}


masterUpgradesDB['repulsorliftstabilizers'] = {
    name = "Repulsorlift Stabilizers",
    XWS = 'repulsorliftstabilizers',
    dual = true,
    slot = 'Configuration',
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
    slot = 'Configuration',
    restriction = {
        ship = { ['tierbheavy'] = true }
    },
}

masterUpgradesDB['targetassistmgk300'] = {
    name = "Target-Assist MGK-300",
    XWS = 'targetassistmgk300',
    slot = 'Configuration',
    restriction = {
        ship = { ['tierbheavy'] = true }
    },
}

masterUpgradesDB['ionlimiteroverride'] = {
    name = "Ion Limiter Override",
    XWS = 'ionlimiteroverride',
    slot = 'Talent',
    addAction = { 'BR' },
    restriction = {
        keywords = { 'TIE' }
    },
}

masterUpgradesDB['backwardstailslide'] = {
    name = "Backwards Tailslide",
    XWS = 'backwardstailslide',
    slot = 'Talent',
    addAction = { 'E' },
    restriction = {
        keywords = { 'X-Wing' }
    },
}

masterUpgradesDB['overdrivethruster'] = {
    name = "Overdrive Thruster",
    XWS = 'overdrivethruster',
    limited = 1,
    slot = 'Modification',
    addAction = { '2B', '2BR' },
    restriction = {
        ship = { ['t70xwing'] = true }
    },
}

masterUpgradesDB['r2d2-resistance'] = {
    name = "R2-D2",
    XWS = 'r2d2-resistance',
    limited = 1,
    slot = 'Astromech',
    Charge = 4,
    restriction = {
        Faction = { ['resistance'] = true },
    },
}

masterUpgradesDB['r6d8'] = {
    name = "R6-D8",
    XWS = 'r6d8',
    limited = 1,
    slot = 'Astromech',
    restriction = {
        Faction = { ['resistance'] = true },
    },
}

masterUpgradesDB['underslungblastercannon'] = {
    name = "Underslung Blaster Cannon",
    XWS = 'underslungblastercannon',
    slot = 'Cannon',
    restriction = {
        Faction = { ['resistance'] = true },
        ship = { ['t70xwing'] = true }
    },
    arcs = { turret = { name = 'underslung blaster cannon', range = 1, type = { 'singleturret' } } }
}

masterUpgradesDB['starbirdslash'] = {
    name = "Starbird Slash",
    XWS = 'starbirdslash',
    slot = 'Talent',
    restriction = {
        keywords = { 'A-Wing' }
    },
    movethrough = true,
}

masterUpgradesDB['extrememaneuvers'] = {
    name = "Extreme Maneuvers",
    XWS = 'extrememaneuvers',
    slot = 'Force Power',
    addAction = { 'Dare' },
    restriction = {
        Size = { small = true },
        -- Todo: add boost requirement
    },
}

masterUpgradesDB['jedicommander'] = {
    name = "Jedi Commander",
    XWS = 'jedicommander',
    slot = 'Command',
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
    slot = 'Astromech',
    Charge = 2,
    restriction = {
        Faction = { ['galacticrepublic'] = true },
    }
}

masterUpgradesDB['patience'] = {
    name = "Patience",
    XWS = 'patience',
    slot = 'Force Power',
    restriction = { keywords = { 'Light Side' } }
}

masterUpgradesDB['alpha3bbesh'] = {
    name = 'Alpha-3B "Besh"',
    XWS = 'alpha3bbesh',
    slot = 'Configuration',
    addSlot = { 'Payload' },
    restriction = {
        ship = {
            ['nimbusclassvwing'] = true,
        },
    }
}

masterUpgradesDB['alpha3eesk'] = {
    name = 'Alpha-3E "Esk"',
    XWS = 'alpha3eesk',
    slot = 'Configuration',
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
    slot = 'Payload',
    Charge = 4,
    Bomb = true,
}

masterUpgradesDB['r7a7'] = {
    name = 'R7-A7',
    XWS = 'r7a7',
    limited = 1,
    slot = 'Astromech',
    Charge = 3,
    restriction = {
        Faction = { ['galacticrepublic'] = true },
    }
}

masterUpgradesDB['precisionionengines'] = {
    name = 'Precision Ion Engines',
    XWS = 'precisionionengines',
    slot = 'Modification',
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
    slot = 'Astromech',
    restriction = {
        Faction = { ['galacticrepublic'] = true },
    }
}

masterUpgradesDB['interceptbooster'] = {
    name = 'Intercept Booster',
    XWS = 'interceptbooster',
    slot = 'Configuration',
    Charge = 3,
    addAction = { 'TL' },
    dual = true,
    restriction = {
        Faction = { ['separatistalliance'] = true },
        ship = { ['droidtrifighter'] = true }
    }
}

masterUpgradesDB['xx23sthreadtracers'] = {
    name = 'XX-23 S-Thread Tracers',
    XWS = 'xx23sthreadtracers',
    slot = 'Missile',
    Charge = 2,
}

masterUpgradesDB['margsablclosure'] = {
    name = 'Marg Sabl Closure',
    XWS = 'margsablclosure',
    slot = 'Talent',
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
    slot = 'Modification',
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
    slot = 'Crew',
    restriction = {
        Faction = { ['scumandvillainy'] = true, ['separatistalliance'] = true },
    },
}

masterUpgradesDB['zamwesell'] = {
    name = 'Zam Wesell',
    XWS = 'zamwesell',
    limited = 1,
    Condition = 'Zam Wesell',
    slot = 'Crew',
    Charge = 2,
    restriction = {
        Faction = { ['scumandvillainy'] = true, ['separatistalliance'] = true },
    },
}

masterUpgradesDB['hondoohnaka'] = {
    name = 'Hondo Ohnaka',
    XWS = 'hondoohnaka',
    limited = 1,
    slot = 'Crew',
}

masterUpgradesDB['slavei-swz82'] = {
    name = 'Slave I',
    XWS = 'slavei-swz82',
    title = "Jango's ride",
    slot = 'Title',
    addSlot = { 'Gunner' },
    restriction = {
        Faction = {
            ['scumandvillainy'] = true,
            ['separatistalliance'] = true
        },
        ship = { ['firesprayclasspatrolcraft'] = true }
    }
}

masterUpgradesDB['bobafett-gunner'] = {
    name = 'Boba Fett',
    XWS = 'bobafett-gunner',
    limited = 1,
    slot = 'Gunner',
    restriction = {
        Faction = {
            ['scumandvillainy'] = true,
            ['separatistalliance'] = true
        }
    }
}

masterUpgradesDB['weaponssystemsofficer'] = {
    name = 'Weapons Systems Officer',
    XWS = 'weaponssystemsofficer',
    slot = 'Gunner',
}

masterUpgradesDB['falsetranspondercodes'] = {
    name = 'False Transponder Codes',
    XWS = 'falsetranspondercodes',
    slot = 'Illicit',
    Charge = 1,
}

masterUpgradesDB['admiralozzel'] = {
    name = "Admiral Ozzel",
    XWS = 'admiralozzel',
    slot = 'Command',
    remSlot = { 'Crew' },
    restriction = {
        Faction = { ['galacticempire'] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['azmorigan'] = {
    name = "Azmorigan",
    XWS = 'azmorigan',
    slot = 'Command',
    remSlot = { 'Crew' },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Faction = { ['scumandvillainy'] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['captainneeda'] = {
    name = "Captain Needa",
    XWS = 'captainneeda',
    slot = 'Command',
    remSlot = { 'Crew' },
    Charge = 4,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Faction = { ['galacticempire'] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['carlistrieekan'] = {
    name = "Carlist Rieekan",
    XWS = 'carlistrieekan',
    slot = 'Command',
    addAction = { 'E' },
    remSlot = { 'Crew' },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Faction = { ['rebelalliance'] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['jandodonna'] = {
    name = "Jan Dodonna",
    XWS = 'jandodonna',
    slot = 'Command',
    remSlot = { 'Crew' },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Faction = { ['rebelalliance'] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['raymusantilles'] = {
    name = "Raymus Antilles",
    XWS = 'raymusantilles',
    slot = 'Command',
    remSlot = { 'Crew' },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Faction = { ['rebelalliance'] = true },
        Size = { huge = true }
    }
}
masterUpgradesDB['stalwartcaptain'] = {
    name = "Stalwart Captain",
    XWS = 'stalwartcaptain',
    slot = 'Command',
    remSlot = { 'Crew' },
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
    slot = 'Command',
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = { ['tieadvancedx1'] = true, ['tieadvancedv1'] = true }
    }
}
masterUpgradesDB['firstorderelite'] = {
    name = "First Order Elite",
    XWS = 'firstorderelite',
    wingleader = true,
    slot = 'Command',
    restriction = {
        Faction = { ['firstorder'] = true },
        ship = { ['tiesffighter'] = true, ['tievnsilencer'] = true }
    }
}
masterUpgradesDB['veteranwingleader'] = {
    name = "Veteran Wing Leader",
    XWS = 'veteranwingleader',
    wingleader = true,
    slot = 'Command',
    restriction = {
        Size = { small = true }
    }
}
masterUpgradesDB['dreadnoughthunter'] = {
    name = "Dreadnought hunter",
    XWS = 'dreadnoughthunter',
    slot = 'Command',
    restriction = {
        Size = { small = true },
        InitiativeGreaterThan = 3
    }
}

masterUpgradesDB['ioncannonbattery'] = {
    name = "Ion Cannon Battery",
    XWS = 'ioncannonbattery',
    slot = 'Hardpoint',
    dual = true,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/IonCannonBattery(Offline).png',
    restriction = {},
    arcs = { turret = { name = 'ion cannon', range = 4, type = { 'singleturret' }, ion = true } }
}

masterUpgradesDB['targetingbattery'] = {
    name = "Targeting Battery",
    XWS = 'targetingbattery',
    slot = 'Hardpoint',
    dual = true,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/TargetingBattery(Offline).png',
    restriction = {},
    arcs = { turret = { name = 'targeting', range = 5, type = { 'singleturret' } } }
}

masterUpgradesDB['ordnancetubes'] = {
    name = "Ordnance Tubes",
    XWS = 'ordnancetubes',
    slot = 'Hardpoint',
    dual = true,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/OrdnanceTubes(Offline).png',
    restriction = {}
}

masterUpgradesDB['pointdefensebattery'] = {
    name = "Point-Defense Battery",
    XWS = 'pointdefensebattery',
    slot = 'Hardpoint',
    dual = true,
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/PointDefenseBattery(Offline).png',
    restriction = {},
    arcs = { turret = { name = 'point defence', range = 2, type = { 'doubleturret' } } }
}

masterUpgradesDB['turbolaserbattery'] = {
    name = "Turbolaser Battery",
    XWS = 'turbolaserbattery',
    slot = 'Hardpoint',
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
    slot = 'Team',
    addAction = { 'TL', 'C' },

    restriction = {}
}

masterUpgradesDB['commsteam'] = {
    name = "Comms Team",
    XWS = 'commsteam',
    slot = 'Team',
    addAction = { 'C' },
    restriction = {}
}

masterUpgradesDB['igrmdroids'] = {
    name = "IG-RM Droids",
    XWS = 'igrmdroids',
    slot = 'Team',
    addAction = { 'C' },
    restriction = {
        Faction = { ['scumandvillainy'] = true }
    }
}

masterUpgradesDB['gunneryspecialists'] = {
    name = "Gunnery Specialists",
    XWS = 'gunneryspecialists',
    slot = 'Team',
    addAction = { 'C' },
    restriction = {}
}

masterUpgradesDB['damagecontrolteam'] = {
    name = "Damage Control Team",
    XWS = 'damagecontrolteam',
    slot = 'Team',
    addAction = { 'R', 'C' },
    restriction = {}
}

masterUpgradesDB['ordnanceteam'] = {
    name = "Ordnance Team",
    XWS = 'ordnanceteam',
    slot = 'Team',
    addAction = { 'C' },

    restriction = {}
}

masterUpgradesDB['sensorexperts'] = {
    name = "Sensor Experts",
    XWS = 'sensorexperts',
    slot = 'Team',
    addAction = { 'TL', 'C' },
    restriction = {}
}

masterUpgradesDB['quickreleaselocks'] = {
    name = "Quick-Release Locks",
    XWS = 'quickreleaselocks',
    slot = 'Illicit',
    Charge = 2,
    restriction = {
        Size = { huge = true }
    }
}
masterUpgradesDB['saboteursmap'] = {
    name = "Saboteur's Map",
    XWS = 'saboteursmap',
    slot = 'Illicit',
    restriction = {
        Size = { huge = true }
    }
}
masterUpgradesDB['scannerbaffler'] = {
    name = "Scanner Baffler",
    XWS = 'scannerbaffler',
    slot = 'Illicit',
    restriction = {
        Size = { huge = true }
    }
}
-- Cargo
masterUpgradesDB['adaptiveshields'] = {
    name = "Adaptive Shields",
    XWS = 'adaptiveshields',
    slot = 'Cargo',
    restriction = {}
}
masterUpgradesDB['boostedscanners'] = {
    name = "Boosted Scanners",
    XWS = 'boostedscanners',
    slot = 'Cargo',
    restriction = {}
}

masterUpgradesDB['optimizedpowercore'] = {
    name = "Optimized Power Core",
    XWS = 'optimizedpowercore',
    slot = 'Cargo',
    restriction = {}
}

masterUpgradesDB['tibannareserves'] = {
    name = "Tibanna Reserves",
    XWS = 'tibannareserves',
    slot = 'Cargo',
    Charge = 3,
    restriction = {}
}

masterUpgradesDB['torynfarr'] = {
    name = "Toryn Farr",
    XWS = 'torynfarr',
    slot = 'Crew',
    addAction = { 'TL' },
    restriction = {
        Faction = { ['rebelalliance'] = true },
        Size = { huge = true }
    }
}

masterUpgradesDB['dodonnaspride'] = {
    name = "Dodonna's Pride",
    XWS = 'dodonnaspride',
    limited = 1,
    slot = 'Title',
    addAction = { 'E', 'F' },
    shd = -2,
    addSlot = { 'Team', 'Cargo' },
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['jainaslight'] = {
    name = "Jaina's Light",
    XWS = 'jainaslight',
    slot = 'Title',
    limited = 1,
    shd = 1,
    Energy = -1,
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['liberator'] = {
    name = "Liberator",
    XWS = 'liberator',
    slot = 'Title',
    Energy = 1,
    Docking = true,
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['tantiveiv'] = {
    name = "Tantive IV",
    XWS = 'tantiveiv',
    slot = 'Title',
    addSlot = { 'Crew', 'Crew' },
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['thunderstrike'] = {
    name = "Thunderstrike",
    XWS = 'thunderstrike',
    slot = 'Title',
    addSlot = { 'Gunner' },
    shd = -3,
    Hull = 3,
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['cr90corvette'] = true }
    }
}
masterUpgradesDB['brighthope'] = {
    name = "Bright Hope",
    XWS = 'brighthope',
    slot = 'Title',
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['gr75mediumtransport'] = true }
    }
}
masterUpgradesDB['luminous'] = {
    name = "Luminous",
    XWS = 'luminous',
    slot = 'Title',
    shd = -1,
    Energy = 2,
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['gr75mediumtransport'] = true }
    }
}
masterUpgradesDB['quantumstorm'] = {
    name = "Quantum Storm",
    XWS = 'quantumstorm',
    slot = 'Title',
    Energy = 1,
    addSlot = { 'Team', 'Cargo' },
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['gr75mediumtransport'] = true }
    }
}
masterUpgradesDB['assailer'] = {
    name = "Assailer",
    XWS = 'assailer',
    slot = 'Title',
    limited = 1,
    shd = -2,
    Hull = 2,
    addSlot = { 'Gunner' },
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}
masterUpgradesDB['corvus'] = {
    name = "Corvus",
    XWS = 'corvus',
    slot = 'Title',
    limited = 1,
    addAction = { 'C' },
    Docking = true,
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}

masterUpgradesDB['impetuous'] = {
    name = "Impetuous",
    XWS = 'impetuous',
    slot = 'Title',
    limited = 1,
    shd = -2,
    Energy = 2,
    addSlot = { 'Crew' },
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}
masterUpgradesDB['instigator'] = {
    name = "Instigator",
    XWS = 'instigator',
    slot = 'Title',
    limited = 1,
    addSlot = { 'Team' },
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}
masterUpgradesDB['bloodcrow'] = {
    name = "Blood Crow",
    XWS = 'bloodcrow',
    slot = 'Title',
    limited = 1,
    Energy = 2,
    shd = -1,
    addSlot = { 'Gunner' },
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['requiem'] = {
    name = "Requiem",
    XWS = 'requiem',
    slot = 'Title',
    limited = 1,
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['suppressor'] = {
    name = "Suppressor",
    XWS = 'suppressor',
    slot = 'Title',
    limited = 1,
    shd = 2,
    Hull = -2,
    addSlot = { 'Sensor' },
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['vector'] = {
    name = "Vector",
    XWS = 'vector',
    slot = 'Title',
    limited = 1,
    addSqdAction = { 'E', 'B' },
    addSlot = { 'Crew', 'Cargo' },
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['brokenhorn'] = {
    name = "Broken Horn",
    XWS = 'brokenhorn',
    slot = 'Title',
    limited = 1,
    addSlot = { 'Crew', 'Illicit' },
    restriction = {
        Faction = { ['scumandvillainy'] = true },
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['merchantone'] = {
    name = "Merchant One",
    XWS = 'merchantone',
    slot = 'Title',
    limited = 1,
    addAction = { 'E' },
    addSlot = { 'Turret', 'Team', 'Cargo' },
    restriction = {
        Faction = { ['scumandvillainy'] = true },
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['insatiableworrt'] = {
    name = "Insatiable Worrt",
    XWS = 'insatiableworrt',
    slot = 'Title',
    shd = -1,
    Energy = -1,
    Hull = 3,
    addSlot = { 'Cargo' },
    restriction = {
        Faction = { ['scumandvillainy'] = true },
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['corsairrefit'] = {
    name = "Corsair Refit",
    XWS = 'corsairrefit',
    slot = 'Configuration',
    shd = -2,
    Energy = 1,
    Hull = 2,
    addSlot = { 'Cannon', 'Turret', 'Missile' },
    restriction = {
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['strategiccommander'] = {
    name = "Strategic Commander",
    XWS = 'strategiccommander',
    slot = 'Command',
    remSlot = { 'Crew' },
    cardB =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        Size = { huge = true }
    }
}

masterUpgradesDB['vectoredcannonsrz1'] = {
    name = "Vectored Cannons (RZ-1)",
    XWS = 'vectoredcannonsrz1',
    slot = 'Configuration',
    restriction = {
        ship = { ['rz1awing'] = true }
    },
    arcs = { turret = { name = 'primary', type = { 'front', 'back' } } },
}

masterUpgradesDB['b6bladewingprototype1'] = {
    name = "B6 Blade Wing Prototype",
    XWS = 'b6bladewingprototype1',
    slot = 'Title',
    limited = 1,
    addSlot = { 'Gunner' },
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['asf01bwing'] = true }
    },
}

masterUpgradesDB['b6bladewingprototype'] = {
    name = "B6 Blade Wing Prototype",
    XWS = 'b6bladewingprototype',
    slot = 'Command',
    limited = 1,
    addSlot = { 'Gunner' },
    remSlot = { 'Title' },
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['asf01bwing'] = true }
    },
}

masterUpgradesDB['hopeful'] = {
    name = "Hopeful",
    XWS = 'hopeful',
    slot = 'Talent',
    restriction = {
        Faction = { ['rebelalliance'] = true }
    },
    addAction = { 'B', 'F' },
}

masterUpgradesDB['sabinewren-gunner'] = {
    name = "Sabine Wren",
    XWS = 'sabinewren-gunner',
    slot = 'Gunner',
    limited = 1,
    restriction = {
        Faction = { ['rebelalliance'] = true }
    },
}

masterUpgradesDB['phoenixsquadron'] = {
    name = "Phoenix Squadron",
    XWS = 'phoenixsquadron',
    slot = 'Command',
    limited = 1,
    wingleader = true,
    dual = true,
    restriction = {
        Faction = { ['rebelalliance'] = true },
        ship = { ['vcx100lightfreighter'] = true }
    },
}

masterUpgradesDB['disciplined'] = {
    name = "Disciplined",
    XWS = 'disciplined',
    slot = 'Talent',
    restriction = {
        Faction = { ['galacticempire'] = true }
    },
    addAction = { 'TL', 'BR' },
}


masterUpgradesDB['sensitivecontrols'] = {
    name = "Sensitive Controls",
    XWS = 'sensitivecontrols',
    slot = 'Configuration',
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
    slot = 'Command',
    limited = 2,
    wingleader = true,
    dual = true,
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = {
            ['tielnfighter'] = true,     --TIE fighter
            ['tieininterceptor'] = true, --TIE interceptor
        }
    },
}

masterUpgradesDB['shadowwing'] = {
    name = "Shadow Wing",
    XWS = 'shadowwing',
    slot = 'Command',
    limited = 1,
    wingleader = true,
    dual = true,
    restriction = {
        Faction = { ['galacticempire'] = true },
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
    slot = 'Crew',
    Charge = 2,
    addAction = { 'TL' },
    restriction = {
        Faction = { ['scumandvillainy'] = true }
    }
}


masterUpgradesDB['cutthroat'] = {
    name = "Cutthroat",
    XWS = 'cutthroat',
    slot = 'Talent',
    restriction = {
        Faction = { ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['bounty'] = {
    name = "Bounty",
    XWS = 'bounty',
    dual = true,
    slot = 'Command',
    restriction = {
        Faction = { ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['initforthemoney'] = {
    name = "In It For The Money",
    XWS = 'initforthemoney',
    dual = true,
    slot = 'Command',
    restriction = {
        Faction = { ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['interloperturn'] = {
    name = "Interloper Turn",
    XWS = 'interloperturn',
    slot = 'Talent',
    restriction = {
        ship = { ['tiededefender'] = true }
    },
    addAction = { 'TL', 'BR' },
}

masterUpgradesDB['protectorategleb'] = {
    name = "Protectorate Gleb",
    XWS = 'protectorategleb',
    slot = 'Crew',
    restriction = {
        Faction = { ['galacticempire'] = true, ['scumandvillainy'] = true, ['firstorder'] = true }
    }
}

masterUpgradesDB['r4b11'] = {
    name = "R4-B11",
    XWS = 'r4b11',
    slot = 'Astromech',
    restriction = {
        Faction = { ['scumandvillainy'] = true }
    }
}

masterUpgradesDB['tiedefenderelite'] = {
    name = "TIE Defender Elite",
    XWS = 'tiedefenderelite',
    slot = 'Configuration',
    restriction = {
        Faction = { ['galacticempire'] = true },
        ship = { ['tiededefender'] = true }
    }
}

masterUpgradesDB['tierfonbellyrun'] = {
    name = "Tierfon Belly Run",
    XWS = 'tierfonbellyrun',
    slot = 'Talent',
    restriction = {
        ship = { ['btla4ywing'] = true }
    }
}


masterUpgradesDB['asajjventress'] = {
    name = "Asajj Ventress",
    XWS = 'asajjventress',
    Force = 1,
    slot = 'Command',
    remSlot = { 'Crew' },
    limited = 1,
    addAction = { "F" },
    restriction = {
        Size = { huge = true },
        Faction = { ['scumandvillainy'] = true, ['separatistalliance'] = true }
    }
}

masterUpgradesDB['rifftamson'] = {
    name = "Riff Tamson",
    XWS = 'rifftamson',
    slot = 'Command',
    remSlot = { 'Crew' },
    limited = 1,
    restriction = {
        Size = { huge = true },
        Faction = { ['separatistalliance'] = true }
    }
}

masterUpgradesDB['generalgrievous-command'] = {
    name = "General Grievous",
    XWS = 'generalgrievous-command',
    slot = 'Command',
    remSlot = { 'Crew' },
    limited = 1,
    restriction = {
        Size = { huge = true },
        Faction = { ['separatistalliance'] = true }
    }
}

masterUpgradesDB['tractortechnicians'] = {
    name = "Tractor Technicians",
    XWS = 'tractortechnicians',
    slot = 'Team',
}

masterUpgradesDB['hondoohnaka-command'] = {
    name = "Hondo Ohnaka",
    XWS = 'hondoohnaka-command',
    slot = 'Command',
    limite = 1,
    remSlot = { 'Crew' },
    Charge = 2,
    restriction = {
        Size = { huge = true },
    }
}

masterUpgradesDB['corsaircrew'] = {
    name = "Corsair Crew",
    XWS = 'corsaircrew',
    slot = 'Team',
    remSlot = { 'Gunner' },
    restriction = {
        Faction = { ['scumandvillainy'] = true },
    }
}

masterUpgradesDB['martuuk'] = {
    name = "Mar Tuuk",
    XWS = 'martuuk',
    slot = 'Command',
    limited = 1,
    remSlot = { 'Crew' },
    restriction = {
        Faction = { ['separatistalliance'] = true },
        Size = { huge = true },
    }
}

masterUpgradesDB['zealouscaptain'] = {
    name = "Zealous Captain",
    XWS = 'zealouscaptain',
    slot = 'Command',
    limited = 1,
    remSlot = { 'Crew' },
    restriction = {
        Size = { huge = true },
    }
}

masterUpgradesDB['tractortentacles'] = {
    name = "Tractor Tentacles",
    XWS = 'tractortentacles',
    slot = 'Hardpoint',
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['drillbeak'] = {
    name = "Drill Beak",
    XWS = 'drillbeak',
    slot = 'Hardpoint',
    remSlot = { 'Cargo' },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['enhancedpropulsion'] = {
    name = "Enhanced Propulsion",
    XWS = 'enhancedpropulsion',
    slot = 'Hardpoint',
    remSlot = { 'Cargo' },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['protoncannonbattery'] = {
    name = "Proton Cannon Battery",
    XWS = 'protoncannonbattery',
    slot = 'Hardpoint',
    remSlot = { 'Cargo' },
    restriction = {
        Size = { huge = true },
    }
}

masterUpgradesDB['droidcrew'] = {
    name = "Droid Crew",
    XWS = 'droidcrew',
    slot = 'Team',
    addAction = { 'C', 'TL' },
    restriction = {
        Faction = { ['separatistalliance'] = true },
    }
}

masterUpgradesDB['grappler'] = {
    name = "Grappler",
    XWS = 'grappler',
    limited = 1,
    slot = 'Title',
    Shield = -1,
    Hull = 2,
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['nautolansrevenge'] = {
    name = "Nautolan's Revenge",
    XWS = 'nautolansrevenge',
    slot = 'Title',
    limited = 1,
    Shield = 1,
    Hull = -2,
    Energy = 1,
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
        Faction = { ['scumandvillainy'] = true }
    }
}

masterUpgradesDB['neimoidiangrasp'] = {
    name = "Neimoidian Grasp",
    XWS = 'neimoidiangrasp',
    slot = 'Title',
    limited = 1,
    Hull = -2,
    addAction = { "E" },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
        Faction = { ['separatistalliance'] = true }
    }
}

masterUpgradesDB['trident'] = {
    name = "Trident",
    XWS = 'trident',
    slot = 'Title',
    limited = 1,
    Energy = 1,
    addAction = { "E" },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
        Faction = { ['separatistalliance'] = true }
    }
}

masterUpgradesDB['trackingtorpedoes'] = {
    name = "Tracking Torpedoes",
    XWS = 'trackingtorpedoes',
    slot = 'Torpedo',
    limited = 1,
    Charge = 3,
    restriction = {
        Size = { huge = true }
    }
}

masterUpgradesDB['feedbackping'] = {
    name = "Feedback Ping",
    XWS = 'feedbackping',
    slot = 'Talent',
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
    slot = 'Tech',
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
    slot = 'Configuration',
    remSlot = { 'Tech' },
    restriction = {
        ship = {
            ['tiewiwhispermodifiedinterceptor'] = true, -- Tie Whisper
        },
    }
}

masterUpgradesDB['l4er5'] = {
    name = "L4E-R5",
    XWS = 'l4er5',
    slot = 'Astromech',
    limited = 1,
    addAction = { 'C' },
    restriction = {
        Faction = { ['resistance'] = true }
    },
}

masterUpgradesDB['overtunedmodulators'] = {
    name = "Overtuned Modulators",
    XWS = 'overtunedmodulators',
    slot = 'Illicit',
    Charge = 1,
    addAction = { 'C' },
}

masterUpgradesDB['wartimeloadout'] = {
    name = "Wartime Loadout",
    XWS = 'wartimeloadout',
    slot = 'Configuration',
    remSlot = { 'Modification' },
    addSlot = { 'Torpedo', 'Missile' },
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
    slot = 'Astromech',
    addAction = { 'C' },
}

masterUpgradesDB['dt798'] = {
    name = "DT-798",
    XWS = 'dt798',
    slot = 'Gunner',
    restriction = {
        Faction = { ['firstorder'] = true }
    },
}

masterUpgradesDB['electrochaffmissiles'] = {
    name = "Electro-Chaff Missiles",
    XWS = 'electrochaffmissiles',
    limited = 2,
    slot = 'Missile',
    Charge = 1,
    Bomb = true,
    remSlot = { 'Payload' },
}

masterUpgradesDB['firstorderordnancetech'] = {
    name = "First Order Ordnance Tech",
    XWS = 'firstorderordnancetech',
    slot = 'Gunner',
    addAction = { 'TL' },
    restriction = {
        Faction = { ['firstorder'] = true }
    },
}

masterUpgradesDB['babufrik'] = {
    name = "Babu Frik",
    XWS = 'babufrik',
    limited = 1,
    Charge = 3,
    slot = 'Illicit',
    restriction = {
        Faction = { ['scumandvillainy'] = true, ['resistance'] = true }
    },
}

masterUpgradesDB['compassion'] = {
    name = "Compassion",
    XWS = 'compassion',
    slot = 'Force Power',
    restriction = {
        keywords = { 'Light Side' }
    },
}

masterUpgradesDB['malice'] = {
    name = "Malice",
    XWS = 'malice',
    slot = 'Force Power',
    restriction = {
        keywords = { 'Dark Side' }
    },
}

masterUpgradesDB['shatteringshot'] = {
    name = "Shattering Shot",
    XWS = 'shatteringshot',
    slot = 'Force Power',
}

-- Pride of Mandalore reinforcement pack

masterUpgradesDB['ahsokatano-crew'] = {
    name = "Ahsoka Tano",
    limited = 1,
    XWS = 'ahsokatano-crew',
    slot = 'Crew',
    Force = 1,
    addSqdAction = { 'F' },
    restriction = {
        Faction = { ['scumandvillainy'] = true, ['galacticrepublic'] = true }
    },
}

masterUpgradesDB['primeministeralmec'] = {
    name = "Prime Minister Almec",
    limited = 1,
    XWS = 'primeministeralmec',
    slot = 'Crew',
    dual = true,
    addSqdAction = { 'C' },
    restriction = {
        Faction = { ['scumandvillainy'] = true, ['galacticrepublic'] = true }
    },
}

masterUpgradesDB['bokatankryze'] = {
    name = "Bo-Katan Kryze",
    limited = 1,
    XWS = 'bokatankryze',
    slot = 'Crew',
    restriction = {
        Faction = { ['galacticrepublic'] = true, ['separatistalliance'] = true }
    },
}

masterUpgradesDB['bokatankryze-rebel-scum'] = {
    name = "Bo-Katan Kryze",
    limited = 1,
    XWS = 'bokatankryze-rebel-scum',
    slot = 'Crew',
    restriction = {
        Faction = { ['rebelalliance'] = true, ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['korkiekryze'] = {
    name = "Korkie Kryze",
    limited = 1,
    XWS = 'korkiekryze',
    slot = 'Crew',
    restriction = {
        Faction = { ['galacticrepublic'] = true }
    },
}

masterUpgradesDB['maul-crew'] = {
    name = "Maul",
    title = "Mandalore",
    limited = 1,
    XWS = 'maul-crew',
    slot = 'Crew',
    remSlot = { 'Crew' },
    addSlot = { 'Illicit' },
    Force = 1,
    restriction = {
        Faction = { ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['previzsla'] = {
    name = "Pre Vizsla",
    limited = 1,
    XWS = 'previzsla',
    slot = 'Crew',
    restriction = {
        Faction = { ['scumandvillainy'] = true, ['separatistalliance'] = true }
    },
}

masterUpgradesDB['rookkast'] = {
    name = "Rook Kast",
    limited = 1,
    XWS = 'rookkast',
    slot = 'Crew',
    addAction = { 'TL' },
    restriction = {
        Faction = { ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['savageopress'] = {
    name = "Savage Opress",
    limited = 1,
    Force = 1,
    XWS = 'savageopress',
    slot = 'Crew',
    restriction = {
        Faction = { ['scumandvillainy'] = true, ['separatistalliance'] = true }
    },
}

masterUpgradesDB['talmerrik'] = {
    name = "Tal Merrik",
    limited = 1,
    XWS = 'talmerrik',
    slot = 'Crew',
    restriction = {
        Faction = { ['separatistalliance'] = true }
    },
    Condition = "False Friend",
}

masterUpgradesDB['sabinewren-crew'] = {
    name = "Sabine Wren",
    limited = 1,
    XWS = 'sabinewren-crew',
    slot = 'Crew',
    restriction = {
        Faction = { ['rebelalliance'] = true },
        Size = { small = true, medium = true, large = true }
    },
    Condition = "Trials of the Darksaber",
}

masterUpgradesDB['captainhark'] = {
    name = "Captain Hark",
    limited = 1,
    XWS = 'captainhark',
    slot = 'Crew',
    Charge = 2,
    restriction = {
        Faction = { ['galacticempire'] = true },
    },
}

masterUpgradesDB['fennrau'] = {
    name = "Fenn Rau",
    limited = 1,
    XWS = 'fennrau',
    slot = 'Crew',
    restriction = {
        Faction = { ['rebelalliance'] = true, ['scumandvillainy'] = true },
    },
}

masterUpgradesDB['garsaxon'] = {
    name = "Gar Saxon",
    limited = 1,
    XWS = 'garsaxon',
    slot = 'Crew',
    restriction = {
        Faction = { ['galacticempire'] = true },
    },
}

masterUpgradesDB['obiwankenobi'] = {
    name = "Obi-Wan Kenobi",
    limited = 1,
    XWS = 'obiwankenobi',
    slot = 'Crew',
    Force = 1,
    restriction = {
        Faction = { ['galacticrepublic'] = true },
    },
}

masterUpgradesDB['satinekryze'] = {
    name = "Satine Kryze",
    limited = 1,
    XWS = 'satinekryze',
    slot = 'Crew',
    Charge = 2,
    restriction = {
        Faction = { ['galacticrepublic'] = true },
    },
}

masterUpgradesDB['kuiil'] = {
    name = "Kuiil",
    limited = 1,
    XWS = 'kuiil',
    slot = 'Crew',
    restriction = {
        Faction = { ['scumandvillainy'] = true },
    },
}

masterUpgradesDB['tristanwren'] = {
    name = "Tristan Wren",
    limited = 1,
    XWS = 'tristanwren',
    slot = 'Crew',
    Charge = 1,
    restriction = {
        Faction = { ['rebelalliance'] = true },
        keywords = { 'Gar Saxon' }
    },
}

masterUpgradesDB['ursawren'] = {
    name = "Ursa Wren",
    limited = 1,
    XWS = 'ursawren',
    slot = 'Crew',
    restriction = {
        Faction = { ['rebelalliance'] = true },
    },
}

masterUpgradesDB['garsaxon-gunner'] = {
    name = "Gar Saxon",
    limited = 1,
    XWS = 'garsaxon-gunner',
    slot = 'Gunner',
    restriction = {
        Faction = { ['scumandvillainy'] = true },
        Size = { large = true, huge = true }
    },
}

masterUpgradesDB['tibersaxon'] = {
    name = "Tiber Saxon",
    limited = 1,
    XWS = 'tibersaxon',
    slot = 'Gunner',
    Charge = 2,
    restriction = {
        Faction = { ['galacticempire'] = true }
    },
}

masterUpgradesDB['ursawren-gunner'] = {
    name = "Ursa Wren",
    limited = 1,
    XWS = 'ursawren-gunner',
    slot = 'Gunner',
    restriction = {
        Faction = { ['galacticrepublic'] = true, ['separatistalliance'] = true }
    },
}


masterUpgradesDB['clantraining'] = {
    name = "Clan Training",
    XWS = 'clantraining',
    slot = 'Talent',
    Charge = 1,
    restriction = {
        keywords = { 'Mandalorian' }
    },
}

masterUpgradesDB['blazerbomb'] = {
    name = "Blazer Bomb",
    XWS = 'blazerbomb',
    slot = 'Payload',
    Charge = 1,
    Bomb = true,
}

masterUpgradesDB['beskarreinforcedplating'] = {
    name = "Beskar Reinforced Plating",
    XWS = 'beskarreinforcedplating',
    slot = 'Modification',
    Charge = 2,
    restriction = {
        keywords = { 'Mandalorian' }
    },
}

masterUpgradesDB['mandalorianoptics'] = {
    name = "Mandalorian Optics",
    XWS = 'mandalorianoptics',
    slot = 'Modification',
    Charge = 2,
    restriction = {
        keywords = { 'Mandalorian' }
    },
}

masterUpgradesDB['gauntlet'] = {
    name = "Gauntlet",
    XWS = 'gauntlet',
    limited = 1,
    slot = 'Title',
    remSlot = { 'Configuration' },
    addSlot = { 'Crew' },
    Charge = 2,
    restriction = {
        Faction = { ['galacticrepublic'] = true, ['separatistalliance'] = true },
        ship = { ['gauntletfighter'] = true }
    }
}

masterUpgradesDB['nightbrother'] = {
    name = "Nightbrother",
    XWS = 'nightbrother',
    limited = 1,
    slot = 'Title',
    remSlot = { 'Configuration' },
    addSlot = { 'Crew' },
    Charge = 2,
    restriction = {
        Faction = { ['rebelalliance'] = true, ['scumandvillainy'] = true },
        ship = { ['gauntletfighter'] = true }
    }
}

masterUpgradesDB['razorcrest'] = {
    name = "Razor Crest",
    XWS = 'razorcrest',
    limited = 1,
    slot = 'Title',
    addAction = { 'E', 'BR' },
    restriction = {
        ship = { ['st70assaultship'] = true }
    }
}

masterUpgradesDB['trackingfob'] = {
    name = "Tracking Fob",
    XWS = 'trackingfob',
    limited = 3,
    slot = 'Illicit',
    restriction = {
        keywords = { 'Bounty Hunter' }
    },
    Condition = "Marked for Elimination",
}

masterUpgradesDB['ig11'] = {
    name = "IG-11",
    XWS = 'ig11',
    limited = 1,
    slot = 'Crew',
    addAction = { 'C' },
    restriction = {
        Faction = { ['scumandvillainy'] = true },
    },
    dual = true,
}

masterUpgradesDB['burnoutthrusters'] = {
    name = "Burnout Thrusters",
    XWS = 'burnoutthrusters',
    Charge = 1,
    slot = 'Modification',
    restriction = {
        Faction = { ['scumandvillainy'] = true },
        Size = { small = true, medium = true }
    },
}

masterUpgradesDB['thechild'] = {
    name = "The Child",
    XWS = 'thechild',
    Force = 2,
    slot = 'Crew',
    restriction = {
        Faction = { ['rebelalliance'] = true, ['galacticempire'] = true, ['scumandvillainy'] = true },
    },
    Condition = "Merciless Pursuit",
}

masterUpgradesDB['themandalorian'] = {
    name = "The Mandalorian",
    XWS = 'themandalorian',
    slot = 'Crew',
    addAction = { 'R' },
    restriction = {
        Faction = { ['scumandvillainy'] = true },
    },
}

masterUpgradesDB['swivelwing'] = {
    name = "Swivel Wing",
    XWS = 'swivelwing',
    slot = 'Configuration',
    restriction = {
        ship = { ['gauntletfighter'] = true }
    },
    dual = true,
}


masterUpgradesDB['clanwrencommandos'] = {
    name = "Clan Wren Commandos",
    XWS = 'clanwrencommandos',
    remotes = { "Clan Wren Commandos (A)", "Clan Wren Commandos (B)" },
    remoteCharge = 2,
    limited = 1,
    slot = 'Crew',
    remSlot = { 'Crew' },
    Charge = 2,
    restriction = {
        Faction = { ['rebelalliance'] = true },
        Size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['imperialsupercommandos'] = {
    name = "Imperial Super Commandos",
    XWS = 'imperialsupercommandos',
    remotes = { "Imperial Super Commandos (A)", "Imperial Super Commandos (B)" },
    remoteCharge = 2,
    limited = 1,
    slot = 'Crew',
    remSlot = { 'Crew' },
    Charge = 2,
    restriction = {
        Faction = { ['galacticempire'] = true },
        Size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['mandaloriansupercommandos'] = {
    name = "Mandalorian Super Commandos",
    XWS = 'mandaloriansupercommandos',
    remotes = { "Mandalorian Super Commandos (A)", "Mandalorian Super Commandos (B)" },
    remoteCharge = 2,
    limited = 1,
    slot = 'Crew',
    remSlot = { 'Crew' },
    Charge = 2,
    restriction = {
        Faction = { ['scumandvillainy'] = true },
        Size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['niteowlcommandos'] = {
    name = "Nite Owl Commandos",
    XWS = 'niteowlcommandos',
    remotes = { "Nite Owl Commandos (A)", "Nite Owl Commandos (B)" },
    remoteCharge = 2,
    limited = 1,
    slot = 'Crew',
    remSlot = { 'Crew' },
    Charge = 2,
    restriction = {
        Faction = { ['galacticrepublic'] = true },
        Size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['deathwatchcommandos'] = {
    name = "Death Watch Commandos",
    XWS = 'deathwatchcommandos',
    remotes = { "Death Watch Commandos (A)", "Death Watch Commandos (B)" },
    remoteCharge = 2,
    limited = 1,
    slot = 'Crew',
    remSlot = { 'Crew' },
    Charge = 2,
    restriction = {
        Faction = { ['separatistalliance'] = true },
        Size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['dropseatbay'] = {
    name = "Drop-Seat bay",
    XWS = 'dropseatbay',
    slot = 'Modification',
    restriction = {
        ship = { ['gauntletfighter'] = true }
    },
}

masterUpgradesDB['homingtorpedoes'] = {
    name = 'Homing Torpedoes',
    XWS = 'homingtorpedoes',
    slot = 'Torpedo',
    Charge = 2,
}

masterUpgradesDB['notorious'] = {
    name = "Notorious",
    XWS = 'notorious',
    slot = 'Talent',
    Charge = 2,
    restriction = {
        -- equipped: illicit
    },
}

masterUpgradesDB['enduring'] = {
    name = "Enduring",
    XWS = 'enduring',
    slot = 'Talent',
}

masterUpgradesDB['pelimotto'] = {
    name = "Peli Motto",
    XWS = 'pelimotto',
    restriction = {
        Faction = { ['scumandvillainy'] = true },
        Size = { medium = true, large = true }
    },
    slot = 'Crew',
    limited = 1,
}

masterUpgradesDB['greefkarga'] = {
    name = "Greef Karga",
    XWS = 'greefkarga',
    restriction = {
        Faction = { ['scumandvillainy'] = true }
    },
    slot = 'Crew',
    limited = 1,
}

masterUpgradesDB['migsmayfeld'] = {
    name = "Migs Mayfeld",
    XWS = 'migsmayfeld',
    restriction = {
        Faction = { ['galacticempire'] = true, ['scumandvillainy'] = true }
    },
    slot = 'Gunner',
    limited = 1,
}

masterUpgradesDB['hotshottailblaster'] = {
    name = "Hotshot Tail Blaster",
    XWS = 'hotshottailblaster',
    Charge = 2,
    slot = 'Modification',
    restriction = {
        Size = { medium = true, large = true }
    },
}

masterUpgradesDB['xanadublood'] = {
    name = "Xanadu Blood",
    XWS = 'xanadublood',
    slot = 'Title',
    restriction = {
        ship = { ['rogueclassstarfighter'] = true }
    },
}

masterUpgradesDB['protoncannons'] = {
    name = "Proton Cannons",
    XWS = 'protoncannons',
    slot = 'Cannon',
    remSlot = { 'Cannon' },
    cardB = cardBackDB['Cannon Dual'],
    Charge = 2,
    arcs = {
        weapon = {
            name = 'Proton Cannons',
            range = 2,
            type = { 'front' }
        }
    }
}

masterUpgradesDB['combatboardingtube'] = {
    name = "Combat Boarding Tube",
    XWS = 'combatboardingtube',
    slot = 'Configuration',
    remSlot = { 'Command' },
    restriction = {
        ship = { ['gauntletfighter'] = true }
    },
}

-- The YASB epic pack Upgrades
masterUpgradesDB['newrecruit'] = {
    name = "New Recruit",
    XWS = 'newrecruit',
    limited = 3,
    slot = 'Command',
    PointModifier = -1,
}

masterUpgradesDB['lockedturretspecialist'] = {
    name = "Locked-Turret Specialist",
    XWS = 'lockedturretspecialist',
    slot = 'Command',
    Charge = 2,
    addAction = { 'B' },
    restriction = {
        -- action: rotate
    },
}

masterUpgradesDB['heavyreinforcedvanguard'] = {
    name = "Heavy Reinforced Vanguard",
    XWS = 'heavyreinforcedvanguard',
    slot = 'Command',
    limited = 1,
    PointModifier = 1,
    Hull = 2,
}

masterUpgradesDB['evasiveinterceptor'] = {
    name = "Evasive Interceptor",
    XWS = 'evasiveinterceptor',
    slot = 'Command',
    limited = 1,
    Hull = -1,
    PointModifier = -1,
    --Agility = 1,
    restriction = { Size = { small = true } }
}

masterUpgradesDB['countermeasuresspecialist'] = {
    name = "Countermeasures Specialist",
    XWS = 'countermeasuresspecialist',
    slot = 'Command',
    limited = 1,
    Charge = 2,
    --addAction = {'Jam'}
    restriction = { Size = { small = true } }
}

masterUpgradesDB['combatveteran'] = {
    name = "Combat Veteran",
    XWS = 'combatveteran',
    slot = 'Command',
    limited = 1,
    PointModifier = 1,
    restriction = {
        HasForce = false,
        IsLimited = true,
        InitiativeGreaterThan = 3
    },
    addSlot = { 'Talent', 'Modification' },
}

masterUpgradesDB['forceadeptpilot'] = {
    name = "Force Adept Pilot",
    XWS = 'forceadeptpilot',
    slot = 'Command',
    limited = 1,
    PointModifier = 1,
    restriction = {
        HasForce = true,
    },
    addSlot = { 'Force Power' },
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
    slot = 'Command',
    limited = 2,
    PointModifier = 1,
    LoadoutModifier = 10
}


return masterUpgradesDB
