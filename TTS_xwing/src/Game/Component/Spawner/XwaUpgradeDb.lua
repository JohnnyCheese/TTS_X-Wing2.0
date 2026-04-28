xwaUpgradeDb = {}

xwaUpgradeDb['captive-legendsandrelics'] = {
    name = "Captive",
    slot = 'Crew',
    limited = 1,
    charge = 1,
    extended_width = true,
    restriction = { faction = { ['galacticempire'] = true, ['firstorder'] = true, ['separatistalliance'] = true } }
}

xwaUpgradeDb['modifiedr4punit-legendsandrelics'] = {
    name = "Modified R4-P Unit",
    slot = 'Astromech',
    charge = 1,
    extended_width = true,
    restriction = { faction = { ['rebelalliance'] = true } }
}

xwaUpgradeDb['flightassistastromech-legendsandrelics'] = {
    name = "Flight-Assist Astromech",
    slot = 'Astromech',
    charge = 2,
    add_action = { '2B', '2BR' },
    extended_width = true,
    restriction = { size = { small = true } }
}

xwaUpgradeDb['unhingedastromech-legendsandrelics'] = {
    name = "Unhinged Astromech",
    slot = 'Astromech',
    extended_width = true,
}

xwaUpgradeDb['r7t1-legendsandrelics'] = {
    name = "R7-T1",
    slot = 'Astromech',
    limited = 1,
    add_action = { 'TL', 'B' },
    extended_width = true,
    restriction = {
        faction = { ['rebelalliance'] = true, ['resistance'] = true },
        size = { small = true }
    }
}

xwaUpgradeDb['precisiontunedcannons-legendsandrelics'] = {
    name = "Precision-Tuned Cannons",
    slot = 'Cannon',
    extended_width = true,
    arcs = { fixed = { name = 'precision-tuned cannons', range = 3, type = { 'front' } } }
}

xwaUpgradeDb['wingedreversal-legendsandrelics'] = {
    name = "Winged Reversal",
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
    extended_width = true,
    restriction = { ship = { ['gauntletfighter'] = true, ['ut60duwing'] = true } }
}

xwaUpgradeDb['fennecshand-legendsandrelics'] = {
    name = "Fennec Shand",
    slot = 'Crew',
    limited = 1,
    charge = 2,
    extended_width = true,
    restriction = { faction = { ['scumandvillainy'] = true } }
}

xwaUpgradeDb['zoriibliss-legendsandrelics'] = {
    name = "Zorii Bliss",
    slot = 'Crew',
    limited = 1,
    charge = 1,
    extended_width = true,
    restriction = { faction = { ['resistance'] = true } }
}

xwaUpgradeDb['ahsokatano-legendsandrelics'] = {
    name = "Ahsoka Tano",
    slot = 'Crew',
    limited = 1,
    force = 1,
    extended_width = true,
    restriction = { faction = { ['rebelalliance'] = true } }
}

xwaUpgradeDb['thrawn-legendsandrelics'] = {
    name = "Thrawn",
    slot = 'Crew',
    limited = 1,
    charge = 2,
    extended_width = true,
    restriction = { faction = { ['galacticempire'] = true } }
}

xwaUpgradeDb['roilinganger-legendsandrelics'] = {
    name = "Roiling Anger",
    slot = 'Force Power',
    extended_width = true,
    restriction = { keywords = { 'Dark Side' } }
}

xwaUpgradeDb['wedgeantilles-legendsandrelics'] = {
    name = "Wedge Antilles",
    slot = 'Gunner',
    limited = 1,
    extended_width = true,
    restriction = { faction = { ['resistance'] = true } }
}

xwaUpgradeDb['retrofittedautothrusters-legendsandrelics'] = {
    name = "Retrofitted Autothrusters",
    slot = 'Modification',
    charge = 2,
    add_action = { 'BR' },
    extended_width = true,
    restriction = { size = { small = true } }
}

xwaUpgradeDb['partinggift-legendsandrelics'] = {
    name = "Parting Gift",
    slot = 'Talent',
    extended_width = true,
}

xwaUpgradeDb['automatedloaders-legendsandrelics'] = {
    name = "Automated Loaders",
    slot = 'Modification',
    charge = 1,
    extended_width = true,
}

xwaUpgradeDb['targetingmatrix-legendsandrelics'] = {
    name = "Targeting Matrix",
    slot = 'Modification',
    extended_width = true,
}

xwaUpgradeDb['blindspottargeter-legendsandrelics'] = {
    name = "Blindspot Targeter",
    slot = 'Sensor',
    extended_width = true,
}

xwaUpgradeDb['graviticwell-legendsandrelics'] = {
    name = "Gravitic Well",
    slot = 'Configuration',
    restriction = { ship = { ['nantexclassstarfighter'] = true } },
    extended_width = true,
}

xwaUpgradeDb['targetingrelay-legendsandrelics'] = {
    name = "Targeting Relay",
    slot = 'Tech',
    charge = 2,
    extended_width = true,
}

xwaUpgradeDb['tsj1atargetingcomputer-legendsandrelics'] = {
    name = "T-SJ1A Targeting Computer",
    slot = 'Tech',
    charge = 1,
    restriction = { faction = { ['firstorder'] = true } },
    extended_width = true,
}

xwaUpgradeDb['burstlaserturret-legendsandrelics'] = {
    name = "Burst Laser Turret",
    slot = 'Turret',
    charge = 2,
    arcs = { turret = { name = 'burst laser turret', range = 2, type = { 'singleturret' } } },
    extended_width = true,
}

xwaUpgradeDb['seekermissiles-legendsandrelics'] = {
    name = "Seeker Missiles",
    slot = 'Missile',
    charge = 4,
    extended_width = true,
}

return xwaUpgradeDb
