xwaUpgradeDb = {}

xwaUpgradeDb['captive-legendsandrelics'] = {
    name = "Captive",
    XWS = 'captive-legendsandrelics',
    slot = 'Crew',
    limited = 1,
    Charge = 1,
    restriction = { Faction = { ['galacticempire'] = true, ['firstorder'] = true, ['separatistalliance'] = true } }
}

xwaUpgradeDb['modifiedr4punit-legendsandrelics'] = {
    name = "Modified R4-P Unit",
    XWS = 'modifiedr4punit-legendsandrelics',
    slot = 'Astromech',
    Charge = 1,
    restriction = { Faction = { ['rebelalliance'] = true } }
}

xwaUpgradeDb['flightassistastromech-legendsandrelics'] = {
    name = "Flight-Assist Astromech",
    XWS = 'flightassistastromech-legendsandrelics',
    slot = 'Astromech',
    Charge = 2,
    addAction = { '2B', '2BR' },
    restriction = { Size = { small = true } }
}

xwaUpgradeDb['unhingedastromech-legendsandrelics'] = {
    name = "Unhinged Astromech",
    XWS = 'unhingedastromech-legendsandrelics',
    slot = 'Astromech',
}

xwaUpgradeDb['r7t1-legendsandrelics'] = {
    name = "R7-T1",
    XWS = 'r7t1-legendsandrelics',
    slot = 'Astromech',
    limited = 1,
    addAction = { 'TL', 'B' },
    restriction = {
        Faction = { ['rebelalliance'] = true, ['resistance'] = true },
        Size = { small = true }
    }
}

xwaUpgradeDb['precisiontunedcannons-legendsandrelics'] = {
    name = "Precision-Tuned Cannons",
    XWS = 'precisiontunedcannons-legendsandrelics',
    slot = 'Cannon',
    arcs = { fixed = { name = 'precision-tuned cannons', range = 3, type = { 'front' } } }
}

xwaUpgradeDb['wingedreversal-legendsandrelics'] = {
    name = "Winged Reversal",
    XWS = 'wingedreversal-legendsandrelics',
    slot = 'Configuration',
    Charge = 2,
    executeOptions = function(moves)
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
    XWS = 'fennecshand-legendsandrelics',
    slot = 'Crew',
    limited = 1,
    Charge = 2,
    restriction = { Faction = { ['scumandvillainy'] = true } }
}

xwaUpgradeDb['zoriibliss-legendsandrelics'] = {
    name = "Zorii Bliss",
    XWS = 'zoriibliss-legendsandrelics',
    slot = 'Crew',
    limited = 1,
    Charge = 1,
    restriction = { Faction = { ['resistance'] = true } }
}

xwaUpgradeDb['ahsokatano-legendsandrelics'] = {
    name = "Ahsoka Tano",
    XWS = 'ahsokatano-legendsandrelics',
    slot = 'Crew',
    limited = 1,
    Force = 1,
    restriction = { Faction = { ['rebelalliance'] = true } }
}

xwaUpgradeDb['thrawn-legendsandrelics'] = {
    name = "Thrawn",
    XWS = 'thrawn-legendsandrelics',
    slot = 'Crew',
    limited = 1,
    Charge = 2,
    restriction = { Faction = { ['galacticempire'] = true } }
}

xwaUpgradeDb['roilinganger-legendsandrelics'] = {
    name = "Roiling Anger",
    XWS = 'roilinganger-legendsandrelics',
    slot = 'Force Power',
    restriction = { keywords = { 'Dark Side' } }
}

xwaUpgradeDb['wedgeantilles-legendsandrelics'] = {
    name = "Wedge Antilles",
    XWS = 'wedgeantilles-legendsandrelics',
    slot = 'Gunner',
    limited = 1,
    restriction = { Faction = { ['resistance'] = true } }
}

xwaUpgradeDb['retrofittedautothrusters-legendsandrelics'] = {
    name = "Retrofitted Autothrusters",
    XWS = 'retrofittedautothrusters-legendsandrelics',
    slot = 'Modification',
    Charge = 2,
    addAction = { 'BR' },
    restriction = { Size = { small = true } }
}

xwaUpgradeDb['partinggift-legendsandrelics'] = {
    name = "Parting Gift",
    XWS = 'partinggift-legendsandrelics',
    slot = 'Talent',
}

xwaUpgradeDb['automatedloaders-legendsandrelics'] = {
    name = "Automated Loaders",
    XWS = 'automatedloaders-legendsandrelics',
    slot = 'Modification',
    Charge = 1,
}

xwaUpgradeDb['targetingmatrix-legendsandrelics'] = {
    name = "Targeting Matrix",
    XWS = 'targetingmatrix-legendsandrelics',
    slot = 'Modification',
}

xwaUpgradeDb['blindspottargeter-legendsandrelics'] = {
    name = "Blindspot Targeter",
    XWS = 'blindspottargeter-legendsandrelics',
    slot = 'Sensor',
}

xwaUpgradeDb['graviticwell-legendsandrelics'] = {
    name = "Gravitic Well",
    XWS = 'graviticwell-legendsandrelics',
    slot = 'Configuration',
    restriction = { ship = { ['nantexclassstarfighter'] = true } }
}

xwaUpgradeDb['targetingrelay-legendsandrelics'] = {
    name = "Targeting Relay",
    XWS = 'targetingrelay-legendsandrelics',
    slot = 'Tech',
    Charge = 2,
}

xwaUpgradeDb['tsj1atargetingcomputer-legendsandrelics'] = {
    name = "T-SJ1A Targeting Computer",
    XWS = 'tsj1atargetingcomputer-legendsandrelics',
    slot = 'Tech',
    Charge = 1,
    restriction = { Faction = { ['firstorder'] = true } }
}

xwaUpgradeDb['burstlaserturret-legendsandrelics'] = {
    name = "Burst Laser Turret",
    XWS = 'burstlaserturret-legendsandrelics',
    slot = 'Turret',
    Charge = 2,
    arcs = { turret = { name = 'burst laser turret', range = 2, type = { 'singleturret' } } }
}

xwaUpgradeDb['seekermissiles-legendsandrelics'] = {
    name = "Seeker Missiles",
    XWS = 'seekermissiles-legendsandrelics',
    slot = 'Missile',
    Charge = 4,
}

return xwaUpgradeDb
