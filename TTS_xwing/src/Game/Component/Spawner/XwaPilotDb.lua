xwaPilotDb = {}


xwaPilotDb['raymusantilles-epicsl-rebelalliance'] = {
    name = 'Raymus Antilles',
    XWS = 'raymusantilles-epicsl-rebelalliance',
    Faction = 'rebelalliance',
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

xwaPilotDb['treborzednem-epicsl'] = {
    name = 'Trebor Zednem',
    XWS = 'treborzednem-epicsl',
    Faction = 'rebelalliance',
    limited = 1,
    ship_type = 'gr75mediumtransport',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Toryn Farr',  limited = 1, charge = 0 },
        { name = 'Planetary Ion Bombardment', charge = 0 },
        { name = 'Bright Hope',  limited = 1, charge = 0 }
    }
}

xwaPilotDb['idenversio-epicsl'] = {
    name = 'Iden Versio',
    title = 'Corvus',
    XWS = 'idenversio-epicsl',
    Faction = 'galacticempire',
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

xwaPilotDb['rikvirgilio-epicsl'] = {
    name = 'Rik Virgilio',
    XWS = 'rikvirgilio-epicsl',
    Docking = true,
    Faction = 'galacticempire',
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
        { name = 'Blood Crow',  limited = 1, charge = 0 }
    }
}

xwaPilotDb['sorctormo-epicsl'] = {
    name = 'Sorc Tormo',
    XWS = 'sorctormo-epicsl',
    Faction = 'scumandvillainy',
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
        { name = "Nautolan's Revenge",  limited = 1, charge = 1 }
    }
}

xwaPilotDb['cikatrovizago-epicsl'] = {
    name = 'Cikatro Vizago',
    XWS = 'cikatrovizago-epicsl',
    Faction = 'scumandvillainy',
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
        { name = "Broken Horn",  limited = 1, charge = 0 }
    }
}

xwaPilotDb['leiaorgana-epicsl'] = {
    name = 'Leia Organa',
    title = 'Tantive IV',
    XWS = 'leiaorgana-epicsl',
    limited = 1,
    Faction = 'resistance',
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
        { name = "Tantive IV",  limited = 1, charge = 0 }
    }
}

xwaPilotDb['orafdesyk-epicsl'] = {
    name = 'Oraf Desyk',
    XWS = 'orafdesyk-epicsl',
    Faction = 'resistance',
    limited = 1,
    ship_type = 'gr75mediumtransport',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'GA-75',  limited = 1, charge = 2 },
        { name = 'Adaptive Shields', charge = 0 },
        { name = 'Hosnian Lament',  limited = 1, charge = 0 }
    }
}

xwaPilotDb['gideonhask-epicsl'] = {
    name = 'Gideon Hask',
    title = 'Precursor',
    XWS = 'gideonhask-epicsl',
    Faction = 'firstorder',
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

xwaPilotDb['cerrafellian-epicsl'] = {
    name = 'Cerra Fellian',
    XWS = 'cerrafellian-epicsl',
    Docking = true,
    Faction = 'firstorder',
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
        { name = 'Malefactor',  limited = 1, charge = 0 }
    }
}

xwaPilotDb['raymusantilles-epicsl-galacticrepublic'] = {
    name = 'Raymus Antilles',
    title = 'Tantive IV',
    XWS = 'raymusantilles-epicsl-galacticrepublic',
    Faction = 'galacticrepublic',
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
        { name = "Tantive IV",  limited = 1, charge = 0 }
    }
}

xwaPilotDb['wezsynat-epicsl'] = {
    name = 'Wez Synat',
    XWS = 'wezsynat-epicsl',
    Faction = 'galacticrepublic',
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

xwaPilotDb['asajjventress-epicsl'] = {
    name = 'Asajj Ventress',
    title = 'Trident',
    XWS = 'asajjventress-epicsl',
    Faction = 'separatistalliance',
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
        { name = "Trident",  limited = 1, charge = 0 }
    }
}

xwaPilotDb['aut0-epicsl'] = {
    name = 'Aut-0',
    XWS = 'aut0-epicsl',
    Faction = 'separatistalliance',
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


xwaPilotDb['bobafett-armedanddangerous'] = {
    name = 'Boba Fett',
    title = 'Armed and Dangerous',
    XWS = 'bobafett-armedanddangerous',
    Faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    init = 5,
    texture = 'boba',
    actSet = { 'F', 'R', 'TL', 'B' },
    Bomb = true,
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Homing Beacon', charge = 2 },
        { name = 'Fennec Shand', limited = 1, charge = 0 },
        { name = 'Seismic Charges', charge = 2 },
        { name = 'Slave I', limited = 1, charge = 0}
    }
}

xwaPilotDb['bokatankryze-armedanddangerous'] = {
    name = 'Bo-Katan Kryze',
    title = 'Armed and Dangerous',
    XWS = 'bokatankryze-armedanddangerous',
    Faction = 'scumandvillainy',
    limited = 1,
    Charge = 2,
    ship_type = 'gauntletfighter',
    init = 4,
    texture = 'bokatan',
    actSet = { 'F', 'TL', 'R', 'Piv' },
    executeOptions = {
        wtl2 = { [1] = 'wtl2', [2] = 'rtl2t'},
        wtr2 = { [1] = 'wtr2', [2] = 'rtr2t'},
        rtl3 = { [1] = 'rtl3', [2] = 'rtl3t'},
        rtr3 = { [1] = 'rtr3', [2] = 'rtr3t'}
    },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Mandalorian Tactics', charge = 0 },
        { name = 'Nite Owl Sentries', limited = 1, charge = 3 },
        { name = 'Veteran Tail Gunner', charge = 0 }
    }
}

xwaPilotDb['bossk-armedanddangerous'] = {
    name = 'Bossk',
    title = 'Armed and Dangerous',
    XWS = 'bossk-armedanddangerous',
    Faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'yv666lightfreighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'EMBO', limited = 1, charge = 0 },
        { name = 'Contraband Cybernetics',  charge = 1 },
        { name = "Hound's Tooth", limited = 1, charge = 0 }
    }
}

xwaPilotDb['cadbane-armedanddangerous'] = {
    name = 'Cad Bane',
    title = 'Armed and Dangerous',
    XWS = 'cadbane-armedanddangerous',
    Faction = 'scumandvillainy',
    Charge = 2,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    init = 4,
    texture = 'green',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    arcs = { fixed = { range = 3, type = { 'front' } }, weapon = { { name = 'Flechette Cannons', range = 3, type = { 'front' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Flechette Cannons', charge = 0 },
        { name = 'TODO 360', limited=1, charge = 2 },
        { name = "Xanadu Blood", limited = 1, charge = 0 }
    }
}

xwaPilotDb['caithrenalli-evacuationofdqar'] = {
    name = "C'ai Threnalli",
    title = "Evacuation of D'Qar",
    XWS = 'caithrenalli-evacuationofdqar',
    limited = 1,
    Faction = 'resistance',
    ship_type = 't70xwing',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'E', 'BR', 'VR'},
    movethrough = true,
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'For The Cause', charge = 0 },
        { name = 'Heroic', charge = 0 },
        { name = 'BB Astromech', charge = 2 },
        { name = 'Repulsorlift engines', charge = 0 }
    }
}

xwaPilotDb['dengar-armedanddangerous'] = {
    name = 'Dengar',
    title = 'Armed and Dangerous',
    XWS = 'dengar-armedanddangerous',
    Faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'jumpmaster5000',
    Charge = 1,
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'R2-G8', limited = 1, charge = 2 },
        { name = 'Synchronized Handling', charge = 1 },
        { name = 'Starboard Thrusters Blood', charge = 2 },
        { name = 'Punishing One', limited = 1, charge = 0 }
    }
}

xwaPilotDb['fennrau-armedanddangerous'] = {
    name = 'Fenn Rau',
    title = 'Armed and Dangerous',
    XWS = 'fennrau-armedanddangerous',
    Faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'fangfighter',
    init = 6,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Fearless', charge = 0 },
        { name = 'Adaptable Power Systems', charge = 2 },
        { name = 'Beskar Reinforced Plating', charge = 2 }
    }
}

xwaPilotDb['finchdallow-evacuationofdqar'] = {
    name = "Finch Dallow",
    title = "Evacuation of D'Qar",
    XWS = 'finchdallow-evacuationofdqar',
    Faction = 'resistance',
    limited = 1,
    ship_type = 'mg100starfortress',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot', 'Piv', 'R'},
    Bomb = true,
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Nix Jerd', limited = 1, charge = 2 },
        { name = 'Paige Tico', limited = 1, charge = 0 },
        { name = 'Proton Bombs', charge = 2 },
        { name = 'Thermal Detonators', charge = 4 }
    }
}

xwaPilotDb['hansolo-armedanddangerous'] = {
    name = 'Han Solo',
    title = 'Armed and Dangerous',
    XWS = 'hansolo-armedanddangerous',
    Faction = 'scumandvillainy',
    limited = 1,
    Charge = 1,
    Shield = 5,
    ship_type = 'customizedyt1300lightfreighter',
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Chewbacca', limited = 1, charge = 2 },
        { name = 'L3-37', limited = 1, charge = 1 },
        { name = 'Tobias Beckett', limited = 1, charge = 0 },
        { name = "Lando's Millennium Falcon", limited = 1, charge = 0 }
    }
}

xwaPilotDb['jaycristubbs-evacuationofdqar'] = {
    name = 'Jaycris Tubbs',
    title = "Evacuation of D'Qar",
    XWS = 'jaycristubbs-evacuationofdqar',
    limited = 1,
    Faction = 'resistance',
    ship_type = 't70xwing',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'For The Cause', charge = 0 },
        { name = 'R0 Astromech',  charge = 0 }
    }
}

xwaPilotDb['kyloren-evacuationofdqar'] = {
    name = 'Kylo Ren',
    title = "Evacuation of D'Qar",
    XWS = 'kyloren-evacuationofdqar',
    Faction = 'firstorder',
    limited = 1,
    ship_type = 'tievnsilencer',
    Force = 3,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Determination', charge = 0 },
        { name = 'Malice',  charge = 0 },
        { name = 'Proton Torpedoes', charge = 2}
    }
}

xwaPilotDb['lieutenantlehuse-evacuationofdqar'] = {
    name = 'Lieutenant LeHuse',
    title = "Evacuation of D'Qar",
    XWS = 'lieutenantlehuse-evacuationofdqar',
    Faction = 'firstorder',
    limited = 1,
    ship_type = 'tiesffighter',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Determination', charge = 0 },
        { name = 'Concussion Missiles',  charge = 3 },
        { name = 'First Order Ordinance Tech', charge = 0}
    }
}

xwaPilotDb['longshot-evacuationofdqar'] = {
    name = '"Longshot"',
    title = "Evacuation of D'Qar",
    XWS = 'longshot-evacuationofdqar',
    limited = 1,
    Faction = 'firstorder',
    ship_type = 'tiefofighter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Determination', charge = 0 },
        { name = 'Fanatical',  charge = 0 },
        { name = 'Experimental Scanners', charge = 0}
    }
}

xwaPilotDb['midnight-evacuationofdqar'] = {
    name = '"Midnight"',
    title = "Evacuation of D'Qar",
    XWS = 'midnight-evacuationofdqar',
    limited = 1,
    Faction = 'firstorder',
    ship_type = 'tiefofighter',
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Determination', charge = 0 },
        { name = 'Targeting Synchronizer',  charge = 0 },
        { name = 'Advanced Warning Systems', charge = 0}
    }
}

xwaPilotDb['omega2-evacuationofdqar'] = {
    name = 'Omega 2',
    title = "Evacuation of D'Qar",
    XWS = 'omega2-evacuationofdqar',
    limited = 1,
    Faction = 'firstorder',
    ship_type = 'tiefofighter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' },
    addSqdAction = { 'C' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Determination', charge = 0 },
        { name = 'Targeting Relay',  charge = 2 }
    }
}

xwaPilotDb['pammichnerrogoode-evacuationofdqar'] = {
    name = 'Pammich Nerro Goode',
    title = "Evacuation of D'Qar",
    XWS = 'pammichnerrogoode-evacuationofdqar',
    Faction = 'resistance',
    limited = 1,
    ship_type = 'resistancetransport',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'C'},
    addSqdAction = { 'B'},
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'For The Cause', charge = 0 },
        { name = 'R0-GR', limited = 1,  charge = 0 },
        { name = 'Black Squadron R4', limited = 1,  charge = 2 }
    }
}

xwaPilotDb['pettyofficerthanisson-evacuationofdqar'] = {
    name = 'Petty Officer Thanisson',
    title = "Evacuation of D'Qar",
    XWS = 'pettyofficerthanisson-evacuationofdqar',
    Faction = 'firstorder',
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    Charge = 1,
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'General Hux', limited = 1, charge = 0 },
        { name = 'Advanced Sensors', charge = 0 },
        { name = 'Interference Array', charge = 2 }
    }
}

xwaPilotDb['poedameron-evacuationofdqar'] = {
    name = 'Poe Dameron',
    title = "Evacuation of D'Qar",
    XWS = 'poedameron-evacuationofdqar',
    limited = 1,
    Faction = 'resistance',
    ship_type = 't70xwing',
    Charge = 1,
    init = 6,
    texture = 'blackone',
    actSet = { 'F', 'TL', 'B', 'BR', '2B', '2BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Heroic', charge = 0 },
        { name = 'BB-8', limited = 1, charge = 2 },
        { name = 'Primed Overdrive Thrusters', limited = 1, charge = 0 },
        { name = 'Black One', limited = 1, charge = 2 }
    }
}

xwaPilotDb['princexizor-armedanddangerous'] = {
    name = 'Prince Xizor',
    title = 'Armed and Dangerous',
    XWS = 'princexizor-armedanddangerous',
    Faction = 'scumandvillainy',
    limited = 1,
    Shield = 2,
    Charge = 3,
    ship_type = 'starviperclassattackplatform',
    init = 4,
    texture = 'white',
    actSet = { 'F', 'TL', 'B', 'VR', 'BR'},
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Crime Lord', limited = 1, charge = 2 },
        { name = 'Mandalorian Optics', charge = 2 },
        { name = 'Virago', limited = 1, charge = 0 }
    }
}

xwaPilotDb['ronithblario-evacuationofdqar'] = {
    name = "Ronith Blario",
    title = "Evacuation of D'Qar",
    XWS = 'ronithblario-evacuationofdqar',
    Faction = 'resistance',
    limited = 1,
    ship_type = 'rz2awing',
    init = 2,
    texture = 'red',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' },
    movethrough = true,
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Escord Fighter',  charge = 1 },
        { name = 'Heroic', charge = 0 },
        { name = 'Starbird Slash', charge = 0 }
    }
}

xwaPilotDb['scorch-evacuationofdqar'] = {
    name = '"Scorch"',
    title = "Evacuation of D'Qar",
    XWS = 'scorch-evacuationofdqar',
    limited = 1,
    Faction = 'firstorder',
    ship_type = 'tiefofighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Determination',  charge = 0 },
        { name = 'Fanatical', charge = 0 },
        { name = 'Threat Sensors', charge = 0 }
    }
}

xwaPilotDb['stomeronistarck-evacuationofdqar'] = {
    name = 'Stomeroni Starck',
    title = "Evacuation of D'Qar",
    XWS = 'stomeronistarck-evacuationofdqar',
    limited = 1,
    Faction = 'resistance',
    ship_type = 't70xwing',
    Charge = 1,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'For The Cause', charge = 0 },
        { name = 'Accelerated Sensor Array', charge = 0 },
        { name = 'R5-X3', limited = 1, charge = 2 }
    },
    moveSet = { 'wtl1', 'wtr1', 'btl2', 'bbl2', 'bs2', 'bbr2', 'btr2', 'rbl3s', 'wtl3', 'bbl3', 'bs3', 'bbr3', 'wtr3', 'rbr3s', 'bs4', 'bs5', 'rk5' }
}

xwaPilotDb['tallissanlintra-evacuationofdqar'] = {
    name = "Tallissan Lintra",
    title = "Evacuation of D'Qar",
    XWS = 'tallissanlintra-evacuationofdqar',
    Faction = 'resistance',
    limited = 1,
    ship_type = 'rz2awing',
    Charge = 1,
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'For The Cause', charge = 0 },
        { name = 'Heroic', charge = 0 },
        { name = 'Push The Limit', charge = 0 },
        { name = 'XX-23 S-Thread Tracers', limited = 2, charge = 2 }
    }
}

xwaPilotDb['themandalorian-armedanddangerous'] = {
    name = 'The Mandalorian',
    title = 'Armed and Dangerous',
    XWS = 'themandalorian-armedanddangerous',
    Faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    init = 5,
    Force = 2,
    texture = 'mandalorian',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Outmaneuver', charge = 0 },
        { name = 'The Child', limited=1,  charge = 0 },
        { name = 'Kineso-Switch', charge = 2 },
        { name = 'Calibrated Laser Targeting', charge = 0 }
    },
    mesh = "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nabooroyaln1starfighter/MandoN1.obj"
}

xwaPilotDb['theta3-evacuationofdqar'] = {
    name = 'Theta 3',
    title = "Evacuation of D'Qar",
    XWS = 'theta3-evacuationofdqar',
    Faction = 'firstorder',
    limited = 1,
    ship_type = 'tiesffighter',
    Shield = 3,
    Charge = 2,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot', 'C'},
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Passive Sensors', charge = 1 },
        { name = 'Seeker Missiles', charge = 4 },
        { name = 'First Order Ordnance Tech', charge = 0 }
    },
}

xwaPilotDb['theta4-evacuationofdqar'] = {
    name = 'Theta 4',
    title = "Evacuation of D'Qar",
    XWS = 'theta4-evacuationofdqar',
    Faction = 'firstorder',
    limited = 1,
    ship_type = 'tiesffighter',
    Shield = 3,
    Charge = 1,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Determination', charge = 0 },
        { name = 'Barrage Rockets', charge = 5},
        { name = 'Pattern Analyzer', charge = 0 }
    },
}

xwaPilotDb['vennie-evacuationofdqar'] = {
    name = "Vennie",
    title = "Evacuation of D'Qar",
    XWS = 'vennie-evacuationofdqar',
    Faction = 'resistance',
    limited = 1,
    ship_type = 'mg100starfortress',
    init = 2,
    texture = 'vennie',
    actSet = { 'F', 'TL', 'Rot', 'Piv' },
    Bomb = true,
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Perceptive Copilot', charge = 0 },
        { name = 'Dedicated Gunners', charge = 0},
        { name = 'Proton Bombs', charge = 2 }
    },
}

xwaPilotDb['zeta5-evacuationofdqar'] = {
    name = 'Zeta 5',
    title = "Evacuation of D'Qar",
    XWS = 'zeta5-evacuationofdqar',
    Faction = 'firstorder',
    limited = 1,
    ship_type = 'tiefofighter',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Determination', charge = 0 },
        { name = 'Pattern Analyzer', charge = 0},
        { name = 'Targeting Matrix', charge = 0 }
    },
}

xwaPilotDb['zizitlo-evacuationofdqar'] = {
    name = "Zizi Tlo",
    title = "Evacuation of D'Qar",
    XWS = 'zizitlo-evacuationofdqar',
    Faction = 'resistance',
    limited = 1,
    ship_type = 'rz2awing',
    Charge = 1,
    init = 5,
    texture = 'red',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'For The Cause', charge = 0 },
        { name = 'Heroic', charge = 0},
        { name = 'Precision Holo-Targeter', charge = 0 }
    },
}

xwaPilotDb['zuckuss-armedanddangerous'] = {
    name = 'Zuckuss',
    title = 'Armed and Dangerous',
    XWS = 'zuckuss-armedanddangerous',
    Faction = 'scumandvillainy',
    limited = 1,
    Shield = 5,
    ship_type = 'g1astarfighter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'C'},
    arcs = { fixed = { range = 3, type = { 'front' } }, weapon = { { name = 'Tractor Beam', range = 3, type = { 'front' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Persistent Tracker', charge = 3 },
        { name = 'Tractor Beam', charge = 0 },
        { name = '4-Lom', limited = 1, charge = 0 },
        { name = 'Misthunter', limited = 1, charge = 0}
    }
}

xwaPilotDb['carnorjax-legendsandrelics'] = {
    name = 'Carnor Jax',
    title = 'Royal Guard',
    XWS = 'carnorjax-legendsandrelics',
    Faction = 'galacticempire',
    limited = 1,
    Force = 1,
    ship_type = 'tieininterceptor',
    init = 5,
    texture = 'red',
    actSet = { 'F', 'E', 'BR', 'B' },
}

xwaPilotDb['disl9b2-legendsandrelics'] = {
    name = 'DIS-L9B2',
    title = 'Calculated Risk',
    XWS = 'disl9b2-legendsandrelics',
    Faction = 'separatistalliance',
    limited = 1,
    Charge = 1,
    ship_type = 'droidtrifighter',
    init = 6,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

xwaPilotDb['herasyndulla-legendsandrelics'] = {
    name = 'Hera Syndulla',
    title = 'New Republic General',
    XWS = 'herasyndulla-legendsandrelics',
    Faction = 'rebelalliance',
    limited = 1,
    Shield = 4,
    ship_type = 'vcx100lightfreighter',
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
}

xwaPilotDb['kazudaxiono-legendsandrelics'] = {
    name = 'Kazuda Xiono',
    title = 'Resistance Spy',
    XWS = 'kazudaxiono-legendsandrelics',
    Faction = 'resistance',
    limited = 1,
    Shield = 3,
    ship_type = 't70xwing',
    addSlot = { 'Weapon Hardpoint' },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' },
}

xwaPilotDb['quinlanvos-legendsandrelics'] = {
    name = 'Quinlan Vos',
    title = 'Darkness Within',
    XWS = 'quinlanvos-legendsandrelics',
    Faction = 'galacticrepublic',
    limited = 1,
    Force = 2,
    ship_type = 'eta2actis',
    init = 4,
    texture = 'kit',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

xwaPilotDb['tamararyvora-legendsandrelics'] = {
    name = 'Tamara Ryvora',
    title = 'DT-533',
    XWS = 'tamararyvora-legendsandrelics',
    Faction = 'firstorder',
    limited = 1,
    Shield = 1,
    ship_type = 'tiefofighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
}

xwaPilotDb['thweek-legendsandrelics'] = {
    name = 'Thweek',
    title = 'Versatile Spy',
    XWS = 'thweek-legendsandrelics',
    Faction = 'scumandvillainy',
    limited = 1,
    Shield = 1,
    ship_type = 'starviperclassattackplatform',
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'VR', 'B' },
}

xwaPilotDb['ursawren-legendsandrelics'] = {
    name = 'Ursa Wren',
    title = 'Countess of Clan Wren',
    XWS = 'ursawren-legendsandrelics',
    Faction = 'galacticrepublic',
    limited = 1,
    Shield = 2,
    ship_type = 'gauntletfighter',
    init = 3,
    texture = 'bokatan',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}




return xwaPilotDb
