xwaPilotDb = {}


xwaPilotDb[10001] = {
    name = 'Raymus Antilles',
    XWS = 'raymusantilles-epicsl-rebelalliance',
    Faction = 1,
    limited = 1,
    ship_type = 'cr90corvette',
    init = 7,
    texture = 'red',
    actSet = { 'F', 'TL', 'R', 'Rot' },
    arcs = { fixed = { range = 4, type = { 'leftright' } }, turret = { front = { name = 'TLB', range = 5, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Leia Organa',  limited = 1, charge = 0 },
        { name = 'C-3PO', limited = 1, charge = 0 },
        { name = 'R2-D2',  limited = 1, charge = 0 },
        { name = 'Turbolaser Battery', charge = 0 },
        { name = 'Tantive IV', limited = 1, charge = 0}
    }
}

masterPilotDB[10002] = {
    name = 'Trebor Zednem',
    XWS = 'treborzednem-epicsl',
    Faction = 1,
    limited = 1,
    ship_type = 'gr75mediumtransport',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Toryn Farr',  limited = 1, charge = 0 },
        { name = 'Planetary Ion Bombardment', charge = 0 },
        { name = 'Bright Hope',  limited = 1, charge = 0 },
    }
}

masterPilotDB[10003] = {
    name = 'Iden Versio',
    title = 'Corvus',
    XWS = 'idenversio-epicsl',
    Faction = 2,
    limited = 1,
    ship_type = 'raiderclasscorvette',
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    arcs = { fixed = { range = 3, type = { 'fullfront' } }, turret = { front = { name = 'TML', range = 3, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ruthless', charge = 0 },
        { name = 'Fanatical',  charge = 0 },
        { name = 'Inferno Squad',  limited = 1, charge = 0 },
        { name = 'Twin Missile Launcher', charge = 0 },
        { name = 'Corvus',  limited = 1, charge = 0 }
    }
}

masterPilotDB[10004] = {
    name = 'Rik Virgilio',
    XWS = 'rikvirgilio-epicsl',
    Docking = true,
    Faction = 2,
    limited = 1,
    ship_type = 'gozanticlasscruiser',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { front = { name = 'HLCT', range = 3, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Thrawn', limited = 1, charge = 1 },
        { name = 'Heavy Laser Cannon Turret',  charge = 0 },
        { name = 'Blood Crow',  limited = 1, charge = 0 },
    }
}

masterPilotDB[10005] = {
    name = 'Sorc Tormo',
    XWS = 'sorctormo-epicsl',
    Faction = 3,
    limited = 1,
    ship_type = 'tridentclassassaultship',
    init = 8,
    actSet = { 'F', 'E', 'TL', 'R' },
    texture = 'standard',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Caij Vanda', limited = 1, charge = 0 },
        { name = 'Tractor Tentacles',  charge = 0 },
        { name = 'Drill Beak',  charge = 0 },
        { name = "Nautolan's Revenge",  limited = 1, charge = 1 },
    }
}

masterPilotDB[10006] = {
    name = 'Cikatro Vizago',
    XWS = 'cikatrovizago-epicsl',
    Faction = 3,
    limited = 1,
    ship_type = 'croccruiser',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { front = { name = 'MDT', range = 3, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Azmorigan', limited = 1, charge = 0 },
        { name = 'Illegal Countermeasures',  charge = 0 },
        { name = 'Modified Dorsal Turret',  charge = 0 },
        { name = "Broken Horn",  limited = 1, charge = 0 },
    }
}

masterPilotDB[10007] = {
    name = 'Leia Organa',
    title = 'Tantive IV',
    XWS = 'leiaorgana-epicsl',
    limited = 1,
    Faction = 4,
    ship_type = 'cr90corvette',
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'blue',
    arcs = { fixed = { range = 4, type = { 'leftright' } }, turret = { front = { name = 'TLB', range = 5, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Nien Nunb', limited = 1, charge = 1 },
        { name = 'Urcos Furdam', limited = 1,  charge = 0 },
        { name = 'Tibanna Reserves', charge = 3 },
        { name = 'Turbolaser Battery',  charge = 0 },
        { name = "Tantive IV",  limited = 1, charge = 0 },
    }
}

masterPilotDB[10008] = {
    name = 'Oraf Desyk',
    XWS = 'orafdesyk-epicsl',
    Faction = 4,
    limited = 1,
    ship_type = 'gr75mediumtransport',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'GA-75',  limited = 1, charge = 2 },
        { name = 'Adaptive Shields', charge = 0 },
        { name = 'Hosnian Lament',  limited = 1, charge = 0 },
    }
}

masterPilotDB[10009] = {
    name = 'Gideon Hask',
    title = 'Precursor',
    XWS = 'gideonhask-epicsl',
    Faction = 5,
    limited = 1,
    ship_type = 'raiderclasscorvette',
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    arcs = { fixed = { range = 3, type = { 'fullfront' } }, turret = { front = { name = 'TML', range = 3, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Agent Terex', limited = 1, charge = 0 },
        { name = 'Protectorate Gleb', limited = 1,  charge = 0 },
        { name = 'Jinata Security Forces',  limited = 1, charge = 0 },
        { name = 'Twin Missile Launcher', charge = 0 },
        { name = 'Precursor',  limited = 1, charge = 0 }
    }
}

masterPilotDB[10010] = {
    name = 'Cerra Fellian',
    XWS = 'cerrafellian-epicsl',
    Docking = true,
    Faction = 5,
    limited = 1,
    ship_type = 'gozanticlasscruiser',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { front = { name = 'ICB', range = 4, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Petty Officer Thanisson', limited = 1, charge = 0 },
        { name = 'Ion Cannon Battery',  charge = 0 },
        { name = 'Malefactor',  limited = 1, charge = 0 },
    }
}

xwaPilotDb[10011] = {
    name = 'Raymus Antilles',
    title = 'Tantive IV',
    XWS = 'raymusantilles-epicsl-galacticrepublic',
    Faction = 6,
    limited = 1,
    ship_type = 'cr90corvette',
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'blue',
    arcs = { fixed = { range = 4, type = { 'leftright' } }, turret = { front = { name = 'TLB', range = 5, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Born For This', charge = 0 },
        { name = 'Bail Organa', limited = 1,  charge = 0 },
        { name = 'Secret Provisions', charge = 3 },
        { name = 'Turbolaser Battery',  charge = 0 },
        { name = "Tantive IV",  limited = 1, charge = 0 },
    }
}

xwaPilotDb[10012] = {
    name = 'Wez Synat',
    XWS = 'wezsynat-epicsl',
    Faction = 6,
    limited = 1,
    ship_type = 'gozanticlasscruiser',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { front = { name = 'PDB', range = 2, type = { 'doubleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Clone Commander Cody', limited = 1, charge = 0 },
        { name = 'Point Defence Battery', charge = 0 },
        { name = 'Spectre Of Nayr', limited = 1, charge = 0 }
    }
}

masterPilotDB[10013] = {
    name = 'Asajj Ventress',
    title = 'Trident',
    XWS = 'asajjventress-epicsl',
    Faction = 7,
    limited = 1,
    Force = 1,
    ship_type = 'tridentclassassaultship',
    init = 8,
    actSet = { 'F', 'E', 'TL', 'R' },
    texture = 'standard',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'AQ-Series Battle Droids', charge = 0 },
        { name = 'Tractor Tentacles',  charge = 0 },
        { name = 'Drill Beak',  charge = 0 },
        { name = "Trident",  limited = 1, charge = 0 },
    }
}

xwaPilotDb[10014] = {
    name = 'Aut-O',
    XWS = 'auto-epicsl',
    Faction = 7,
    limited = 1,
    ship_type = 'gozanticlasscruiser',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'TX-25', limited = 1, charge = 0 },
        { name = 'Endless Hordes', charge = 1 },
        { name = 'Alpha Revue', limited = 1, charge = 0 }
    }
}

return xwaPilotDb