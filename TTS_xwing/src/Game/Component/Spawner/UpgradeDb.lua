masterUpgradesDB = {}
masterUpgradesDB['crackshot'] = {
    name = 'Crack Shot',
    xws = 'crackshot',
    slot = 'Talent',
    charge = 1,
}

masterUpgradesDB['daredevil'] = {
    name = 'Daredevil',
    xws = 'daredevil',
    slot = 'Talent',
    add_action = { 'Dare' },
    restriction = { size = { small = true } }
}

masterUpgradesDB['debrisgambit'] = {
    name = 'Debris Gambit',
    xws = 'debrisgambit',
    slot = 'Talent',
    add_action = { 'E' },
    restriction = { size = { small = true, medium = true } }
}

masterUpgradesDB['elusive'] = {
    name = 'Elusive',
    xws = 'elusive',
    slot = 'Talent',
    charge = 1,
    restriction = { size = { small = true, medium = true } }
}

masterUpgradesDB['experthandling'] = {
    name = 'Expert Handling',
    xws = 'experthandling',
    slot = 'Talent',
}

masterUpgradesDB['fearless'] = {
    name = 'Fearless',
    xws = 'fearless',
    slot = 'Talent',
    restriction = {
        faction = { ['scumandvillainy'] = true }
    }
}

masterUpgradesDB['intimidation'] = {
    name = 'Intimidation',
    xws = 'intimidation',
    slot = 'Talent',
}

masterUpgradesDB['juke'] = {
    name = 'Juke',
    xws = 'juke',
    slot = 'Talent',
    restriction = { size = { small = true, medium = true } }
}

masterUpgradesDB['lonewolf'] = {
    name = 'Lone Wolf',
    xws = 'lonewolf',
    slot = 'Talent',
    charge = 1,
}

masterUpgradesDB['marksmanship'] = {
    name = 'Marksmanship',
    xws = 'marksmanship',
    slot = 'Talent',
}

masterUpgradesDB['outmaneuver'] = {
    name = 'Outmaneuver',
    xws = 'outmaneuver',
    slot = 'Talent',
}

masterUpgradesDB['predator'] = {
    name = 'Predator',
    xws = 'predator',
    slot = 'Talent',
}

masterUpgradesDB['ruthless'] = {
    name = 'Ruthless',
    xws = 'ruthless',
    slot = 'Talent',
    restriction = {
        faction = { ['galacticempire'] = true }
    }
}

masterUpgradesDB['saturationsalvo'] = {
    name = 'Saturation Salvo',
    xws = 'saturationsalvo',
    slot = 'Talent',
}

masterUpgradesDB['selfless'] = {
    name = 'Selfless',
    xws = 'selfless',
    slot = 'Talent',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['squadleader'] = {
    name = 'Squad Leader',
    xws = 'squadleader',
    slot = 'Talent',
}

masterUpgradesDB['swarmtactics'] = {
    name = 'Swarm Tactics',
    xws = 'swarmtactics',
    slot = 'Talent',
}

masterUpgradesDB['trickshot'] = {
    name = 'Trick Shot',
    xws = 'trickshot',
    slot = 'Talent',
}

masterUpgradesDB['heightenedperception'] = {
    name = 'Heightened Perception',
    xws = 'heightenedperception',
    slot = 'Force Power',
}

masterUpgradesDB['instinctiveaim'] = {
    name = 'Instinctive Aim',
    xws = 'instinctiveaim',
    slot = 'Force Power',
}

masterUpgradesDB['sense'] = {
    name = 'Sense',
    xws = 'sense',
    slot = 'Force Power',
}

masterUpgradesDB['supernaturalreflexes'] = {
    name = 'Supernatural Reflexes',
    xws = 'supernaturalreflexes',
    slot = 'Force Power',
    add_action = { 'B', 'BR' },
    restriction = { size = { small = true } }
}

masterUpgradesDB['advancedsensors'] = {
    name = 'Advanced Sensors',
    xws = 'advancedsensors',
    slot = 'Sensor',
}

masterUpgradesDB['collisiondetector'] = {
    name = 'Collision Detector',
    xws = 'collisiondetector',
    slot = 'Sensor',
    charge = 2
}

masterUpgradesDB['firecontrolsystem'] = {
    name = 'Fire-Control System',
    xws = 'firecontrolsystem',
    slot = 'Sensor',
}

masterUpgradesDB['trajectorysimulator'] = {
    name = 'Trajectory Simulator',
    xws = 'trajectorysimulator',
    slot = 'Sensor',
}

masterUpgradesDB['heavylasercannon'] = {
    name = 'Heavy Laser Cannon',
    xws = 'heavylasercannon',
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
    xws = 'ioncannon',
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
    xws = 'jammingbeam',
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
    xws = 'tractorbeam',
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
    xws = 'dorsalturret',
    slot = 'Turret',
    arcs = { turret = { name = 'dorsal turret', range = 2, type = { 'singleturret' } } }
}

masterUpgradesDB['ioncannonturret'] = {
    name = 'Ion Cannon Turret',
    xws = 'ioncannonturret',
    slot = 'Turret',
    arcs = { turret = { name = 'ion cannon turret', range = 2, type = { 'singleturret' }, ion = true } }
}

masterUpgradesDB['advprotontorpedoes'] = {
    name = 'Adv. Proton Torpedoes',
    xws = 'advprotontorpedoes',
    slot = 'Torpedo',
    charge = 1
}

masterUpgradesDB['iontorpedoes'] = {
    name = 'Ion Torpedoes',
    xws = 'iontorpedoes',
    slot = 'Torpedo',
    charge = 2
}

masterUpgradesDB['protontorpedoes'] = {
    name = 'Proton Torpedoes',
    xws = 'protontorpedoes',
    slot = 'Torpedo',
    charge = 2,
}

masterUpgradesDB['barragerockets'] = {
    name = 'Barrage Rockets',
    xws = 'barragerockets',
    slot = 'Missile',
    remove_slots = { 'Missile' },
    charge = 5,
    card_back = cardBackDB['Missile Dual'],
}

masterUpgradesDB['clustermissiles'] = {
    name = 'Cluster Missiles',
    xws = 'clustermissiles',
    slot = 'Missile',
    charge = 4
}

masterUpgradesDB['concussionmissiles'] = {
    name = 'Concussion Missiles',
    xws = 'concussionmissiles',
    slot = 'Missile',
    charge = 3
}

masterUpgradesDB['homingmissiles'] = {
    name = 'Homing Missiles',
    xws = 'homingmissiles',
    slot = 'Missile',
    charge = 2
}

masterUpgradesDB['ionmissiles'] = {
    name = 'Ion Missiles',
    xws = 'ionmissiles',
    slot = 'Missile',
    charge = 3
}

masterUpgradesDB['protonrockets'] = {
    name = 'Proton Rockets',
    xws = 'protonrockets',
    slot = 'Missile',
    charge = 1
}

masterUpgradesDB['freelanceslicer'] = {
    name = 'Freelance Slicer',
    xws = 'freelanceslicer',
    slot = 'Crew',
}

masterUpgradesDB['gnkgonkdroid'] = {
    name = 'GNK "Gonk" Droid',
    xws = 'gnkgonkdroid',
    slot = 'Crew',
    charge = 1
}

masterUpgradesDB['informant'] = {
    name = 'Informant',
    xws = 'informant',
    condition = "Listening Device",
    slot = 'Crew',
}

masterUpgradesDB['novicetechnician'] = {
    name = 'Novice Technician',
    xws = 'novicetechnician',
    slot = 'Crew',
}

masterUpgradesDB['perceptivecopilot'] = {
    name = 'Perceptive Copilot',
    xws = 'perceptivecopilot',
    slot = 'Crew',
}

masterUpgradesDB['seasonednavigator'] = {
    name = 'Seasoned Navigator',
    xws = 'seasonednavigator',
    slot = 'Crew',

    restriction = {},
    execute_options = function(list, pilotid)
        exopts = {}
        nextdiff = { b = "w", w = "r" }
        if pilotid == 0 or pilotid == '' then
            return {}
        end
        for _, man in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].move_set) do
            local Char = man:find("%d")
            local speed = tonumber(man:sub(Char, Char))
            local exopt = { man }
            for _, man2 in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].move_set) do
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
    xws = 'tacticalofficer',
    slot = 'Crew',
}

masterUpgradesDB['hotshotgunner'] = {
    name = 'Hotshot Gunner',
    xws = 'hotshotgunner',
    slot = 'Gunner',
}

masterUpgradesDB['skilledbombardier'] = {
    name = 'Skilled Bombardier',
    xws = 'skilledbombardier',
    slot = 'Gunner',
}

masterUpgradesDB['veterantailgunner'] = {
    name = 'Veteran Tail Gunner',
    xws = 'veterantailgunner',
    slot = 'Gunner',
}

masterUpgradesDB['veteranturretgunner'] = {
    name = 'Veteran Turret Gunner',
    xws = 'veteranturretgunner',
    slot = 'Gunner',
}

masterUpgradesDB['r2astromech'] = {
    name = 'R2 Astromech',
    xws = 'r2astromech',
    slot = 'Astromech',
    charge = 2
}

masterUpgradesDB['r3astromech'] = {
    name = 'R3 Astromech',
    xws = 'r3astromech',
    slot = 'Astromech',
}

masterUpgradesDB['r4astromech'] = {
    name = 'R4 Astromech',
    xws = 'r4astromech',
    slot = 'Astromech',
    restriction = { size = { small = true } }
}

masterUpgradesDB['r5astromech'] = {
    name = 'R5 Astromech',
    xws = 'r5astromech',
    slot = 'Astromech',
    charge = 2
}

masterUpgradesDB['cloakingdevice'] = {
    name = 'Cloaking Device',
    xws = 'cloakingdevice',
    slot = 'Illicit',
    limited = 1,
    add_action = { 'CL' },
    charge = 2,
    restriction = { size = { small = true, medium = true } }
}

masterUpgradesDB['contrabandcybernetics'] = {
    name = 'Contraband Cybernetics',
    xws = 'contrabandcybernetics',
    slot = 'Illicit',
    charge = 1
}

masterUpgradesDB['deadmansswitch'] = {
    name = "Deadman's Switch",
    xws = 'deadmansswitch',
    slot = 'Illicit',
}

masterUpgradesDB['feedbackarray'] = {
    name = 'Feedback Array',
    xws = 'feedbackarray',
    slot = 'Illicit',
}

masterUpgradesDB['inertialdampeners'] = {
    name = 'Inertial Dampeners',
    xws = 'inertialdampeners',
    slot = 'Illicit',
}

masterUpgradesDB['riggedcargochute'] = {
    name = 'Rigged Cargo Chute',
    xws = 'riggedcargochute',
    slot = 'Illicit',
    bomb = true,
    charge = 1,
    restriction = { size = { large = true, medium = true } }
}

masterUpgradesDB['ablativeplating'] = {
    name = 'Ablative Plating',
    xws = 'ablativeplating',
    slot = 'Modification',
    charge = 2,
    restriction = { size = { large = true, medium = true } }
}

masterUpgradesDB['advancedslam'] = {
    name = 'Advanced SLAM',
    xws = 'advancedslam',
    slot = 'Modification',
}


masterUpgradesDB['afterburners'] = {
    name = 'Afterburners',
    xws = 'afterburners',
    add_action = { 'B' },
    slot = 'Modification',
    charge = 2,
    restriction = {
        size = { small = true }
    }
}

masterUpgradesDB['electronicbaffle'] = {
    name = 'Electronic Baffle',
    xws = 'electronicbaffle',
    slot = 'Modification',
}

masterUpgradesDB['engineupgrade'] = {
    name = 'Engine Upgrade',
    xws = 'engineupgrade',
    slot = 'Modification',
}

masterUpgradesDB['hullupgrade'] = {
    name = 'Hull Upgrade',
    xws = 'hullupgrade',
    slot = 'Modification',
    hull = 1,
    restriction = {}
}
masterUpgradesDB['munitionsfailsafe'] = {
    name = 'Munitions Failsafe',
    xws = 'munitionsfailsafe',
    slot = 'Modification',
}

masterUpgradesDB['shieldupgrade'] = {
    name = 'Shield Upgrade',
    xws = 'shieldupgrade',
    slot = 'Modification',
    shd = 1
}

masterUpgradesDB['staticdischargevanes'] = {
    name = 'Static Discharge Vanes',
    xws = 'staticdischargevanes',
    slot = 'Modification',
}

masterUpgradesDB['stealthdevice'] = {
    name = 'Stealth Device',
    xws = 'stealthdevice',
    slot = 'Modification',
    charge = 1
}

masterUpgradesDB['tacticalscrambler'] = {
    name = 'Tactical Scrambler',
    xws = 'tacticalscrambler',
    slot = 'Modification',
    restriction = { size = { large = true, medium = true } }
}

masterUpgradesDB['bazemalbus'] = {
    name = 'Baze Malbus',
    xws = 'bazemalbus',
    slot = 'Crew',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['c3po'] = {
    name = 'C-3PO',
    xws = 'c3po',
    slot = 'Crew',
    add_action = { 'C' },
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['cassianandor'] = {
    name = 'Cassian Andor',
    xws = 'cassianandor',
    slot = 'Crew',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['chewbacca'] = {
    name = 'Chewbacca',
    xws = 'chewbacca',
    slot = 'Crew',
    charge = 2,
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['chopper-crew'] = {
    name = '"Chopper"',
    xws = 'chopper-crew',
    slot = 'Crew',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['herasyndulla'] = {
    name = 'Hera Syndulla',
    xws = 'herasyndulla',
    slot = 'Crew',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['jynerso'] = {
    name = 'Jyn Erso',
    xws = 'jynerso',
    slot = 'Crew',
    limited = 1,
    add_squad_action = { 'E' },
    restriction = { faction = { ['rebelalliance'] = true } }
}


masterUpgradesDB['kananjarrus'] = {
    name = 'Kanan Jarrus',
    xws = 'kananjarrus',
    slot = 'Crew',
    limited = 1,
    force = 1,
    restriction = { faction = { ['rebelalliance'] = true } }
}


masterUpgradesDB['landocalrissian'] = {
    name = 'Lando Calrissian',
    xws = 'landocalrissian',
    slot = 'Crew',
    add_action = { 'F', 'E' },
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['leiaorgana'] = {
    name = 'Leia Organa',
    xws = 'leiaorgana',
    slot = 'Crew',
    charge = 3,
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['magvayarro'] = {
    name = 'Magva Yarro',
    xws = 'magvayarro',
    slot = 'Crew',
    add_action = { 'TL' },
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['niennunb'] = {
    name = 'Nien Nunb',
    xws = 'niennunb',
    slot = 'Crew',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['r2d2-crew'] = {
    name = 'R2-D2',
    xws = 'r2d2-crew',
    slot = 'Crew',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['sabinewren'] = {
    name = 'Sabine Wren',
    xws = 'sabinewren',
    slot = 'Crew',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['sawgerrera'] = {
    name = 'Saw Gerrera',
    xws = 'sawgerrera',
    slot = 'Crew',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['zeborrelios'] = {
    name = '"Zeb" Orrelios',
    xws = 'zeborrelios',
    slot = 'Crew',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['bistan'] = {
    name = 'Bistan',
    xws = 'bistan',
    slot = 'Gunner',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['ezrabridger'] = {
    name = 'Ezra Bridger',
    xws = 'ezrabridger',
    slot = 'Gunner',
    force = 1,
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['hansolo'] = {
    name = 'Han Solo',
    xws = 'hansolo',
    slot = 'Gunner',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['lukeskywalker'] = {
    name = 'Luke Skywalker',
    xws = 'lukeskywalker',
    slot = 'Gunner',
    force = 1,
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['chopper'] = {
    name = '"Chopper"',
    xws = 'chopper',
    slot = 'Astromech',
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['r2d2'] = {
    name = 'R2-D2',
    xws = 'r2d2',
    slot = 'Astromech',
    charge = 3,
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['r5d8'] = {
    name = 'R5-D8',
    xws = 'r5d8',
    slot = 'Astromech',
    charge = 3,
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['ghost'] = {
    name = 'Ghost',
    xws = 'ghost',
    slot = 'Title',
    restriction = { faction = { ['rebelalliance'] = true }, ship = { ['vcx100lightfreighter'] = true } }
}

masterUpgradesDB['millenniumfalcon'] = {
    name = 'Millennium Falcon',
    xws = 'millenniumfalcon',
    limited = 1,
    slot = 'Title',
    add_action = { 'E' },
    restriction = { faction = { ['rebelalliance'] = true }, ship = { ['modifiedyt1300lightfreighter'] = true } }
}

masterUpgradesDB['moldycrow'] = {
    name = 'Moldy Crow',
    xws = 'moldycrow',
    limited = 1,
    slot = 'Title',
    restriction = {
        faction = { ['rebelalliance'] = true, ['scumandvillainy'] = true },
        ship = { ['hwk290lightfreighter'] = true }
    },
    arcs = { fixed = { range = 3, type = { 'front' } } }
}

masterUpgradesDB['outrider'] = {
    name = 'Outrider',
    xws = 'outrider',
    slot = 'Title',
    restriction = { ship = { ['yt2400lightfreighter'] = true } }
}

masterUpgradesDB['phantom'] = {
    name = 'Phantom',
    xws = 'phantom',
    slot = 'Title',
    restriction = { faction = { ['rebelalliance'] = true }, ship = { ['attackshuttle'] = true, ['sheathipedeclassshuttle'] = true } }
}

masterUpgradesDB['pivotwing'] = {
    name = 'Pivot Wing',
    xws = 'pivotwing',
    slot = 'Configuration',
    add_action = { 'Piv' },
    dual = true,
    restriction = { faction = { ['rebelalliance'] = true }, ship = { ['ut60duwing'] = true } }
}

masterUpgradesDB['servomotorsfoils'] = {
    name = 'Servomotor S-Foils',
    xws = 'servomotorsfoils',
    slot = 'Configuration',
    add_action = { 'B' },
    dual = true,
    restriction = { faction = { ['rebelalliance'] = true }, ship = { ['t65xwing'] = true } }
}


masterUpgradesDB['admiralsloane'] = {
    name = 'Admiral Sloane',
    xws = 'admiralsloane',
    slot = 'Crew',
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['agentkallus'] = {
    name = 'Agent Kallus',
    xws = 'agentkallus',
    condition = "Hunted",
    slot = 'Crew',
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['cienaree'] = {
    name = 'Ciena Ree',
    xws = 'cienaree',
    slot = 'Crew',
    limited = 1,
    add_squad_action = { 'Piv' },
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['darthvader'] = {
    name = 'Darth Vader',
    xws = 'darthvader',
    slot = 'Crew',
    limited = 1,
    force = 1,
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['deathtroopers'] = {
    name = 'Death Troopers',
    xws = 'deathtroopers',
    slot = 'Crew',
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['directorkrennic'] = {
    name = 'Director Krennic',
    xws = 'directorkrennic',
    condition = "Optimized Prototype",
    slot = 'Crew',
    limited = 1,
    add_action = { 'TL' },
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['emperorpalpatine'] = {
    name = 'Emperor Palpatine',
    xws = 'emperorpalpatine',
    slot = 'Crew',
    remove_slots = { 'Crew' },
    force = 1,
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['grandinquisitor'] = {
    name = 'Grand Inquisitor',
    xws = 'grandinquisitor',
    slot = 'Crew',
    force = 1,
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['grandmofftarkin'] = {
    name = 'Grand Moff Tarkin',
    xws = 'grandmofftarkin',
    slot = 'Crew',
    charge = 2,
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['isbslicer'] = {
    name = 'ISB Slicer',
    xws = 'isbslicer',
    slot = 'Crew',
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['ministertua'] = {
    name = 'Minister Tua',
    xws = 'ministertua',
    slot = 'Crew',
    limited = 1,
    add_action = { 'R' },
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['moffjerjerrod'] = {
    name = 'Moff Jerjerrod',
    xws = 'moffjerjerrod',
    slot = 'Crew',
    limited = 1,
    add_squad_action = { 'B' },
    charge = 2,
    restriction = { faction = { ['galacticempire'] = true } }
}


masterUpgradesDB['seventhsister'] = {
    name = 'Seventh Sister',
    xws = 'seventhsister',
    slot = 'Crew',
    force = 1,
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['fifthbrother'] = {
    name = 'Fifth Brother',
    xws = 'fifthbrother',
    slot = 'Gunner',
    force = 1,
    restriction = { faction = { ['galacticempire'] = true } }
}

masterUpgradesDB['dauntless'] = {
    name = 'Dauntless',
    xws = 'dauntless',
    slot = 'Title',
    restriction = { faction = { ['galacticempire'] = true }, ship = { ['vt49decimator'] = true } }
}

masterUpgradesDB['os1arsenalloadout'] = {
    name = 'Os-1 Arsenal Loadout',
    xws = 'os1arsenalloadout',
    slot = 'Configuration',
    add_slots = { 'Torpedo', 'Missile' },
    restriction = { faction = { ['galacticempire'] = true }, ship = { ['alphaclassstarwing'] = true } }
}

masterUpgradesDB['xg1assaultconfiguration'] = {
    name = 'Xg-1 Assault Configuration',
    xws = 'xg1assaultconfiguration',
    slot = 'Configuration',
    add_slots = { 'Cannon' },
    restriction = { faction = { ['galacticempire'] = true }, ship = { ['alphaclassstarwing'] = true } }
}

masterUpgradesDB['000'] = {
    name = '0-0-0',
    xws = '000',
    slot = 'Crew',
    add_action = { 'C' },
    restriction = { faction = { ['galacticempire'] = true, ['scumandvillainy'] = true }, keywords = { 'Darth Vader' } }
}

masterUpgradesDB['4lom'] = {
    name = '4-LOM',
    xws = '4lom',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['bobafett'] = {
    name = 'Boba Fett',
    xws = 'bobafett',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['cadbane'] = {
    name = 'Cad Bane',
    xws = 'cadbane',
    slot = 'Crew',
    limited = 1,
    add_action = { 'B' },
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['cikatrovizago'] = {
    name = 'Cikatro Vizago',
    xws = 'cikatrovizago',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['ig88d'] = {
    name = 'IG-88D',
    xws = 'ig88d',
    slot = 'Crew',
    limited = 1,
    add_action = { 'C' },
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['jabbathehutt'] = {
    name = 'Jabba the Hutt',
    xws = 'jabbathehutt',
    slot = 'Crew',
    remove_slots = { 'Crew' },
    charge = 4,
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['ketsuonyo'] = {
    name = 'Ketsu Onyo',
    xws = 'ketsuonyo',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['lattsrazzi'] = {
    name = 'Latts Razzi',
    xws = 'lattsrazzi',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['maul'] = {
    name = 'Maul',
    title = "Original",
    xws = 'maul',
    slot = 'Crew',
    force = 1,
    --restriction = {Func = function(list) faction = {['rebelalliance'] = true,['scumandvillainy'] = true}}
}

masterUpgradesDB['unkarplutt'] = {
    name = 'Unkar Plutt',
    xws = 'unkarplutt',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['zuckuss'] = {
    name = 'Zuckuss',
    xws = 'zuckuss',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['bossk'] = {
    name = 'Bossk',
    xws = 'bossk',
    slot = 'Gunner',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['bt1'] = {
    name = 'BT-1',
    xws = 'bt1',
    slot = 'Gunner',
    restriction = { faction = { ['galacticempire'] = true, ['scumandvillainy'] = true } }
}

masterUpgradesDB['dengar'] = {
    name = 'Dengar',
    xws = 'dengar',
    slot = 'Gunner',
    charge = 1,
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['greedo'] = {
    name = 'Greedo',
    xws = 'greedo',
    slot = 'Gunner',
    charge = 1,
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['genius'] = {
    name = '"Genius"',
    xws = 'genius',
    slot = 'Astromech',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['r5p8'] = {
    name = 'R5-P8',
    xws = 'r5p8',
    slot = 'Astromech',
    charge = 3,
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['r5tk'] = {
    name = 'R5-TK',
    xws = 'r5tk',
    slot = 'Astromech',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['andrasta'] = {
    name = 'Andrasta',
    xws = 'andrasta',
    slot = 'Title',
    add_slots = { 'Payload' },
    restriction = { faction = { ['scumandvillainy'] = true }, ship = { ['firesprayclasspatrolcraft'] = true } }
}

masterUpgradesDB['havoc'] = {
    name = 'Havoc',
    xws = 'havoc',
    slot = 'Title',
    add_slots = { 'Sensor', 'Astromech' },
    remove_slots = { 'Crew' },
    restriction = { faction = { ['scumandvillainy'] = true }, ship = { ['scurrgh6bomber'] = true } }
}

masterUpgradesDB['houndstooth'] = {
    name = "Hound's Tooth",
    xws = 'houndstooth',
    docking = true,
    slot = 'Title',
    restriction = { faction = { ['scumandvillainy'] = true }, ship = { ['yv666lightfreighter'] = true } }
}


masterUpgradesDB['ig2000'] = {
    name = 'IG-2000',
    xws = 'ig2000',
    slot = 'Title',
    restriction = {
        faction = { ['scumandvillainy'] = true },
        ship = { ['aggressorassaultfighter'] = true }
    },
    execute_options = function(list, me)
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
    xws = 'marauder',
    slot = 'Title',
    add_slots = { 'Gunner' },
    restriction = { faction = { ['scumandvillainy'] = true }, ship = { ['firesprayclasspatrolcraft'] = true } }
}

masterUpgradesDB['misthunter'] = {
    name = 'Mist Hunter',
    xws = 'misthunter',
    slot = 'Title',
    limited = 1,
    add_action = { 'BR' },
    add_slots = { 'Cannon' },
    restriction = { faction = { ['scumandvillainy'] = true }, ship = { ['g1astarfighter'] = true } }
}

masterUpgradesDB['punishingone'] = {
    name = 'Punishing One',
    xws = 'punishingone',
    slot = 'Title',
    add_slots = { 'Astromech' },
    remove_slots = { 'Crew' },
    restriction = { faction = { ['scumandvillainy'] = true }, ship = { ['jumpmaster5000'] = true } }
}

masterUpgradesDB['shadowcaster'] = {
    name = 'Shadow Caster',
    xws = 'shadowcaster',
    slot = 'Title',
    restriction = { faction = { ['scumandvillainy'] = true }, ship = { ['lancerclasspursuitcraft'] = true } }
}

masterUpgradesDB['slavei'] = {
    name = 'Slave I',
    xws = 'slavei',
    title = "Boba's ride",
    slot = 'Title',
    add_slots = { 'Torpedo' },
    execute_options = function(list, pid)
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
        faction = { ['scumandvillainy'] = true },
        ship = { ['firesprayclasspatrolcraft'] = true }
    }
}
masterUpgradesDB['virago'] = {
    name = 'Virago',
    xws = 'virago',
    slot = 'Title',
    charge = 2,
    shd = 1,
    add_slots = { 'Modification' },
    restriction = { ship = { ['starviperclassattackplatform'] = true } }
}

masterUpgradesDB['composure'] = {
    name = 'Composure',
    xws = 'composure',
    slot = 'Talent',
    add_action = { 'F' },
}

masterUpgradesDB['chewbacca-crew'] = {
    name = 'Chewbacca',
    xws = 'chewbacca-crew',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['l337'] = {
    name = 'L3-37',
    xws = 'l337',
    dual = true,
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['landocalrissian-crew'] = {
    name = 'Lando Calrissian',
    xws = 'landocalrissian-crew',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['tobiasbeckett'] = {
    name = 'Tobias Beckett',
    xws = 'tobiasbeckett',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['qira'] = {
    name = "Qi'ra",
    xws = 'qira',
    slot = 'Crew',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['agilegunner'] = {
    name = 'Agile Gunner',
    xws = 'agilegunner',
    slot = 'Gunner',
}

masterUpgradesDB['hansolo-gunner'] = {
    name = 'Han Solo',
    xws = 'hansolo-gunner',
    slot = 'Gunner',
    restriction = { faction = { ['scumandvillainy'] = true } }
}

masterUpgradesDB['landosmillenniumfalcon'] = {
    name = "Lando's Millennium Falcon",
    xws = 'landosmillenniumfalcon',
    slot = 'Title',
    restriction = { faction = { ['scumandvillainy'] = true }, ship = { ['customizedyt1300lightfreighter'] = true } }
}

masterUpgradesDB['st321'] = {
    name = 'ST-321',
    xws = 'st321',
    slot = 'Title',
    limited = 1,
    add_action = { 'TL' },
    restriction = { faction = { ['galacticempire'] = true }, ship = { ['lambdaclasst4ashuttle'] = true } }
}

masterUpgradesDB['bombletgenerator'] = {
    name = 'Bomblet Generator',
    xws = 'bombletgenerator',
    slot = 'Payload',
    remove_slots = { 'Payload' },
    bomb = true,
    charge = 2,
    card_back = cardBackDB['Payload Dual']
}

masterUpgradesDB['connernets'] = {
    name = 'Conner Nets',
    xws = 'connernets',
    slot = 'Payload',
    bomb = true,
    charge = 1
}

masterUpgradesDB['protonbombs'] = {
    name = 'Proton Bombs',
    xws = 'protonbombs',
    slot = 'Payload',
    bomb = true,
    charge = 2
}

masterUpgradesDB['proximitymines'] = {
    name = 'Proximity Mines',
    xws = 'proximitymines',
    slot = 'Payload',
    bomb = true,
    charge = 2
}

masterUpgradesDB['seismiccharges'] = {
    name = 'Seismic Charges',
    xws = 'seismiccharges',
    slot = 'Payload',
    bomb = true,
    charge = 2
}

masterUpgradesDB['fanatical'] = {
    name = "Fanatical",
    xws = 'fanatical',
    slot = 'Talent',
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['advancedoptics'] = {
    name = "Advanced Optics",
    xws = 'advancedoptics',
    slot = 'Tech',
}

masterUpgradesDB['hyperspacetrackingdata'] = {
    name = "Hyperspace Tracking Data",
    xws = 'hyperspacetrackingdata',
    slot = 'Tech',
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['patternanalyzer'] = {
    name = "Pattern Analyzer",
    xws = 'patternanalyzer',
    slot = 'Tech',
}

masterUpgradesDB['primedthrusters'] = {
    name = "Primed Thrusters",
    xws = 'primedthrusters',
    slot = 'Tech',
}

masterUpgradesDB['targetingsynchronizer'] = {
    name = "Targeting Synchronizer",
    xws = 'targetingsynchronizer',
    slot = 'Tech',
}

masterUpgradesDB['captainphasma'] = {
    name = "Captain Phasma",
    xws = 'captainphasma',
    slot = 'Crew',
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['generalhux'] = {
    name = "General Hux",
    xws = 'generalhux',
    slot = 'Crew',
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['kyloren'] = {
    name = "Kylo Ren",
    xws = 'kyloren',
    condition = "I'll Show You the Dark Side",
    slot = 'Crew',
    force = 1,
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['pettyofficerthanisson'] = {
    name = "Petty Officer Thanisson",
    xws = 'pettyofficerthanisson',
    slot = 'Crew',
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['supremeleadersnoke'] = {
    name = "Supreme Leader Snoke",
    xws = 'supremeleadersnoke',
    slot = 'Crew',
    remove_slots = { 'Crew' },
    force = 1,
    card_back = cardBackDB['Crew Dual'],
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['specialforcesgunner'] = {
    name = "Special Forces Gunner",
    xws = 'specialforcesgunner',
    slot = 'Gunner',
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['heroic'] = {
    name = "Heroic",
    xws = 'heroic',
    slot = 'Talent',
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['c3po-crew'] = {
    name = "C-3PO",
    xws = 'c3po-crew',
    slot = 'Crew',
    add_action = { 'C' },
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['chewbacca-crew-swz19'] = {
    name = "Chewbacca",
    xws = 'chewbacca-crew-swz19',
    slot = 'Crew',
    charge = 2,
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['hansolo-crew'] = {
    name = "Han Solo",
    xws = 'hansolo-crew',
    slot = 'Crew',
    add_action = { 'E' },
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['rosetico'] = {
    name = "Rose Tico",
    xws = 'rosetico',
    slot = 'Crew',
    add_action = { 'TL' },
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['finn'] = {
    name = "Finn",
    xws = 'finn',
    slot = 'Gunner',
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['paigetico'] = {
    name = "Paige Tico",
    xws = 'paigetico',
    slot = 'Gunner',
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['rey-gunner'] = {
    name = "Rey",
    xws = 'rey-gunner',
    slot = 'Gunner',
    force = 1,
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['bb8'] = {
    name = "BB-8",
    xws = 'bb8',
    slot = 'Astromech',
    add_action = { 'BR' },
    charge = 2,
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['bbastromech'] = {
    name = "BB Astromech",
    xws = 'bbastromech',
    slot = 'Astromech',
    add_action = { 'BR' },
    charge = 2,
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['m9g8'] = {
    name = "M9-G8",
    xws = 'm9g8',
    slot = 'Astromech',
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['r2ha'] = {
    name = "R2-HA",
    xws = 'r2ha',
    slot = 'Astromech',
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['r5x3'] = {
    name = "R5-X3",
    xws = 'r5x3',
    slot = 'Astromech',
    charge = 2,
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['blackone'] = {
    name = "Black One",
    xws = 'blackone',
    slot = 'Title',
    charge = 1,
    restriction = { ship = { ['t70xwing'] = true } }
}

masterUpgradesDB['reysmillenniumfalcon'] = {
    name = "Rey's Millennium Falcon",
    xws = 'reysmillenniumfalcon',
    slot = 'Title',
    restriction = { ['ship'] = { ['scavengedyt1300lightfreighter'] = true } }
}

masterUpgradesDB['integratedsfoils'] = {
    name = "Integrated S-foils",
    xws = 'integratedsfoils',
    dual = true,
    slot = 'Configuration',
    add_action = { 'BR' },
    restriction = { faction = { ['resistance'] = true }, ship = { ['t70xwing'] = true } }
}

masterUpgradesDB['ferrospherepaint'] = {
    name = "Ferrosphere Paint",
    xws = 'ferrospherepaint',
    slot = 'Tech',
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['hate'] = {
    name = "Hate",
    xws = 'hate',
    slot = 'Force Power',
    restriction = { keywords = { 'Dark Side' } }
}

masterUpgradesDB['predictiveshot'] = {
    name = "Predictive Shot",
    xws = 'predictiveshot',
    slot = 'Force Power',
}

masterUpgradesDB['biohexacryptcodes'] = {
    name = "Biohexacrypt Codes",
    xws = 'biohexacryptcodes',
    slot = 'Tech',
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['dedicated'] = {
    name = "Dedicated",
    xws = 'dedicated',
    slot = 'Talent',
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['treacherous'] = {
    name = "Treacherous",
    xws = 'treacherous',
    slot = 'Talent',
    charge = 1,
    restriction = { faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['tv94'] = {
    name = "TV-94",
    xws = 'tv94',
    slot = 'Relay',
    restriction = { faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['kraken'] = {
    name = "Kraken",
    xws = 'kraken',
    slot = 'Relay',
    add_action = { 'C' },
    restriction = { faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['energyshellcharges'] = {
    name = "Energy-Shell Charges",
    xws = 'energyshellcharges',
    slot = 'Missile',
    charge = 1,
    restriction = { faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['soullessone'] = {
    name = "Soulless One",
    xws = 'soullessone',
    slot = 'Title',
    restriction = { ship = { ['belbulab22starfighter'] = true } }
}

masterUpgradesDB['imperviumplating'] = {
    name = "Impervium Plating",
    xws = 'imperviumplating',
    slot = 'Modification',
    charge = 2,
    restriction = { ship = { ['belbulab22starfighter'] = true } }
}


masterUpgradesDB['brilliantevasion'] = {
    name = "Brilliant Evasion",
    xws = 'brilliantevasion',
    slot = 'Force Power',
}

masterUpgradesDB['k2b4'] = {
    name = "K2-B4",
    xws = 'k2b4',
    slot = 'Relay',
    restriction = { faction = { ['separatistalliance'] = true } }
}


masterUpgradesDB['countdooku'] = {
    name = "Count Dooku",
    xws = 'countdooku',
    slot = 'Crew',
    force = 1,
    restriction = { faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['generalgrievous'] = {
    name = "General Grievous",
    xws = 'generalgrievous',
    slot = 'Crew',
    charge = 1,
    restriction = { faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['drk1probedroids'] = {
    name = "DRK-1 Probe Droids",
    xws = 'drk1probedroids',
    condition = 'DRK-1 Probe Droid',
    slot = 'Payload',
    charge = 2,
    restriction = { faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['scimitar'] = {
    name = "Scimitar",
    xws = 'scimitar',
    slot = 'Title',
    limited = 1,
    add_action = { 'CL' },
    restriction = { ship = { ['sithinfiltrator'] = true } }
}


masterUpgradesDB['discordmissiles'] = {
    name = "Discord Missiles",
    xws = 'discordmissiles',
    remotes = { "Buzz Droid Swarm" },
    limited = 3,
    slot = 'Missile',
    charge = 1,
    restriction = {
        faction = { ['separatistalliance'] = true }
    }
}
masterUpgradesDB['battlemeditation'] = {
    name = "Battle Meditation",
    xws = 'battlemeditation',
    slot = 'Force Power',
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['r4pastromech'] = {
    name = "R4-P Astromech",
    xws = 'r4pastromech',
    slot = 'Astromech',
    charge = 2,
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['r4p17'] = {
    name = "R4-P17",
    xws = 'r4p17',
    slot = 'Astromech',
    charge = 2,
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['delta7b'] = {
    name = "Delta-7B",
    xws = 'delta7b',
    slot = 'Configuration',
    shd = 2,
    restriction = { ship = { ['delta7aethersprite'] = true } }
}

masterUpgradesDB['calibratedlasertargeting'] = {
    name = "Calibrated laser Targeting",
    xws = 'calibratedlasertargeting',
    slot = 'Configuration',
    remove_slots = { 'Modification' },
    card_back = cardBackDB.mc,
    restriction = { ship = { ['delta7aethersprite'] = true } }
}

masterUpgradesDB['sparepartscanisters'] = {
    name = "Spare Parts Canisters",
    xws = 'sparepartscanisters',
    slot = 'Modification',
    charge = 1
}

masterUpgradesDB['r4p44'] = {
    name = "R4-P44",
    xws = 'r4p44',
    slot = 'Astromech',
    limited = 1,
    add_action = { 'C' },
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['clonecommandercody'] = {
    name = "Clone Commander Cody",
    xws = 'clonecommandercody',
    slot = 'Gunner',
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['seventhfleetgunner'] = {
    name = "Seventh Fleet Gunner",
    xws = 'seventhfleetgunner',
    slot = 'Gunner',
    charge = 1,
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['synchronizedconsole'] = {
    name = "Synchronized Console",
    xws = 'synchronizedconsole',
    slot = 'Modification',
    add_squad_action = { 'TL' },
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['grapplingstruts'] = {
    name = "Grappling Struts",
    xws = 'grapplingstruts',
    dual = true,
    slot = 'Configuration',
    add_action = { 'Piv' },
    execute_options = function(moves)
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
    xws = 'chancellorpalpatine',
    slot = 'Crew',
    limited = 1,
    add_squad_action = { 'F' },
    force = 1,
    dual = true,
    restriction = { faction = { ['galacticrepublic'] = true, ['separatistalliance'] = true } }
}

masterUpgradesDB['passivesensors'] = {
    name = "Passive Sensors",
    xws = 'passivesensors',
    slot = 'Sensor',
    add_action = { 'C', 'TL' },
    charge = 1,
    restriction = {}
}

masterUpgradesDB['autoblasters'] = {
    name = "Autoblasters",
    xws = 'autoblasters',
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
    xws = 'plasmatorpedoes',
    slot = 'Torpedo',
    charge = 2,
}

masterUpgradesDB['diamondboronmissiles'] = {
    name = "Diamond-Boron Missiles",
    xws = 'diamondboronmissiles',
    slot = 'Missile',
    charge = 3
}
masterUpgradesDB['amilynholdo'] = {
    name = "Amilyn Holdo",
    xws = 'amilynholdo',
    slot = 'Crew',
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['ga97'] = {
    name = "GA-97",
    xws = 'ga97',
    slot = 'Crew',
    limited = 1,
    add_action = { 'C' },
    charge = 5,
    restriction = { faction = { ['resistance'] = true } },
    condition = "It's the Resistance",
}

masterUpgradesDB['kaydelconnix'] = {
    name = "Kaydel Connix",
    xws = 'kaydelconnix',
    slot = 'Crew',
    restriction = {
        faction = { ['resistance'] = true }
    },
    execute_options = function(list, pilotid)
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
        for _, man in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].move_set) do
            local Char = man:find("%d")
            local speed = tonumber(man:sub(Char, Char))
            --print("Man:" .. man .. " lower:" .. lower .. " higher:" .. higher)
            exopt = { man }
            for _, man2 in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].move_set) do
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
    xws = 'korrsella',
    slot = 'Crew',
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['larmadacy'] = {
    name = "Larma D'Acy",
    xws = 'larmadacy',
    slot = 'Crew',
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['leiaorgana-resistance'] = {
    name = "Leia Organa",
    xws = 'leiaorgana-resistance',
    slot = 'Crew',
    remove_slots = { 'Crew' },
    force = 1,
    card_back = cardBackDB['Crew Dual'],
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['pz4co'] = {
    name = "PZ-4CO",
    xws = 'pz4co',
    slot = 'Crew',
    limited = 1,
    add_action = { 'C' },
    restriction = { faction = { ['resistance'] = true } }
}

masterUpgradesDB['r2a6'] = {
    name = "R2-A6",
    xws = 'r2a6',
    slot = 'Astromech',
    execute_options = function(list, pilotid)
        exopts = {}
        if pilotid ~= 0 and pilotid ~= '' then
            for _, man in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].move_set) do
                local Char = man:find("%d")
                local speed = tonumber(man:sub(Char, Char))
                local lower = man:sub(2, Char - 1) .. tostring(speed - 1) .. man:sub(Char + 1)
                local higher = man:sub(2, Char - 1) .. tostring(speed + 1) .. man:sub(Char + 1)
                --print("Man:" .. man .. " lower:" .. lower .. " higher:" .. higher)
                exopt = { man }
                for _, man2 in pairs(masterShipDB[masterPilotDB[pilotid].ship_type].move_set) do
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
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['r2c4'] = {
    name = "R2-C4",
    xws = 'r2c4',
    slot = 'Astromech',
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['ta175'] = {
    name = "TA-175",
    xws = 'ta175',
    slot = 'Relay',
    restriction = { faction = { ['separatistalliance'] = true } }
}

masterUpgradesDB['electroprotonbomb'] = {
    name = "Electro-Proton Bomb",
    xws = 'electroprotonbomb',
    slot = 'Payload',
    bomb = true,
    charge = 1,
    remove_slots = { 'Modification' },
}

masterUpgradesDB['delayedfuses'] = {
    name = "Delayed Fuses",
    xws = 'delayedfuses',
    slot = 'Modification',
}

masterUpgradesDB['angleddeflectors'] = {
    name = "Angled Deflectors",
    xws = 'angleddeflectors',
    slot = 'Modification',
    add_action = { 'R' },
    shd = -1,
    restriction = { size = { small = true, medium = true } }
}

masterUpgradesDB['landingstruts'] = {
    name = "Landing Struts",
    xws = 'landingstruts',
    slot = 'Configuration',
    add_action = { 'Piv' },
    execute_options = function(moves)
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
    restriction = { faction = { ['separatistalliance'] = true }, ship = { ['hyenaclassdroidbomber'] = true } }
}

masterUpgradesDB['foresight'] = {
    name = "Foresight",
    xws = 'foresight',
    slot = 'Force Power',
}

masterUpgradesDB['precognitivereflexes'] = {
    name = "Precognitive Reflexes",
    xws = 'precognitivereflexes',
    slot = 'Force Power',
    restriction = { size = { small = true } }
}

masterUpgradesDB['targetingcomputer'] = {
    name = "Targeting Computer",
    xws = 'targetingcomputer',
    slot = 'Modification',
    add_action = { 'TL' },
}

masterUpgradesDB['snapshot'] = {
    name = "Snap Shot",
    xws = 'snapshot',
    slot = 'Talent',
}

masterUpgradesDB['ensnare'] = {
    name = "Ensnare",
    xws = 'ensnare',
    slot = 'Talent',
    restriction = { ship = { ['nantexclassstarfighter'] = true } }
}

masterUpgradesDB['graviticdeflection'] = {
    name = "Gravitic Deflection",
    xws = 'graviticdeflection',
    slot = 'Talent',
    restriction = { ship = { ['nantexclassstarfighter'] = true } }
}

masterUpgradesDB['c110p'] = {
    name = "C1-10P",
    xws = 'c110p',
    slot = 'Astromech',
    add_action = { 'E' },
    dual = true,
    charge = 2,
    restriction = { faction = { ['galacticrepublic'] = true } }
}


masterUpgradesDB['c3po-republic'] = {
    name = "C-3PO",
    xws = 'c3po-republic',
    slot = 'Crew',
    add_action = { 'C' },
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['ahsokatano'] = {
    name = "Ahsoka Tano",
    xws = 'ahsokatano',
    slot = 'Gunner',
    force = 1,
    restriction = { faction = { ['galacticrepublic'] = true } }
}

masterUpgradesDB['r1j5'] = {
    name = "R1-J5",
    xws = 'r1j5',
    slot = 'Astromech',
    limited = 1,
    charge = 3,
    restriction = { faction = { ['resistance'] = true } }
}


masterUpgradesDB['stabilizedsfoils'] = {
    name = "Stabilized S-Foils",
    xws = 'stabilizedsfoils',
    dual = true,
    slot = 'Configuration',
    add_action = { 'E' },
    restriction = { ship = { ['asf01bwing'] = true } }
}


masterUpgradesDB['k2so'] = {
    name = "K-2SO",
    xws = 'k2so',
    slot = 'Crew',
    limited = 1,
    add_action = { 'C' },
    restriction = { faction = { ['rebelalliance'] = true } }
}

masterUpgradesDB['clustermines'] = {
    name = 'Cluster Mines',
    xws = 'clustermines',
    slot = 'Payload',
    bomb = true,
    charge = 1
}

masterUpgradesDB['ionbombs'] = {
    name = 'Ion Bombs',
    xws = 'ionbombs',
    slot = 'Payload',
    bomb = true,
    charge = 2
}

masterUpgradesDB['coaxiumhyperfuel'] = {
    name = "Coaxium Hyperfuel",
    xws = 'coaxiumhyperfuel',
    slot = 'Illicit',
}

masterUpgradesDB['magpulsewarheads'] = {
    name = "Mag-Pulse Warheads",
    xws = 'magpulsewarheads',
    slot = 'Missile',
    charge = 2
}

masterUpgradesDB['proudtradition'] = {
    name = "Proud Tradition",
    xws = 'proudtradition',
    dual = true,
    slot = 'Talent',
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['deuteriumpowercells'] = {
    name = "Deuterium Power Cells",
    xws = 'deuteriumpowercells',
    slot = 'Tech',
    charge = 2,
    remove_slots = { 'Modification' },
    restriction = { faction = { ['firstorder'] = true } }
}

masterUpgradesDB['kazsfireball'] = {
    name = "Kaz's Fireball",
    xws = 'kazsfireball',
    slot = 'Title',
    restriction = { ship = { ['fireball'] = true } }
}

masterUpgradesDB['deadeyeshot'] = {
    name = "Deadeye Shot",
    xws = 'deadeyeshot',
    slot = 'Talent',
    restriction = {
        size = { small = true, medium = true }
    }
}

masterUpgradesDB['automatedtargetpriority'] = {
    name = "Automated Target Priority",
    xws = 'automatedtargetpriority',
    slot = 'Tech',
    restriction = {
        -- todo int 3 or less
    }
}

masterUpgradesDB['sensorbuoysuite'] = {
    name = "Sensor Buoy Suite",
    xws = 'sensorbuoysuite',
    slot = 'Tech',
    restriction = {
        faction = { ['firstorder'] = true },
        size = { medium = true, large = true }
    },
    remotes = { 'Sensor Buoy (Red)', 'Sensor Buoy (Blue)' }
}

masterUpgradesDB['multimissilepods'] = {
    name = "Multi-Missile Pods",
    xws = 'multimissilepods',
    slot = 'Missile',
    remove_slots = { 'Missile' },
    charge = 5,
    restriction = {},
}

masterUpgradesDB['syncedlasercannons'] = {
    name = "Synced Laser Cannons",
    xws = 'syncedlasercannons',
    slot = 'Cannon',
    remove_slots = { 'Cannon' },
    card_back = cardBackDB['Cannon Dual'],
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
    xws = 'aaylasecura',
    force = 1,
    limited = 1,
    slot = 'Crew',
    restriction = {
        faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['kitfisto'] = {
    name = "Kit Fisto",
    xws = 'kitfisto',
    force = 1,
    limited = 1,
    add_action = { 'E' },
    slot = 'Crew',
    restriction = {
        faction = { ['galacticrepublic'] = true }
    }
}


masterUpgradesDB['plokoon'] = {
    name = "Plo Koon",
    xws = 'plokoon',
    force = 1,
    limited = 1,
    slot = 'Crew',
    add_action = { 'R' },
    restriction = {
        faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['yoda'] = {
    name = "Yoda",
    xws = 'yoda',
    force = 2,
    limited = 1,
    slot = 'Crew',
    restriction = {
        faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['fives'] = {
    name = '"Fives"',
    xws = 'fives',
    limited = 1,
    slot = 'Crew',
    restriction = {
        faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['wolfpack'] = {
    name = "Wolfpack",
    xws = 'wolfpack',
    limited = 1,
    slot = 'Gunner',
    remove_slots = { 'Crew' },
    restriction = {
        faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['ghostcompany'] = {
    name = "Ghost Company",
    xws = 'ghostcompany',
    limited = 1,
    slot = 'Gunner',
    add_action = { 'F' },
    remove_slots = { 'Crew' },
    restriction = {
        faction = { ['galacticrepublic'] = true }
        -- Todo: Add rotate requirement
    }
}

masterUpgradesDB['kalani'] = {
    name = "Kalani",
    xws = 'kalani',
    limited = 1,
    slot = 'Relay',
    add_action = { 'C' },
    charge = 3,
    restriction = {
        faction = { ['separatistalliance'] = true }
    },
}

masterUpgradesDB['commandermalarus'] = {
    name = "Commander Malarus",
    xws = 'commandermalarus',
    dual = true,
    slot = 'Crew',
    limited = 1,
    restriction = {
        faction = { ['firstorder'] = true }
    }
}

masterUpgradesDB['agentterex'] = {
    name = "Agent Terex",
    xws = 'agentterex',
    dual = true,
    slot = 'Crew',
    limited = 1,
    add_squad_action = { 'C' },
    restriction = {
        faction = { ['firstorder'] = true }
    }
}

masterUpgradesDB['commanderpyre'] = {
    name = 'Commander Pyre',
    xws = 'commanderpyre',
    slot = 'Crew',
    limited = 1,
    restriction = {
        faction = { ['firstorder'] = true }
    }
}

masterUpgradesDB['clonecaptainrex'] = {
    name = "Clone Captain Rex",
    xws = 'clonecaptainrex',
    limited = 1,
    slot = 'Gunner',
    restriction = {
        faction = { ['galacticrepublic'] = true }
    }
}

masterUpgradesDB['suppressivegunner'] = {
    name = "Suppressive Gunner",
    xws = 'suppressivegunner',
    slot = 'Gunner',
    restriction = {}
}

masterUpgradesDB['concussionbombs'] = {
    name = "Concussion Bombs",
    xws = 'concussionbombs',
    slot = 'Payload',
    charge = 3,
    card_back = cardBackDB['Payload Dual'],
    restriction = {},
    bomb = true
}


masterUpgradesDB['repulsorliftstabilizers'] = {
    name = "Repulsorlift Stabilizers",
    xws = 'repulsorliftstabilizers',
    dual = true,
    slot = 'Configuration',
    restriction = {
        ship = { ['hmpdroidgunship'] = true }
    },
    execute_options = function()
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
    xws = 'maneuverassistmgk300',
    slot = 'Configuration',
    restriction = {
        ship = { ['tierbheavy'] = true }
    },
}

masterUpgradesDB['targetassistmgk300'] = {
    name = "Target-Assist MGK-300",
    xws = 'targetassistmgk300',
    slot = 'Configuration',
    restriction = {
        ship = { ['tierbheavy'] = true }
    },
}

masterUpgradesDB['ionlimiteroverride'] = {
    name = "Ion Limiter Override",
    xws = 'ionlimiteroverride',
    slot = 'Talent',
    add_action = { 'BR' },
    restriction = {
        keywords = { 'TIE' }
    },
}

masterUpgradesDB['backwardstailslide'] = {
    name = "Backwards Tailslide",
    xws = 'backwardstailslide',
    slot = 'Talent',
    add_action = { 'E' },
    restriction = {
        keywords = { 'X-Wing' }
    },
}

masterUpgradesDB['overdrivethruster'] = {
    name = "Overdrive Thruster",
    xws = 'overdrivethruster',
    limited = 1,
    slot = 'Modification',
    add_action = { '2B', '2BR' },
    restriction = {
        ship = { ['t70xwing'] = true }
    },
}

masterUpgradesDB['r2d2-resistance'] = {
    name = "R2-D2",
    xws = 'r2d2-resistance',
    limited = 1,
    slot = 'Astromech',
    charge = 4,
    restriction = {
        faction = { ['resistance'] = true },
    },
}

masterUpgradesDB['r6d8'] = {
    name = "R6-D8",
    xws = 'r6d8',
    limited = 1,
    slot = 'Astromech',
    restriction = {
        faction = { ['resistance'] = true },
    },
}

masterUpgradesDB['underslungblastercannon'] = {
    name = "Underslung Blaster Cannon",
    xws = 'underslungblastercannon',
    slot = 'Cannon',
    restriction = {
        faction = { ['resistance'] = true },
        ship = { ['t70xwing'] = true }
    },
    arcs = { turret = { name = 'underslung blaster cannon', range = 1, type = { 'singleturret' } } }
}

masterUpgradesDB['starbirdslash'] = {
    name = "Starbird Slash",
    xws = 'starbirdslash',
    slot = 'Talent',
    restriction = {
        keywords = { 'A-Wing' }
    },
    movethrough = true,
}

masterUpgradesDB['extrememaneuvers'] = {
    name = "Extreme Maneuvers",
    xws = 'extrememaneuvers',
    slot = 'Force Power',
    add_action = { 'Dare' },
    restriction = {
        size = { small = true },
        -- Todo: add boost requirement
    },
}

masterUpgradesDB['jedicommander'] = {
    name = "Jedi Commander",
    xws = 'jedicommander',
    slot = 'Command',
    wingleader = true,
    dual = true,
    restriction = {
        ship = { ['eta2actis'] = true, ['delta7aethersprite'] = true }
    },
}

masterUpgradesDB['r2d2-republic'] = {
    name = "R2-D2",
    xws = 'r2d2-republic',
    limited = 1,
    slot = 'Astromech',
    charge = 2,
    restriction = {
        faction = { ['galacticrepublic'] = true },
    }
}

masterUpgradesDB['patience'] = {
    name = "Patience",
    xws = 'patience',
    slot = 'Force Power',
    restriction = { keywords = { 'Light Side' } }
}

masterUpgradesDB['alpha3bbesh'] = {
    name = 'Alpha-3B "Besh"',
    xws = 'alpha3bbesh',
    slot = 'Configuration',
    add_slots = { 'Payload' },
    restriction = {
        ship = {
            ['nimbusclassvwing'] = true,
        },
    }
}

masterUpgradesDB['alpha3eesk'] = {
    name = 'Alpha-3E "Esk"',
    xws = 'alpha3eesk',
    slot = 'Configuration',
    charge = 2,
    restriction = {
        ship = {
            ['nimbusclassvwing'] = true,
        },
    }
}

masterUpgradesDB['thermaldetonators'] = {
    name = 'Thermal Detonators',
    xws = 'thermaldetonators',
    slot = 'Payload',
    charge = 4,
    bomb = true,
}

masterUpgradesDB['r7a7'] = {
    name = 'R7-A7',
    xws = 'r7a7',
    limited = 1,
    slot = 'Astromech',
    charge = 3,
    restriction = {
        faction = { ['galacticrepublic'] = true },
    }
}

masterUpgradesDB['precisionionengines'] = {
    name = 'Precision Ion Engines',
    xws = 'precisionionengines',
    slot = 'Modification',
    charge = 2,
    execute_options = function(list, pid)
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
    xws = 'q7astromech',
    slot = 'Astromech',
    restriction = {
        faction = { ['galacticrepublic'] = true },
    }
}

masterUpgradesDB['interceptbooster'] = {
    name = 'Intercept Booster',
    xws = 'interceptbooster',
    slot = 'Configuration',
    charge = 3,
    add_action = { 'TL' },
    dual = true,
    restriction = {
        faction = { ['separatistalliance'] = true },
        ship = { ['droidtrifighter'] = true }
    }
}

masterUpgradesDB['xx23sthreadtracers'] = {
    name = 'XX-23 S-Thread Tracers',
    xws = 'xx23sthreadtracers',
    slot = 'Missile',
    charge = 2,
}

masterUpgradesDB['margsablclosure'] = {
    name = 'Marg Sabl Closure',
    xws = 'margsablclosure',
    slot = 'Talent',
    restriction = {
        size = {
            small = true,
            medium = true
        },
    },
    movethrough = true,
}

masterUpgradesDB['independentcalculations'] = {
    name = 'Independent Calculations',
    xws = 'independentcalculations',
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
    xws = 'jangofett',
    limited = 1,
    slot = 'Crew',
    restriction = {
        faction = { ['scumandvillainy'] = true, ['separatistalliance'] = true },
    },
}

masterUpgradesDB['zamwesell'] = {
    name = 'Zam Wesell',
    xws = 'zamwesell',
    limited = 1,
    condition = 'Zam Wesell',
    slot = 'Crew',
    charge = 2,
    restriction = {
        faction = { ['scumandvillainy'] = true, ['separatistalliance'] = true },
    },
}

masterUpgradesDB['hondoohnaka'] = {
    name = 'Hondo Ohnaka',
    xws = 'hondoohnaka',
    limited = 1,
    slot = 'Crew',
}

masterUpgradesDB['slavei-swz82'] = {
    name = 'Slave I',
    xws = 'slavei-swz82',
    title = "Jango's ride",
    slot = 'Title',
    add_slots = { 'Gunner' },
    restriction = {
        faction = {
            ['scumandvillainy'] = true,
            ['separatistalliance'] = true
        },
        ship = { ['firesprayclasspatrolcraft'] = true }
    }
}

masterUpgradesDB['bobafett-gunner'] = {
    name = 'Boba Fett',
    xws = 'bobafett-gunner',
    limited = 1,
    slot = 'Gunner',
    restriction = {
        faction = {
            ['scumandvillainy'] = true,
            ['separatistalliance'] = true
        }
    }
}

masterUpgradesDB['weaponssystemsofficer'] = {
    name = 'Weapons Systems Officer',
    xws = 'weaponssystemsofficer',
    slot = 'Gunner',
}

masterUpgradesDB['falsetranspondercodes'] = {
    name = 'False Transponder Codes',
    xws = 'falsetranspondercodes',
    slot = 'Illicit',
    charge = 1,
}

masterUpgradesDB['admiralozzel'] = {
    name = "Admiral Ozzel",
    xws = 'admiralozzel',
    slot = 'Command',
    remove_slots = { 'Crew' },
    restriction = {
        faction = { ['galacticempire'] = true },
        size = { huge = true }
    }
}
masterUpgradesDB['azmorigan'] = {
    name = "Azmorigan",
    xws = 'azmorigan',
    slot = 'Command',
    remove_slots = { 'Crew' },
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        faction = { ['scumandvillainy'] = true },
        size = { huge = true }
    }
}
masterUpgradesDB['captainneeda'] = {
    name = "Captain Needa",
    xws = 'captainneeda',
    slot = 'Command',
    remove_slots = { 'Crew' },
    charge = 4,
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        faction = { ['galacticempire'] = true },
        size = { huge = true }
    }
}
masterUpgradesDB['carlistrieekan'] = {
    name = "Carlist Rieekan",
    xws = 'carlistrieekan',
    slot = 'Command',
    add_action = { 'E' },
    remove_slots = { 'Crew' },
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        faction = { ['rebelalliance'] = true },
        size = { huge = true }
    }
}
masterUpgradesDB['jandodonna'] = {
    name = "Jan Dodonna",
    xws = 'jandodonna',
    slot = 'Command',
    remove_slots = { 'Crew' },
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        faction = { ['rebelalliance'] = true },
        size = { huge = true }
    }
}
masterUpgradesDB['raymusantilles'] = {
    name = "Raymus Antilles",
    xws = 'raymusantilles',
    slot = 'Command',
    remove_slots = { 'Crew' },
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        faction = { ['rebelalliance'] = true },
        size = { huge = true }
    }
}
masterUpgradesDB['stalwartcaptain'] = {
    name = "Stalwart Captain",
    xws = 'stalwartcaptain',
    slot = 'Command',
    remove_slots = { 'Crew' },
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        size = { huge = true }
    }
}
masterUpgradesDB['agentoftheempire'] = {
    name = "Agent of the Empire",
    xws = 'agentoftheempire',
    wingleader = true,
    slot = 'Command',
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = { ['tieadvancedx1'] = true, ['tieadvancedv1'] = true }
    }
}
masterUpgradesDB['firstorderelite'] = {
    name = "First Order Elite",
    xws = 'firstorderelite',
    wingleader = true,
    slot = 'Command',
    restriction = {
        faction = { ['firstorder'] = true },
        ship = { ['tiesffighter'] = true, ['tievnsilencer'] = true }
    }
}
masterUpgradesDB['veteranwingleader'] = {
    name = "Veteran Wing Leader",
    xws = 'veteranwingleader',
    wingleader = true,
    slot = 'Command',
    restriction = {
        size = { small = true }
    }
}
masterUpgradesDB['dreadnoughthunter'] = {
    name = "Dreadnought hunter",
    xws = 'dreadnoughthunter',
    slot = 'Command',
    restriction = {
        size = { small = true },
        initiative_greater_than = 3
    }
}

masterUpgradesDB['ioncannonbattery'] = {
    name = "Ion Cannon Battery",
    xws = 'ioncannonbattery',
    slot = 'Hardpoint',
    dual = true,
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/IonCannonBattery(Offline).png',
    restriction = {},
    arcs = { turret = { name = 'ion cannon', range = 4, type = { 'singleturret' }, ion = true } }
}

masterUpgradesDB['targetingbattery'] = {
    name = "Targeting Battery",
    xws = 'targetingbattery',
    slot = 'Hardpoint',
    dual = true,
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/TargetingBattery(Offline).png',
    restriction = {},
    arcs = { turret = { name = 'targeting', range = 5, type = { 'singleturret' } } }
}

masterUpgradesDB['ordnancetubes'] = {
    name = "Ordnance Tubes",
    xws = 'ordnancetubes',
    slot = 'Hardpoint',
    dual = true,
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/OrdnanceTubes(Offline).png',
    restriction = {}
}

masterUpgradesDB['pointdefensebattery'] = {
    name = "Point-Defense Battery",
    xws = 'pointdefensebattery',
    slot = 'Hardpoint',
    dual = true,
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/PointDefenseBattery(Offline).png',
    restriction = {},
    arcs = { turret = { name = 'point defence', range = 2, type = { 'doubleturret' } } }
}

masterUpgradesDB['turbolaserbattery'] = {
    name = "Turbolaser Battery",
    xws = 'turbolaserbattery',
    slot = 'Hardpoint',
    dual = true,
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/EpicCards/TurbolaserBattery(Offline).png',
    restriction = {
        -- TODO: Add restriction energy 5 or higher
    },
    arcs = { turret = { name = 'turbolaser', range = 5, type = { 'singleturret' } } }
}

masterUpgradesDB['bombardmentspecialists'] = {
    name = "Bombardment Specialists",
    xws = 'bombardmentspecialists',
    slot = 'Team',
    add_action = { 'TL', 'C' },

    restriction = {}
}

masterUpgradesDB['commsteam'] = {
    name = "Comms Team",
    xws = 'commsteam',
    slot = 'Team',
    add_action = { 'C' },
    restriction = {}
}

masterUpgradesDB['igrmdroids'] = {
    name = "IG-RM Droids",
    xws = 'igrmdroids',
    slot = 'Team',
    add_action = { 'C' },
    restriction = {
        faction = { ['scumandvillainy'] = true }
    }
}

masterUpgradesDB['gunneryspecialists'] = {
    name = "Gunnery Specialists",
    xws = 'gunneryspecialists',
    slot = 'Team',
    add_action = { 'C' },
    restriction = {}
}

masterUpgradesDB['damagecontrolteam'] = {
    name = "Damage Control Team",
    xws = 'damagecontrolteam',
    slot = 'Team',
    add_action = { 'R', 'C' },
    restriction = {}
}

masterUpgradesDB['ordnanceteam'] = {
    name = "Ordnance Team",
    xws = 'ordnanceteam',
    slot = 'Team',
    add_action = { 'C' },

    restriction = {}
}

masterUpgradesDB['sensorexperts'] = {
    name = "Sensor Experts",
    xws = 'sensorexperts',
    slot = 'Team',
    add_action = { 'TL', 'C' },
    restriction = {}
}

masterUpgradesDB['quickreleaselocks'] = {
    name = "Quick-Release Locks",
    xws = 'quickreleaselocks',
    slot = 'Illicit',
    charge = 2,
    restriction = {
        size = { huge = true }
    }
}
masterUpgradesDB['saboteursmap'] = {
    name = "Saboteur's Map",
    xws = 'saboteursmap',
    slot = 'Illicit',
    restriction = {
        size = { huge = true }
    }
}
masterUpgradesDB['scannerbaffler'] = {
    name = "Scanner Baffler",
    xws = 'scannerbaffler',
    slot = 'Illicit',
    restriction = {
        size = { huge = true }
    }
}
-- Cargo
masterUpgradesDB['adaptiveshields'] = {
    name = "Adaptive Shields",
    xws = 'adaptiveshields',
    slot = 'Cargo',
    restriction = {}
}
masterUpgradesDB['boostedscanners'] = {
    name = "Boosted Scanners",
    xws = 'boostedscanners',
    slot = 'Cargo',
    restriction = {}
}

masterUpgradesDB['optimizedpowercore'] = {
    name = "Optimized Power Core",
    xws = 'optimizedpowercore',
    slot = 'Cargo',
    restriction = {}
}

masterUpgradesDB['tibannareserves'] = {
    name = "Tibanna Reserves",
    xws = 'tibannareserves',
    slot = 'Cargo',
    charge = 3,
    restriction = {}
}

masterUpgradesDB['torynfarr'] = {
    name = "Toryn Farr",
    xws = 'torynfarr',
    slot = 'Crew',
    add_action = { 'TL' },
    restriction = {
        faction = { ['rebelalliance'] = true },
        size = { huge = true }
    }
}

masterUpgradesDB['dodonnaspride'] = {
    name = "Dodonna's Pride",
    xws = 'dodonnaspride',
    limited = 1,
    slot = 'Title',
    add_action = { 'E', 'F' },
    shd = -2,
    add_slots = { 'Team', 'Cargo' },
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['jainaslight'] = {
    name = "Jaina's Light",
    xws = 'jainaslight',
    slot = 'Title',
    limited = 1,
    shd = 1,
    energy = -1,
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['liberator'] = {
    name = "Liberator",
    xws = 'liberator',
    slot = 'Title',
    energy = 1,
    docking = true,
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['tantiveiv'] = {
    name = "Tantive IV",
    xws = 'tantiveiv',
    slot = 'Title',
    add_slots = { 'Crew', 'Crew' },
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['cr90corvette'] = true }
    }
}

masterUpgradesDB['thunderstrike'] = {
    name = "Thunderstrike",
    xws = 'thunderstrike',
    slot = 'Title',
    add_slots = { 'Gunner' },
    shd = -3,
    hull = 3,
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['cr90corvette'] = true }
    }
}
masterUpgradesDB['brighthope'] = {
    name = "Bright Hope",
    xws = 'brighthope',
    slot = 'Title',
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['gr75mediumtransport'] = true }
    }
}
masterUpgradesDB['luminous'] = {
    name = "Luminous",
    xws = 'luminous',
    slot = 'Title',
    shd = -1,
    energy = 2,
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['gr75mediumtransport'] = true }
    }
}
masterUpgradesDB['quantumstorm'] = {
    name = "Quantum Storm",
    xws = 'quantumstorm',
    slot = 'Title',
    energy = 1,
    add_slots = { 'Team', 'Cargo' },
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['gr75mediumtransport'] = true }
    }
}
masterUpgradesDB['assailer'] = {
    name = "Assailer",
    xws = 'assailer',
    slot = 'Title',
    limited = 1,
    shd = -2,
    hull = 2,
    add_slots = { 'Gunner' },
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}
masterUpgradesDB['corvus'] = {
    name = "Corvus",
    xws = 'corvus',
    slot = 'Title',
    limited = 1,
    add_action = { 'C' },
    docking = true,
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}

masterUpgradesDB['impetuous'] = {
    name = "Impetuous",
    xws = 'impetuous',
    slot = 'Title',
    limited = 1,
    shd = -2,
    energy = 2,
    add_slots = { 'Crew' },
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}
masterUpgradesDB['instigator'] = {
    name = "Instigator",
    xws = 'instigator',
    slot = 'Title',
    limited = 1,
    add_slots = { 'Team' },
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = { ['raiderclasscorvette'] = true }
    }
}
masterUpgradesDB['bloodcrow'] = {
    name = "Blood Crow",
    xws = 'bloodcrow',
    slot = 'Title',
    limited = 1,
    energy = 2,
    shd = -1,
    add_slots = { 'Gunner' },
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['requiem'] = {
    name = "Requiem",
    xws = 'requiem',
    slot = 'Title',
    limited = 1,
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['suppressor'] = {
    name = "Suppressor",
    xws = 'suppressor',
    slot = 'Title',
    limited = 1,
    shd = 2,
    hull = -2,
    add_slots = { 'Sensor' },
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['vector'] = {
    name = "Vector",
    xws = 'vector',
    slot = 'Title',
    limited = 1,
    add_squad_action = { 'E', 'B' },
    add_slots = { 'Crew', 'Cargo' },
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = { ['gozanticlasscruiser'] = true }
    }
}

masterUpgradesDB['brokenhorn'] = {
    name = "Broken Horn",
    xws = 'brokenhorn',
    slot = 'Title',
    limited = 1,
    add_slots = { 'Crew', 'Illicit' },
    restriction = {
        faction = { ['scumandvillainy'] = true },
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['merchantone'] = {
    name = "Merchant One",
    xws = 'merchantone',
    slot = 'Title',
    limited = 1,
    add_action = { 'E' },
    add_slots = { 'Turret', 'Team', 'Cargo' },
    restriction = {
        faction = { ['scumandvillainy'] = true },
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['insatiableworrt'] = {
    name = "Insatiable Worrt",
    xws = 'insatiableworrt',
    slot = 'Title',
    shd = -1,
    energy = -1,
    hull = 3,
    add_slots = { 'Cargo' },
    restriction = {
        faction = { ['scumandvillainy'] = true },
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['corsairrefit'] = {
    name = "Corsair Refit",
    xws = 'corsairrefit',
    slot = 'Configuration',
    shd = -2,
    energy = 1,
    hull = 2,
    add_slots = { 'Cannon', 'Turret', 'Missile' },
    restriction = {
        ship = { ['croccruiser'] = true }
    }
}

masterUpgradesDB['strategiccommander'] = {
    name = "Strategic Commander",
    xws = 'strategiccommander',
    slot = 'Command',
    remove_slots = { 'Crew' },
    card_back =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic+Crew.png',
    restriction = {
        size = { huge = true }
    }
}

masterUpgradesDB['vectoredcannonsrz1'] = {
    name = "Vectored Cannons (RZ-1)",
    xws = 'vectoredcannonsrz1',
    slot = 'Configuration',
    restriction = {
        ship = { ['rz1awing'] = true }
    },
    arcs = { turret = { name = 'primary', type = { 'front', 'back' } } },
}

masterUpgradesDB['b6bladewingprototype1'] = {
    name = "B6 Blade Wing Prototype",
    xws = 'b6bladewingprototype1',
    slot = 'Title',
    limited = 1,
    add_slots = { 'Gunner' },
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['asf01bwing'] = true }
    },
}

masterUpgradesDB['b6bladewingprototype'] = {
    name = "B6 Blade Wing Prototype",
    xws = 'b6bladewingprototype',
    slot = 'Command',
    limited = 1,
    add_slots = { 'Gunner' },
    remove_slots = { 'Title' },
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['asf01bwing'] = true }
    },
}

masterUpgradesDB['hopeful'] = {
    name = "Hopeful",
    xws = 'hopeful',
    slot = 'Talent',
    restriction = {
        faction = { ['rebelalliance'] = true }
    },
    add_action = { 'B', 'F' },
}

masterUpgradesDB['sabinewren-gunner'] = {
    name = "Sabine Wren",
    xws = 'sabinewren-gunner',
    slot = 'Gunner',
    limited = 1,
    restriction = {
        faction = { ['rebelalliance'] = true }
    },
}

masterUpgradesDB['phoenixsquadron'] = {
    name = "Phoenix Squadron",
    xws = 'phoenixsquadron',
    slot = 'Command',
    limited = 1,
    wingleader = true,
    dual = true,
    restriction = {
        faction = { ['rebelalliance'] = true },
        ship = { ['vcx100lightfreighter'] = true }
    },
}

masterUpgradesDB['disciplined'] = {
    name = "Disciplined",
    xws = 'disciplined',
    slot = 'Talent',
    restriction = {
        faction = { ['galacticempire'] = true }
    },
    add_action = { 'TL', 'BR' },
}


masterUpgradesDB['sensitivecontrols'] = {
    name = "Sensitive Controls",
    xws = 'sensitivecontrols',
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
    xws = 'skystrikeacademyclass',
    slot = 'Command',
    limited = 2,
    wingleader = true,
    dual = true,
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = {
            ['tielnfighter'] = true,     --TIE fighter
            ['tieininterceptor'] = true, --TIE interceptor
        }
    },
}

masterUpgradesDB['shadowwing'] = {
    name = "Shadow Wing",
    xws = 'shadowwing',
    slot = 'Command',
    limited = 1,
    wingleader = true,
    dual = true,
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = {
            ['tielnfighter'] = true,     --TIE fighter
            ['tieininterceptor'] = true, --TIE interceptor
            ['tiesabomber'] = true,      --TIE bomber
        }
    },
}

masterUpgradesDB['gamutkey'] = {
    name = "Gamut Key",
    xws = 'gamutkey',
    slot = 'Crew',
    charge = 2,
    add_action = { 'TL' },
    restriction = {
        faction = { ['scumandvillainy'] = true }
    }
}


masterUpgradesDB['cutthroat'] = {
    name = "Cutthroat",
    xws = 'cutthroat',
    slot = 'Talent',
    restriction = {
        faction = { ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['bounty'] = {
    name = "Bounty",
    xws = 'bounty',
    dual = true,
    slot = 'Command',
    restriction = {
        faction = { ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['initforthemoney'] = {
    name = "In It For The Money",
    xws = 'initforthemoney',
    dual = true,
    slot = 'Command',
    restriction = {
        faction = { ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['interloperturn'] = {
    name = "Interloper Turn",
    xws = 'interloperturn',
    slot = 'Talent',
    restriction = {
        ship = { ['tiededefender'] = true }
    },
    add_action = { 'TL', 'BR' },
}

masterUpgradesDB['protectorategleb'] = {
    name = "Protectorate Gleb",
    xws = 'protectorategleb',
    slot = 'Crew',
    restriction = {
        faction = { ['galacticempire'] = true, ['scumandvillainy'] = true, ['firstorder'] = true }
    }
}

masterUpgradesDB['r4b11'] = {
    name = "R4-B11",
    xws = 'r4b11',
    slot = 'Astromech',
    restriction = {
        faction = { ['scumandvillainy'] = true }
    }
}

masterUpgradesDB['tiedefenderelite'] = {
    name = "TIE Defender Elite",
    xws = 'tiedefenderelite',
    slot = 'Configuration',
    restriction = {
        faction = { ['galacticempire'] = true },
        ship = { ['tiededefender'] = true }
    }
}

masterUpgradesDB['tierfonbellyrun'] = {
    name = "Tierfon Belly Run",
    xws = 'tierfonbellyrun',
    slot = 'Talent',
    restriction = {
        ship = { ['btla4ywing'] = true }
    }
}


masterUpgradesDB['asajjventress'] = {
    name = "Asajj Ventress",
    xws = 'asajjventress',
    force = 1,
    slot = 'Command',
    remove_slots = { 'Crew' },
    limited = 1,
    add_action = { "F" },
    restriction = {
        size = { huge = true },
        faction = { ['scumandvillainy'] = true, ['separatistalliance'] = true }
    }
}

masterUpgradesDB['rifftamson'] = {
    name = "Riff Tamson",
    xws = 'rifftamson',
    slot = 'Command',
    remove_slots = { 'Crew' },
    limited = 1,
    restriction = {
        size = { huge = true },
        faction = { ['separatistalliance'] = true }
    }
}

masterUpgradesDB['generalgrievous-command'] = {
    name = "General Grievous",
    xws = 'generalgrievous-command',
    slot = 'Command',
    remove_slots = { 'Crew' },
    limited = 1,
    restriction = {
        size = { huge = true },
        faction = { ['separatistalliance'] = true }
    }
}

masterUpgradesDB['tractortechnicians'] = {
    name = "Tractor Technicians",
    xws = 'tractortechnicians',
    slot = 'Team',
}

masterUpgradesDB['hondoohnaka-command'] = {
    name = "Hondo Ohnaka",
    xws = 'hondoohnaka-command',
    slot = 'Command',
    limite = 1,
    remove_slots = { 'Crew' },
    charge = 2,
    restriction = {
        size = { huge = true },
    }
}

masterUpgradesDB['corsaircrew'] = {
    name = "Corsair Crew",
    xws = 'corsaircrew',
    slot = 'Team',
    remove_slots = { 'Gunner' },
    restriction = {
        faction = { ['scumandvillainy'] = true },
    }
}

masterUpgradesDB['martuuk'] = {
    name = "Mar Tuuk",
    xws = 'martuuk',
    slot = 'Command',
    limited = 1,
    remove_slots = { 'Crew' },
    restriction = {
        faction = { ['separatistalliance'] = true },
        size = { huge = true },
    }
}

masterUpgradesDB['zealouscaptain'] = {
    name = "Zealous Captain",
    xws = 'zealouscaptain',
    slot = 'Command',
    limited = 1,
    remove_slots = { 'Crew' },
    restriction = {
        size = { huge = true },
    }
}

masterUpgradesDB['tractortentacles'] = {
    name = "Tractor Tentacles",
    xws = 'tractortentacles',
    slot = 'Hardpoint',
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['drillbeak'] = {
    name = "Drill Beak",
    xws = 'drillbeak',
    slot = 'Hardpoint',
    remove_slots = { 'Cargo' },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['enhancedpropulsion'] = {
    name = "Enhanced Propulsion",
    xws = 'enhancedpropulsion',
    slot = 'Hardpoint',
    remove_slots = { 'Cargo' },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['protoncannonbattery'] = {
    name = "Proton Cannon Battery",
    xws = 'protoncannonbattery',
    slot = 'Hardpoint',
    remove_slots = { 'Cargo' },
    restriction = {
        size = { huge = true },
    }
}

masterUpgradesDB['droidcrew'] = {
    name = "Droid Crew",
    xws = 'droidcrew',
    slot = 'Team',
    add_action = { 'C', 'TL' },
    restriction = {
        faction = { ['separatistalliance'] = true },
    }
}

masterUpgradesDB['grappler'] = {
    name = "Grappler",
    xws = 'grappler',
    limited = 1,
    slot = 'Title',
    shield = -1,
    hull = 2,
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
    }
}

masterUpgradesDB['nautolansrevenge'] = {
    name = "Nautolan's Revenge",
    xws = 'nautolansrevenge',
    slot = 'Title',
    limited = 1,
    shield = 1,
    hull = -2,
    energy = 1,
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
        faction = { ['scumandvillainy'] = true }
    }
}

masterUpgradesDB['neimoidiangrasp'] = {
    name = "Neimoidian Grasp",
    xws = 'neimoidiangrasp',
    slot = 'Title',
    limited = 1,
    hull = -2,
    add_action = { "E" },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
        faction = { ['separatistalliance'] = true }
    }
}

masterUpgradesDB['trident'] = {
    name = "Trident",
    xws = 'trident',
    slot = 'Title',
    limited = 1,
    energy = 1,
    add_action = { "E" },
    restriction = {
        ship = { ['tridentclassassaultship'] = true },
        faction = { ['separatistalliance'] = true }
    }
}

masterUpgradesDB['trackingtorpedoes'] = {
    name = "Tracking Torpedoes",
    xws = 'trackingtorpedoes',
    slot = 'Torpedo',
    limited = 1,
    charge = 3,
    restriction = {
        size = { huge = true }
    }
}

masterUpgradesDB['feedbackping'] = {
    name = "Feedback Ping",
    xws = 'feedbackping',
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
    xws = 'sensorscramblers',
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
    xws = 'enhancedjammingsuite',
    slot = 'Configuration',
    remove_slots = { 'Tech' },
    restriction = {
        ship = {
            ['tiewiwhispermodifiedinterceptor'] = true, -- Tie Whisper
        },
    }
}

masterUpgradesDB['l4er5'] = {
    name = "L4E-R5",
    xws = 'l4er5',
    slot = 'Astromech',
    limited = 1,
    add_action = { 'C' },
    restriction = {
        faction = { ['resistance'] = true }
    },
}

masterUpgradesDB['overtunedmodulators'] = {
    name = "Overtuned Modulators",
    xws = 'overtunedmodulators',
    slot = 'Illicit',
    charge = 1,
    add_action = { 'C' },
}

masterUpgradesDB['wartimeloadout'] = {
    name = "Wartime Loadout",
    xws = 'wartimeloadout',
    slot = 'Configuration',
    remove_slots = { 'Modification' },
    add_slots = { 'Torpedo', 'Missile' },
    shd = 2,
    add_action = { 'TL' },
    restriction = {
        ship = {
            ['btanr2ywing'] = true, -- Res Y-Wing
        },
    }
}

masterUpgradesDB['watchfulastromech'] = {
    name = "Watchful Astromech",
    xws = 'watchfulastromech',
    slot = 'Astromech',
    add_action = { 'C' },
}

masterUpgradesDB['dt798'] = {
    name = "DT-798",
    xws = 'dt798',
    slot = 'Gunner',
    restriction = {
        faction = { ['firstorder'] = true }
    },
}

masterUpgradesDB['electrochaffmissiles'] = {
    name = "Electro-Chaff Missiles",
    xws = 'electrochaffmissiles',
    limited = 2,
    slot = 'Missile',
    charge = 1,
    bomb = true,
    remove_slots = { 'Payload' },
}

masterUpgradesDB['firstorderordnancetech'] = {
    name = "First Order Ordnance Tech",
    xws = 'firstorderordnancetech',
    slot = 'Gunner',
    add_action = { 'TL' },
    restriction = {
        faction = { ['firstorder'] = true }
    },
}

masterUpgradesDB['babufrik'] = {
    name = "Babu Frik",
    xws = 'babufrik',
    limited = 1,
    charge = 3,
    slot = 'Illicit',
    restriction = {
        faction = { ['scumandvillainy'] = true, ['resistance'] = true }
    },
}

masterUpgradesDB['compassion'] = {
    name = "Compassion",
    xws = 'compassion',
    slot = 'Force Power',
    restriction = {
        keywords = { 'Light Side' }
    },
}

masterUpgradesDB['malice'] = {
    name = "Malice",
    xws = 'malice',
    slot = 'Force Power',
    restriction = {
        keywords = { 'Dark Side' }
    },
}

masterUpgradesDB['shatteringshot'] = {
    name = "Shattering Shot",
    xws = 'shatteringshot',
    slot = 'Force Power',
}

-- Pride of Mandalore reinforcement pack

masterUpgradesDB['ahsokatano-crew'] = {
    name = "Ahsoka Tano",
    limited = 1,
    xws = 'ahsokatano-crew',
    slot = 'Crew',
    force = 1,
    add_squad_action = { 'F' },
    restriction = {
        faction = { ['scumandvillainy'] = true, ['galacticrepublic'] = true }
    },
}

masterUpgradesDB['primeministeralmec'] = {
    name = "Prime Minister Almec",
    limited = 1,
    xws = 'primeministeralmec',
    slot = 'Crew',
    dual = true,
    add_squad_action = { 'C' },
    restriction = {
        faction = { ['scumandvillainy'] = true, ['galacticrepublic'] = true }
    },
}

masterUpgradesDB['bokatankryze'] = {
    name = "Bo-Katan Kryze",
    limited = 1,
    xws = 'bokatankryze',
    slot = 'Crew',
    restriction = {
        faction = { ['galacticrepublic'] = true, ['separatistalliance'] = true }
    },
}

masterUpgradesDB['bokatankryze-rebel-scum'] = {
    name = "Bo-Katan Kryze",
    limited = 1,
    xws = 'bokatankryze-rebel-scum',
    slot = 'Crew',
    restriction = {
        faction = { ['rebelalliance'] = true, ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['korkiekryze'] = {
    name = "Korkie Kryze",
    limited = 1,
    xws = 'korkiekryze',
    slot = 'Crew',
    restriction = {
        faction = { ['galacticrepublic'] = true }
    },
}

masterUpgradesDB['maul-crew'] = {
    name = "Maul",
    title = "Mandalore",
    limited = 1,
    xws = 'maul-crew',
    slot = 'Crew',
    remove_slots = { 'Crew' },
    add_slots = { 'Illicit' },
    force = 1,
    restriction = {
        faction = { ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['previzsla'] = {
    name = "Pre Vizsla",
    limited = 1,
    xws = 'previzsla',
    slot = 'Crew',
    restriction = {
        faction = { ['scumandvillainy'] = true, ['separatistalliance'] = true }
    },
}

masterUpgradesDB['rookkast'] = {
    name = "Rook Kast",
    limited = 1,
    xws = 'rookkast',
    slot = 'Crew',
    add_action = { 'TL' },
    restriction = {
        faction = { ['scumandvillainy'] = true }
    },
}

masterUpgradesDB['savageopress'] = {
    name = "Savage Opress",
    limited = 1,
    force = 1,
    xws = 'savageopress',
    slot = 'Crew',
    restriction = {
        faction = { ['scumandvillainy'] = true, ['separatistalliance'] = true }
    },
}

masterUpgradesDB['talmerrik'] = {
    name = "Tal Merrik",
    limited = 1,
    xws = 'talmerrik',
    slot = 'Crew',
    restriction = {
        faction = { ['separatistalliance'] = true }
    },
    condition = "False Friend",
}

masterUpgradesDB['sabinewren-crew'] = {
    name = "Sabine Wren",
    limited = 1,
    xws = 'sabinewren-crew',
    slot = 'Crew',
    restriction = {
        faction = { ['rebelalliance'] = true },
        size = { small = true, medium = true, large = true }
    },
    condition = "Trials of the Darksaber",
}

masterUpgradesDB['captainhark'] = {
    name = "Captain Hark",
    limited = 1,
    xws = 'captainhark',
    slot = 'Crew',
    charge = 2,
    restriction = {
        faction = { ['galacticempire'] = true },
    },
}

masterUpgradesDB['fennrau'] = {
    name = "Fenn Rau",
    limited = 1,
    xws = 'fennrau',
    slot = 'Crew',
    restriction = {
        faction = { ['rebelalliance'] = true, ['scumandvillainy'] = true },
    },
}

masterUpgradesDB['garsaxon'] = {
    name = "Gar Saxon",
    limited = 1,
    xws = 'garsaxon',
    slot = 'Crew',
    restriction = {
        faction = { ['galacticempire'] = true },
    },
}

masterUpgradesDB['obiwankenobi'] = {
    name = "Obi-Wan Kenobi",
    limited = 1,
    xws = 'obiwankenobi',
    slot = 'Crew',
    force = 1,
    restriction = {
        faction = { ['galacticrepublic'] = true },
    },
}

masterUpgradesDB['satinekryze'] = {
    name = "Satine Kryze",
    limited = 1,
    xws = 'satinekryze',
    slot = 'Crew',
    charge = 2,
    restriction = {
        faction = { ['galacticrepublic'] = true },
    },
}

masterUpgradesDB['kuiil'] = {
    name = "Kuiil",
    limited = 1,
    xws = 'kuiil',
    slot = 'Crew',
    restriction = {
        faction = { ['scumandvillainy'] = true },
    },
}

masterUpgradesDB['tristanwren'] = {
    name = "Tristan Wren",
    limited = 1,
    xws = 'tristanwren',
    slot = 'Crew',
    charge = 1,
    restriction = {
        faction = { ['rebelalliance'] = true },
        keywords = { 'Gar Saxon' }
    },
}

masterUpgradesDB['ursawren'] = {
    name = "Ursa Wren",
    limited = 1,
    xws = 'ursawren',
    slot = 'Crew',
    restriction = {
        faction = { ['rebelalliance'] = true },
    },
}

masterUpgradesDB['garsaxon-gunner'] = {
    name = "Gar Saxon",
    limited = 1,
    xws = 'garsaxon-gunner',
    slot = 'Gunner',
    restriction = {
        faction = { ['scumandvillainy'] = true },
        size = { large = true, huge = true }
    },
}

masterUpgradesDB['tibersaxon'] = {
    name = "Tiber Saxon",
    limited = 1,
    xws = 'tibersaxon',
    slot = 'Gunner',
    charge = 2,
    restriction = {
        faction = { ['galacticempire'] = true }
    },
}

masterUpgradesDB['ursawren-gunner'] = {
    name = "Ursa Wren",
    limited = 1,
    xws = 'ursawren-gunner',
    slot = 'Gunner',
    restriction = {
        faction = { ['galacticrepublic'] = true, ['separatistalliance'] = true }
    },
}


masterUpgradesDB['clantraining'] = {
    name = "Clan Training",
    xws = 'clantraining',
    slot = 'Talent',
    charge = 1,
    restriction = {
        keywords = { 'Mandalorian' }
    },
}

masterUpgradesDB['blazerbomb'] = {
    name = "Blazer Bomb",
    xws = 'blazerbomb',
    slot = 'Payload',
    charge = 1,
    bomb = true,
}

masterUpgradesDB['beskarreinforcedplating'] = {
    name = "Beskar Reinforced Plating",
    xws = 'beskarreinforcedplating',
    slot = 'Modification',
    charge = 2,
    restriction = {
        keywords = { 'Mandalorian' }
    },
}

masterUpgradesDB['mandalorianoptics'] = {
    name = "Mandalorian Optics",
    xws = 'mandalorianoptics',
    slot = 'Modification',
    charge = 2,
    restriction = {
        keywords = { 'Mandalorian' }
    },
}

masterUpgradesDB['gauntlet'] = {
    name = "Gauntlet",
    xws = 'gauntlet',
    limited = 1,
    slot = 'Title',
    remove_slots = { 'Configuration' },
    add_slots = { 'Crew' },
    charge = 2,
    restriction = {
        faction = { ['galacticrepublic'] = true, ['separatistalliance'] = true },
        ship = { ['gauntletfighter'] = true }
    }
}

masterUpgradesDB['nightbrother'] = {
    name = "Nightbrother",
    xws = 'nightbrother',
    limited = 1,
    slot = 'Title',
    remove_slots = { 'Configuration' },
    add_slots = { 'Crew' },
    charge = 2,
    restriction = {
        faction = { ['rebelalliance'] = true, ['scumandvillainy'] = true },
        ship = { ['gauntletfighter'] = true }
    }
}

masterUpgradesDB['razorcrest'] = {
    name = "Razor Crest",
    xws = 'razorcrest',
    limited = 1,
    slot = 'Title',
    add_action = { 'E', 'BR' },
    restriction = {
        ship = { ['st70assaultship'] = true }
    }
}

masterUpgradesDB['trackingfob'] = {
    name = "Tracking Fob",
    xws = 'trackingfob',
    limited = 3,
    slot = 'Illicit',
    restriction = {
        keywords = { 'Bounty Hunter' }
    },
    condition = "Marked for Elimination",
}

masterUpgradesDB['ig11'] = {
    name = "IG-11",
    xws = 'ig11',
    limited = 1,
    slot = 'Crew',
    add_action = { 'C' },
    restriction = {
        faction = { ['scumandvillainy'] = true },
    },
    dual = true,
}

masterUpgradesDB['burnoutthrusters'] = {
    name = "Burnout Thrusters",
    xws = 'burnoutthrusters',
    charge = 1,
    slot = 'Modification',
    restriction = {
        faction = { ['scumandvillainy'] = true },
        size = { small = true, medium = true }
    },
}

masterUpgradesDB['thechild'] = {
    name = "The Child",
    xws = 'thechild',
    force = 2,
    slot = 'Crew',
    restriction = {
        faction = { ['rebelalliance'] = true, ['galacticempire'] = true, ['scumandvillainy'] = true },
    },
    condition = "Merciless Pursuit",
}

masterUpgradesDB['themandalorian'] = {
    name = "The Mandalorian",
    xws = 'themandalorian',
    slot = 'Crew',
    add_action = { 'R' },
    restriction = {
        faction = { ['scumandvillainy'] = true },
    },
}

masterUpgradesDB['swivelwing'] = {
    name = "Swivel Wing",
    xws = 'swivelwing',
    slot = 'Configuration',
    restriction = {
        ship = { ['gauntletfighter'] = true }
    },
    dual = true,
}


masterUpgradesDB['clanwrencommandos'] = {
    name = "Clan Wren Commandos",
    xws = 'clanwrencommandos',
    remotes = { "Clan Wren Commandos (A)", "Clan Wren Commandos (B)" },
    remote_charge = 2,
    limited = 1,
    slot = 'Crew',
    remove_slots = { 'Crew' },
    charge = 2,
    restriction = {
        faction = { ['rebelalliance'] = true },
        size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['imperialsupercommandos'] = {
    name = "Imperial Super Commandos",
    xws = 'imperialsupercommandos',
    remotes = { "Imperial Super Commandos (A)", "Imperial Super Commandos (B)" },
    remote_charge = 2,
    limited = 1,
    slot = 'Crew',
    remove_slots = { 'Crew' },
    charge = 2,
    restriction = {
        faction = { ['galacticempire'] = true },
        size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['mandaloriansupercommandos'] = {
    name = "Mandalorian Super Commandos",
    xws = 'mandaloriansupercommandos',
    remotes = { "Mandalorian Super Commandos (A)", "Mandalorian Super Commandos (B)" },
    remote_charge = 2,
    limited = 1,
    slot = 'Crew',
    remove_slots = { 'Crew' },
    charge = 2,
    restriction = {
        faction = { ['scumandvillainy'] = true },
        size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['niteowlcommandos'] = {
    name = "Nite Owl Commandos",
    xws = 'niteowlcommandos',
    remotes = { "Nite Owl Commandos (A)", "Nite Owl Commandos (B)" },
    remote_charge = 2,
    limited = 1,
    slot = 'Crew',
    remove_slots = { 'Crew' },
    charge = 2,
    restriction = {
        faction = { ['galacticrepublic'] = true },
        size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['deathwatchcommandos'] = {
    name = "Death Watch Commandos",
    xws = 'deathwatchcommandos',
    remotes = { "Death Watch Commandos (A)", "Death Watch Commandos (B)" },
    remote_charge = 2,
    limited = 1,
    slot = 'Crew',
    remove_slots = { 'Crew' },
    charge = 2,
    restriction = {
        faction = { ['separatistalliance'] = true },
        size = { medium = true, large = true, huge = true }
    },
}

masterUpgradesDB['dropseatbay'] = {
    name = "Drop-Seat bay",
    xws = 'dropseatbay',
    slot = 'Modification',
    restriction = {
        ship = { ['gauntletfighter'] = true }
    },
}

masterUpgradesDB['homingtorpedoes'] = {
    name = 'Homing Torpedoes',
    xws = 'homingtorpedoes',
    slot = 'Torpedo',
    charge = 2,
}

masterUpgradesDB['notorious'] = {
    name = "Notorious",
    xws = 'notorious',
    slot = 'Talent',
    charge = 2,
    restriction = {
        -- equipped: illicit
    },
}

masterUpgradesDB['enduring'] = {
    name = "Enduring",
    xws = 'enduring',
    slot = 'Talent',
}

masterUpgradesDB['pelimotto'] = {
    name = "Peli Motto",
    xws = 'pelimotto',
    restriction = {
        faction = { ['scumandvillainy'] = true },
        size = { medium = true, large = true }
    },
    slot = 'Crew',
    limited = 1,
}

masterUpgradesDB['greefkarga'] = {
    name = "Greef Karga",
    xws = 'greefkarga',
    restriction = {
        faction = { ['scumandvillainy'] = true }
    },
    slot = 'Crew',
    limited = 1,
}

masterUpgradesDB['migsmayfeld'] = {
    name = "Migs Mayfeld",
    xws = 'migsmayfeld',
    restriction = {
        faction = { ['galacticempire'] = true, ['scumandvillainy'] = true }
    },
    slot = 'Gunner',
    limited = 1,
}

masterUpgradesDB['hotshottailblaster'] = {
    name = "Hotshot Tail Blaster",
    xws = 'hotshottailblaster',
    charge = 2,
    slot = 'Modification',
    restriction = {
        size = { medium = true, large = true }
    },
}

masterUpgradesDB['xanadublood'] = {
    name = "Xanadu Blood",
    xws = 'xanadublood',
    slot = 'Title',
    restriction = {
        ship = { ['rogueclassstarfighter'] = true }
    },
}

masterUpgradesDB['protoncannons'] = {
    name = "Proton Cannons",
    xws = 'protoncannons',
    slot = 'Cannon',
    remove_slots = { 'Cannon' },
    card_back = cardBackDB['Cannon Dual'],
    charge = 2,
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
    xws = 'combatboardingtube',
    slot = 'Configuration',
    remove_slots = { 'Command' },
    restriction = {
        ship = { ['gauntletfighter'] = true }
    },
}

-- The YASB epic pack Upgrades
masterUpgradesDB['newrecruit'] = {
    name = "New Recruit",
    xws = 'newrecruit',
    limited = 3,
    slot = 'Command',
    point_modifier = -1,
}

masterUpgradesDB['lockedturretspecialist'] = {
    name = "Locked-Turret Specialist",
    xws = 'lockedturretspecialist',
    slot = 'Command',
    charge = 2,
    add_action = { 'B' },
    restriction = {
        -- action: rotate
    },
}

masterUpgradesDB['heavyreinforcedvanguard'] = {
    name = "Heavy Reinforced Vanguard",
    xws = 'heavyreinforcedvanguard',
    slot = 'Command',
    limited = 1,
    point_modifier = 1,
    hull = 2,
}

masterUpgradesDB['evasiveinterceptor'] = {
    name = "Evasive Interceptor",
    xws = 'evasiveinterceptor',
    slot = 'Command',
    limited = 1,
    hull = -1,
    point_modifier = -1,
    --Agility = 1,
    restriction = { size = { small = true } }
}

masterUpgradesDB['countermeasuresspecialist'] = {
    name = "Countermeasures Specialist",
    xws = 'countermeasuresspecialist',
    slot = 'Command',
    limited = 1,
    charge = 2,
    --add_action = {'Jam'}
    restriction = { size = { small = true } }
}

masterUpgradesDB['combatveteran'] = {
    name = "Combat Veteran",
    xws = 'combatveteran',
    slot = 'Command',
    limited = 1,
    point_modifier = 1,
    restriction = {
        has_force = false,
        is_limited = true,
        initiative_greater_than = 3
    },
    add_slots = { 'Talent', 'Modification' },
}

masterUpgradesDB['forceadeptpilot'] = {
    name = "Force Adept Pilot",
    xws = 'forceadeptpilot',
    slot = 'Command',
    limited = 1,
    point_modifier = 1,
    restriction = {
        has_force = true,
    },
    add_slots = { 'Force Power' },
    execute_options = function(moves)
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
    xws = 'adaptablepilot',
    slot = 'Command',
    limited = 2,
    point_modifier = 1,
    loadout_modifier = 10
}


return masterUpgradesDB
