xwaUpgradeDb = {}

xwaUpgradeDb['captive-legendsandrelics'] = {
    name = "Captive",
    xws = 'captive-legendsandrelics',
    slot = 'Crew',
    limited = 1,
    charge = 1,
    restriction = { faction = { ['galacticempire'] = true, ['firstorder'] = true, ['separatistalliance'] = true } }
}

xwaUpgradeDb['modifiedr4punit-legendsandrelics'] = {
    name = "Modified R4-P Unit",
    xws = 'modifiedr4punit-legendsandrelics',
    slot = 'Astromech',
    charge = 1,
    restriction = { faction = { ['rebelalliance'] = true } }
}

xwaUpgradeDb['flightassistastromech-legendsandrelics'] = {
    name = "Flight-Assist Astromech",
    xws = 'flightassistastromech-legendsandrelics',
    slot = 'Astromech',
    charge = 2,
    add_action = { '2B', '2BR' },
    restriction = { size = { small = true } }
}

xwaUpgradeDb['unhingedastromech-legendsandrelics'] = {
    name = "Unhinged Astromech",
    xws = 'unhingedastromech-legendsandrelics',
    slot = 'Astromech',
}

xwaUpgradeDb['r7t1-legendsandrelics'] = {
    name = "R7-T1",
    xws = 'r7t1-legendsandrelics',
    slot = 'Astromech',
    limited = 1,
    add_action = { 'TL', 'B' },
    restriction = {
        faction = { ['rebelalliance'] = true, ['resistance'] = true },
        size = { small = true }
    }
}

xwaUpgradeDb['precisiontunedcannons-legendsandrelics'] = {
    name = "Precision-Tuned Cannons",
    xws = 'precisiontunedcannons-legendsandrelics',
    slot = 'Cannon',
    arcs = { fixed = { name = 'precision-tuned cannons', range = 3, type = { 'front' } } }
}

xwaUpgradeDb['wingedreversal-legendsandrelics'] = {
    name = "Winged Reversal",
    xws = 'wingedreversal-legendsandrelics',
    slot = 'Configuration',
    charge = 2,
    execute_options = function(moves)
        return {
            btl1   = { [1] = 'btl1', [2] = 'wtl1t' },
            btl2   = { [1] = 'btl2', [2] = 'wtl2t' },
            btl3   = { [1] = 'btl3', [2] = 'wtl3t' },
            btr1   = { [1] = 'btr1', [2] = 'wtr1t' },
            btr2   = { [1] = 'btr2', [2] = 'wtr2t' },
            btr3   = { [1] = 'btr3', [2] = 'wtr3t' },
            wtl1   = { [1] = 'wtl1', [2] = 'rtl1t' },
            wtl2   = { [1] = 'wtl2', [2] = 'rtl2t' },
            wtl3   = { [1] = 'wtl3', [2] = 'rtl3t' },
            wtr1   = { [1] = 'wtr1', [2] = 'rtr1t' },
            wtr2   = { [1] = 'wtr2', [2] = 'rtr2t' },
            wtr3   = { [1] = 'wtr3', [2] = 'rtr3t' },
            rtl1   = { [1] = 'rtl1', [2] = 'rtl1t' },
            rtl2   = { [1] = 'rtl2', [2] = 'rtl2t' },
            rtl3   = { [1] = 'rtl3', [2] = 'rtl3t' },
            rtr1   = { [1] = 'rtr1', [2] = 'rtr1t' },
            rtr2   = { [1] = 'rtr2', [2] = 'rtr2t' },
            rtr3   = { [1] = 'rtr3', [2] = 'rtr3t' },
        }
    end,
    restriction = { ship = { ['gauntletfighter'] = true, ['ut60duwing'] = true } }
}

xwaUpgradeDb['fennecshand-legendsandrelics'] = {
    name = "Fennec Shand",
    xws = 'fennecshand-legendsandrelics',
    slot = 'Crew',
    limited = 1,
    charge = 2,
    restriction = { faction = { ['scumandvillainy'] = true } }
}

xwaUpgradeDb['zoriibliss-legendsandrelics'] = {
    name = "Zorii Bliss",
    xws = 'zoriibliss-legendsandrelics',
    slot = 'Crew',
    limited = 1,
    charge = 1,
    restriction = { faction = { ['resistance'] = true } }
}

xwaUpgradeDb['ahsokatano-legendsandrelics'] = {
    name = "Ahsoka Tano",
    xws = 'ahsokatano-legendsandrelics',
    slot = 'Crew',
    limited = 1,
    force = 1,
    restriction = { faction = { ['rebelalliance'] = true } }
}

xwaUpgradeDb['thrawn-legendsandrelics'] = {
    name = "Thrawn",
    xws = 'thrawn-legendsandrelics',
    slot = 'Crew',
    limited = 1,
    charge = 2,
    restriction = { faction = { ['galacticempire'] = true } }
}

xwaUpgradeDb['roilinganger-legendsandrelics'] = {
    name = "Roiling Anger",
    xws = 'roilinganger-legendsandrelics',
    slot = 'Force Power',
    restriction = { keywords = { 'Dark Side' } }
}

xwaUpgradeDb['wedgeantilles-legendsandrelics'] = {
    name = "Wedge Antilles",
    xws = 'wedgeantilles-legendsandrelics',
    slot = 'Gunner',
    limited = 1,
    restriction = { faction = { ['resistance'] = true } }
}

xwaUpgradeDb['retrofittedautothrusters-legendsandrelics'] = {
    name = "Retrofitted Autothrusters",
    xws = 'retrofittedautothrusters-legendsandrelics',
    slot = 'Modification',
    charge = 2,
    add_action = { 'BR' },
    restriction = { size = { small = true } }
}

xwaUpgradeDb['partinggift-legendsandrelics'] = {
    name = "Parting Gift",
    xws = 'partinggift-legendsandrelics',
    slot = 'Talent',
}

xwaUpgradeDb['automatedloaders-legendsandrelics'] = {
    name = "Automated Loaders",
    xws = 'automatedloaders-legendsandrelics',
    slot = 'Modification',
    charge = 1,
}

xwaUpgradeDb['targetingmatrix-legendsandrelics'] = {
    name = "Targeting Matrix",
    xws = 'targetingmatrix-legendsandrelics',
    slot = 'Modification',
}

xwaUpgradeDb['blindspottargeter-legendsandrelics'] = {
    name = "Blindspot Targeter",
    xws = 'blindspottargeter-legendsandrelics',
    slot = 'Sensor',
}

xwaUpgradeDb['graviticwell-legendsandrelics'] = {
    name = "Gravitic Well",
    xws = 'graviticwell-legendsandrelics',
    slot = 'Configuration',
    restriction = { ship = { ['nantexclassstarfighter'] = true } }
}

xwaUpgradeDb['targetingrelay-legendsandrelics'] = {
    name = "Targeting Relay",
    xws = 'targetingrelay-legendsandrelics',
    slot = 'Tech',
    charge = 2,
}

xwaUpgradeDb['tsj1atargetingcomputer-legendsandrelics'] = {
    name = "T-SJ1A Targeting Computer",
    xws = 'tsj1atargetingcomputer-legendsandrelics',
    slot = 'Tech',
    charge = 1,
    restriction = { faction = { ['firstorder'] = true } }
}

xwaUpgradeDb['burstlaserturret-legendsandrelics'] = {
    name = "Burst Laser Turret",
    xws = 'burstlaserturret-legendsandrelics',
    slot = 'Turret',
    charge = 2,
    arcs = { turret = { name = 'burst laser turret', range = 2, type = { 'singleturret' } } }
}

xwaUpgradeDb['seekermissiles-legendsandrelics'] = {
    name = "Seeker Missiles",
    xws = 'seekermissiles-legendsandrelics',
    slot = 'Missile',
    charge = 4,
}

return xwaUpgradeDb
