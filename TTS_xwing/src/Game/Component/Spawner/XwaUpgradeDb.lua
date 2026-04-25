xwaUpgradeDb = {}

xwaUpgradeDb['captive-legendsandrelics'] = {
    name = "Captive",
    XWS = 'captive-legendsandrelics',
    slot = 8,
    limited = 1,
    Charge = 1,
    restriction = { Faction = { [2] = true, [5] = true, [7] = true } }
}

xwaUpgradeDb['modifiedr4punit-legendsandrelics'] = {
    name = "Modified R4-P Unit",
    XWS = 'modifiedr4punit-legendsandrelics',
    slot = 10,
    Charge = 1,
    restriction = { Faction = { [1] = true } }
}

xwaUpgradeDb['flightassistastromech-legendsandrelics'] = {
    name = "Flight-Assist Astromech",
    XWS = 'flightassistastromech-legendsandrelics',
    slot = 10,
    Charge = 2,
    restriction = { Size = { small = true } }
}

xwaUpgradeDb['unhingedastromech-legendsandrelics'] = {
    name = "Unhinged Astromech",
    XWS = 'unhingedastromech-legendsandrelics',
    slot = 10,
}

xwaUpgradeDb['r7t1-legendsandrelics'] = {
    name = "R7-T1",
    XWS = 'r7t1-legendsandrelics',
    slot = 10,
    limited = 1,
    addAction = { 'TL', 'B' },
    restriction = {
        Faction = { [1] = true, [4] = true },
        Size = { small = true }
    }
}

xwaUpgradeDb['precisiontunedcannons-legendsandrelics'] = {
    name = "Precision-Tuned Cannons",
    XWS = 'precisiontunedcannons-legendsandrelics',
    slot = 3,
    arcs = { fixed = { name = 'precision-tuned cannons', range = 3, type = { 'front' } } }
}

xwaUpgradeDb['wingedreversal-legendsandrelics'] = {
    name = "Winged Reversal",
    XWS = 'wingedreversal-legendsandrelics',
    slot = 18,
    Charge = 2,
    restriction = { ship = { ['gauntletfighter'] = true, ['ut60duwing'] = true } }
}

xwaUpgradeDb['fennecshand-legendsandrelics'] = {
    name = "Fennec Shand",
    XWS = 'fennecshand-legendsandrelics',
    slot = 8,
    limited = 1,
    Charge = 2,
    restriction = { Faction = { [3] = true } }
}

xwaUpgradeDb['zoriibliss-legendsandrelics'] = {
    name = "Zorii Bliss",
    XWS = 'zoriibliss-legendsandrelics',
    slot = 8,
    limited = 1,
    Charge = 1,
    restriction = { Faction = { [4] = true } }
}

xwaUpgradeDb['ahsokatano-legendsandrelics'] = {
    name = "Ahsoka Tano",
    XWS = 'ahsokatano-legendsandrelics',
    slot = 8,
    limited = 1,
    Force = 1,
    restriction = { Faction = { [1] = true } }
}

xwaUpgradeDb['thrawn-legendsandrelics'] = {
    name = "Thrawn",
    XWS = 'thrawn-legendsandrelics',
    slot = 8,
    limited = 1,
    Charge = 2,
    restriction = { Faction = { [2] = true } }
}

xwaUpgradeDb['roilinganger-legendsandrelics'] = {
    name = "Roiling Anger",
    XWS = 'roilinganger-legendsandrelics',
    slot = 17,
    restriction = { keywords = { 'Dark Side' } }
}

xwaUpgradeDb['wedgeantilles-legendsandrelics'] = {
    name = "Wedge Antilles",
    XWS = 'wedgeantilles-legendsandrelics',
    slot = 16,
    limited = 1,
    restriction = { Faction = { [4] = true } }
}

xwaUpgradeDb['retrofittedautothrusters-legendsandrelics'] = {
    name = "Retrofitted Autothrusters",
    XWS = 'retrofittedautothrusters-legendsandrelics',
    slot = 14,
    Charge = 2,
    restriction = { Size = { small = true } }
}

xwaUpgradeDb['partinggift-legendsandrelics'] = {
    name = "Parting Gift",
    XWS = 'partinggift-legendsandrelics',
    slot = 1,
}

xwaUpgradeDb['automatedloaders-legendsandrelics'] = {
    name = "Automated Loaders",
    XWS = 'automatedloaders-legendsandrelics',
    slot = 14,
    Charge = 1,
}

xwaUpgradeDb['targetingmatrix-legendsandrelics'] = {
    name = "Targeting Matrix",
    XWS = 'targetingmatrix-legendsandrelics',
    slot = 14,
}

xwaUpgradeDb['blindspottargeter-legendsandrelics'] = {
    name = "Blindspot Targeter",
    XWS = 'blindspottargeter-legendsandrelics',
    slot = 2,
}

xwaUpgradeDb['graviticwell-legendsandrelics'] = {
    name = "Gravitic Well",
    XWS = 'graviticwell-legendsandrelics',
    slot = 18,
    restriction = { ship = { ['nantexclassstarfighter'] = true } }
}

xwaUpgradeDb['targetingrelay-legendsandrelics'] = {
    name = "Targeting Relay",
    XWS = 'targetingrelay-legendsandrelics',
    slot = 19,
    Charge = 2,
}

xwaUpgradeDb['tsj1atargetingcomputer-legendsandrelics'] = {
    name = "T-SJ1A Targeting Computer",
    XWS = 'tsj1atargetingcomputer-legendsandrelics',
    slot = 19,
    Charge = 1,
    restriction = { Faction = { [5] = true } }
}

xwaUpgradeDb['burstlaserturret-legendsandrelics'] = {
    name = "Burst Laser Turret",
    XWS = 'burstlaserturret-legendsandrelics',
    slot = 4,
    Charge = 2,
    arcs = { turret = { name = 'burst laser turret', range = 2, type = { 'singleturret' } } }
}

xwaUpgradeDb['seekermissiles-legendsandrelics'] = {
    name = "Seeker Missiles",
    XWS = 'seekermissiles-legendsandrelics',
    slot = 6,
    Charge = 4,
}

return xwaUpgradeDb
