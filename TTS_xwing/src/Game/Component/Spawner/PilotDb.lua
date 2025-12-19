masterPilotDB = {}
masterPilotDB[0] = {
    ['name'] = '',
    ['XWS'] = '',
    ['Faction'] = 0,
    ['ship_type'] = 0,
    ['cost'] = 0,
    ['slot'] = {},
    ['Shield'] = 0,
    ['card'] = '',
    ['cardB'] = '',
    ['init'] = 0,
    ['actSet'] = {}
}



-- Huge ships
masterPilotDB[2000] = {
    name = 'Alderaanian Guard',
    XWS = 'alderaanianguard',
    Faction = 1,
    ship_type = 'cr90corvette',
    cost = 134,
    slot = { 21, 24, 24, 8, 8, 16, 23, 23, 22, 15 },
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'red'
}

masterPilotDB[2001] = {
    name = 'Republic Judiciary',
    XWS = 'republicjudiciary',
    Faction = 6,
    ship_type = 'cr90corvette',
    cost = 131,
    slot = { 21, 24, 24, 8, 8, 16, 23, 23, 22 },
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'blue'
}

masterPilotDB[2002] = {
    name = 'Separatist Privateers',
    XWS = 'separatistprivateers',
    Faction = 7,
    ship_type = 'croccruiser',
    cost = 63,
    slot = { 21, 24, 8, 8, 20, 23, 22, 12, 18 },
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB[2003] = {
    name = 'Syndicate Smugglers',
    XWS = 'syndicatesmugglers',
    Faction = 3,
    ship_type = 'croccruiser',
    cost = 63,
    slot = { 21, 24, 8, 8, 23, 22, 12, 13, 15, 18 },
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB[2004] = {
    name = 'First Order Sympathizers',
    XWS = 'firstordersympathizers',
    Docking = true,
    Faction = 5,
    ship_type = 'gozanticlasscruiser',
    cost = 67,
    slot = { 21, 24, 8, 8, 16, 23, 22, 22 },
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB[2005] = {
    name = 'Outer Rim Garrison',
    XWS = 'outerrimgarrison',
    Docking = true,
    Faction = 2,
    ship_type = 'gozanticlasscruiser',
    cost = 67,
    slot = { 21, 24, 8, 8, 16, 23, 22, 22, 15 },
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB[2006] = {
    name = 'Echo Base Evacuees',
    XWS = 'echobaseevacuees',
    Faction = 1,
    ship_type = 'gr75mediumtransport',
    cost = 65,
    slot = { 21, 24, 4, 8, 8, 23, 22, 22, 15 },
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB[2007] = {
    name = 'New Republic Volunteers',
    XWS = 'newrepublicvolunteers',
    Faction = 4,
    ship_type = 'gr75mediumtransport',
    cost = 65,
    slot = { 21, 24, 4, 8, 8, 23, 22, 22 },
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB[2008] = {
    name = 'First Order Collaborators',
    XWS = 'firstordercollaborators',
    Faction = 5,
    ship_type = 'raiderclasscorvette',
    cost = 131,
    slot = { 21, 5, 6, 24, 24, 8, 8, 23, 23, 22 },
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB[2009] = {
    name = 'Outer Rim Patrol',
    XWS = 'outerrimpatrol',
    Faction = 2,
    ship_type = 'raiderclasscorvette',
    cost = 134,
    slot = { 21, 5, 6, 24, 24, 8, 8, 23, 23, 22, 15 },
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB[2010] = {
    name = 'Lawless Pirates',
    XWS = 'lawlesspirates',
    Faction = 3,
    ship_type = 'tridentclassassaultship',
    cost = 85,
    slot = { 21, 5, 24, 24, 8, 8, 16, 23, 22, 15 },
    init = 8,
    actSet = { 'F', 'E', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB[2011] = {
    name = 'Colicoid Destroyer',
    XWS = 'colicoiddestroyer',
    Faction = 7,
    ship_type = 'tridentclassassaultship',
    cost = 85,
    slot = { 21, 5, 24, 24, 8, 8, 16, 23, 22, 15 },
    init = 8,
    actSet = { 'F', 'E', 'TL', 'R' },
    texture = 'standard'
}


masterPilotDB[1] = {
    name = 'Wedge Antilles',
    XWS = 'wedgeantilles',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 54,
    slot = { 21, 1, 5, 10, 14, 18 },
    init = 6,
    texture = 'wedge',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[2] = {
    name = 'Luke Skywalker',
    XWS = 'lukeskywalker',
    title = 'Red Five',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 60,
    slot = { 21, 17, 5, 10, 14, 18 },
    Force = 2,
    init = 5,
    texture = 'luke',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Light Side' }
}

masterPilotDB[3] = {
    name = 'Thane Kyrell',
    XWS = 'thanekyrell',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 46,
    slot = { 21, 1, 5, 10, 14, 18 },
    init = 5,
    texture = 'thane',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[4] = {
    name = 'Garven Dreis',
    XWS = 'garvendreis-t65xwing',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 46,
    slot = { 21, 1, 5, 10, 14, 18 },
    init = 4,
    texture = 'garven',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[5] = {
    name = 'Jek Porkins',
    XWS = 'jekporkins',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 44,
    slot = { 21, 1, 5, 10, 14, 18 },
    init = 4,
    texture = 'porkins',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[6] = {
    name = 'Kullbee Sperado',
    XWS = 'kullbeesperado',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 43,
    slot = { 21, 1, 5, 10, 13, 14, 18 },
    init = 4,
    texture = 'renegade',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB[7] = {
    name = 'Biggs Darklighter',
    XWS = 'biggsdarklighter',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 47,
    slot = { 21, 5, 10, 14, 18 },
    init = 3,
    texture = 'biggs',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[8] = {
    name = 'Leevan Tenza',
    XWS = 'leevantenza',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 41,
    slot = { 21, 1, 5, 10, 13, 14, 18 },
    init = 3,
    texture = 'renegade',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB[9] = {
    name = 'Edrio Two Tubes',
    XWS = 'edriotwotubes',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 42,
    slot = { 21, 5, 10, 13, 14, 18 },
    init = 2,
    texture = 'renegade',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB[10] = {
    name = 'Red Squadron Veteran',
    XWS = 'redsquadronveteran',
    Faction = 1,
    ship_type = 't65xwing',
    cost = 40,
    slot = { 21, 1, 5, 10, 14, 18 },
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[11] = {
    name = 'Blue Squadron Escort',
    XWS = 'bluesquadronescort',
    Faction = 1,
    ship_type = 't65xwing',
    cost = 38,
    slot = { 21, 5, 10, 14, 18 },
    init = 2,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[12] = {
    name = 'Cavern Angels Zealot',
    XWS = 'cavernangelszealot',
    Faction = 1,
    ship_type = 't65xwing',
    cost = 38,
    slot = { 21, 5, 10, 13, 14, 18 },
    init = 1,
    texture = 'renegade',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB[13] = {
    name = 'Norra Wexley',
    XWS = 'norrawexley-btla4ywing',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 40,
    slot = { 21, 1, 4, 5, 6, 10, 12, 14 },
    init = 5,
    texture = 'norra',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[14] = {
    name = '"Dutch" Vander',
    XWS = 'dutchvander',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 40,
    slot = { 21, 1, 4, 5, 6, 10, 12, 14 },
    init = 4,
    texture = 'gold',
    addSqdAction = { 'TL' },
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[15] = {
    name = 'Horton Salm',
    XWS = 'hortonsalm',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 36,
    slot = { 21, 1, 4, 5, 6, 10, 12, 14 },
    init = 4,
    texture = 'horton',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[16] = {
    name = 'Evaan Verlaine',
    XWS = 'evaanverlaine',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 34,
    slot = { 21, 1, 4, 5, 6, 10, 12, 14 },
    init = 3,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[17] = {
    name = 'Gold Squadron Veteran',
    XWS = 'goldsquadronveteran',
    Faction = 1,
    ship_type = 'btla4ywing',
    cost = 31,
    slot = { 21, 1, 4, 5, 6, 10, 12, 14 },
    init = 3,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[18] = {
    name = 'Gray Squadron Bomber',
    XWS = 'graysquadronbomber',
    Faction = 1,
    ship_type = 'btla4ywing',
    cost = 29,
    slot = { 21, 4, 5, 6, 10, 12, 14 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[19] = {
    name = 'Jake Farrell',
    XWS = 'jakefarrell',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 34,
    slot = { 21, 1, 1, 6, 18 },
    init = 4,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB[20] = {
    name = 'Arvel Crynyd',
    XWS = 'arvelcrynyd',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 32,
    slot = { 21, 1, 1, 6, 18 },
    init = 3,
    texture = 'arvel',
    actSet = { 'F', 'TL', 'E', 'Ail', 'BR' }
}

masterPilotDB[21] = {
    name = 'Green Squadron Pilot',
    XWS = 'greensquadronpilot',
    Faction = 1,
    ship_type = 'rz1awing',
    cost = 30,
    slot = { 21, 1, 1, 6, 18 },
    init = 3,
    texture = 'green',
    actSet = { 'F', 'TL', 'E', 'B', 'BR' }
}

masterPilotDB[22] = {
    name = 'Phoenix Squadron Pilot',
    XWS = 'phoenixsquadronpilot',
    Faction = 1,
    ship_type = 'rz1awing',
    cost = 28,
    slot = { 21, 1, 6, 18 },
    init = 1,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'B', 'BR' }
}


masterPilotDB[804] = {
    name = 'Hera Syndulla',
    XWS = 'herasyndulla-rz1awing',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 48,
    slot = { 21, 1, 1, 6, 18 },
    init = 6,
    texture = 'hera',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    keywords = { 'Spectre' }
}

masterPilotDB[805] = {
    name = 'Wedge Antilles',
    XWS = 'wedgeantilles-rz1awing',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 35,
    slot = { 21, 1, 1, 6, 18 },
    init = 4,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB[806] = {
    name = 'Derek Klivian',
    XWS = 'derekklivian',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 30,
    slot = { 21, 1, 1, 6, 18 },
    init = 3,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB[807] = {
    name = 'Shara Bey',
    XWS = 'sharabey-rz1awing',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 32,
    slot = { 21, 1, 1, 6, 18 },
    init = 4,
    texture = 'shara',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB[808] = {
    name = 'Ahsoka Tano',
    XWS = 'ahsokatano-rz1awing',
    Faction = 1,
    limited = 1,
    Force = 3,
    ship_type = 'rz1awing',
    cost = 49,
    slot = { 21, 17, 17, 6, 18 },
    init = 5,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    keywords = { 'Light Side' }
}

masterPilotDB[809] = {
    name = 'Sabine Wren',
    XWS = 'sabinewren-rz1awing',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 35,
    slot = { 21, 1, 1, 6, 18 },
    init = 3,
    texture = 'sabines',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[23] = {
    name = 'Braylen Stramm',
    XWS = 'braylenstramm',
    Faction = 1,
    limited = 1,
    ship_type = 'asf01bwing',
    cost = 52,
    slot = { 21, 1, 2, 3, 3, 5, 14, 15, 18 },
    init = 4,
    texture = 'braylen',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[24] = {
    name = 'Ten Numb',
    XWS = 'tennumb',
    Faction = 1,
    limited = 1,
    ship_type = 'asf01bwing',
    cost = 49,
    slot = { 21, 1, 2, 3, 3, 5, 14, 15, 18 },
    init = 4,
    texture = 'tennumb',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[25] = {
    name = 'Blade Squadron Veteran',
    XWS = 'bladesquadronveteran',
    Faction = 1,
    ship_type = 'asf01bwing',
    cost = 42,
    slot = { 21, 1, 2, 3, 3, 5, 14, 15, 18 },
    init = 3,
    texture = 'blade',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[26] = {
    name = 'Blue Squadron Pilot',
    XWS = 'bluesquadronpilot',
    Faction = 1,
    ship_type = 'asf01bwing',
    cost = 41,
    slot = { 21, 2, 3, 3, 5, 14, 15, 18 },
    init = 2,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[628] = {
    name = 'Gina Moonsong',
    XWS = 'ginamoonsong',
    Faction = 1,
    limited = 1,
    ship_type = 'asf01bwing',
    cost = 45,
    slot = { 21, 1, 2, 3, 3, 5, 14, 18 },
    init = 5,
    texture = 'gina',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[810] = {
    name = 'Hera Syndulla',
    XWS = 'herasyndulla-asf01bwing',
    Faction = 1,
    limited = 1,
    ship_type = 'asf01bwing',
    cost = 48,
    slot = { 21, 1, 2, 3, 3, 5, 14, 15, 18 },
    init = 6,
    texture = 'hera',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB[811] = {
    name = 'Netrem Pollard',
    XWS = 'netrempollard',
    Faction = 1,
    limited = 1,
    ship_type = 'asf01bwing',
    cost = 43,
    slot = { 21, 1, 2, 3, 3, 5, 14, 15, 18 },
    init = 3,
    texture = 'netrem',
    actSet = { 'F', 'TL', 'BR', 'Piv' }
}

masterPilotDB[27] = {
    name = 'Airen Cracken',
    XWS = 'airencracken',
    Faction = 1,
    limited = 1,
    ship_type = 'z95af4headhunter',
    cost = 35,
    slot = { 21, 1, 6, 14 },
    init = 5,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[28] = {
    name = 'Lieutenant Blount',
    XWS = 'lieutenantblount',
    Faction = 1,
    limited = 1,
    ship_type = 'z95af4headhunter',
    cost = 29,
    slot = { 21, 1, 6, 14 },
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[29] = {
    name = 'Tala Squadron Pilot',
    XWS = 'talasquadronpilot',
    Faction = 1,
    ship_type = 'z95af4headhunter',
    cost = 23,
    slot = { 21, 1, 6, 14 },
    init = 2,
    texture = 'tala',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[30] = {
    name = 'Bandit Squadron Pilot',
    XWS = 'banditsquadronpilot',
    Faction = 1,
    ship_type = 'z95af4headhunter',
    cost = 22,
    slot = { 21, 6, 14 },
    init = 1,
    texture = 'bandit',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[31] = {
    name = 'Wullffwarro',
    XWS = 'wullffwarro',
    Faction = 1,
    limited = 1,
    ship_type = 'auzituckgunship',
    cost = 53,
    slot = { 21, 1, 8, 8, 14 },
    init = 4,
    texture = 'cream',
    actSet = { 'F', 'R', 'BR' }
}

masterPilotDB[32] = {
    name = 'Lowhhrick',
    XWS = 'lowhhrick',
    Faction = 1,
    limited = 1,
    ship_type = 'auzituckgunship',
    cost = 50,
    slot = { 21, 1, 8, 8, 14 },
    init = 3,
    texture = 'orange',
    actSet = { 'F', 'R', 'BR' }
}

masterPilotDB[33] = {
    name = 'Kashyyyk Defender',
    XWS = 'kashyyykdefender',
    Faction = 1,
    ship_type = 'auzituckgunship',
    cost = 44,
    slot = { 21, 8, 8, 14 },
    init = 1,
    texture = 'cream',
    actSet = { 'F', 'R', 'BR' }
}

masterPilotDB[34] = {
    name = 'Hera Syndulla',
    XWS = 'herasyndulla',
    Faction = 1,
    limited = 1,
    ship_type = 'attackshuttle',
    cost = 38,
    slot = { 21, 1, 4, 8, 14, 15 },
    executeOptions = {
        rtl1 = { [1] = 'rtl1', [2] = 'rtr1', [3] = 'rtl3', [4] = 'rtr3', [5] = 'rk4' },
        rtr1 = { [1] = 'rtl1', [2] = 'rtr1', [3] = 'rtl3', [4] = 'rtr3', [5] = 'rk4' },
        rtl3 = { [1] = 'rtl1', [2] = 'rtr1', [3] = 'rtl3', [4] = 'rtr3', [5] = 'rk4' },
        rtr3 = { [1] = 'rtl1', [2] = 'rtr1', [3] = 'rtl3', [4] = 'rtr3', [5] = 'rk4' },
        rk4  = { [1] = 'rtl1', [2] = 'rtr1', [3] = 'rtl3', [4] = 'rtr3', [5] = 'rk4' },
        bs1  = { [1] = 'bs1', [2] = 'bbl1', [3] = 'bbr1', [4] = 'bs2' },
        bbl1 = { [1] = 'bs1', [2] = 'bbl1', [3] = 'bbr1', [4] = 'bs2' },
        bbr1 = { [1] = 'bs1', [2] = 'bbl1', [3] = 'bbr1', [4] = 'bs2' },
        bs2  = { [1] = 'bs1', [2] = 'bbl1', [3] = 'bbr1', [4] = 'bs2' }
    },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB[35] = {
    name = 'Sabine Wren',
    XWS = 'sabinewren',
    Faction = 1,
    limited = 1,
    ship_type = 'attackshuttle',
    cost = 41,
    slot = { 21, 1, 4, 8, 14, 15 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'B', 'BR' },
    keywords = { 'Spectre', 'Mandalorian' }
}

masterPilotDB[36] = {
    name = 'Ezra Bridger',
    XWS = 'ezrabridger',
    Faction = 1,
    limited = 1,
    ship_type = 'attackshuttle',
    cost = 40,
    slot = { 21, 17, 4, 8, 14, 15 },
    Force = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Spectre', 'Light Side' }
}

masterPilotDB[37] = {
    name = '"Zeb" Orrelios',
    XWS = 'zeborrelios',
    Faction = 1,
    limited = 1,
    ship_type = 'attackshuttle',
    cost = 33,
    slot = { 21, 1, 4, 8, 14, 15 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB[38] = {
    name = 'Fenn Rau',
    XWS = 'fennrau-sheathipedeclassshuttle',
    Faction = 1,
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    cost = 47,
    slot = { 21, 1, 8, 10, 14, 15 },
    init = 6,
    texture = 'standard',
    actSet = { 'F' },
    keywords = { 'Spectre', 'Mandalorian' }
}

masterPilotDB[39] = {
    name = 'Ezra Bridger',
    XWS = 'ezrabridger-sheathipedeclassshuttle',
    Faction = 1,
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    cost = 40,
    slot = { 21, 17, 8, 10, 14, 15 },
    Force = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F' },
    keywords = { 'Spectre', 'Light Side' }
}

masterPilotDB[40] = {
    name = '"Zeb" Orrelios',
    XWS = 'zeborrelios-sheathipedeclassshuttle',
    Faction = 1,
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    cost = 33,
    slot = { 21, 1, 8, 10, 14, 15 },
    init = 2,
    texture = 'standard',
    actSet = { 'F' },
    keywords = { 'Spectre' }
}

masterPilotDB[41] = {
    name = 'AP-5',
    XWS = 'ap5',
    Faction = 1,
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    cost = 32,
    slot = { 21, 1, 8, 10, 14, 15 },
    init = 1,
    texture = 'standard',
    actSet = { 'C' },
    keywords = { 'Spectre', 'Droid' }
}

masterPilotDB[42] = {
    name = 'Jan Ors',
    XWS = 'janors',
    Faction = 1,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    cost = 41,
    slot = { 21, 1, 8, 12, 14, 14, 15 },
    init = 5,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[43] = {
    name = 'Kyle Katarn',
    XWS = 'kylekatarn',
    Faction = 1,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    cost = 31,
    slot = { 21, 1, 8, 12, 14, 14, 15 },
    init = 3,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[44] = {
    name = 'Roark Garnet',
    XWS = 'roarkgarnet',
    Faction = 1,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    cost = 38,
    slot = { 21, 1, 8, 12, 14, 14, 15 },
    init = 4,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[45] = {
    name = 'Rebel Scout',
    XWS = 'rebelscout',
    Faction = 1,
    ship_type = 'hwk290lightfreighter',
    cost = 29,
    slot = { 21, 8, 12, 14, 14, 15 },
    init = 2,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[46] = {
    name = 'Ezra Bridger',
    XWS = 'ezrabridger-tielnfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 26,
    slot = { 21, 17, 14 },
    Force = 1,
    init = 3,
    texture = 'rebel',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Light Side', 'Spectre' }
}

masterPilotDB[47] = {
    name = 'Sabine Wren',
    XWS = 'sabinewren-tielnfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 26,
    slot = { 21, 1, 14 },
    init = 3,
    texture = 'rebel',
    actSet = { 'F', 'E', 'B', 'BR' },
    keywords = { 'Spectre', 'Mandalorian' }
}

masterPilotDB[48] = {
    name = 'Captain Rex',
    XWS = 'captainrex',
    Condition = 'Suppressive Fire',
    Faction = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 26,
    slot = { 21, 14 },
    init = 2,
    texture = 'rebel',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[49] = {
    name = '"Zeb" Orrelios',
    XWS = 'zeborrelios-tielnfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 22,
    slot = { 21, 14 },
    init = 2,
    texture = 'rebel',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB[50] = {
    name = 'Corran Horn',
    XWS = 'corranhorn',
    Faction = 1,
    limited = 1,
    ship_type = 'ewing',
    cost = 59,
    slot = { 21, 1, 19, 2, 5, 10, 14 },
    init = 5,
    texture = 'corran',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB[51] = {
    name = 'Gavin Darklighter',
    XWS = 'gavindarklighter',
    Faction = 1,
    limited = 1,
    ship_type = 'ewing',
    cost = 55,
    slot = { 21, 1, 19, 2, 5, 10, 14 },
    init = 4,
    texture = 'gavin',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB[52] = {
    name = 'Rogue Squadron Escort',
    XWS = 'roguesquadronescort',
    Faction = 1,
    ship_type = 'ewing',
    cost = 51,
    slot = { 21, 1, 19, 2, 5, 10, 14 },
    init = 4,
    texture = 'rogue',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB[53] = {
    name = 'Knave Squadron Escort',
    XWS = 'knavesquadronescort',
    Faction = 1,
    ship_type = 'ewing',
    cost = 48,
    slot = { 21, 19, 2, 5, 10, 14 },
    init = 2,
    texture = 'knave',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB[54] = {
    name = 'Bodhi Rook',
    XWS = 'bodhirook',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    cost = 48,
    slot = { 21, 1, 2, 8, 8, 14, 18 },
    init = 4,
    texture = 'captain',
    actSet = { 'F', 'TL' }
}

masterPilotDB[55] = {
    name = 'Saw Gerrera',
    XWS = 'sawgerrera',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    cost = 52,
    slot = { 21, 1, 2, 8, 8, 13, 14, 18 },
    init = 4,
    texture = 'renegade',
    actSet = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB[56] = {
    name = 'Cassian Andor',
    XWS = 'cassianandor',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    cost = 51,
    slot = { 21, 1, 2, 8, 8, 14, 18 },
    init = 3,
    texture = 'captain',
    actSet = { 'F', 'TL' }
}

masterPilotDB[57] = {
    name = 'Magva Yarro',
    XWS = 'magvayarro',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    cost = 50,
    slot = { 21, 1, 2, 8, 8, 13, 14, 18 },
    init = 3,
    texture = 'renegade',
    actSet = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB[58] = {
    name = 'Benthic Two Tubes',
    XWS = 'benthictwotubes',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    cost = 46,
    slot = { 21, 2, 8, 8, 13, 14, 18 },
    init = 2,
    texture = 'renegade',
    actSet = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB[59] = {
    name = 'Heff Tobber',
    XWS = 'hefftobber',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    cost = 44,
    slot = { 21, 1, 2, 8, 8, 14, 18 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB[60] = {
    name = 'Blue Squadron Scout',
    XWS = 'bluesquadronscout',
    Faction = 1,
    ship_type = 'ut60duwing',
    cost = 43,
    slot = { 21, 2, 8, 8, 14, 18 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB[61] = {
    name = 'Partisan Renegade',
    XWS = 'partisanrenegade',
    Faction = 1,
    ship_type = 'ut60duwing',
    cost = 43,
    slot = { 21, 2, 8, 8, 13, 14, 18 },
    init = 1,
    texture = 'renegade',
    actSet = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB[629] = {
    name = 'K-2SO',
    XWS = 'k2so',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    cost = 46,
    slot = { 21, 1, 2, 8, 8, 14, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL' },
    keywords = { 'Droid' }
}


masterPilotDB[62] = {
    name = 'Miranda Doni',
    XWS = 'mirandadoni',
    Faction = 1,
    limited = 1,
    ship_type = 'btls8kwing',
    cost = 40,
    slot = { 21, 5, 6, 6, 16, 8, 12, 12, 14 },
    init = 4,
    texture = 'miranda',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB[63] = {
    name = 'Esege Tuketu',
    XWS = 'esegetuketu',
    Faction = 1,
    limited = 1,
    ship_type = 'btls8kwing',
    cost = 43,
    slot = { 21, 5, 6, 6, 16, 8, 12, 12, 14 },
    init = 3,
    texture = 'esege',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB[64] = {
    name = 'Warden Squadron Pilot',
    XWS = 'wardensquadronpilot',
    Faction = 1,
    ship_type = 'btls8kwing',
    cost = 38,
    slot = { 21, 5, 6, 6, 16, 8, 12, 12, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB[65] = {
    name = 'Norra Wexley',
    XWS = 'norrawexley',
    Faction = 1,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 53,
    slot = { 21, 1, 5, 8, 16, 10, 14 },
    init = 5,
    texture = 'rebel',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[66] = {
    name = 'Garven Dreis',
    XWS = 'garvendreis',
    Faction = 1,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 49,
    slot = { 21, 1, 5, 8, 16, 10, 14 },
    init = 4,
    texture = 'rebel',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[67] = {
    name = 'Shara Bey',
    XWS = 'sharabey',
    Faction = 1,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 50,
    slot = { 21, 1, 5, 8, 16, 10, 14 },
    init = 4,
    texture = 'rebel',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[68] = {
    name = 'Ibtisam',
    XWS = 'ibtisam',
    Faction = 1,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 45,
    slot = { 21, 1, 5, 8, 16, 10, 14 },
    init = 3,
    texture = 'rebel',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[69] = {
    name = 'Han Solo',
    XWS = 'hansolo-modifiedyt1300lightfreighter',
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    cost = 79,
    slot = { 21, 1, 6, 8, 8, 16, 14, 14, 15 },
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[70] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian-modifiedyt1300lightfreighter',
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    cost = 78,
    slot = { 21, 1, 6, 8, 8, 16, 14, 14, 15 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[71] = {
    name = 'Chewbacca',
    XWS = 'chewbacca',
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    cost = 70,
    slot = { 21, 1, 6, 8, 8, 16, 14, 14, 15 },
    Charge = 1,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[72] = {
    name = 'Outer Rim Smuggler',
    XWS = 'outerrimsmuggler',
    Faction = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    cost = 67,
    slot = { 21, 6, 8, 8, 16, 14, 14, 15 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[630] = {
    name = 'Leia Organa',
    XWS = 'leiaorgana',
    Force = 1,
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    cost = 77,
    slot = { 21, 17, 6, 8, 8, 16, 14, 14, 15 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' },
    keywords = { 'Light Side' }
}

masterPilotDB[73] = {
    name = 'Hera Syndulla',
    XWS = 'herasyndulla-vcx100lightfreighter',
    Faction = 1,
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    cost = 69,
    slot = { 21, 1, 2, 4, 5, 8, 8, 16, 14, 15 },
    executeOptions = {
        rtl1 = { [1] = 'rtl1', [2] = 'rtr1', [3] = 'rtl3', [4] = 'rtr3', [5] = 'rk4' },
        rtr1 = { [1] = 'rtl1', [2] = 'rtr1', [3] = 'rtl3', [4] = 'rtr3', [5] = 'rk4' },
        rtl3 = { [1] = 'rtl1', [2] = 'rtr1', [3] = 'rtl3', [4] = 'rtr3', [5] = 'rk4' },
        rtr3 = { [1] = 'rtl1', [2] = 'rtr1', [3] = 'rtl3', [4] = 'rtr3', [5] = 'rk4' },
        rk4  = { [1] = 'rtl1', [2] = 'rtr1', [3] = 'rtl3', [4] = 'rtr3', [5] = 'rk4' },
        bs1  = { [1] = 'bs1', [2] = 'bbl2', [3] = 'bbr2', [4] = 'bs2' },
        bbl2 = { [1] = 'bs1', [2] = 'bbl2', [3] = 'bbr2', [4] = 'bs2' },
        bbr2 = { [1] = 'bs1', [2] = 'bbl2', [3] = 'bbr2', [4] = 'bs2' },
        bs2  = { [1] = 'bs1', [2] = 'bbl2', [3] = 'bbr2', [4] = 'bs2' }
    },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    keywords = { 'Spectre' }
}

masterPilotDB[74] = {
    name = 'Kanan Jarrus',
    XWS = 'kananjarrus',
    Faction = 1,
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    cost = 73,
    slot = { 21, 17, 2, 4, 5, 8, 8, 16, 14, 15 },
    Force = 2,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    keywords = { 'Jedi', 'Light Side', 'Spectre' }
}

masterPilotDB[75] = {
    name = '"Chopper"',
    XWS = 'chopper',
    Faction = 1,
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    cost = 66,
    slot = { 21, 4, 2, 5, 8, 8, 16, 14, 15 },
    init = 2,
    texture = 'standard',
    actSet = { 'C', 'TL', 'R' },
    keywords = { 'Droid', 'Spectre' }
}

masterPilotDB[76] = {
    name = 'Lothal Rebel',
    XWS = 'lothalrebel',
    Faction = 1,
    ship_type = 'vcx100lightfreighter',
    cost = 68,
    slot = { 21, 4, 2, 5, 8, 8, 16, 14, 15 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB[631] = {
    name = 'Alexsandr Kallus',
    XWS = 'alexsandrkallus',
    Faction = 1,
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    cost = 68,
    slot = { 21, 1, 2, 4, 5, 8, 8, 16, 14, 15 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    keywords = { 'Spectre' }
}

masterPilotDB[77] = {
    name = 'Dash Rendar',
    XWS = 'dashrendar',
    Faction = 1,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    cost = 79,
    slot = { 21, 1, 8, 8, 6, 13, 14, 15 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB[78] = {
    name = '"Leebo"',
    XWS = 'leebo',
    Faction = 1,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    cost = 72,
    slot = { 1, 21, 6, 13, 13, 14, 15 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' }
}

masterPilotDB[79] = {
    name = 'Wild Space Fringer',
    XWS = 'wildspacefringer',
    Faction = 1,
    ship_type = 'yt2400lightfreighter',
    cost = 72,
    slot = { 21, 8, 8, 6, 13, 14, 15 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB[80] = {
    name = '"Mauler" Mithel',
    XWS = 'maulermithel',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 28,
    slot = { 21, 1, 14 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[81] = {
    name = '"Howlrunner"',
    XWS = 'howlrunner',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 41,
    slot = { 21, 1, 14 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[82] = {
    name = '"Scourge" Skutu',
    XWS = 'scourgeskutu',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 28,
    slot = { 21, 1, 14 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[83] = {
    name = 'Iden Versio',
    XWS = 'idenversio',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 40,
    slot = { 21, 1, 14 },
    Shield = 0,
    Charge = 1,
    init = 4,
    texture = 'inferno',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[84] = {
    name = 'Gideon Hask',
    XWS = 'gideonhask',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 27,
    slot = { 21, 1, 14 },
    init = 4,
    texture = 'inferno',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[85] = {
    name = 'Del Meeko',
    XWS = 'delmeeko',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 27,
    slot = { 21, 1, 14 },
    init = 4,
    texture = 'inferno',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[86] = {
    name = 'Seyn Marana',
    XWS = 'seynmarana',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 27,
    slot = { 21, 1, 14 },
    init = 4,
    texture = 'inferno',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[87] = {
    name = 'Valen Rudor',
    XWS = 'valenrudor',
    Faction = 2,
    limited = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 24,
    slot = { 21, 1, 14 },
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[88] = {
    name = '"Night Beast"',
    XWS = 'nightbeast',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 23,
    slot = { 21, 14 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[89] = {
    name = '"Wampa"',
    XWS = 'wampa',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 28,
    slot = { 21, 14 },
    Charge = 1,
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[90] = {
    name = 'Black Squadron Ace',
    XWS = 'blacksquadronace',
    Faction = 2,
    ship_type = 'tielnfighter',
    cost = 25,
    slot = { 21, 1, 14 },
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[91] = {
    name = 'Obsidian Squadron Pilot',
    XWS = 'obsidiansquadronpilot',
    Faction = 2,
    ship_type = 'tielnfighter',
    cost = 23,
    slot = { 21, 14 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[92] = {
    name = 'Academy Pilot',
    XWS = 'academypilot',
    Faction = 2,
    ship_type = 'tielnfighter',
    cost = 22,
    slot = { 21, 14 },
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[93] = {
    name = 'Darth Vader',
    XWS = 'darthvader',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    cost = 66,
    slot = { 21, 17, 2, 6, 14 },
    Force = 3,
    init = 6,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB[94] = {
    name = 'Maarek Stele',
    XWS = 'maarekstele',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    cost = 44,
    slot = { 21, 1, 2, 6, 14 },
    init = 5,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[95] = {
    name = 'Ved Foslo',
    XWS = 'vedfoslo',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    cost = 43,
    slot = { 21, 1, 2, 6, 14 },
    executeOptions = {
        ws1   = { [1] = 'ws1', [2] = 'ws2' },
        bs2   = { [1] = 'bs1', [2] = 'bs2', [3] = 'bs3' },
        bs3   = { [1] = 'bs2', [2] = 'bs3', [3] = 'bs4' },
        ws4   = { [1] = 'ws3', [2] = 'ws4', [3] = 'ws5' },
        ws5   = { [1] = 'ws4', [2] = 'ws5' },
        bbl1  = { [1] = 'bbl1', [2] = 'bbl2' },
        bbr1  = { [1] = 'bbr1', [2] = 'bbr2' },
        bbl2  = { [1] = 'bbl1', [2] = 'bbl2', [3] = 'bbl3' },
        bbr2  = { [1] = 'bbr1', [2] = 'bbr2', [3] = 'bbr3' },
        wbl3  = { [1] = 'wbl2', [2] = 'wbl3' },
        wbr3  = { [1] = 'wbr2', [2] = 'wbr3' },
        wtl2  = { [1] = 'wtl1', [2] = 'wtl2', [3] = 'wtl3' },
        wtr2  = { [1] = 'wtr1', [2] = 'wtr2', [3] = 'wtr3' },
        wtl3  = { [1] = 'wtl2', [2] = 'wtl3' },
        wtr3  = { [1] = 'wtr2', [2] = 'wtr3' },
        rtl3t = { [1] = 'rtl2t', [2] = 'rtl3t' },
        rtr3t = { [1] = 'rtr2t', [2] = 'rtr3t' },
        rk4   = { [1] = 'rk3', [2] = 'rk4', [3] = 'rk5' }
    },
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[96] = {
    name = 'Zertik Strom',
    XWS = 'zertikstrom',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    cost = 40,
    slot = { 21, 2, 6, 14 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[97] = {
    name = 'Storm Squadron Ace',
    XWS = 'stormsquadronace',
    Faction = 2,
    ship_type = 'tieadvancedx1',
    cost = 39,
    slot = { 21, 1, 2, 6, 14 },
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[98] = {
    name = 'Tempest Squadron Pilot',
    XWS = 'tempestsquadronpilot',
    Faction = 2,
    ship_type = 'tieadvancedx1',
    cost = 36,
    slot = { 21, 2, 6, 14 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[99] = {
    name = 'Grand Inquisitor',
    XWS = 'grandinquisitor',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedv1',
    cost = 52,
    slot = { 21, 17, 2, 6 },
    Force = 2,
    init = 5,
    texture = 'grey',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side' }
}

masterPilotDB[100] = {
    name = 'Seventh Sister',
    XWS = 'seventhsister',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedv1',
    cost = 43,
    slot = { 21, 17, 2, 6 },
    Force = 2,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[101] = {
    name = 'Baron of the Empire',
    XWS = 'baronoftheempire',
    Faction = 2,
    ship_type = 'tieadvancedv1',
    cost = 31,
    slot = { 21, 1, 2, 6 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[102] = {
    name = 'Inquisitor',
    XWS = 'inquisitor',
    Faction = 2,
    ship_type = 'tieadvancedv1',
    cost = 39,
    slot = { 21, 17, 2, 6 },
    Force = 1,
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[632] = {
    name = 'Fifth Brother',
    XWS = 'fifthbrother',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedv1',
    cost = 44,
    slot = { 21, 17, 2, 6 },
    Force = 2,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' }
}


masterPilotDB[103] = {
    name = 'Soontir Fel',
    XWS = 'soontirfel',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 53,
    slot = { 21, 1, 14, 14, 18 },
    init = 6,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB[104] = {
    name = 'Turr Phennir',
    XWS = 'turrphennir',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 42,
    slot = { 21, 1, 14, 14, 18 },
    init = 4,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB[105] = {
    name = 'Saber Squadron Ace',
    XWS = 'sabersquadronace',
    Faction = 2,
    ship_type = 'tieininterceptor',
    cost = 36,
    slot = { 21, 1, 14, 14, 18 },
    init = 4,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB[106] = {
    name = 'Alpha Squadron Pilot',
    XWS = 'alphasquadronpilot',
    Faction = 2,
    ship_type = 'tieininterceptor',
    cost = 32,
    slot = { 21, 14, 14, 18 },
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB[830] = {
    name = 'Ciena Ree',
    XWS = 'cienaree',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 48,
    slot = { 21, 1, 14, 14, 18 },
    init = 6,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB[831] = {
    name = 'Vult Skerris',
    XWS = 'vultskerris-tieininterceptor',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 43,
    slot = { 21, 1, 14, 14, 18 },
    Charge = 1,
    init = 5,
    texture = 'skystrike',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB[832] = {
    name = 'Commandant Goran',
    XWS = 'commandantgoran',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 43,
    slot = { 21, 1, 14, 14, 18 },
    init = 4,
    texture = 'skystrike',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB[833] = {
    name = 'Gideon Hask',
    XWS = 'gideonhask-tieininterceptor',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 48,
    slot = { 21, 1, 14, 14, 18 },
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB[834] = {
    name = 'Nash Windrider',
    XWS = 'nashwindrider',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 41,
    slot = { 21, 1, 14, 14, 18 },
    Charge = 1,
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB[835] = {
    name = 'Lieutenant Lorrir',
    XWS = 'lieutenantlorrir',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 39,
    slot = { 21, 1, 14, 14, 18 },
    init = 3,
    texture = 'the181',
    actSet = { 'F', 'E', 'VR', 'B' }
}

masterPilotDB[107] = {
    name = 'Tomax Bren',
    XWS = 'tomaxbren',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    cost = 35,
    slot = { 21, 1, 5, 6, 6, 16, 12, 12, 14 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[108] = {
    name = 'Captain Jonus',
    XWS = 'captainjonus',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    cost = 45,
    slot = { 21, 1, 5, 6, 6, 16, 12, 12, 14 },
    init = 4,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[109] = {
    name = 'Major Rhymer',
    XWS = 'majorrhymer',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    cost = 37,
    slot = { 21, 1, 5, 6, 6, 16, 12, 12, 14 },
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[110] = {
    name = '"Deathfire"',
    XWS = 'deathfire',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    cost = 32,
    slot = { 21, 5, 6, 6, 16, 12, 12, 14 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[111] = {
    name = 'Gamma Squadron Ace',
    XWS = 'gammasquadronace',
    Faction = 2,
    ship_type = 'tiesabomber',
    cost = 30,
    slot = { 21, 1, 5, 6, 6, 16, 12, 12, 14 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[112] = {
    name = 'Scimitar Squadron Pilot',
    XWS = 'scimitarsquadronpilot',
    Faction = 2,
    ship_type = 'tiesabomber',
    cost = 27,
    slot = { 21, 5, 6, 6, 16, 12, 12, 14 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[113] = {
    name = 'Major Vermeil',
    XWS = 'majorvermeil',
    Faction = 2,
    limited = 1,
    ship_type = 'tierereaper',
    cost = 49,
    slot = { 21, 1, 8, 8, 14 },
    init = 4,
    texture = 'blue',
    actSet = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB[114] = {
    name = 'Captain Feroph',
    XWS = 'captainferoph',
    Faction = 2,
    limited = 1,
    ship_type = 'tierereaper',
    cost = 47,
    slot = { 21, 1, 8, 8, 14 },
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB[115] = {
    name = '"Vizier"',
    XWS = 'vizier',
    Faction = 2,
    limited = 1,
    ship_type = 'tierereaper',
    cost = 42,
    slot = { 21, 8, 8, 14 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB[116] = {
    name = 'Scarif Base Pilot',
    XWS = 'scarifbasepilot',
    Faction = 2,
    ship_type = 'tierereaper',
    cost = 39,
    slot = { 21, 8, 8, 14 },
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB[117] = {
    name = '"Duchess"',
    XWS = 'duchess',
    Faction = 2,
    limited = 1,
    ship_type = 'tieskstriker',
    cost = 44,
    slot = { 21, 1, 16, 12, 14 },
    init = 5,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB[118] = {
    name = '"Countdown"',
    XWS = 'countdown',
    Faction = 2,
    limited = 1,
    ship_type = 'tieskstriker',
    cost = 41,
    slot = { 21, 1, 16, 12, 14 },
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB[119] = {
    name = '"Pure Sabacc"',
    XWS = 'puresabacc',
    Faction = 2,
    limited = 1,
    ship_type = 'tieskstriker',
    cost = 42,
    slot = { 21, 1, 16, 12, 14 },
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB[120] = {
    name = 'Black Squadron Scout',
    XWS = 'blacksquadronscout',
    Faction = 2,
    ship_type = 'tieskstriker',
    cost = 34,
    slot = { 21, 1, 16, 12, 14 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB[121] = {
    name = 'Planetary Sentinel',
    XWS = 'planetarysentinel',
    Faction = 2,
    ship_type = 'tieskstriker',
    cost = 32,
    slot = { 21, 16, 12, 14 },
    init = 1,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB[633] = {
    name = '"Vagabond"',
    XWS = 'vagabond',
    Faction = 2,
    limited = 1,
    ship_type = 'tieskstriker',
    cost = 32,
    slot = { 21, 1, 16, 12, 14 },
    init = 2,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB[122] = {
    name = 'Rexler Brath',
    XWS = 'rexlerbrath',
    Faction = 2,
    limited = 1,
    ship_type = 'tiededefender',
    cost = 78,
    slot = { 21, 1, 2, 3, 6, 18 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB[123] = {
    name = 'Colonel Vessery',
    XWS = 'colonelvessery',
    Faction = 2,
    limited = 1,
    ship_type = 'tiededefender',
    cost = 81,
    slot = { 21, 1, 2, 3, 6, 18 },
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB[124] = {
    name = 'Countess Ryad',
    XWS = 'countessryad',
    Faction = 2,
    limited = 1,
    ship_type = 'tiededefender',
    cost = 79,
    slot = { 21, 1, 2, 3, 6, 18 },
    init = 4,
    executeOptions = {
        bs2 = { [1] = 'bs2', [2] = 'wk2' },
        bs3 = { [1] = 'bs3', [2] = 'wk3' },
        bs4 = { [1] = 'bs4', [2] = 'wk4' },
        bs5 = { [1] = 'bs5', [2] = 'wk5' }
    },
    texture = 'red',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB[125] = {
    name = 'Onyx Squadron Ace',
    XWS = 'onyxsquadronace',
    Faction = 2,
    ship_type = 'tiededefender',
    cost = 73,
    slot = { 21, 1, 2, 3, 6, 18 },
    init = 4,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB[126] = {
    name = 'Delta Squadron Pilot',
    XWS = 'deltasquadronpilot',
    Faction = 2,
    ship_type = 'tiededefender',
    cost = 67,
    slot = { 21, 2, 3, 6, 18 },
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}


masterPilotDB[815] = {
    name = 'Darth Vader',
    XWS = 'darthvader-tieddefender',
    Faction = 2,
    ship_type = 'tiededefender',
    cost = 112,
    slot = { 21, 17, 3, 6, 18 },
    Force = 3,
    init = 6,
    texture = 'vader',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' },
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB[816] = {
    name = 'Vult Skerris',
    XWS = 'vultskerris',
    Faction = 2,
    ship_type = 'tiededefender',
    cost = 77,
    Charge = 1,
    slot = { 21, 1, 2, 3, 6, 18 },
    init = 5,
    texture = 'skystrike',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB[817] = {
    name = 'Captain Dobbs',
    XWS = 'captaindobbs',
    Faction = 2,
    ship_type = 'tiededefender',
    cost = 73,
    slot = { 21, 1, 2, 3, 6, 18 },
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB[127] = {
    name = 'Lieutenant Kestal',
    XWS = 'lieutenantkestal',
    Faction = 2,
    limited = 1,
    ship_type = 'tieagaggressor',
    cost = 29,
    slot = { 21, 1, 4, 6, 6, 16, 14 },
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB[128] = {
    name = '"Double Edge"',
    XWS = 'doubleedge',
    Faction = 2,
    limited = 1,
    ship_type = 'tieagaggressor',
    cost = 28,
    slot = { 21, 1, 4, 6, 6, 16, 14 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB[129] = {
    name = 'Onyx Squadron Scout',
    XWS = 'onyxsquadronscout',
    Faction = 2,
    ship_type = 'tieagaggressor',
    cost = 28,
    slot = { 21, 1, 4, 6, 6, 16, 14 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB[130] = {
    name = 'Sienar Specialist',
    XWS = 'sienarspecialist',
    Faction = 2,
    ship_type = 'tieagaggressor',
    cost = 26,
    slot = { 21, 4, 6, 6, 16, 14 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB[131] = {
    name = '"Whisper"',
    title = 'Soft-Spoken Slayer',
    XWS = 'whisper',
    Faction = 2,
    limited = 1,
    ship_type = 'tiephphantom',
    cost = 60,
    slot = { 21, 1, 2, 16, 14 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB[132] = {
    name = '"Echo"',
    title = 'Slippery Trickster',
    XWS = 'echo',
    Faction = 2,
    limited = 1,
    ship_type = 'tiephphantom',
    cost = 51,
    slot = { 21, 1, 2, 16, 14 },
    init = 4,
    texture = 'echo',
    actSet = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB[133] = {
    name = 'Sigma Squadron Ace',
    XWS = 'sigmasquadronace',
    Faction = 2,
    ship_type = 'tiephphantom',
    cost = 49,
    slot = { 21, 1, 2, 16, 14 },
    init = 4,
    texture = 'sigma',
    actSet = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB[134] = {
    name = 'Imdaar Test Pilot',
    XWS = 'imdaartestpilot',
    Faction = 2,
    ship_type = 'tiephphantom',
    cost = 43,
    slot = { 21, 2, 16, 14 },
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB[135] = {
    name = 'Major Vynder',
    title = 'Pragmatic Survivor',
    XWS = 'majorvynder',
    Faction = 2,
    limited = 1,
    ship_type = 'alphaclassstarwing',
    cost = 40,
    slot = { 21, 1, 2, 5, 6, 14, 18 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB[136] = {
    name = 'Lieutenant Karsabi',
    title = 'Brash Noble',
    XWS = 'lieutenantkarsabi',
    Faction = 2,
    limited = 1,
    ship_type = 'alphaclassstarwing',
    cost = 33,
    slot = { 21, 1, 2, 5, 6, 14, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB[137] = {
    name = 'Rho Squadron Pilot',
    XWS = 'rhosquadronpilot',
    Faction = 2,
    ship_type = 'alphaclassstarwing',
    cost = 34,
    slot = { 21, 1, 2, 5, 6, 14, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB[138] = {
    name = 'Nu Squadron Pilot',
    XWS = 'nusquadronpilot',
    Faction = 2,
    ship_type = 'alphaclassstarwing',
    cost = 32,
    slot = { 21, 2, 5, 6, 14, 18 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB[139] = {
    name = '"Redline"',
    XWS = 'redline',
    Faction = 2,
    limited = 1,
    ship_type = 'tiecapunisher',
    cost = 51,
    slot = { 21, 2, 5, 6, 6, 16, 12, 12, 14 },
    init = 5,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR', "B" }
}
masterPilotDB[140] = {
    name = '"Deathrain"',
    XWS = 'deathrain',
    Faction = 2,
    limited = 1,
    ship_type = 'tiecapunisher',
    cost = 43,
    slot = { 21, 2, 5, 6, 6, 16, 12, 12, 14 },
    init = 4,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', "B" }
}

masterPilotDB[141] = {
    name = 'Cutlass Squadron Pilot',
    XWS = 'cutlasssquadronpilot',
    Faction = 2,
    ship_type = 'tiecapunisher',
    cost = 35,
    slot = { 21, 2, 5, 6, 6, 16, 12, 12, 14 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR', "B" }
}

masterPilotDB[142] = {
    name = 'Captain Kagi',
    XWS = 'captainkagi',
    Faction = 2,
    limited = 1,
    ship_type = 'lambdaclasst4ashuttle',
    cost = 47,
    slot = { 21, 2, 3, 8, 8, 14, 15 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'R' }
}

masterPilotDB[143] = {
    name = 'Colonel Jendon',
    XWS = 'coloneljendon',
    Faction = 2,
    limited = 1,
    ship_type = 'lambdaclasst4ashuttle',
    cost = 49,
    slot = { 21, 2, 3, 8, 8, 14, 15 },
    Charge = 2,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'R' }
}

masterPilotDB[144] = {
    name = 'Lieutenant Sai',
    XWS = 'lieutenantsai',
    Faction = 2,
    limited = 1,
    ship_type = 'lambdaclasst4ashuttle',
    cost = 46,
    slot = { 21, 2, 3, 8, 8, 14, 15 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'R' }
}

masterPilotDB[145] = {
    name = 'Omicron Group Pilot',
    XWS = 'omicrongrouppilot',
    Faction = 2,
    ship_type = 'lambdaclasst4ashuttle',
    cost = 41,
    slot = { 21, 2, 3, 8, 8, 14, 15 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'R' }
}

masterPilotDB[146] = {
    name = 'Captain Oicunn',
    XWS = 'captainoicunn',
    Faction = 2,
    limited = 1,
    ship_type = 'vt49decimator',
    cost = 71,
    slot = { 21, 1, 5, 8, 8, 8, 16, 12, 14, 15 },
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB[147] = {
    name = 'Rear Admiral Chiraneau',
    XWS = 'rearadmiralchiraneau',
    Faction = 2,
    limited = 1,
    ship_type = 'vt49decimator',
    cost = 75,
    slot = { 21, 1, 5, 8, 8, 8, 16, 12, 14, 15 },
    init = 5,
    texture = 'grey',
    actSet = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB[148] = {
    name = 'Patrol Leader',
    XWS = 'patrolleader',
    Faction = 2,
    ship_type = 'vt49decimator',
    cost = 67,
    slot = { 21, 5, 8, 8, 8, 16, 12, 14, 15 },
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB[634] = {
    name = 'Morna Kee',
    XWS = 'mornakee',
    Faction = 2,
    limited = 1,
    ship_type = 'vt49decimator',
    cost = 73,
    slot = { 21, 1, 5, 8, 8, 8, 16, 12, 14, 15 },
    Charge = 3,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB[149] = {
    name = 'Boba Fett',
    XWS = 'bobafett',
    title = 'Notorious Bounty Hunter',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 85,
    slot = { 21, 1, 3, 6, 12, 13, 14, 14, 15 },
    init = 5,
    texture = 'boba',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[150] = {
    name = 'Emon Azzameen',
    XWS = 'emonazzameen',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 71,
    slot = { 21, 1, 3, 6, 8, 12, 13, 14, 15 },
    init = 4,
    texture = 'emon',
    actSet = { 'F', 'R', 'TL', 'B' }
}

masterPilotDB[151] = {
    name = 'Kath Scarlet',
    XWS = 'kathscarlet',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 68,
    slot = { 21, 1, 3, 6, 8, 12, 13, 14, 15 },
    init = 4,
    texture = 'kath',
    actSet = { 'F', 'R', 'TL', 'B' }
}

masterPilotDB[152] = {
    name = 'Koshka Frost',
    XWS = 'koshkafrost',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 70,
    slot = { 21, 1, 3, 6, 8, 12, 13, 14, 15 },
    init = 3,
    texture = 'koshka',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[153] = {
    name = 'Krassis Trelix',
    XWS = 'krassistrelix',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 65,
    slot = { 21, 1, 3, 6, 8, 12, 13, 14, 15 },
    init = 3,
    texture = 'krassis',
    actSet = { 'F', 'R', 'TL', 'B' }
}

masterPilotDB[154] = {
    name = 'Bounty Hunter',
    XWS = 'bountyhunter',
    Faction = 3,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 62,
    slot = { 21, 3, 6, 8, 12, 13, 14, 15 },
    init = 2,
    texture = 'bountyhunter',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[155] = {
    name = 'Fenn Rau',
    XWS = 'fennrau',
    Faction = 3,
    limited = 1,
    ship_type = 'fangfighter',
    cost = 68,
    slot = { 21, 1, 5 },
    init = 6,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[156] = {
    name = 'Old Teroch',
    XWS = 'oldteroch',
    Faction = 3,
    limited = 1,
    ship_type = 'fangfighter',
    cost = 56,
    slot = { 21, 1, 5, 14 },
    init = 5,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[157] = {
    name = 'Joy Rekkoff',
    XWS = 'joyrekkoff',
    Faction = 3,
    limited = 1,
    ship_type = 'fangfighter',
    cost = 47,
    slot = { 21, 1, 5, 14 },
    init = 4,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[158] = {
    name = 'Kad Solus',
    XWS = 'kadsolus',
    Faction = 3,
    limited = 1,
    ship_type = 'fangfighter',
    cost = 53,
    slot = { 21, 1, 5, 14 },
    init = 4,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[159] = {
    name = 'Skull Squadron Pilot',
    XWS = 'skullsquadronpilot',
    Faction = 3,
    ship_type = 'fangfighter',
    cost = 47,
    slot = { 21, 1, 5, 14 },
    init = 4,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[160] = {
    name = 'Zealous Recruit',
    XWS = 'zealousrecruit',
    Faction = 3,
    ship_type = 'fangfighter',
    cost = 41,
    slot = { 21, 5, 14 },
    init = 1,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[161] = {
    name = 'Constable Zuvio',
    XWS = 'constablezuvio',
    limited = 1,
    Faction = 3,
    ship_type = 'quadrijettransferspacetug',
    cost = 29,
    slot = { 21, 1, 19, 8, 12, 13, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[162] = {
    name = 'Sarco Plank',
    XWS = 'sarcoplank',
    Faction = 3,
    limited = 1,
    ship_type = 'quadrijettransferspacetug',
    cost = 29,
    slot = { 21, 19, 8, 12, 13, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[163] = {
    name = 'Unkar Plutt',
    XWS = 'unkarplutt',
    Faction = 3,
    limited = 1,
    ship_type = 'quadrijettransferspacetug',
    cost = 29,
    slot = { 21, 19, 8, 12, 13, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[164] = {
    name = 'Jakku Gunrunner',
    XWS = 'jakkugunrunner',
    Faction = 3,
    ship_type = 'quadrijettransferspacetug',
    cost = 29,
    slot = { 21, 19, 8, 12, 13, 14 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[165] = {
    name = 'Kavil',
    XWS = 'kavil',
    Faction = 3,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 41,
    slot = { 21, 1, 4, 5, 6, 10, 12, 13, 14 },
    init = 5,
    texture = 'kavil',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[166] = {
    name = 'Drea Renthal',
    XWS = 'drearenthal',
    Faction = 3,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 46,
    slot = { 21, 1, 4, 5, 6, 10, 12, 13, 14 },
    init = 4,
    texture = 'drea',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[167] = {
    name = 'Hired Gun',
    XWS = 'hiredgun',
    Faction = 3,
    ship_type = 'btla4ywing',
    cost = 31,
    slot = { 21, 1, 4, 5, 6, 10, 12, 13, 14 },
    init = 2,
    texture = 'hiredgun',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[168] = {
    name = 'Crymorah Goon',
    XWS = 'crymorahgoon',
    Faction = 3,
    ship_type = 'btla4ywing',
    cost = 29,
    slot = { 21, 4, 5, 6, 10, 12, 13, 14 },
    init = 1,
    texture = 'crymorah',
    actSet = { 'F', 'TL', 'BR' }
}


masterPilotDB[820] = {
    name = 'Arliz Hadrassian',
    XWS = 'arlizhadrassian',
    Faction = 3,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 38,
    slot = { 21, 1, 4, 5, 6, 10, 12, 19 },
    init = 4,
    texture = 'amaxine',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[821] = {
    name = 'Leema Kai',
    XWS = 'leemakai',
    Faction = 3,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 39,
    slot = { 21, 1, 4, 5, 6, 10, 12, 19 },
    init = 5,
    texture = 'jinata',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[822] = {
    name = 'Padric',
    XWS = 'padric',
    Faction = 3,
    ship_type = 'btla4ywing',
    cost = 36,
    slot = { 21, 1, 4, 5, 6, 10, 12, 19 },
    init = 3,
    texture = 'padric',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[823] = {
    name = 'Amaxine Warrior',
    XWS = 'amaxinewarrior',
    Faction = 3,
    ship_type = 'btla4ywing',
    cost = 33,
    slot = { 21, 1, 4, 5, 6, 10, 12, 19 },
    init = 3,
    texture = 'amaxine',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[824] = {
    name = 'Jinata Security Officer',
    XWS = 'jinatasecurityofficer',
    Faction = 3,
    ship_type = 'btla4ywing',
    cost = 30,
    slot = { 21, 4, 5, 6, 10, 12, 19 },
    init = 2,
    texture = 'jinata',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[169] = {
    name = "N'dru Suhlak",
    XWS = 'ndrusuhlak',
    Faction = 3,
    limited = 1,
    ship_type = 'z95af4headhunter',
    cost = 28,
    slot = { 21, 1, 6, 13, 14 },
    init = 4,
    texture = 'ndru',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[170] = {
    name = "Kaa'to Leeachos",
    XWS = 'kaatoleeachos',
    Faction = 3,
    limited = 1,
    ship_type = 'z95af4headhunter',
    cost = 24,
    slot = { 21, 1, 6, 13, 14 },
    init = 3,
    texture = 'orange',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[171] = {
    name = 'Nashtah Pup',
    XWS = 'nashtahpup',
    Faction = 3,
    limited = 1,
    ship_type = 'z95af4headhunter',
    cost = 4,
    slot = { 21, 6, 13, 14 },
    init = 0,
    texture = 'nashtah',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[172] = {
    name = 'Black Sun Soldier',
    XWS = 'blacksunsoldier',
    Faction = 3,
    ship_type = 'z95af4headhunter',
    cost = 23,
    slot = { 21, 1, 6, 13, 14 },
    init = 3,
    texture = 'blacksun',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[173] = {
    name = 'Binayre Pirate',
    XWS = 'binayrepirate',
    Faction = 3,
    ship_type = 'z95af4headhunter',
    cost = 22,
    slot = { 21, 6, 13, 14 },
    init = 1,
    texture = 'pirate',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[635] = {
    name = 'Bossk',
    XWS = 'bossk-z95af4headhunter',
    Faction = 3,
    limited = 1,
    ship_type = 'z95af4headhunter',
    cost = 27,
    slot = { 21, 6, 13, 14 },
    init = 4,
    texture = 'bossk',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[174] = {
    name = 'Dace Bonearm',
    XWS = 'dacebonearm',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    cost = 31,
    slot = { 21, 1, 8, 12, 13, 14, 14, 15 },
    Charge = 3,
    init = 4,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[175] = {
    name = 'Palob Godalhi',
    XWS = 'palobgodalhi',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    cost = 40,
    slot = { 21, 1, 8, 12, 13, 14, 14, 15 },
    init = 3,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[176] = {
    name = 'Torkil Mux',
    XWS = 'torkilmux',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    cost = 38,
    slot = { 21, 8, 12, 13, 14, 14, 15 },
    init = 2,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[177] = {
    name = 'Spice Runner',
    XWS = 'spicerunner',
    Faction = 3,
    ship_type = 'hwk290lightfreighter',
    cost = 28,
    slot = { 21, 8, 12, 13, 14, 14, 15 },
    init = 1,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}


masterPilotDB[825] = {
    name = 'Kanan Jarrus',
    XWS = 'kananjarrus-hwk290lightfreighter',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    cost = 42,
    slot = { 21, 17, 8, 12, 13, 14, 14, 15 },
    Force = 1,
    init = 3,
    texture = 'black',
    actSet = { 'F', 'TL', 'B', 'Rot' },
    keywords = { 'Jedi', 'Light Side' }
}

masterPilotDB[826] = {
    name = 'Gamut Key',
    XWS = 'gamutkey',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    cost = 34,
    slot = { 21, 1, 8, 12, 13, 14, 14, 15 },
    Charge = 2,
    init = 3,
    texture = 'black',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[827] = {
    name = 'Tápusk',
    XWS = 'tapusk',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    cost = 36,
    slot = { 21, 1, 8, 12, 13, 14, 14, 15 },
    Charge = 2,
    init = 5,
    texture = 'black',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[178] = {
    name = 'Guri',
    XWS = 'guri',
    Faction = 3,
    limited = 1,
    ship_type = 'starviperclassattackplatform',
    cost = 60,
    slot = { 21, 1, 19, 5, 14, 15 },
    init = 5,
    texture = 'white',
    actSet = { 'C', 'F', 'TL', 'B', 'VR' },
    keywords = { 'Droid' }
}

masterPilotDB[179] = {
    name = 'Dalan Oberos',
    XWS = 'dalanoberos-starviperclassattackplatform',
    Faction = 3,
    limited = 1,
    ship_type = 'starviperclassattackplatform',
    cost = 51,
    slot = { 21, 1, 19, 5, 14, 15 },
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'B', 'VR', 'Piv' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[180] = {
    name = 'Prince Xizor',
    XWS = 'princexizor',
    Faction = 3,
    limited = 1,
    ship_type = 'starviperclassattackplatform',
    cost = 51,
    slot = { 21, 1, 19, 5, 14, 15 },
    init = 4,
    texture = 'white',
    actSet = { 'F', 'TL', 'B', 'VR' }
}

masterPilotDB[181] = {
    name = 'Black Sun Assassin',
    XWS = 'blacksunassassin',
    Faction = 3,
    ship_type = 'starviperclassattackplatform',
    cost = 49,
    slot = { 21, 1, 19, 5, 14, 15 },
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'B', 'VR' }
}

masterPilotDB[182] = {
    name = 'Black Sun Enforcer',
    XWS = 'blacksunenforcer',
    Faction = 3,
    ship_type = 'starviperclassattackplatform',
    cost = 45,
    slot = { 21, 19, 5, 14, 15 },
    init = 2,
    texture = 'white',
    actSet = { 'F', 'TL', 'B', 'VR' }
}

masterPilotDB[183] = {
    name = 'Serissu',
    XWS = 'serissu',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    cost = 40,
    slot = { 21, 1, 14, 99 },
    init = 5,
    texture = 'tansarii',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB[184] = {
    name = 'Genesis Red',
    XWS = 'genesisred',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    cost = 31,
    slot = { 21, 1, 14, 99 },
    init = 4,
    texture = 'genesis',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB[185] = {
    name = "Laetin A'shera",
    XWS = 'laetinashera',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    cost = 30,
    slot = { 21, 1, 14, 99 },
    init = 3,
    texture = 'cartel',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB[186] = {
    name = 'Quinn Jast',
    XWS = 'quinnjast',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    cost = 31,
    slot = { 21, 1, 14, 99 },
    init = 3,
    texture = 'tansarii',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[187] = {
    name = 'Inaldra',
    XWS = 'inaldra',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    cost = 30,
    slot = { 21, 14, 99 },
    init = 2,
    texture = 'tansarii',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB[188] = {
    name = 'Sunny Bounder',
    XWS = 'sunnybounder',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    cost = 27,
    slot = { 21, 14, 99 },
    init = 1,
    texture = 'sunny',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB[189] = {
    name = 'Tansarii Point Veteran',
    XWS = 'tansariipointveteran',
    Faction = 3,
    ship_type = 'm3ainterceptor',
    cost = 29,
    slot = { 21, 1, 14, 99 },
    init = 3,
    texture = 'tansarii',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB[190] = {
    name = 'Cartel Spacer',
    XWS = 'cartelspacer',
    Faction = 3,
    ship_type = 'm3ainterceptor',
    cost = 27,
    slot = { 21, 14, 99 },
    init = 1,
    texture = 'cartel',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB[636] = {
    name = 'G4R-G0R V/M',
    XWS = 'g4rgorvm',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    cost = 28,
    slot = { 21, 14, 99 },
    init = 0,
    texture = 'gargor',
    actSet = { 'C', 'E', 'TL', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB[191] = {
    name = 'Talonbane Cobra',
    XWS = 'talonbanecobra',
    Faction = 3,
    limited = 1,
    ship_type = 'kihraxzfighter',
    cost = 48,
    slot = { 21, 1, 6, 13, 13, 14, 14 },
    init = 5,
    texture = 'talonbane',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[192] = {
    name = 'Graz',
    XWS = 'graz',
    Faction = 3,
    limited = 1,
    ship_type = 'kihraxzfighter',
    cost = 45,
    slot = { 21, 1, 6, 13, 13, 14, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[193] = {
    name = 'Viktor Hel',
    XWS = 'viktorhel',
    Faction = 3,
    limited = 1,
    ship_type = 'kihraxzfighter',
    cost = 43,
    slot = { 21, 1, 6, 13, 13, 14, 14 },
    init = 4,
    texture = 'green',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[194] = {
    name = 'Captain Jostero',
    XWS = 'captainjostero',
    Faction = 3,
    limited = 1,
    ship_type = 'kihraxzfighter',
    cost = 41,
    slot = { 21, 6, 13, 13, 14, 14 },
    init = 3,
    texture = 'orange',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[195] = {
    name = 'Black Sun Ace',
    XWS = 'blacksunace',
    Faction = 3,
    ship_type = 'kihraxzfighter',
    cost = 38,
    slot = { 21, 1, 6, 13, 13, 14, 14 },
    init = 3,
    texture = 'blacksun',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[196] = {
    name = 'Cartel Marauder',
    XWS = 'cartelmarauder',
    Faction = 3,
    ship_type = 'kihraxzfighter',
    cost = 37,
    slot = { 21, 6, 13, 13, 14, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[197] = {
    name = 'IG-88A',
    XWS = 'ig88a',
    Faction = 3,
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    cost = 65,
    slot = { 21, 1, 2, 3, 3, 12, 13, 14, 15 },
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB[198] = {
    name = 'IG-88B',
    XWS = 'ig88b',
    Faction = 3,
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    cost = 61,
    slot = { 21, 1, 2, 3, 3, 12, 13, 14, 15 },
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB[199] = {
    name = 'IG-88C',
    XWS = 'ig88c',
    Faction = 3,
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    cost = 62,
    slot = { 21, 1, 2, 3, 3, 12, 13, 14, 15 },
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB[200] = {
    name = 'IG-88D',
    XWS = 'ig88d',
    Faction = 3,
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    cost = 61,
    slot = { 21, 1, 2, 3, 3, 12, 13, 14, 15 },
    executeOptions = {
        rbl3s = { [1] = 'rtl3s', [2] = 'rbl3s', [3] = 'rk3' },
        rbr3s = { [1] = 'rk3', [2] = 'rbr3s', [3] = 'rtr3s' }
    },
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB[201] = {
    name = '4-LOM',
    XWS = '4lom',
    Faction = 3,
    limited = 1,
    ship_type = 'g1astarfighter',
    cost = 49,
    slot = { 21, 1, 2, 8, 13, 14, 15 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB[202] = {
    name = 'Zuckuss',
    XWS = 'zuckuss',
    Faction = 3,
    limited = 1,
    ship_type = 'g1astarfighter',
    cost = 45,
    slot = { 21, 1, 2, 8, 13, 14, 15 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[203] = {
    name = 'Gand Findsman',
    XWS = 'gandfindsman',
    Faction = 3,
    ship_type = 'g1astarfighter',
    cost = 41,
    slot = { 21, 2, 8, 13, 14, 15 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[204] = {
    name = 'Captain Nym',
    XWS = 'captainnym',
    Faction = 3,
    limited = 1,
    ship_type = 'scurrgh6bomber',
    cost = 45,
    slot = { 21, 1, 4, 8, 12, 12, 16, 14, 15 },
    Charge = 1,
    init = 5,
    texture = 'orange',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[205] = {
    name = 'Sol Sixxa',
    XWS = 'solsixxa',
    Faction = 3,
    limited = 1,
    ship_type = 'scurrgh6bomber',
    cost = 44,
    slot = { 21, 1, 4, 8, 12, 12, 16, 14, 15 },
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[206] = {
    name = 'Lok Revenant',
    XWS = 'lokrevenant',
    Faction = 3,
    ship_type = 'scurrgh6bomber',
    cost = 43,
    slot = { 21, 4, 8, 12, 16, 12, 14, 15 },
    init = 2,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[207] = {
    name = 'Torani Kulda',
    XWS = 'toranikulda',
    Faction = 3,
    limited = 1,
    ship_type = 'm12lkimogilafighter',
    cost = 48,
    slot = { 21, 1, 5, 6, 10, 13, 14 },
    init = 4,
    texture = 'torani',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[208] = {
    name = 'Dalan Oberos',
    XWS = 'dalanoberos',
    Faction = 3,
    limited = 1,
    ship_type = 'm12lkimogilafighter',
    cost = 45,
    slot = { 21, 1, 5, 6, 10, 13, 14 },
    Charge = 2,
    init = 3,
    texture = 'dalan',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[209] = {
    name = 'Cartel Executioner',
    XWS = 'cartelexecutioner',
    Faction = 3,
    ship_type = 'm12lkimogilafighter',
    cost = 41,
    slot = { 21, 1, 5, 6, 10, 13, 14 },
    init = 3,
    texture = 'cartel',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[210] = {
    name = 'Bossk',
    XWS = 'bossk',
    Faction = 3,
    limited = 1,
    ship_type = 'yv666lightfreighter',
    cost = 60,
    slot = { 21, 1, 3, 6, 8, 8, 16, 13, 14, 15 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[211] = {
    name = 'Moralo Eval',
    XWS = 'moraloeval',
    Faction = 3,
    limited = 1,
    ship_type = 'yv666lightfreighter',
    cost = 64,
    slot = { 21, 1, 3, 6, 8, 8, 16, 13, 14, 15 },
    Charge = 2,
    init = 4,
    texture = 'moralo',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB[212] = {
    name = 'Latts Razzi',
    XWS = 'lattsrazzi',
    Faction = 3,
    limited = 1,
    ship_type = 'yv666lightfreighter',
    cost = 55,
    slot = { 21, 1, 3, 6, 8, 8, 16, 13, 14, 15 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[213] = {
    name = 'Trandoshan Slaver',
    XWS = 'trandoshanslaver',
    Faction = 3,
    ship_type = 'yv666lightfreighter',
    cost = 51,
    slot = { 21, 3, 6, 8, 8, 16, 13, 14, 15 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB[214] = {
    name = 'Dengar',
    XWS = 'dengar',
    Faction = 3,
    limited = 1,
    ship_type = 'jumpmaster5000',
    cost = 53,
    slot = { 21, 1, 3, 8, 5, 13, 14, 15, 16 },
    Charge = 1,
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[215] = {
    name = 'Manaroo',
    XWS = 'manaroo',
    Faction = 3,
    limited = 1,
    ship_type = 'jumpmaster5000',
    cost = 45,
    slot = { 21, 1, 3, 8, 5, 13, 14, 15, 16 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[216] = {
    name = 'Tel Trevura',
    XWS = 'teltrevura',
    Faction = 3,
    limited = 1,
    ship_type = 'jumpmaster5000',
    cost = 44,
    slot = { 21, 1, 3, 8, 5, 13, 14, 15, 16 },
    Charge = 1,
    init = 4,
    texture = 'tel',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB[217] = {
    name = 'Contracted Scout',
    XWS = 'contractedscout',
    Faction = 3,
    ship_type = 'jumpmaster5000',
    cost = 41,
    slot = { 21, 8, 3, 5, 13, 14, 15, 16 },
    init = 2,
    texture = 'scout',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB[637] = {
    name = 'Nom Lumb',
    XWS = 'nomlumb',
    Faction = 3,
    limited = 1,
    ship_type = 'jumpmaster5000',
    cost = 38,
    slot = { 21, 1, 3, 8, 5, 13, 14, 15, 16 },
    init = 1,
    texture = 'nom',
    actSet = { 'F', 'TL', 'BR', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[218] = {
    name = 'Ketsu Onyo',
    XWS = 'ketsuonyo',
    Faction = 3,
    limited = 1,
    ship_type = 'lancerclasspursuitcraft',
    cost = 66,
    slot = { 21, 1, 8, 13, 13, 14, 15 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[219] = {
    name = 'Asajj Ventress',
    XWS = 'asajjventress',
    Faction = 3,
    limited = 1,
    ship_type = 'lancerclasspursuitcraft',
    cost = 68,
    slot = { 21, 17, 8, 13, 13, 14, 15 },
    Force = 2,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Bounty Hunter', 'Dark Side' }
}

masterPilotDB[220] = {
    name = 'Sabine Wren',
    XWS = 'sabinewren-lancerclasspursuitcraft',
    Faction = 3,
    limited = 1,
    ship_type = 'lancerclasspursuitcraft',
    cost = 58,
    slot = { 21, 1, 8, 13, 13, 14, 15 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[221] = {
    name = 'Shadowport Hunter',
    XWS = 'shadowporthunter',
    Faction = 3,
    ship_type = 'lancerclasspursuitcraft',
    cost = 54,
    slot = { 21, 8, 13, 13, 14, 15 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[222] = {
    name = 'Han Solo',
    XWS = 'hansolo',
    Faction = 3,
    limited = 1,
    ship_type = 'customizedyt1300lightfreighter',
    cost = 48,
    slot = { 21, 1, 6, 8, 8, 16, 13, 14, 15 },
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[223] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian',
    Faction = 3,
    limited = 1,
    ship_type = 'customizedyt1300lightfreighter',
    cost = 42,
    slot = { 21, 1, 6, 8, 8, 16, 13, 14, 15 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[224] = {
    name = 'L3-37',
    XWS = 'l337',
    Faction = 3,
    limited = 1,
    ship_type = 'customizedyt1300lightfreighter',
    cost = 41,
    slot = { 21, 6, 8, 8, 16, 13, 14, 15 },
    init = 2,
    texture = 'standard',
    actSet = { 'C', 'TL', 'B', 'Rot' },
    keywords = { 'Droid' }
}

masterPilotDB[225] = {
    name = 'Freighter Captain',
    XWS = 'freightercaptain',
    Faction = 3,
    ship_type = 'customizedyt1300lightfreighter',
    cost = 41,
    slot = { 21, 6, 8, 8, 16, 13, 14, 15 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[226] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian-escapecraft',
    Faction = 3,
    limited = 1,
    ship_type = 'escapecraft',
    cost = 29,
    slot = { 21, 1, 8, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'BR' }
}

masterPilotDB[227] = {
    name = 'Outer Rim Pioneer',
    XWS = 'outerrimpioneer',
    Faction = 3,
    limited = 1,
    ship_type = 'escapecraft',
    cost = 28,
    slot = { 21, 1, 8, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'BR' }
}

masterPilotDB[228] = {
    name = 'L3-37',
    XWS = 'l337-escapecraft',
    Faction = 3,
    limited = 1,
    ship_type = 'escapecraft',
    cost = 26,
    slot = { 21, 1, 8, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'C', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB[229] = {
    name = 'Autopilot Drone',
    XWS = 'autopilotdrone',
    Faction = 3,
    limited = 1,
    ship_type = 'escapecraft',
    cost = 12,
    slot = { 21, 0 },
    Charge = 3,
    init = 1,
    texture = 'standard',
    actSet = { 'C', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB[397] = {
    name = '"Midnight"',
    XWS = 'midnight',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    cost = 35,
    slot = { 21, 1, 19, 14 },
    Shield = 1,
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[398] = {
    name = '"Scorch"',
    XWS = 'scorch',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    cost = 33,
    slot = { 21, 1, 19, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[399] = {
    name = '"Static"',
    XWS = 'static',
    Faction = 5,
    limited = 1,
    ship_type = 'tiefofighter',
    cost = 31,
    slot = { 21, 1, 19, 14 },
    Shield = 1,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[400] = {
    name = '"Longshot"',
    XWS = 'longshot',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    cost = 30,
    slot = { 21, 1, 19, 14 },
    Shield = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[401] = {
    limited = 1,
    name = '"Muse"',
    XWS = 'muse',
    Faction = 5,
    ship_type = 'tiefofighter',
    cost = 30,
    slot = { 21, 1, 19, 14 },
    Shield = 1,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[402] = {
    limited = 1,
    name = '"Null"',
    XWS = 'null',
    Faction = 5,
    ship_type = 'tiefofighter',
    cost = 30,
    slot = { 21, 19, 14 },
    Shield = 1,
    init = 0,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[403] = {
    name = 'Omega Squadron Ace',
    XWS = 'omegasquadronace',
    Faction = 5,
    ship_type = 'tiefofighter',
    cost = 29,
    slot = { 21, 1, 19, 14 },
    Shield = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[404] = {
    name = 'Zeta Squadron Pilot',
    XWS = 'zetasquadronpilot',
    Faction = 5,
    ship_type = 'tiefofighter',
    cost = 27,
    slot = { 21, 19, 14 },
    Shield = 1,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[405] = {
    name = 'Epsilon Squadron Cadet',
    XWS = 'epsilonsquadroncadet',
    Faction = 5,
    ship_type = 'tiefofighter',
    cost = 26,
    slot = { 21, 19, 14 },
    Shield = 1,
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[406] = {
    limited = 1,
    name = '"Quickdraw"',
    XWS = 'quickdraw',
    Faction = 5,
    ship_type = 'tiesffighter',
    cost = 44,
    slot = { 21, 1, 2, 19, 6, 16, 14 },
    Charge = 1,
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB[407] = {
    limited = 1,
    name = '"Backdraft"',
    XWS = 'backdraft',
    Faction = 5,
    ship_type = 'tiesffighter',
    cost = 36,
    slot = { 21, 1, 2, 19, 6, 16, 14 },
    Shield = 3,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB[408] = {
    name = 'Omega Squadron Expert',
    XWS = 'omegasquadronexpert',
    Faction = 5,
    ship_type = 'tiesffighter',
    cost = 33,
    slot = { 21, 1, 2, 19, 6, 16, 14 },
    Shield = 3,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB[409] = {
    name = 'Zeta Squadron Survivor',
    XWS = 'zetasquadronsurvivor',
    Faction = 5,
    ship_type = 'tiesffighter',
    cost = 32,
    slot = { 21, 2, 19, 6, 16, 14 },
    Shield = 3,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB[641] = {
    name = 'Lieutenant LeHuse',
    XWS = 'lieutenantlehuse',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesffighter',
    cost = 37,
    slot = { 21, 1, 2, 19, 6, 16, 14 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB[642] = {
    name = 'Captain Phasma',
    XWS = 'captainphasma',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesffighter',
    cost = 34,
    slot = { 21, 1, 2, 19, 6, 16, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB[410] = {
    name = 'Major Stridan',
    XWS = 'majorstridan',
    limited = 1,
    Faction = 5,
    ship_type = 'upsilonclasscommandshuttle',
    cost = 61,
    slot = { 21, 2, 19, 19, 3, 8, 8, 8, 14 },
    Shield = 6,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB[411] = {
    name = 'Lieutenant Tavson',
    XWS = 'lieutenanttavson',
    Faction = 5,
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    cost = 64,
    slot = { 21, 2, 19, 19, 3, 8, 8, 8, 14 },
    Shield = 6,
    Charge = 2,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB[412] = {
    name = 'Lieutenant Dormitz',
    XWS = 'lieutenantdormitz',
    Faction = 5,
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    cost = 73,
    slot = { 21, 2, 19, 19, 3, 8, 8, 8, 14 },
    Shield = 6,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB[413] = {
    name = 'Starkiller Base Pilot',
    XWS = 'starkillerbasepilot',
    Faction = 5,
    ship_type = 'upsilonclasscommandshuttle',
    cost = 58,
    slot = { 21, 2, 19, 19, 3, 8, 8, 8, 14 },
    Shield = 6,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB[414] = {
    name = 'Kylo Ren',
    XWS = 'kyloren',
    Condition = "I'll Show You the Dark Side",
    Faction = 5,
    limited = 1,
    ship_type = 'tievnsilencer',
    cost = 77,
    slot = { 21, 17, 19, 5, 6, 18 },
    Shield = 2,
    Force = 2,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side' }
}

masterPilotDB[415] = {
    name = '"Blackout"',
    XWS = 'blackout',
    Faction = 5,
    limited = 1,
    ship_type = 'tievnsilencer',
    cost = 61,
    slot = { 21, 1, 19, 5, 6, 18 },
    Shield = 2,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB[416] = {
    name = 'First Order Test Pilot',
    XWS = 'firstordertestpilot',
    Faction = 5,
    ship_type = 'tievnsilencer',
    cost = 56,
    slot = { 21, 1, 19, 5, 6, 18 },
    Shield = 2,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB[417] = {
    name = 'Sienar-Jaemus Engineer',
    XWS = 'sienarjaemusengineer',
    Faction = 5,
    ship_type = 'tievnsilencer',
    cost = 50,
    slot = { 21, 19, 5, 6, 18 },
    Shield = 2,
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB[643] = {
    name = '"Rush"',
    XWS = 'rush',
    Faction = 5,
    limited = 1,
    ship_type = 'tievnsilencer',
    cost = 57,
    slot = { 21, 1, 19, 5, 6, 18 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'B', 'TL', 'BR' }
}

masterPilotDB[418] = {
    name = 'Poe Dameron',
    XWS = 'poedameron',
    title = 'Trigger-Happy Flyboy',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 61,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    Charge = 1,
    init = 6,
    texture = 'blackone',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[419] = {
    name = 'Ello Asty',
    XWS = 'elloasty',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 53,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[420] = {
    name = 'Nien Nunb',
    XWS = 'niennunb',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 54,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[421] = {
    name = 'Kare Kun',
    XWS = 'karekun',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 47,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Dare' }
}

masterPilotDB[422] = {
    name = 'Temmin Wexley',
    XWS = 'temminwexley',
    title = 'Snap',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 49,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[423] = {
    name = 'Jessika Pava',
    XWS = 'jessikapava',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 51,
    slot = { 21, 19, 14, 18, 15, 10, 99 },
    Charge = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[424] = {
    name = 'Joph Seastriker',
    XWS = 'jophseastriker',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 46,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[425] = {
    name = 'Red Squadron Expert',
    XWS = 'redsquadronexpert',
    Faction = 4,
    ship_type = 't70xwing',
    cost = 43,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[426] = {
    name = 'Blue Squadron Rookie',
    XWS = 'bluesquadronrookie',
    Faction = 4,
    ship_type = 't70xwing',
    cost = 41,
    slot = { 21, 19, 14, 18, 15, 10, 99 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}


masterPilotDB[700] = {
    name = 'Nimi Chireen',
    XWS = 'nimichireen',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 47,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' },
}

masterPilotDB[699] = {
    name = "C'ai Threnalli",
    XWS = 'caithrenalli',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 46,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'E' },
    movethrough = true
}


masterPilotDB[698] = {
    name = "Temmin Wexley",
    XWS = 'temminwexley-swz68',
    title = "Black Two",
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 53,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 4,
    texture = 'snap',
    actSet = { 'F', 'TL', 'B' },
    addSqdAction = { 'C' }
}

masterPilotDB[697] = {
    name = "Poe Dameron",
    XWS = 'poedameron-swz68',
    title = "Resistance Commander",
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 55,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    Charge = 2,
    init = 6,
    texture = 'commanderpoe',
    actSet = { 'F', 'TL', 'B' },
}

masterPilotDB[427] = {
    name = "Han Solo",
    XWS = 'hansolo-scavengedyt1300',
    Faction = 4,
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    cost = 62,
    slot = { 21, 1, 8, 8, 16, 13, 14, 15 },
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[428] = {
    name = "Rey",
    XWS = 'rey',
    Faction = 4,
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    cost = 68,
    slot = { 21, 17, 8, 8, 16, 13, 14, 15 },
    Force = 2,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' },
    keywords = { 'Light Side' }
}

masterPilotDB[429] = {
    name = "Chewbacca",
    XWS = 'chewbacca-scavengedyt1300',
    Faction = 4,
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    cost = 60,
    slot = { 21, 1, 8, 8, 16, 13, 14, 15 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[430] = {
    name = "Resistance Sympathizer",
    XWS = 'resistancesympathizer',
    Faction = 4,
    ship_type = 'scavengedyt1300lightfreighter',
    cost = 58,
    slot = { 21, 8, 8, 16, 13, 14, 15 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[431] = {
    name = "Finch Dallow",
    XWS = 'finchdallow',
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    cost = 55,
    slot = { 21, 2, 19, 8, 16, 16, 12, 12, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB[432] = {
    name = "Ben Teene",
    XWS = 'benteene',
    Condition = "Rattled",
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    cost = 54,
    slot = { 21, 2, 19, 8, 16, 16, 12, 12, 14 },
    init = 3,
    texture = 'vennie',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB[433] = {
    name = "Cat",
    XWS = 'cat',
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    cost = 51,
    slot = { 21, 2, 19, 8, 16, 16, 12, 12, 14 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB[434] = {
    name = "Cobalt Squadron Bomber",
    XWS = 'cobaltsquadronbomber',
    Faction = 4,
    ship_type = 'mg100starfortress',
    cost = 51,
    slot = { 21, 2, 19, 8, 16, 16, 12, 12, 14 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB[435] = {
    name = "L'ulo L'ampar",
    XWS = 'lulolampar',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    cost = 40,
    slot = { 21, 1, 1, 19, 6 },
    init = 5,
    texture = 'orange',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB[436] = {
    name = "Tallissan Lintra",
    XWS = 'tallissanlintra',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    cost = 37,
    slot = { 21, 1, 1, 19, 6 },
    Charge = 1,
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB[437] = {
    name = "Greer Sonnel",
    XWS = 'greersonnel',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    cost = 36,
    slot = { 21, 1, 1, 19, 6 },
    init = 4,
    texture = 'orange',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB[438] = {
    name = "Zari Bangel",
    XWS = 'zaribangel',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    cost = 35,
    slot = { 21, 1, 1, 19, 6 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB[439] = {
    name = "Green Squadron Expert",
    XWS = 'greensquadronexpert',
    Faction = 4,
    ship_type = 'rz2awing',
    cost = 34,
    slot = { 21, 1, 1, 19, 6 },
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB[440] = {
    name = "Blue Squadron Recruit",
    XWS = 'bluesquadronrecruit',
    Faction = 4,
    ship_type = 'rz2awing',
    cost = 33,
    slot = { 21, 1, 19, 6 },
    init = 1,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB[638] = {
    name = "Zizi Tlo",
    XWS = 'zizitlo',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    cost = 41,
    slot = { 21, 1, 1, 19, 6 },
    Charge = 1,
    init = 5,
    texture = 'red',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB[639] = {
    name = "Ronith Blario",
    XWS = 'ronithblario',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    cost = 34,
    slot = { 21, 1, 1, 19, 6 },
    init = 2,
    texture = 'red',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}


masterPilotDB[701] = {
    name = "Seftin Vanik",
    XWS = 'seftinvanik',
    limited = 1,
    Faction = 4,
    ship_type = 'rz2awing',
    cost = 37,
    slot = { 21, 1, 1, 19, 6 },
    init = 5,
    texture = 'green',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB[704] = {
    name = "Merl Cobben",
    XWS = 'merlcobben',
    limited = 1,
    Faction = 4,
    ship_type = 'rz2awing',
    cost = 33,
    slot = { 21, 1, 1, 19, 6 },
    init = 1,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB[703] = {
    name = "Suralinda Javos",
    XWS = 'suralindajavos',
    limited = 1,
    Faction = 4,
    cost = 35,
    ship_type = 'rz2awing',
    slot = { 21, 1, 1, 19, 6 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR', 'Piv' }
}

masterPilotDB[702] = {
    name = "Wrobie Tyce",
    XWS = 'wrobietyce',
    limited = 1,
    Faction = 4,
    ship_type = 'rz2awing',
    cost = 35,
    slot = { 21, 1, 1, 19, 6 },
    init = 4,
    texture = 'green',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}


masterPilotDB[441] = {
    name = 'Foreman Proach',
    XWS = 'foremanproach',
    Faction = 3,
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    cost = 29,
    slot = { 21, 1, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[442] = {
    name = 'Ahhav',
    XWS = 'ahhav',
    Faction = 3,
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    cost = 28,
    slot = { 21, 1, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[443] = {
    name = 'Captain Seevor',
    XWS = 'captainseevor',
    Faction = 3,
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    cost = 30,
    slot = { 21, 1, 14 },
    Charge = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[444] = {
    name = 'Overseer Yushyn',
    XWS = 'overseeryushyn',
    Faction = 3,
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    cost = 24,
    slot = { 21, 1, 14 },
    Charge = 1,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[445] = {
    name = 'Mining Guild Surveyor',
    XWS = 'miningguildsurveyor',
    Faction = 3,
    ship_type = 'modifiedtielnfighter',
    cost = 23,
    slot = { 21, 1, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[446] = {
    name = 'Mining Guild Sentry',
    XWS = 'miningguildsentry',
    Faction = 3,
    ship_type = 'modifiedtielnfighter',
    cost = 22,
    slot = { 21, 1, 14 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[447] = {
    name = "Edon Kappehl",
    XWS = 'edonkappehl',
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    cost = 55,
    slot = { 21, 2, 19, 8, 16, 16, 12, 12, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB[448] = {
    name = "Vennie",
    XWS = 'vennie',
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    cost = 53,
    slot = { 21, 2, 19, 8, 16, 16, 12, 12, 14 },
    init = 2,
    texture = 'vennie',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB[640] = {
    name = "Paige Tico",
    XWS = 'paigetico',
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    cost = 55,
    slot = { 21, 2, 19, 8, 16, 16, 12, 12, 14 },
    Charge = 1,
    init = 5,
    texture = 'paige',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB[449] = {
    name = 'Lieutenant Bastian',
    XWS = 'lieutenantbastian',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 47,
    slot = { 21, 19, 14, 18, 15, 10 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[450] = {
    name = 'Jaycris Tubbs',
    XWS = 'jaycristubbs',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 45,
    slot = { 21, 19, 14, 18, 15, 10 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[451] = {
    name = 'Black Squadron Ace',
    XWS = 'blacksquadronace-t70xwing',
    Faction = 4,
    ship_type = 't70xwing',
    cost = 46,
    slot = { 21, 1, 19, 14, 18, 15, 10 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[452] = {
    name = 'Commander Malarus',
    XWS = 'commandermalarus',
    Faction = 5,
    limited = 1,
    ship_type = 'tiefofighter',
    cost = 33,
    slot = { 21, 1, 19, 14 },
    Charge = 2,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB[453] = {
    name = 'TN-3465',
    XWS = 'tn3465',
    Faction = 5,
    limited = 1,
    ship_type = 'tiefofighter',
    cost = 28,
    slot = { 21, 19, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB[454] = {
    name = 'Lieutenant Rivas',
    XWS = 'lieutenantrivas',
    Faction = 5,
    limited = 1,
    ship_type = 'tiefofighter',
    cost = 28,
    slot = { 21, 19, 14 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB[455] = {
    name = '"Recoil"',
    XWS = 'recoil',
    Faction = 5,
    limited = 1,
    ship_type = 'tievnsilencer',
    cost = 56,
    slot = { 21, 1, 19, 5, 6, 18 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'B', 'TL', 'BR' }
}

masterPilotDB[456] = {
    name = '"Avenger"',
    XWS = 'avenger',
    Faction = 5,
    limited = 1,
    ship_type = 'tievnsilencer',
    cost = 56,
    slot = { 21, 1, 19, 5, 6, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'B', 'TL', 'BR' }
}

masterPilotDB[457] = {
    name = 'Captain Cardinal',
    XWS = 'captaincardinal',
    Faction = 5,
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    cost = 62,
    slot = { 21, 2, 19, 19, 3, 8, 8, 8, 14 },
    Charge = 2,
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB[458] = {
    name = 'Petty Officer Thanisson',
    XWS = 'pettyofficerthanisson',
    Faction = 5,
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    cost = 59,
    slot = { 21, 2, 19, 19, 3, 8, 8, 8, 14 },
    Charge = 1,
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

--w3pilot

masterPilotDB[492] = {
    name = 'General Grievous',
    XWS = 'generalgrievous',
    Faction = 7,
    limited = 1,
    ship_type = 'belbulab22starfighter',
    cost = 44,
    slot = { 21, 1, 14, 15, 20 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'BR' }
}

masterPilotDB[493] = {
    name = 'Wat Tambor',
    XWS = 'wattambor',
    Faction = 7,
    limited = 1,
    ship_type = 'belbulab22starfighter',
    cost = 42,
    slot = { 21, 1, 14, 15, 20 },
    init = 3,
    actSet = { 'F', 'TL', 'B', 'BR' },
    texture = 'wat',
}

masterPilotDB[494] = {
    name = 'Captain Sear',
    XWS = 'captainsear',
    Faction = 7,
    limited = 1,
    ship_type = 'belbulab22starfighter',
    cost = 45,
    slot = { 21, 14, 15, 20 },
    init = 2,
    actSet = { 'F', 'TL', 'B', 'BR' },
    texture = 'standard',
}
masterPilotDB[495] = {
    name = 'Skakoan Ace',
    XWS = 'skakoanace',
    Faction = 7,
    ship_type = 'belbulab22starfighter',
    cost = 38,
    slot = { 21, 1, 14, 15, 20 },
    init = 3,
    actSet = { 'F', 'TL', 'B', 'BR' },
    texture = 'standard',
}

masterPilotDB[496] = {
    name = 'Feethan Ottraw Autopilot',
    XWS = 'feethanottrawautopilot',
    Faction = 7,
    ship_type = 'belbulab22starfighter',
    cost = 35,
    slot = { 21, 14, 15, 20 },
    init = 1,
    actSet = { 'C', 'TL', 'B', 'BR' },
    texture = 'standard',
    keywords = { 'Droid' }
}

masterPilotDB[497] = {
    name = 'Separatist Drone',
    XWS = 'separatistdrone',
    Faction = 7,
    ship_type = 'vultureclassdroidfighter',
    cost = 21,
    slot = { 21, 6, 14, 18 },
    init = 3,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'drone',
}

masterPilotDB[498] = {
    name = 'Trade Federation Drone',
    XWS = 'tradefederationdrone',
    Faction = 7,
    ship_type = 'vultureclassdroidfighter',
    cost = 21,
    slot = { 21, 6, 14, 18 },
    init = 1,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'drone',
}

masterPilotDB[499] = {
    name = 'DFS-081',
    XWS = 'dfs081',
    Faction = 7,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    cost = 23,
    slot = { 21, 6, 14, 18 },
    init = 3,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'dfs081',
}

masterPilotDB[500] = {
    name = 'Precise Hunter',
    XWS = 'precisehunter',
    Faction = 7,
    limited = 3,
    ship_type = 'vultureclassdroidfighter',
    cost = 24,
    slot = { 21, 6, 14, 18 },
    init = 3,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'hunter',
}

masterPilotDB[501] = {
    name = 'DFS-311',
    XWS = 'dfs311',
    Faction = 7,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    cost = 23,
    slot = { 21, 6, 14, 18 },
    init = 1,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'dfs311',
}

masterPilotDB[502] = {
    name = 'Haor Chall Prototype',
    XWS = 'haorchallprototype',
    Faction = 7,
    limited = 2,
    ship_type = 'vultureclassdroidfighter',
    cost = 22,
    slot = { 21, 6, 14, 18 },
    init = 1,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'proto',
}

masterPilotDB[503] = {
    name = 'Darth Maul',
    XWS = 'darthmaul',
    Faction = 7,
    limited = 1,
    ship_type = 'sithinfiltrator',
    cost = 64,
    slot = { 21, 17, 5, 3, 8, 8, 20, 12, 15, 14 },
    Force = 3,
    init = 5,
    actSet = { 'F', 'TL', 'BR' },
    texture = 'maul',
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB[504] = {
    name = 'Count Dooku',
    XWS = 'countdooku',
    Faction = 7,
    limited = 1,
    ship_type = 'sithinfiltrator',
    cost = 63,
    slot = { 21, 17, 5, 3, 8, 8, 20, 12, 15, 14 },
    Force = 3,
    init = 3,
    actSet = { 'F', 'TL', 'BR' },
    texture = 'standard',
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB[505] = {
    name = 'O-66',
    XWS = '066',
    Faction = 7,
    limited = 1,
    ship_type = 'sithinfiltrator',
    cost = 49,
    slot = { 21, 1, 5, 3, 8, 8, 20, 12, 15, 14 },
    init = 3,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'standard',
    keywords = { 'Droid' }
}

masterPilotDB[506] = {
    name = 'Dark Courier',
    XWS = 'darkcourier',
    Faction = 7,
    ship_type = 'sithinfiltrator',
    cost = 50,
    slot = { 21, 5, 3, 8, 8, 20, 12, 15, 14 },
    init = 2,
    actSet = { 'F', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB[507] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    cost = 59,
    slot = { 21, 17, 10, 18, 14 },
    Force = 3,
    init = 6,
    texture = 'anakin',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[508] = {
    name = 'Luminara Unduli',
    XWS = 'luminaraunduli',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    cost = 40,
    slot = { 21, 17, 10, 18, 14 },
    Force = 2,
    init = 4,
    texture = 'lumi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[509] = {
    name = 'Barriss Offee',
    XWS = 'barrissoffee',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    cost = 36,
    slot = { 21, 17, 10, 18, 14 },
    Force = 1,
    init = 4,
    texture = 'barriss',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[510] = {
    name = 'Ahsoka Tano',
    XWS = 'ahsokatano',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    cost = 41,
    slot = { 21, 17, 10, 18, 14 },
    Force = 2,
    init = 3,
    texture = 'ahsoka',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[511] = {
    name = 'Obi-Wan Kenobi',
    XWS = 'obiwankenobi',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    cost = 47,
    slot = { 21, 17, 10, 18, 14 },
    Force = 3,
    init = 5,
    texture = 'obi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[512] = {
    name = 'Mace Windu',
    XWS = 'macewindu',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    cost = 44,
    slot = { 21, 17, 10, 18, 14 },
    Force = 3,
    init = 4,
    texture = 'mace',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[513] = {
    name = 'Plo Koon',
    XWS = 'plokoon',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    cost = 43,
    slot = { 21, 17, 10, 18, 14 },
    Force = 2,
    init = 5,
    texture = 'plo',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[514] = {
    name = 'Saesee Tiin',
    XWS = 'saeseetiin',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    cost = 40,
    slot = { 21, 17, 10, 18, 14 },
    Force = 2,
    init = 4,
    texture = 'saesee',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[515] = {
    name = 'Jedi Knight',
    XWS = 'jediknight',
    Faction = 6,
    ship_type = 'delta7aethersprite',
    cost = 36,
    slot = { 21, 17, 10, 18, 14 },
    Force = 1,
    init = 3,
    texture = 'knight',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    --tintFriendly = {mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/Small/delta7aethersprite/Jedi_Delta7_tint.obj',
    --                texture = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships/Small/GRP_Delta7/JediKnight-tint.png',}
}

masterPilotDB[516] = {
    name = '"Odd Ball"',
    XWS = 'oddball',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    cost = 29,
    slot = { 21, 1, 6, 14 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[517] = {
    name = '"Kickback"',
    XWS = 'kickback',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    cost = 29,
    slot = { 21, 1, 6, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[518] = {
    name = '"Axe"',
    XWS = 'axe',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    cost = 28,
    slot = { 21, 1, 6, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[519] = {
    name = '"Swoop"',
    XWS = 'swoop',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    cost = 27,
    slot = { 21, 1, 6, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[520] = {
    name = '"Tucker"',
    XWS = 'tucker',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    cost = 26,
    slot = { 21, 6, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[521] = {
    name = 'Blue Squadron Protector',
    XWS = 'bluesquadronprotector',
    Faction = 6,
    ship_type = 'v19torrentstarfighter',
    cost = 26,
    slot = { 21, 1, 6, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[522] = {
    name = 'Gold Squadron Trooper',
    XWS = 'goldsquadrontrooper',
    Faction = 6,
    ship_type = 'v19torrentstarfighter',
    cost = 25,
    slot = { 21, 6, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[523] = {
    name = '"Odd Ball"',
    XWS = 'oddball-arc170starfighter',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 48,
    slot = { 21, 1, 5, 14, 8, 16, 10 },
    init = 5,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[524] = {
    name = '"Wolffe"',
    XWS = 'wolffe',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 49,
    slot = { 21, 1, 5, 14, 8, 16, 10 },
    Charge = 1,
    init = 4,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[525] = {
    name = '"Jag"',
    XWS = 'jag',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 47,
    slot = { 21, 5, 14, 8, 16, 10 },
    init = 3,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[526] = {
    name = '"Sinker"',
    XWS = 'sinker',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 53,
    slot = { 21, 5, 14, 8, 16, 10 },
    init = 3,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[527] = {
    name = 'Squad Seven Veteran',
    XWS = 'squadsevenveteran',
    Faction = 6,
    ship_type = 'arc170starfighter',
    cost = 44,
    slot = { 21, 1, 5, 14, 8, 16, 10 },
    init = 3,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[528] = {
    name = '104th Battalion Pilot',
    XWS = '104thbattalionpilot',
    Faction = 6,
    ship_type = 'arc170starfighter',
    cost = 42,
    slot = { 21, 5, 14, 8, 16, 10 },
    init = 2,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

--w4 Pilots
--N-1
masterPilotDB[557] = {
    name = 'Ric Olié',
    XWS = 'ricolie',
    Faction = 6,
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    cost = 44,
    slot = { 21, 1, 2, 5, 10 },
    init = 5,
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB[558] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker-nabooroyaln1starfighter',
    Faction = 6,
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    cost = 41,
    slot = { 21, 1, 2, 5, 10 },
    Force = 1,
    init = 4,
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' },
    keywords = { 'Light Side' }
}

masterPilotDB[559] = {
    name = 'Padmé Amidala',
    XWS = 'padmeamidala',
    Faction = 6,
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    cost = 43,
    slot = { 21, 1, 2, 5, 10 },
    init = 4,
    texture = 'silver',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB[560] = {
    name = 'Dineé Ellberger',
    XWS = 'dineeellberger',
    Faction = 6,
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    cost = 36,
    slot = { 21, 1, 2, 5, 10 },
    init = 3,
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB[561] = {
    name = 'Naboo Handmaiden',
    XWS = 'naboohandmaiden',
    Faction = 6,
    limited = 2,
    ship_type = 'nabooroyaln1starfighter',
    cost = 41,
    slot = { 21, 2, 5, 10 },
    init = 1,
    Condition = 'Decoyed',
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB[562] = {
    name = 'Bravo Flight Officer',
    XWS = 'bravoflightofficer',
    Faction = 6,
    ship_type = 'nabooroyaln1starfighter',
    cost = 33,
    slot = { 21, 2, 5, 10 },
    init = 2,
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

--Resistance Transport
masterPilotDB[569] = {
    name = 'Cova Nell',
    XWS = 'covanell',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransport',
    cost = 38,
    slot = { 21, 1, 19, 3, 3, 5, 8, 8, 10, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB[570] = {
    name = 'Pammich Nerro Goode',
    XWS = 'pammichnerrogoode',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransport',
    cost = 35,
    slot = { 21, 19, 3, 3, 5, 8, 8, 10, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB[571] = {
    name = 'Nodin Chavdri',
    XWS = 'nodinchavdri',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransport',
    cost = 37,
    slot = { 21, 19, 3, 3, 5, 8, 8, 10, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB[572] = {
    name = 'Logistics Division Pilot',
    XWS = 'logisticsdivisionpilot',
    Faction = 4,
    ship_type = 'resistancetransport',
    cost = 34,
    slot = { 21, 19, 3, 3, 5, 8, 8, 10, 14 },
    init = 1,
    texture = 'red',
    actSet = { 'F', 'TL' }
}

masterPilotDB[574] = {
    name = 'Rose Tico',
    XWS = 'rosetico',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransportpod',
    cost = 28,
    slot = { 21, 1, 19, 8, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[573] = {
    name = 'BB-8',
    XWS = 'bb8',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransportpod',
    cost = 25,
    slot = { 21, 1, 19, 8, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR', 'B' },
    keywords = { 'Droid' }
}

masterPilotDB[575] = {
    name = 'Finn',
    XWS = 'finn',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransportpod',
    cost = 32,
    slot = { 21, 1, 19, 8, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[576] = {
    name = 'Vi Moradi',
    XWS = 'vimoradi',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransportpod',
    cost = 27,
    slot = { 21, 19, 8, 14 },
    init = 1,
    Condition = "Compromising Intel",
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB[563] = {
    name = 'DBS-404',
    XWS = 'dbs404',
    Faction = 7,
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
    cost = 31,
    slot = { 21, 5, 6, 12, 14, 18 },
    init = 4,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'fourohfour',
}

masterPilotDB[564] = {
    name = 'DBS-32C',
    XWS = 'dbs32c',
    Faction = 7,
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
    cost = 40,
    slot = { 21, 2, 20, 14, 18 },
    init = 3,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB[565] = {
    name = 'Bombardment Drone',
    XWS = 'bombardmentdrone',
    Faction = 7,
    limited = 3,
    ship_type = 'hyenaclassdroidbomber',
    cost = 30,
    slot = { 21, 2, 12, 12, 14, 18 },
    init = 3,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB[566] = {
    name = 'Baktoid Prototype',
    XWS = 'baktoidprototype',
    Faction = 7,
    limited = 2,
    ship_type = 'hyenaclassdroidbomber',
    cost = 29,
    slot = { 21, 2, 6, 6, 14, 18 },
    init = 1,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'baktoid',
}

masterPilotDB[567] = {
    name = 'Separatist Bomber',
    XWS = 'separatistbomber',
    Faction = 7,
    ship_type = 'hyenaclassdroidbomber',
    cost = 29,
    slot = { 21, 5, 6, 12, 14, 18 },
    init = 3,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB[568] = {
    name = 'Techno Union Bomber',
    XWS = 'technounionbomber',
    Faction = 7,
    ship_type = 'hyenaclassdroidbomber',
    cost = 26,
    slot = { 21, 5, 6, 12, 14, 18 },
    init = 1,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'baktoid',
}

--Republic Y-Wing
masterPilotDB[596] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker-btlbywing',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    cost = 50,
    slot = { 21, 17, 4, 5, 16, 10, 12, 14 },
    Force = 3,
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[597] = {
    name = '"Odd Ball"',
    XWS = 'oddball-btlbywing',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    cost = 39,
    slot = { 21, 1, 4, 5, 16, 10, 12, 14 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[598] = {
    name = '"Matchstick"',
    XWS = 'matchstick',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    cost = 41,
    slot = { 21, 1, 4, 5, 16, 10, 12, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[599] = {
    name = '"Broadside"',
    XWS = 'broadside',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    cost = 36,
    slot = { 21, 1, 4, 5, 16, 10, 12, 14 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[600] = {
    name = 'R2-D2',
    XWS = 'r2d2',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    cost = 31,
    slot = { 21, 1, 4, 5, 16, 8, 12, 14 },
    init = 2,
    texture = 'green',
    actSet = { 'C', 'TL', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB[601] = {
    name = '"Goji"',
    XWS = 'goji',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    cost = 29,
    slot = { 21, 4, 5, 16, 10, 12, 14 },
    init = 2,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[602] = {
    name = 'Shadow Squadron Veteran',
    XWS = 'shadowsquadronveteran',
    Faction = 6,
    ship_type = 'btlbywing',
    cost = 31,
    slot = { 21, 1, 4, 5, 16, 10, 12, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[603] = {
    name = 'Red Squadron Bomber',
    XWS = 'redsquadronbomber',
    Faction = 6,
    ship_type = 'btlbywing',
    cost = 30,
    slot = { 21, 4, 5, 16, 10, 12, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

--Nantex
masterPilotDB[604] = {
    name = 'Sun Fac',
    XWS = 'sunfac',
    Faction = 7,
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    cost = 44,
    slot = { 21, 1, 1 },
    init = 6,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB[605] = {
    name = 'Berwer Kret',
    XWS = 'berwerkret',
    Faction = 7,
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    cost = 37,
    slot = { 21, 1, 1 },
    init = 5,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB[606] = {
    name = 'Chertek',
    XWS = 'chertek',
    Faction = 7,
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    cost = 36,
    slot = { 21, 1, 1 },
    init = 4,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB[607] = {
    name = 'Gorgol',
    XWS = 'gorgol',
    Faction = 7,
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    cost = 32,
    slot = { 21, 1, 14 },
    init = 2,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB[608] = {
    name = 'Petranaki Arena Ace',
    XWS = 'petranakiarenaace',
    Faction = 7,
    ship_type = 'nantexclassstarfighter',
    cost = 37,
    slot = { 21, 1, 1 },
    init = 4,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB[609] = {
    name = 'Stalgasin Hive Guard',
    XWS = 'stalgasinhiveguard',
    Faction = 7,
    ship_type = 'nantexclassstarfighter',
    cost = 35,
    slot = { 21, 1 },
    init = 3,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

--w7
--TIE/ba
masterPilotDB[627] = {
    name = 'First Order Provocateur',
    XWS = 'firstorderprovocateur',
    Faction = 5,
    ship_type = 'tiebainterceptor',
    cost = 41,
    slot = { 21, 1, 19, 6, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB[626] = {
    name = '"Ember"',
    XWS = 'ember',
    Faction = 5,
    limited = 1,
    ship_type = 'tiebainterceptor',
    cost = 45,
    slot = { 21, 1, 19, 6, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB[625] = {
    name = '"Holo"',
    XWS = 'holo',
    Faction = 5,
    limited = 1,
    ship_type = 'tiebainterceptor',
    cost = 53,
    slot = { 21, 1, 19, 6, 14 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB[624] = {
    name = 'Major Vonreg',
    XWS = 'majorvonreg',
    Faction = 5,
    limited = 1,
    ship_type = 'tiebainterceptor',
    cost = 54,
    slot = { 21, 1, 19, 6, 14 },
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

--FireBall
masterPilotDB[620] = {
    name = 'Jarek Yeager',
    XWS = 'jarekyeager',
    Faction = 4,
    limited = 1,
    ship_type = 'fireball',
    cost = 31,
    slot = { 21, 1, 6, 10, 13, 14, 14, 15 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[621] = {
    name = 'Kazuda Xiono',
    XWS = 'kazudaxiono',
    Faction = 4,
    limited = 1,
    ship_type = 'fireball',
    cost = 38,
    slot = { 21, 1, 6, 10, 13, 14, 14, 15 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[622] = {
    name = 'R1-J5',
    XWS = 'r1j5',
    Faction = 4,
    limited = 1,
    ship_type = 'fireball',
    cost = 27,
    slot = { 21, 6, 8, 13, 14, 14, 15 },
    init = 1,
    texture = 'standard',
    actSet = { 'C', 'E', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB[623] = {
    name = 'Colossus Station Mechanic',
    XWS = 'colossusstationmechanic',
    Faction = 4,
    ship_type = 'fireball',
    cost = 26,
    slot = { 21, 6, 10, 13, 14, 14, 15 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[656] = {
    name = 'Commander Malarus',
    XWS = 'commandermalarus-xiclasslightshuttle',
    Faction = 5,
    limited = 1,
    ship_type = 'xiclasslightshuttle',
    cost = 44,
    slot = { 1, 19, 19, 8, 8, 14 },
    init = 5,
    texture = 'light',
    actSet = { 'F', 'TL' }
}

masterPilotDB[657] = {
    name = 'Gideon Hask',
    XWS = 'gideonhask-xiclasslightshuttle',
    Faction = 5,
    limited = 1,
    ship_type = 'xiclasslightshuttle',
    cost = 40,
    slot = { 1, 19, 19, 8, 8, 14 },
    init = 4,
    texture = 'light',
    actSet = { 'F', 'TL' }
}

masterPilotDB[658] = {
    name = 'Agent Terex',
    XWS = 'agentterex',
    Faction = 5,
    limited = 1,
    ship_type = 'xiclasslightshuttle',
    cost = 38,
    slot = { 19, 19, 8, 8, 13, 13, 13, 14 },
    init = 3,
    texture = 'dark',
    actSet = { 'F', 'TL' }
}

masterPilotDB[659] = {
    name = 'First Order Courier',
    XWS = 'firstordercourier',
    Faction = 5,
    ship_type = 'xiclasslightshuttle',
    cost = 35,
    slot = { 19, 19, 8, 8, 14 },
    init = 2,
    texture = 'light',
    actSet = { 'F', 'TL' }
}

masterPilotDB[660] = {
    name = '"Hawk"',
    XWS = 'hawk',
    limited = 1,
    Faction = 6,
    ship_type = 'laatigunship',
    cost = 51,
    slot = { 1, 6, 6, 8, 8, 16, 16, 14 },
    init = 4,
    texture = 'munilist',
    actSet = { 'F', 'R', 'TL', 'Rot' },
    addSqdAction = { 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB[661] = {
    name = '"Warthog"',
    XWS = 'warthog',
    limited = 1,
    Faction = 6,
    ship_type = 'laatigunship',
    cost = 52,
    slot = { 6, 6, 8, 8, 16, 16, 14 },
    init = 3,
    texture = 'warthog',
    actSet = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' }
}

masterPilotDB[662] = {
    name = '"Hound"',
    XWS = 'hound',
    limited = 1,
    Faction = 6,
    ship_type = 'laatigunship',
    cost = 48,
    slot = { 6, 6, 8, 8, 16, 16, 14 },
    init = 2,
    texture = 'hound1',
    actSet = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' }
}

masterPilotDB[663] = {
    name = '212th Battalion Pilot',
    XWS = '212thbattalionpilot',
    Faction = 6,
    ship_type = 'laatigunship',
    cost = 47,
    slot = { 6, 6, 8, 8, 16, 16, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' }
}

masterPilotDB[665] = {
    name = 'Onderon Oppressor',
    XWS = 'onderonoppressor',
    limited = 2,
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    cost = 40,
    slot = { 6, 6, 8, 12, 20, 14, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB[668] = {
    name = 'Geonosian Prototype',
    XWS = 'geonosianprototype',
    limited = 2,
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    cost = 38,
    slot = { 3, 3, 6, 6, 20, 14, 18 },
    init = 2,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB[666] = {
    name = 'DGS-047',
    XWS = 'dgs047',
    limited = 1,
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    cost = 38,
    slot = { 6, 6, 8, 12, 20, 14, 18 },
    init = 1,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB[664] = {
    name = 'DGS-286',
    XWS = 'dgs286',
    limited = 1,
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    cost = 39,
    slot = { 6, 6, 8, 12, 20, 14, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB[667] = {
    name = 'Separatist Predator',
    XWS = 'separatistpredator',
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    cost = 38,
    slot = { 6, 6, 8, 12, 20, 14, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB[669] = {
    name = 'Baktoid Drone',
    XWS = 'baktoiddrone',
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    cost = 37,
    slot = { 6, 6, 8, 12, 20, 14, 18 },
    init = 1,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB[693] = {
    name = '"Rampage"',
    XWS = 'rampage',
    limited = 1,
    Faction = 2,
    ship_type = 'tierbheavy',
    cost = 38,
    slot = { 1, 3, 3, 14, 14, 18 },
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB[694] = {
    name = 'Lyttan Dree',
    XWS = 'lyttandree',
    limited = 1,
    Faction = 2,
    ship_type = 'tierbheavy',
    cost = 36,
    slot = { 3, 3, 14, 14, 18 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB[695] = {
    name = 'Onyx Squadron Sentry',
    XWS = 'onyxsquadronsentry',
    Faction = 2,
    ship_type = 'tierbheavy',
    cost = 35,
    slot = { 1, 3, 3, 14, 14, 18 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB[696] = {
    name = 'Carida Academy Cadet',
    XWS = 'caridaacademycadet',
    Faction = 2,
    ship_type = 'tierbheavy',
    cost = 34,
    slot = { 3, 3, 14, 14, 18 },
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB[781] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker-eta2actis',
    limited = 1,
    Faction = 6,
    Force = 3,
    ship_type = 'eta2actis',
    cost = 51,
    slot = { 1, 17, 10, 14 },
    init = 6,
    texture = 'anakin',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side', 'Light Side', 'Jedi' }
}

masterPilotDB[782] = {
    name = 'Obi-Wan Kenobi',
    XWS = 'obiwankenobi-eta2actis',
    limited = 1,
    Faction = 6,
    Force = 3,
    ship_type = 'eta2actis',
    cost = 48,
    slot = { 1, 17, 10, 14 },
    init = 5,
    texture = 'obi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[783] = {
    name = 'Aayla Secura',
    XWS = 'aaylasecura',
    limited = 1,
    Faction = 6,
    Force = 2,
    ship_type = 'eta2actis',
    cost = 48,
    slot = { 1, 17, 10, 14 },
    init = 5,
    texture = 'aayla',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[784] = {
    name = 'Shaak Ti',
    XWS = 'shaakti',
    limited = 1,
    Faction = 6,
    Force = 2,
    ship_type = 'eta2actis',
    cost = 43,
    slot = { 1, 17, 10, 14 },
    init = 4,
    texture = 'shaak',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[785] = {
    name = 'Yoda',
    XWS = 'yoda',
    limited = 1,
    Faction = 6,
    Force = 3,
    ship_type = 'eta2actis',
    cost = 45,
    slot = { 17, 17, 10, 14 },
    init = 3,
    texture = 'yoda',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    mesh = "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/eta2actis-Yoda.obj"
}

masterPilotDB[786] = {
    name = 'Jedi General',
    XWS = 'jedigeneral',
    Faction = 6,
    Force = 2,
    ship_type = 'eta2actis',
    cost = 41,
    slot = { 17, 10, 14 },
    init = 4,
    texture = 'jedi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[788] = {
    name = '"Odd Ball"',
    XWS = 'oddball-nimbusclassvwing',
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    cost = 31,
    slot = { 1, 10, 14, 18 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB[789] = {
    name = '"Contrail"',
    XWS = 'contrail',
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    cost = 32,
    slot = { 1, 10, 14, 18 },
    init = 5,
    texture = 'contrail',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB[790] = {
    name = '"Klick"',
    XWS = 'klick',
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    Charge = 1,
    cost = 31,
    slot = { 1, 10, 14, 18 },
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB[791] = {
    name = 'Wilhuff Tarkin',
    XWS = 'wilhufftarkin',
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    cost = 31,
    slot = { 1, 10, 14, 18 },
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B' },
}

masterPilotDB[792] = {
    name = 'Shadow Squadron Escort',
    XWS = 'shadowsquadronescort',
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    cost = 28,
    slot = { 1, 10, 14, 18 },
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB[793] = {
    name = 'Loyalist Volunteer',
    XWS = 'loyalistvolunteer',
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    cost = 26,
    slot = { 10, 14, 18 },
    init = 2,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B' },
}

masterPilotDB[796] = {
    name = "Phlac-Arphocc Prototype",
    XWS = 'phlacarphoccprototype',
    limited = 2,
    Faction = 7,
    ship_type = 'droidtrifighter',
    cost = 38,
    slot = { 21, 1, 2, 6, 14, 18 },
    init = 5,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[794] = {
    name = "DIS-T81",
    XWS = 'dist81',
    limited = 1,
    Faction = 7,
    ship_type = 'droidtrifighter',
    cost = 37,
    slot = { 21, 1, 2, 6, 14, 18 },
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[795] = {
    name = "DIS-347",
    XWS = 'dis347',
    limited = 1,
    Faction = 7,
    ship_type = 'droidtrifighter',
    cost = 36,
    slot = { 21, 1, 2, 6, 14, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[797] = {
    name = "Fearsome Predator",
    XWS = 'fearsomepredator',
    limited = 3,
    Faction = 7,
    ship_type = 'droidtrifighter',
    Condition = "Fearful Prey",
    cost = 36,
    slot = { 21, 1, 2, 6, 14, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[798] = {
    name = "Separatist Interceptor",
    XWS = 'separatistinterceptor',
    Faction = 7,
    ship_type = 'droidtrifighter',
    cost = 35,
    slot = { 21, 1, 2, 6, 14, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[799] = {
    name = "Colicoid Interceptor",
    XWS = 'colicoidinterceptor',
    Faction = 7,
    ship_type = 'droidtrifighter',
    cost = 34,
    slot = { 21, 2, 6, 14, 18 },
    init = 1,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[800] = {
    name = 'Jango Fett',
    XWS = 'jangofett',
    limited = 1,
    Faction = 7,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 80,
    slot = { 21, 1, 3, 6, 8, 12, 13, 14, 15 },
    init = 6,
    texture = 'jango',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[801] = {
    name = 'Zam Wesell',
    XWS = 'zamwesell',
    limited = 1,
    Faction = 7,
    Condition = 'Zam Wesell',
    Charge = 4,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 84,
    slot = { 21, 1, 3, 6, 8, 12, 13, 14, 15 },
    init = 5,
    texture = 'zam',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[802] = {
    name = 'Boba Fett',
    XWS = 'bobafett-separatistalliance',
    title = 'Survivor',
    limited = 1,
    Faction = 7,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 70,
    slot = { 21, 3, 6, 8, 12, 13, 14, 15 },
    init = 3,
    texture = 'jango',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB[803] = {
    name = 'Separatist Racketeer',
    XWS = 'separatistracketeer',
    Faction = 7,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 63,
    slot = { 21, 3, 6, 8, 12, 13, 14, 15 },
    init = 2,
    texture = 'zam',
    actSet = { 'F', 'R', 'TL', 'B' }
}

-- Tie Whisper

masterPilotDB[836] = {
    name = '709th Legion Ace',
    XWS = '709thlegionace',
    Faction = 5,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    cost = 47,
    slot = { 21, 1, 1, 6, 19, 19, 18 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[837] = {
    name = '"Wrath"',
    XWS = 'wrath',
    Faction = 5,
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    cost = 53,
    slot = { 21, 1, 6, 19, 19, 18 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[838] = {
    name = '"Whirlwind"',
    XWS = 'whirlwind',
    Faction = 5,
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    cost = 47,
    slot = { 21, 1, 1, 6, 19, 19, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[839] = {
    name = '"Nightfall"',
    XWS = 'nightfall',
    Faction = 5,
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    cost = 49,
    slot = { 21, 1, 1, 6, 19, 19, 18 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' },
    movethrough = true
}

masterPilotDB[840] = {
    name = 'Kylo Ren',
    XWS = 'kyloren-tiewiwhispermodifiedinterceptor',
    Faction = 5,
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    cost = 63,
    slot = { 21, 1, 17, 6, 19, 19, 18 },
    init = 5,
    Force = 3,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[841] = {
    name = 'Red Fury Zealot',
    XWS = 'redfuryzealot',
    Faction = 5,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    cost = 44,
    slot = { 21, 1, 6, 19, 19, 18 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

-- First Order Bomber

masterPilotDB[842] = {
    name = 'First Order Cadet',
    XWS = 'firstordercadet',
    Faction = 5,
    ship_type = 'tiesebomber',
    cost = 32,
    slot = { 21, 1, 19, 5, 6, 16, 12, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB[843] = {
    name = 'Sienar-Jaemus Test Pilot',
    XWS = 'sienarjaemustestpilot',
    Faction = 5,
    ship_type = 'tiesebomber',
    cost = 31,
    slot = { 21, 19, 5, 6, 16, 12, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB[844] = {
    name = '"Grudge"',
    XWS = 'grudge',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesebomber',
    cost = 36,
    slot = { 21, 19, 5, 6, 16, 12, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB[845] = {
    name = '"Scorch"',
    XWS = 'scorch-tiesebomber',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesebomber',
    cost = 35,
    slot = { 21, 1, 19, 5, 6, 16, 12, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB[846] = {
    name = '"Breach"',
    XWS = 'breach',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesebomber',
    cost = 36,
    slot = { 21, 1, 19, 5, 6, 16, 12, 14 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB[847] = {
    name = '"Dread"',
    XWS = 'dread',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesebomber',
    cost = 32,
    slot = { 21, 19, 5, 6, 16, 12, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

-- Resistance Y-Wing

masterPilotDB[848] = {
    name = 'New Republic Patrol',
    XWS = 'newrepublicpatrol',
    Faction = 4,
    ship_type = 'btanr2ywing',
    cost = 32,
    slot = { 21, 1, 19, 4, 10, 12, 14, 14, 18 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[849] = {
    name = 'Kijimi Spice Runner',
    XWS = 'kijimispicerunner',
    Faction = 4,
    ship_type = 'btanr2ywing',
    cost = 31,
    slot = { 21, 1, 19, 4, 10, 12, 14, 13, 18 },
    init = 2,
    texture = 'plain',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[850] = {
    name = 'Teza Nasz',
    XWS = 'tezanasz',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    cost = 37,
    slot = { 21, 1, 19, 4, 10, 12, 14, 14, 18 },
    init = 4,
    texture = 'teza',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[851] = {
    name = 'Shasa Zaro',
    XWS = 'shasazaro',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    cost = 33,
    slot = { 21, 1, 19, 4, 10, 12, 14, 14, 18 },
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[852] = {
    name = 'Corus Kapellim',
    XWS = 'coruskapellim',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    cost = 33,
    slot = { 21, 1, 19, 4, 10, 12, 14, 13, 18 },
    init = 1,
    texture = 'corus',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[853] = {
    name = "C'ai Threnalli",
    XWS = 'caithrenalli-btanr2ywing',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    cost = 34,
    slot = { 21, 1, 19, 4, 10, 12, 14, 14, 18 },
    init = 2,
    texture = 'cai',
    actSet = { 'F', 'TL', 'BR', 'B', 'C', 'E' },
    movethrough = true
}

masterPilotDB[854] = {
    name = 'Wilsa Teshlo',
    XWS = 'wilsateshlo',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    cost = 34,
    slot = { 21, 1, 19, 4, 10, 12, 14, 14, 18 },
    init = 4,
    texture = 'wilsa',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[855] = {
    name = 'Zorii Bliss',
    XWS = 'zoriibliss',
    Charge = 1,
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    cost = 40,
    slot = { 21, 1, 19, 4, 10, 12, 14, 13, 18 },
    init = 5,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[856] = {
    name = 'Aftab Ackbar',
    XWS = 'aftabackbar',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    cost = 34,
    slot = { 21, 1, 19, 4, 10, 12, 14, 14, 18 },
    init = 2,
    texture = 'cai',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[857] = {
    name = 'Lega Fossang',
    XWS = 'legafossang',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    cost = 33,
    slot = { 21, 1, 19, 4, 10, 12, 14, 14, 18 },
    init = 3,
    texture = 'lega',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}


--- NEW SHIT:
masterPilotDB[900] = {
    name = 'Fenn Rau',
    XWS = 'fennrau-fangfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'fangfighter',
    cost = 200,
    slot = { 21, 1, 5 },
    init = 6,
    texture = 'rebelfenn',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[901] = {
    name = 'Bodica Venj',
    XWS = 'bodicavenj',
    Faction = 1,
    limited = 1,
    ship_type = 'fangfighter',
    cost = 200,
    slot = { 21, 1, 5 },
    init = 4,
    texture = 'bodica',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[902] = {
    name = 'Dirk Ullodin',
    XWS = 'dirkullodin',
    Faction = 1,
    limited = 1,
    ship_type = 'fangfighter',
    cost = 200,
    slot = { 21, 1, 5 },
    init = 3,
    init = 3,
    texture = 'dirk',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[903] = {
    name = 'Clan Wren Volunteer',
    XWS = 'clanwrenvolunteer',
    Faction = 1,
    limited = 2,
    ship_type = 'fangfighter',
    cost = 200,
    slot = { 21, 1, 5 },
    init = 3,
    texture = 'volunteer',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[904] = {
    name = 'Mandalorian Royal Guard',
    XWS = 'mandalorianroyalguard',
    Faction = 3,
    limited = 2,
    ship_type = 'fangfighter',
    cost = 200,
    slot = { 21, 1, 5 },
    init = 4,
    texture = 'original',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

-- New TIE Ln

masterPilotDB[905] = {
    name = 'Moff Gideon',
    XWS = 'moffgideon',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 200,
    slot = { 21, 1, 14 },
    Charge = 2,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[906] = {
    name = 'ISB Jingoist',
    XWS = 'isbjingoist',
    Faction = 2,
    limited = 2,
    ship_type = 'tielnfighter',
    cost = 200,
    slot = { 21, 1, 14 },
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}


-- Gauntlet fighter:
masterPilotDB[910] = {
    name = 'Maul',
    XWS = 'maul',
    Faction = 3,
    limited = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    Force = 3,
    init = 5,
    texture = 'maul',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[911] = {
    name = 'Bo-Katan Kryze',
    title = 'Nite Owl Commander',
    XWS = 'bokatankryze',
    Faction = 6,
    limited = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 4,
    texture = 'bokatan',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[912] = {
    name = 'Bo-Katan Kryze',
    title = "Vizsla's Lieutenant",
    XWS = 'bokatankryze-separatistalliance',
    Faction = 7,
    limited = 1,
    Charge = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 4,
    texture = 'bokatancis',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[913] = {
    name = 'Pre Vizsla',
    XWS = 'previzsla',
    Faction = 7,
    limited = 1,
    Charge = 2,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 3,
    texture = 'previzsla',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[914] = {
    name = 'Rook Kast',
    XWS = 'rookkast',
    Faction = 3,
    limited = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 3,
    texture = 'scum',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[915] = {
    name = 'Death Watch Warrior',
    XWS = 'deathwatchwarrior',
    Faction = 7,
    limited = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 2,
    texture = 'deathwatch',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[916] = {
    name = 'Nite Owl Liberator',
    XWS = 'niteowlliberator',
    Faction = 6,
    limited = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 2,
    texture = 'default',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[917] = {
    name = 'Shadow Collective Operator',
    XWS = 'shadowcollectiveoperator',
    Faction = 3,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 1,
    texture = 'scum',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[918] = {
    name = 'Ezra Bridger',
    XWS = 'ezrabridger-gauntletfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    Force = 1,
    init = 3,
    texture = 'scum',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[919] = {
    name = '"Chopper"',
    XWS = 'chopper-gauntletfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 2,
    texture = 'scum',
    actSet = { 'C', 'TL', 'R', 'Piv' },
}

masterPilotDB[920] = {
    name = 'Mandalorian Resistance Pilot',
    XWS = 'mandalorianresistancepilot',
    Faction = 1,
    limited = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 2,
    texture = 'default',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[921] = {
    name = 'Captain Hark',
    XWS = 'captainhark',
    Faction = 2,
    limited = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 3,
    texture = 'imperial',
    actSet = { 'F', 'TL', 'R' },
    executeOptions = {
        rs0 = { 'rbl1z', 'rs0', 'rbr1z' }
    },
}

masterPilotDB[922] = {
    name = 'Gar Saxon',
    XWS = 'garsaxon',
    Charge = 2,
    Faction = 2,
    limited = 1,
    ship_type = 'gauntletfighter',
    cost = 200,
    slot = { 21, 1, 5, 18 },
    init = 3,
    texture = 'deathwatch',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}


-- razorcrest pilots

masterPilotDB[923] = {
    name = 'The Mandalorian',
    XWS = 'themandalorian',
    Faction = 3,
    limited = 1,
    ship_type = 'st70assaultship',
    cost = 200,
    slot = { 21, 1, 5 },
    init = 5,
    texture = 'mandalorian',
    actSet = { 'F', 'TL', 'E', 'BR' },
}

masterPilotDB[924] = {
    name = 'Q9-0',
    XWS = 'q90',
    Faction = 3,
    limited = 1,
    ship_type = 'st70assaultship',
    cost = 200,
    slot = { 21, 1, 5 },
    init = 5,
    texture = 'guildbountyhunter',
    actSet = { 'C', 'TL', 'E', 'BR' },
}

masterPilotDB[925] = {
    name = 'Guild Bounty Hunter',
    XWS = 'guildbountyhunter',
    Faction = 3,
    limited = 2,
    ship_type = 'st70assaultship',
    cost = 200,
    slot = { 21, 1, 5 },
    init = 3,
    texture = 'guildbountyhunter',
    actSet = { 'F', 'TL', 'E', 'BR' },
}



masterPilotDB[926] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    cost = 59,
    slot = { 21, 17, 10, 14 },
    Force = 3,
    init = 6,
    texture = 'anakin',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[927] = {
    name = 'Luminara Unduli',
    XWS = 'luminaraunduli-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    cost = 40,
    slot = { 21, 17, 10, 14 },
    Force = 2,
    init = 4,
    texture = 'lumi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[928] = {
    name = 'Barriss Offee',
    XWS = 'barrissoffee-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    cost = 36,
    slot = { 21, 17, 10, 14 },
    Force = 1,
    init = 4,
    texture = 'barriss',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[929] = {
    name = 'Ahsoka Tano',
    XWS = 'ahsokatano-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    cost = 41,
    slot = { 21, 17, 10, 14 },
    Force = 2,
    init = 3,
    texture = 'ahsoka',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[930] = {
    name = 'Obi-Wan Kenobi',
    XWS = 'obiwankenobi-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    cost = 47,
    slot = { 21, 17, 10, 14 },
    Force = 3,
    init = 5,
    texture = 'obi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[931] = {
    name = 'Mace Windu',
    XWS = 'macewindu-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    cost = 44,
    slot = { 21, 17, 10, 14 },
    Force = 3,
    init = 4,
    texture = 'mace',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[932] = {
    name = 'Plo Koon',
    XWS = 'plokoon-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    cost = 43,
    slot = { 21, 17, 10, 14 },
    Force = 2,
    init = 5,
    texture = 'plo',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[933] = {
    name = 'Saesee Tiin',
    XWS = 'saeseetiin-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    cost = 40,
    slot = { 21, 17, 10, 14 },
    Force = 2,
    init = 4,
    texture = 'saesee',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[934] = {
    name = 'Jedi Knight',
    XWS = 'jediknight-delta7baethersprite',
    Faction = 6,
    ship_type = 'delta7baethersprite',
    cost = 36,
    slot = { 21, 17, 10, 14 },
    Force = 1,
    init = 3,
    texture = 'knight',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    --tintFriendly = {mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/Small/delta7baethersprite/Jedi_Delta7_tint.obj',
    --                texture = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/Small/delta7baethersprite/JediKnight-tint.png',}
}

-- Rogue class starfighter

masterPilotDB[935] = {
    name = 'Cad Bane',
    XWS = 'cadbane-separatistalliance',
    Faction = 7,
    Charge = 1,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    cost = 20,
    slot = { 21, 17, 10, 14, 15 },
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[936] = {
    name = 'IG-101',
    XWS = 'ig101',
    Faction = 7,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 4,
    texture = 'grey',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[937] = {
    name = 'IG-102',
    XWS = 'ig102',
    Faction = 7,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 4,
    texture = 'grey',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[938] = {
    name = 'IG-111',
    XWS = 'ig111',
    Faction = 7,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 1,
    texture = 'grey',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[939] = {
    name = 'MagnaGuard Protector',
    XWS = 'magnaguardprotector',
    Faction = 7,
    limited = 2,
    ship_type = 'rogueclassstarfighter',
    Condition = 'Guarded',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 4,
    texture = 'grey',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[940] = {
    name = 'MagnaGuard Executioner',
    XWS = 'magnaguardexecutioner',
    Faction = 7,
    ship_type = 'rogueclassstarfighter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 3,
    texture = 'grey',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[941] = {
    name = 'Cad Bane',
    XWS = 'cadbane',
    Faction = 3,
    Charge = 2,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    cost = 20,
    slot = { 21, 17, 10, 14, 15 },
    init = 4,
    texture = 'green',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[942] = {
    name = 'Viktor Hel',
    XWS = 'viktorhel-rogueclassstarfighter',
    Faction = 3,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 4,
    texture = 'green',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[943] = {
    name = 'Nom Lumb',
    XWS = 'nomlumb-rogueclassstarfighter',
    Faction = 3,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 1,
    texture = 'green',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[944] = {
    name = 'Outer Rim Hunter',
    XWS = 'outerrimhunter',
    Faction = 3,
    ship_type = 'rogueclassstarfighter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 3,
    texture = 'green',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

-- Clone Z-95

masterPilotDB[945] = {
    name = '"Hawk"',
    XWS = 'hawk-clonez95headhunter',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 4,
    limited = 1,
    texture = 'standard',
    addSqdAction = { 'BR', 'B' },
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB[946] = {
    name = '"Slider"',
    XWS = 'slider',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    cost = 20,
    Charge = 2,
    slot = { 21, 17, 10, 14 },
    init = 4,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
    executeOptions = {
        bbl2 = { 'bbl2', 'bbl2z' },
        bbr2 = { 'bbr2', 'bbr2z' },
    },
}

masterPilotDB[947] = {
    name = '"Boost"',
    XWS = 'boost',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 3,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'B', 'TL' },
}

masterPilotDB[948] = {
    name = '"Drift"',
    XWS = 'drift',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 3,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB[949] = {
    name = '"Stub"',
    XWS = 'stub',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 3,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB[950] = {
    name = '"Warthog"',
    XWS = 'warthog-clonez95headhunter',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 3,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB[951] = {
    name = '"Killer"',
    XWS = 'killer',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 2,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB[952] = {
    name = '"Knack"',
    XWS = 'knack',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 5,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB[953] = {
    name = 'Reaper Squadron Scout',
    XWS = 'reapersquadronscout',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    cost = 20,
    slot = { 21, 17, 10, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB[954] = {
    name = '7th Sky Corps Pilot',
    XWS = '7thskycorpspilot',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    cost = 3,
    slot = { 21, 2, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

-- Missing ships
masterPilotDB[955] = {
    name = 'Imperial Super Commando',
    XWS = 'imperialsupercommando',
    Faction = 2,
    ship_type = 'gauntletfighter',
    cost = 7,
    slot = { 21, 1, 8, 16, 12, 12, 14, 18 },
    init = 2,
    texture = 'imperial',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB[956] = {
    name = 'Outer Rim Enforcer',
    XWS = 'outerrimenforcer',
    Faction = 3,
    ship_type = 'st70assaultship',
    cost = 2,
    slot = { 21, 1, 8, 16, 13, 13, 14 },
    init = 2,
    texture = 'guildbountyhunter',
    actSet = { 'F', 'TL', 'E', 'BR' },
}

-- Battle of Yavin standardized pilots

masterPilotDB[957] = {
    name = 'Luke Skywalker',
    XWS = 'lukeskywalker-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 20,
    Force = 2,
    init = 5,
    texture = 'luke',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Light Side' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Attack Speed',     charge = 0 },
        { name = 'Instinctive Aim',  charge = 0 },
        { name = 'Proton Torpedoes', charge = 2 },
        { name = 'R2-D2',            charge = 2 }
    }
}

masterPilotDB[958] = {
    name = 'Wedge Antilles',
    XWS = 'wedgeantilles-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 20,
    init = 5,
    texture = 'wedge',
    actSet = { 'F', 'TL', 'BR', 'B' },

    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Attack Speed',     charge = 0 },
        { name = 'Marksmanship',     charge = 0 },
        { name = 'Proton Torpedoes', charge = 2 },
        { name = 'R2-A3',            charge = 2 }
    }
}

masterPilotDB[959] = {
    name = 'Jek Porkins',
    XWS = 'jekporkins-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 20,
    init = 4,
    texture = 'porkins',
    actSet = { 'F', 'TL', 'BR', 'B' },

    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Adv. Proton Torpedoes',     charge = 1 },
        { name = 'Proton Torpedoes',          charge = 2 },
        { name = 'Unstable Sublight Engines', charge = 0 }
    }
}

masterPilotDB[960] = {
    name = 'Garven Dreis',
    XWS = 'garvendreis-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 20,
    init = 4,
    texture = 'garven',
    actSet = { 'F', 'TL', 'BR', 'B' },
    addSqdAction = { 'F' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'R5-K6',                 charge = 2 }
    }
}

masterPilotDB[961] = {
    name = 'Biggs Darklighter',
    XWS = 'biggsdarklighter-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 20,
    init = 3,
    texture = 'biggs',
    actSet = { 'F', 'TL', 'BR', 'B' },

    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Attack Speed',     charge = 0 },
        { name = 'Selfless',         charge = 0 },
        { name = 'Proton Torpedoes', charge = 2 },
        { name = 'R2-F2',            charge = 2 },
    }
}

masterPilotDB[962] = {
    name = 'Dex Tiree',
    XWS = 'dextiree-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 20,
    init = 2,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR', 'B' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Dorsal Turret',         charge = 0 },
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'R4 Astromech',          charge = 0 },
    }
}

masterPilotDB[963] = {
    name = 'Hol Okand',
    XWS = 'holokand-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 20,
    init = 4,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR', 'B' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Dorsal Turret',         charge = 0 },
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'Precise Astromech',     charge = 2 },
    }
}

masterPilotDB[964] = {
    name = '"Pops" Krail',
    XWS = 'popskrail-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 20,
    init = 4,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR', 'B' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Cannon Turret',     charge = 0 },
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'R4 Astromech',          charge = 2 },
    }
}

masterPilotDB[965] = {
    name = 'Han Solo',
    XWS = 'hansolo-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    cost = 20,
    Charge = 4,
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'E' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Chewbacca',           charge = 0 },
        { name = 'Rigged Cargo Chute',  charge = 1 },
        { name = 'Millennium Falcon',   charge = 0 },
        { name = "L3-37's Programming", charge = 0 },
    }
}


masterPilotDB[966] = {
    name = 'Darth Vader',
    XWS = 'darthvader-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    cost = 20,
    Force = 3,
    init = 6,
    Shield = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side', 'Sith' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Marksmanship', charge = 0 },
        { name = 'Hate',         charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB[967] = {
    name = '"Mauler" Mithel',
    XWS = 'maulermithel-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 20,
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator',     charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB[968] = {
    name = '"Wampa"',
    XWS = 'wampa-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 20,
    Charge = 1,
    init = 1,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Elusive',  charge = 1 },
        { name = 'Vengeful', charge = 0 },
    }
}

masterPilotDB[969] = {
    name = '"Dark Curse"',
    XWS = 'darkcurse-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 20,
    init = 6,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    executeOptions = {
        rk3 = { [1] = 'rk3', [2] = 'rbl3s', [3] = 'rbr3s' },
    },
    standardized_upgrades = {
        { name = 'Ruthless',              charge = 0 },
        { name = 'Precision Ion Engines', charge = 2 },
    }
}

masterPilotDB[970] = {
    name = '"Backstabber"',
    XWS = 'backstabber-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 20,
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Crackshot',    charge = 1 },
        { name = 'Disciplined',  charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB[971] = {
    name = 'Iden Versio',
    XWS = 'idenversio-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    Shield = 1,
    ship_type = 'tieininterceptor',
    Charge = 2,
    cost = 20,
    init = 4,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator', charge = 0 },
        { name = 'Fanatic',  charge = 0 },
    }
}

masterPilotDB[972] = {
    name = 'Sigma 4',
    XWS = 'sigma4-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 20,
    Charge = 2,
    init = 4,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Disciplined',      charge = 0 },
        { name = 'Primed Thrusters', charge = 0 },
    }
}

masterPilotDB[973] = {
    name = 'Sigma 5',
    XWS = 'sigma5-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 20,
    Charge = 2,
    init = 4,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Sensor Jammer', charge = 0 },
        { name = 'Elusive',       charge = 1 },
    }
}

masterPilotDB[974] = {
    name = 'Sigma 6',
    XWS = 'sigma6-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 20,
    Charge = 2,
    init = 4,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Daredevil',    charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB[975] = {
    name = 'Sigma 7',
    XWS = 'sigma7-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 20,
    Charge = 2,
    init = 4,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Marksmanship',        charge = 0 },
        { name = 'Fire-Control System', charge = 0 },
    }
}

masterPilotDB[976] = {
    name = '"Dutch" Vander',
    XWS = 'dutchvander-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 20,
    init = 4,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR', 'B' },
    addSqdAction = { 'TL' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Cannon Turret',     charge = 0 },
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'Targeting Astromech',   charge = 0 },
    }
}
-- Siege of corruscant

masterPilotDB[977] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker-siegeofcoruscant',
    title = 'Siege of Coruscant',
    limited = 1,
    Faction = 6,
    Force = 3,
    ship_type = 'eta2actis',
    cost = 20,
    slot = { 1, 17, 10, 14 },
    init = 6,
    texture = 'anakin',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side', 'Light Side', 'Jedi' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Malice',                charge = 0 },
        { name = 'Ancillary Ion Weapons', charge = 2 },
        { name = 'R2-D2',                 charge = 2 },
    }
}

masterPilotDB[978] = {
    name = 'Obi-Wan Kenobi',
    XWS = 'obiwankenobi-siegeofcoruscant',
    title = 'Siege of Coruscant',
    limited = 1,
    Faction = 6,
    Force = 3,
    ship_type = 'eta2actis',
    cost = 20,
    slot = { 1, 17, 10, 14 },
    init = 5,
    texture = 'obi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Patience',              charge = 0 },
        { name = 'Ancillary Ion Weapons', charge = 2 },
        { name = 'R4-P17',                charge = 2 },
    }
}

masterPilotDB[979] = {
    name = 'Shaak Ti',
    XWS = 'shaakti-siegeofcoruscant',
    title = 'Siege of Coruscant',
    limited = 1,
    Faction = 6,
    Force = 2,
    ship_type = 'eta2actis',
    cost = 20,
    slot = { 1, 17, 10, 14 },
    init = 4,
    texture = 'shaak',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Marksmanship',          charge = 0 },
        { name = 'Brilliant Evasion',     charge = 0 },
        { name = 'Ancillary Ion Weapons', charge = 2 },
        { name = 'R4-P Astromech',        charge = 2 },
    }
}

masterPilotDB[980] = {
    name = '"Axe"',
    XWS = 'axe-siegeofcoruscant',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    title = 'Siege of Coruscant',
    cost = 20,
    slot = { 21, 1, 6, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' },
    addSqdAction = { 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Deadeye Shot',    charge = 0 },
        { name = 'Barrage Rockets', charge = 5 },
    }
}

masterPilotDB[981] = {
    name = '"Kickback"',
    XWS = 'kickback-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    cost = 20,
    slot = { 21, 1, 6, 14 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Diamond-Boron Missiles', charge = 3 },
        { name = 'Munitions Failsafe',     charge = 0 },
    }
}

masterPilotDB[982] = {
    name = '"Contrail"',
    XWS = 'contrail-siegeofcoruscant',
    title = 'Siege of Coruscant',
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    cost = 20,
    slot = { 1, 10, 14, 18 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Limiter Override', charge = 0 },
        { name = 'Precise Astromech',    charge = 2 },
        { name = 'Ion Bombs',            charge = 2 },
        { name = 'Alpha-3b "Besh"',      charge = 0 },
    }
}

masterPilotDB[983] = {
    name = '"Jag"',
    XWS = 'jag-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 20,
    slot = { 21, 5, 14, 8, 16, 10 },
    init = 3,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    addSqdAction = { 'TL' },
    keywords = { 'Clone' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Veteran Tail Gunner',  charge = 0 },
        { name = 'R4-P Astromech',       charge = 2 },
        { name = 'Synchronized Console', charge = 0 },
    }
}

masterPilotDB[984] = {
    name = '"Wolffe"',
    XWS = 'wolffe-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 20,
    slot = { 21, 1, 5, 14, 8, 16, 10 },
    Charge = 1,
    init = 4,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Wolfpack',            charge = 0 },
        { name = 'Veteran Tail Gunner', charge = 0 },
        { name = 'Q7 Astromech',        charge = 0 },
    }
}

masterPilotDB[985] = {
    name = '"Odd Ball"',
    XWS = 'oddball-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    cost = 20,
    slot = { 21, 1, 5, 14, 8, 16, 10 },
    init = 5,
    Shield = 4,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    addSqdAction = { 'TL' },
    keywords = { 'Clone' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Selfless',            charge = 0 },
        { name = 'Veteran Tail Gunner', charge = 0 },
        { name = 'R4-P Astromech',      charge = 2 },
    }
}

masterPilotDB[986] = {
    name = 'Count Dooku',
    XWS = 'countdooku-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 7,
    limited = 1,
    ship_type = 'sithinfiltrator',
    cost = 20,
    slot = { 21, 17, 5, 3, 8, 8, 20, 12, 15, 14 },
    Force = 3,
    init = 5,
    actSet = { 'F', 'TL', 'BR' },
    texture = 'standard',
    keywords = { 'Dark Side', 'Sith' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Malice',        charge = 0 },
        { name = 'Roiling Anger', charge = 0 },
        { name = 'Scimitar',      charge = 0 },
    }
}

masterPilotDB[987] = {
    name = 'DFS-081',
    XWS = 'dfs081-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 7,
    Charge = 2,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    cost = 20,
    slot = { 21, 6, 14, 18 },
    init = 3,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'dfs081',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Discord Missiles',     charge = 1 },
        { name = 'Contingency Protocol', charge = 0 },
        { name = 'Strut-Lock Override',  charge = 2 },
    }
}


masterPilotDB[988] = {
    name = 'DFS-311',
    XWS = 'dfs311-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 7,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    cost = 23,
    slot = { 21, 6, 14, 18 },
    init = 1,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'dfs311',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Discord Missiles',     charge = 1 },
        { name = 'Contingency Protocol', charge = 0 },
        { name = 'Strut-Lock Override',  charge = 2 },
    }
}

masterPilotDB[989] = {
    name = 'Haor Chall Prototype',
    XWS = 'haorchallprototype-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 7,
    limited = 2,
    ship_type = 'vultureclassdroidfighter',
    cost = 22,
    slot = { 21, 6, 14, 18 },
    init = 1,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'proto',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Missiles',         charge = 3 },
        { name = 'Contingency Protocol', charge = 0 },
        { name = 'Strut-Lock Override',  charge = 2 },
    }
}


-- Hotshot and aces II

masterPilotDB[990] = {
    name = 'Adi Gallia',
    XWS = 'adigallia',
    Faction = 6,
    ship_type = 'delta7aethersprite',
    cost = 0,
    slot = { 21, 17, 10, 14 },
    Force = 2,
    init = 5,
    texture = 'plo',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
}

masterPilotDB[991] = {
    name = 'Adi Gallia',
    XWS = 'adigallia-delta7baethersprite',
    Faction = 6,
    ship_type = 'delta7baethersprite',
    cost = 0,
    limited = 1,
    slot = { 21, 17, 10, 14 },
    Force = 2,
    init = 5,
    texture = 'plo',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
}

masterPilotDB[992] = {
    name = 'Corran Horn',
    XWS = 'corranhorn-t65xwing',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 0,
    slot = { 21, 17, 5, 10, 14, 18 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' },
    addSqdAction = { 'TL' }
}

masterPilotDB[993] = {
    name = 'Doctor Aphra',
    XWS = 'doctoraphra',
    Faction = 3,
    limited = 1,
    ship_type = 'yv666lightfreighter',
    cost = 0,
    slot = { 21, 1, 3, 6, 8, 8, 16, 13, 14, 15 },
    init = 3,
    Charge = 3,
    texture = 'aphra',
    actSet = { 'F', 'TL', 'R' },
}

masterPilotDB[994] = {
    name = 'Durge',
    XWS = 'durge',
    Faction = 3,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    cost = 0,
    slot = { 21, 17, 10, 14, 15 },
    init = 5,
    texture = 'durge',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[995] = {
    name = 'Flight Leader Ubbel',
    XWS = 'flightleaderubbel',
    limited = 1,
    Faction = 2,
    ship_type = 'tierbheavy',
    cost = 0,
    slot = { 3, 3, 14, 14, 18 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB[996] = {
    name = 'Gavyn Sykes',
    XWS = 'gavynsykes',
    Faction = 6,
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    cost = 0,
    slot = { 21, 1, 2, 5, 10 },
    init = 3,
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB[997] = {
    name = 'Hondo Ohnaka',
    XWS = 'hondoohnaka',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 0,
    slot = { 21, 1, 3, 6, 8, 12, 13, 14, 15 },
    init = 1,
    texture = 'blue',
    actSet = { 'F', 'R', 'TL', 'B', 'C' },
    addSqdAction = { 'F', 'R', 'TL', 'B' },
}

masterPilotDB[998] = {
    name = 'Juno Eclipse',
    XWS = 'junoeclipse',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    cost = 0,
    slot = { 21, 2, 6, 14 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB[999] = {
    name = 'Keo Venzee',
    XWS = 'keovenzee',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 0,
    slot = { 21, 1, 1, 6, 18 },
    init = 3,
    Force = 1,
    texture = 'keo',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    executeOptions = {
        wtl1 = { 'wtl1', 'rtl1z' },
        wtr1 = { 'wtr1', 'rtr1z' },
        btl2 = { 'btl2', 'wtl2z' },
        bbl2 = { 'bbl2', 'wbl2z' },
        bbr2 = { 'bbr2', 'wbr2z' },
        btr2 = { 'btr2', 'wtr2z' },
        wtl3 = { 'wtl3', 'rtl3z' },
        wbl3 = { 'wbl3', 'rbl3z' },
        wbr3 = { 'wbr3', 'rbr3z' },
        wtr3 = { 'wtr3', 'rtr3z' },
    },
}

masterPilotDB[1000] = {
    name = 'Kit Fisto',
    XWS = 'kitfisto',
    limited = 1,
    Faction = 6,
    Force = 2,
    ship_type = 'eta2actis',
    cost = 48,
    slot = { 1, 17, 10, 14 },
    init = 4,
    texture = 'kit',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB[1001] = {
    name = 'Lapin',
    XWS = 'lapin',
    Faction = 3,
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    cost = 0,
    slot = { 21, 1, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[1002] = {
    name = 'Magna Tolvan',
    XWS = 'magnatolvan',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 0,
    slot = { 21, 1, 14 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB[1003] = {
    name = '"Pops" Krail',
    XWS = 'popskrail',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 0,
    init = 3,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR' },
}

masterPilotDB[1004] = {
    name = 'Second Sister',
    XWS = 'secondsister',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 0,
    slot = { 21, 17, 2, 6 },
    Force = 2,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB[1005] = {
    name = '"Sicko"',
    XWS = 'sicko',
    limited = 1,
    Faction = 6,
    ship_type = 'laatigunship',
    Condition = 'Sickening Maneuver',
    cost = 48,
    slot = { 6, 6, 8, 8, 16, 16, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' },
    executeOptions = {
        wbl1 = { [1] = 'wbl1', [2] = 'wbl1z' },
        wbr1 = { [1] = 'wbr1', [2] = 'wbr1z' },
        wtl2 = { [1] = 'wtl2', [2] = 'wtl2z' },
        wbl2 = { [1] = 'wbl2', [2] = 'wbl2z' },
        wbr2 = { [1] = 'wbr2', [2] = 'wbr2z' },
        wtr2 = { [1] = 'wtr2', [2] = 'wtr2z' },
        rtl3 = { [1] = 'rtl3', [2] = 'rtl3z' },
        wbl3 = { [1] = 'wbl3', [2] = 'wbl3z' },
        wbr3 = { [1] = 'wbr3', [2] = 'wbr3z' },
        rtr3 = { [1] = 'rtr3', [2] = 'rtr3z' },
        bs1  = { [1] = 'bs1', [2] = 'rk1' },
        bs2  = { [1] = 'bs2', [2] = 'rk2' },
        ws3  = { [1] = 'ws3', [2] = 'rk3' },
        rs4  = { [1] = 'rs4', [2] = 'rk4' },
    },
}

masterPilotDB[1006] = {
    name = '"Slammer"',
    XWS = 'slammer',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    cost = 0,
    slot = { 21, 1, 6, 14 },
    init = 1,
    Charge = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB[1007] = {
    name = 'Tor Phun',
    XWS = 'torphun',
    Faction = 3,
    limited = 1,
    ship_type = 'fangfighter',
    cost = 0,
    slot = { 21, 1, 5, 14 },
    init = 3,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB[1008] = {
    name = 'Tycho Celchu',
    XWS = 'tychocelchu',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 0,
    slot = { 21, 1, 1, 6, 18 },
    init = 5,
    texture = 'arvel',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB[1009] = {
    name = 'Wes Janson',
    XWS = 'wesjanson',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 0,
    slot = { 21, 17, 5, 10, 14, 18 },
    init = 5,
    Charge = 1,
    texture = 'wes',
    actSet = { 'F', 'TL', 'BR' },
}

masterPilotDB[1010] = {
    name = 'Yrica Quell',
    XWS = 'yricaquell',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 0,
    slot = { 21, 1, 14 },
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB[1011] = {
    name = 'Taka Jamoreesa',
    XWS = 'takajamoreesa',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransport',
    cost = 0,
    slot = { 21, 1, 19, 3, 3, 5, 8, 8, 10, 14 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB[1012] = {
    name = 'Zay Versio',
    XWS = 'zayversio',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 0,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB[1013] = {
    name = 'Venisa Doza',
    XWS = 'venisadoza',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    cost = 0,
    slot = { 21, 1, 19, 14, 18, 15, 10, 99 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' },
    arcs = { fixed = { range = 3, type = { 'front', 'back' } } },
}

masterPilotDB[1014] = {
    name = "Lando Calrissian",
    XWS = 'landocalrissian-scavengedyt1300',
    Faction = 4,
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    cost = 0,
    slot = { 21, 1, 8, 8, 16, 13, 14, 15 },
    init = 5,
    Charge = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB[1015] = {
    name = "Poe Dameron",
    XWS = 'poedameron-scavengedyt1300',
    Faction = 4,
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    cost = 0,
    slot = { 21, 1, 8, 8, 16, 13, 14, 15 },
    init = 6,
    Charge = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'BR', 'Rot' }
}

masterPilotDB[1016] = {
    name = 'The Iron Assembler',
    XWS = 'theironassembler',
    Faction = 7,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    cost = 0,
    Charge = 3,
    slot = { 21, 6, 14, 18 },
    init = 1,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'proto',
}

masterPilotDB[1017] = {
    name = 'Kelrodo-Ai Holdout',
    XWS = 'kelrodoaiholdout',
    Faction = 7,
    limited = 3,
    ship_type = 'vultureclassdroidfighter',
    cost = 0,
    slot = { 21, 6, 14, 18 },
    init = 1,
    actSet = { 'F', 'BR', 'TL', 'C' },
    texture = 'proto',
}

masterPilotDB[1018] = {
    name = 'Aurra Sing',
    XWS = 'aurrasing',
    limited = 1,
    Faction = 7,
    Force = 1,
    ship_type = 'firesprayclasspatrolcraft',
    cost = 0,
    slot = { 21, 1, 3, 6, 8, 12, 13, 14, 15 },
    init = 4,
    texture = 'zam',
    actSet = { 'F', 'R', 'TL', 'B' },
}

masterPilotDB[1019] = {
    name = 'Agent Tierny',
    XWS = 'agenttierny',
    Faction = 5,
    limited = 1,
    Condition = 'Broken Trust',
    ship_type = 'xiclasslightshuttle',
    cost = 0,
    slot = { 1, 19, 19, 8, 8, 14 },
    init = 3,
    texture = 'light',
    actSet = { 'F', 'TL' }
}

masterPilotDB[1020] = {
    name = 'Lin Gaava',
    XWS = 'lingaava',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    Condition = 'Primed for Speed',
    cost = 0,
    slot = { 21, 1, 19, 14 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[1021] = {
    name = 'Lieutenant Galek',
    XWS = 'lieutenantgalek',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    cost = 0,
    slot = { 21, 1, 19, 14 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[1022] = {
    name = 'DT-798',
    XWS = 'dt798',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    cost = 0,
    slot = { 21, 1, 19, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB[1023] = {
    name = "Phlac-Arphocc Prototype",
    XWS = 'phlacarphoccprototype-siegeofcoruscant',
    title = "Siege of Coruscant",
    limited = 2,
    Faction = 7,
    ship_type = 'droidtrifighter',
    cost = 38,
    slot = { 21, 1, 2, 6, 14, 18 },
    init = 5,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Afterburners',         charge = 2 },
        { name = 'Contingency Protocol', charge = 0 },
        { name = 'Evasion Sequence 7',   charge = 0 },
    }
}

masterPilotDB[1024] = {
    name = "DIS-T81",
    XWS = 'dist81-siegeofcoruscant',
    title = "Siege of Coruscant",
    limited = 1,
    Faction = 7,
    ship_type = 'droidtrifighter',
    cost = 0,
    slot = { 21, 1, 2, 6, 14, 18 },
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Outmaneuver',          charge = 0 },
        { name = 'Afterburners',         charge = 2 },
        { name = 'Contingency Protocol', charge = 0 },
    }
}

masterPilotDB[1025] = {
    name = "DIS-347",
    XWS = 'dis347-siegeofcoruscant',
    title = "Siege of Coruscant",
    limited = 1,
    Faction = 7,
    ship_type = 'droidtrifighter',
    cost = 0,
    slot = { 21, 1, 2, 6, 14, 18 },
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Marksmanship',         charge = 0 },
        { name = 'Afterburners',         charge = 2 },
        { name = 'Contingency Protocol', charge = 0 },
    }
}

masterPilotDB[1026] = {
    name = 'Baktoid Prototype',
    XWS = 'baktoidprototype-siegeofcoruscant',
    title = "Siege of Coruscant",
    Faction = 7,
    limited = 2,
    ship_type = 'hyenaclassdroidbomber',
    cost = 0,
    slot = { 21, 2, 6, 6, 14, 18 },
    init = 1,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'baktoid',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Homing Missiles',      charge = 2 },
        { name = 'Contingency Protocol', charge = 0 },
        { name = 'Strut-Lock Override',  charge = 2 },
    }
}

masterPilotDB[1027] = {
    name = 'DBS-404',
    XWS = 'dbs404-siegeofcoruscant',
    title = "Siege of Coruscant",
    Faction = 7,
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
    cost = 31,
    slot = { 21, 5, 6, 12, 14, 18 },
    init = 4,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'fourohfour',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'Contingency Protocol',  charge = 0 },
        { name = 'Strut-Lock Override',   charge = 2 },
    }
}

masterPilotDB[1028] = {
    name = 'DBS-32C',
    XWS = 'dbs32c-siegeofcoruscant',
    title = "Siege of Coruscant",
    Faction = 7,
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
    cost = 40,
    slot = { 21, 2, 20, 14, 18 },
    init = 3,
    actSet = { 'C', 'TL', 'BR' },
    Charge = 2,
    texture = 'standard',
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Plasma Torpedoes',     charge = 2 },
        { name = 'Contingency Protocol', charge = 0 },
        { name = 'Strut-Lock Override',  charge = 2 },
    }
}

masterPilotDB[1029] = {
    name = "Volan Das",
    XWS = 'volandas',
    limited = 1,
    Faction = 7,
    ship_type = 'droidtrifighter',
    cost = 38,
    slot = { 21, 1, 2, 6, 14, 18 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB[1030] = {
    name = 'Durge',
    XWS = 'durge-separatistalliance',
    Faction = 7,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    cost = 0,
    Charge = 1,
    slot = { 21, 17, 10, 14, 15 },
    init = 5,
    texture = 'durge',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB[1031] = {
    name = '"Klick"',
    XWS = 'klick-siegeofcoruscant',
    title = "Siege of Coruscant",
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    Charge = 1,
    cost = 31,
    slot = { 1, 10, 14, 18 },
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' },
    standardized_loadout = true,
    executeOptions = {
        rk2 = { [1] = 'rk2', [2] = 'rbl2s', [3] = 'rbr2s' },
    },
    standardized_upgrades = {
        { name = 'R3 Astromech',          charge = 0 },
        { name = 'Precision Ion Engines', charge = 2 },
        { name = 'Alpha-3E "Esk"',        charge = 2 },
    }
}


masterPilotDB[1032] = {
    name = 'Jul Jerjerrod',
    XWS = 'juljerjerrod',
    Faction = 5,
    limited = 1,
    Charge = 3,
    ship_type = 'tiesebomber',
    cost = 36,
    slot = { 21, 19, 5, 6, 16, 12, 14 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB[1033] = {
    name = 'Luke Skywalker',
    XWS = 'lukeskywalker-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 0,
    Force = 2,
    init = 5,
    texture = 'luke',
    actSet = { 'F', 'TL', 'BR', },
    keywords = { 'Light Side' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Instinctive Aim',  charge = 0 },
        { name = 'Proton Torpedoes', charge = 2 },
        { name = 'R2-D2',            charge = 2 }
    }
}

masterPilotDB[1034] = {
    name = 'Jek Porkins',
    XWS = 'jekporkins-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 20,
    init = 4,
    texture = 'porkins',
    actSet = { 'F', 'TL', 'BR', },

    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator',         charge = 0 },
        { name = 'Proton Torpedoes', charge = 2 },
        { name = 'R5-D8',            charge = 3 }
    }
}

masterPilotDB[1035] = {
    name = '"Dutch" Vander',
    XWS = 'dutchvander-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 20,
    init = 4,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR', 'B' },
    addSqdAction = { 'TL' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Cannon Turret', charge = 0 },
        { name = 'Proton Bombs',      charge = 2 },
    }
}

masterPilotDB[1036] = {
    name = 'Horton Salm',
    XWS = 'hortonsalm-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    cost = 36,
    init = 4,
    texture = 'horton',
    actSet = { 'F', 'TL', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Cannon Turret', charge = 0 },
        { name = 'Proximity Mines',   charge = 2 },
    }
}

masterPilotDB[1037] = {
    name = 'Arvel Crynyd',
    XWS = 'arvelcrynyd-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 32,
    init = 3,
    texture = 'arvel',
    actSet = { 'F', 'TL', 'E', 'Ail', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator',     charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB[1038] = {
    name = 'Jake Farrell',
    XWS = 'jakefarrell-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 34,
    init = 4,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Elusive',      charge = 1 },
        { name = 'Outmaneuver',  charge = 0 },
        { name = 'Ion Missiles', charge = 3 },
    }
}

masterPilotDB[1039] = {
    name = 'Shara Bey',
    XWS = 'sharabey-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    cost = 32,
    init = 4,
    texture = 'shara',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Hopeful',             charge = 0 },
        { name = 'Concussion Missiles', charge = 3 },
    }
}

masterPilotDB[1040] = {
    name = 'Darth Vader',
    XWS = 'darthvader-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    cost = 20,
    Force = 3,
    init = 6,
    Shield = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side', 'Sith' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Hate',         charge = 0 },
        { name = 'Ion Missiles', charge = 3 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB[1041] = {
    name = 'Maarek Stele',
    XWS = 'maarekstele-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    cost = 20,
    init = 6,
    Shield = 2,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side', 'Sith' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Elusive',      charge = 1 },
        { name = 'Outmaneuver',  charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB[1042] = {
    name = 'Captain Jonus',
    XWS = 'captainjonus-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
    cost = 45,
    slot = { 21, 1, 5, 6, 6, 16, 12, 12, 14 },
    init = 4,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Feedback Ping',    charge = 0 },
        { name = 'Plasma Torpedoes', charge = 2 },
        { name = 'Proton Bombs',     charge = 2 },
    }
}

masterPilotDB[1043] = {
    name = 'Tomax Bren',
    XWS = 'tomaxbren-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
    cost = 45,
    slot = { 21, 1, 5, 6, 6, 16, 12, 12, 14 },
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Elusive',         charge = 1 },
        { name = 'Barrage Rockets', charge = 5 },
        { name = 'Proximity Mines', charge = 2 },
    }
}

masterPilotDB[1044] = {
    name = '"Night Beast"',
    XWS = 'nightbeast-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 23,
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Disciplined', charge = 0 },
        { name = 'Predator',    charge = 0 },
    }
}

masterPilotDB[1045] = {
    name = 'Valen Rudor',
    XWS = 'valenrudor-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 0,
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Disciplined',           charge = 0 },
        { name = 'Precision Ion Engines', charge = 2 },
    }
}

masterPilotDB[1046] = {
    name = 'Iden Versio',
    XWS = 'idenversio-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 0,
    Shield = 0,
    Charge = 1,
    init = 4,
    texture = 'inferno',
    actSet = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Disciplined', charge = 0 },
        { name = 'Elusive',     charge = 1 },
    }
}

masterPilotDB[1047] = {
    name = '"Deathfire"',
    title = 'SL',
    XWS = 'deathfire-swz98',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
    cost = 0,
    Charge = 2,
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Swift Approach', charge = 0 },
        { name = 'Conner Nets',    charge = 1 },
        { name = 'Proton Bombs',   charge = 2 },
    }
}

masterPilotDB[1048] = {
    name = 'Captain Jonus',
    title = 'SL',
    XWS = 'captainjonus-swz98',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
    cost = 0,
    init = 4,
    texture = 'blue',
    actSet = { 'F', 'TL', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Top Cover',       charge = 0 },
        { name = 'Barrage Rockets', charge = 5 },
        { name = 'Proton Bombs',    charge = 2 },
    }
}

masterPilotDB[1049] = {
    name = 'Tomax Bren',
    title = 'SL',
    XWS = 'tomaxbren-swz98',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
    cost = 0,
    init = 5,
    Charge = 2,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'True Grit',        charge = 0 },
        { name = 'Plasma Torpedoes', charge = 2 },
        { name = 'Ion Bombs',        charge = 2 },
    }
}


masterPilotDB[1050] = {
    name = 'Major Rhymer',
    title = 'SL',
    XWS = 'majorrhymer-swz98',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    cost = 0,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'TL', 'B', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'Automated Loaders',     charge = 1 },
        { name = 'Afterburners',          charge = 2 },
    }
}

masterPilotDB[1051] = {
    name = 'Dash Rendar',
    title = 'Rebel (SL)',
    XWS = 'dashrendar-swz103-sl-rebelalliance',
    Faction = 1,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    cost = 0,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Mercenary',       charge = 0 },
        { name = 'Seeker Missiles', charge = 4 },
        { name = '"Leebo"',         charge = 2 },
        { name = 'Outrider',        charge = 2 },
    }
}

masterPilotDB[1052] = {
    name = 'Dash Rendar',
    title = 'Scum (SL)',
    XWS = 'dashrendar-swz103-sl-scumandvillainy',
    Faction = 3,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    cost = 0,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Mercenary',       charge = 0 },
        { name = 'Seeker Missiles', charge = 4 },
        { name = '"Leebo"',         charge = 2 },
        { name = 'Outrider',        charge = 2 },
    }
}

masterPilotDB[1053] = {
    name = '"Leebo"',
    title = 'Scum (SL)',
    XWS = 'leebo-swz103-sl-scumandvillainy',
    Faction = 3,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    cost = 0,
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Efficient Processing', charge = 0 },
        { name = 'Seeker Missiles',      charge = 4 },
        { name = 'Outrider',             charge = 2 },
    }
}

masterPilotDB[1054] = {
    name = '"Leebo"',
    title = 'Rebel (SL)',
    XWS = 'leebo-swz103-sl-rebelalliance',
    Faction = 1,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    cost = 0,
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Efficient Processing', charge = 0 },
        { name = 'Seeker Missiles',      charge = 4 },
        { name = 'Outrider',             charge = 2 },
    }
}

masterPilotDB[1055] = {
    name = 'Dash Rendar',
    title = 'Rebel',
    XWS = 'dashrendar-swz103-rebelalliance',
    Faction = 1,
    limited = 1,
    slot = { 21, 1, 8, 8, 6, 13, 14, 15 },
    ship_type = 'yt2400lightfreighter',
    cost = 0,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB[1056] = {
    name = 'Dash Rendar',
    title = 'Scum',
    XWS = 'dashrendar-swz103-scumandvillainy',
    Faction = 3,
    limited = 1,
    slot = { 21, 1, 8, 8, 6, 13, 14, 15 },
    ship_type = 'yt2400lightfreighter',
    cost = 0,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB[1057] = {
    name = '"Leebo"',
    XWS = 'leebo-swz103-rebelalliance',
    title = 'Rebel',
    Faction = 1,
    limited = 1,
    slot = { 21, 1, 8, 8, 6, 13, 14, 15 },
    ship_type = 'yt2400lightfreighter',
    cost = 0,
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' }
}

masterPilotDB[1058] = {
    name = '"Leebo"',
    title = 'Scum',
    XWS = 'leebo-swz103-scumandvillainy',
    Faction = 3,
    limited = 1,
    slot = { 21, 1, 8, 8, 6, 13, 14, 15 },
    ship_type = 'yt2400lightfreighter',
    cost = 0,
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' }
}

--Battle over Endor Standardized Pilots

masterPilotDB[1059] = {
    name = 'Captain Yorr',
    XWS = 'captainyorr-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    Charge = 2,
    ship_type = 'tiededefender',
    cost = 6,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',                  charge = 0 },
        { name = 'Predator',                   charge = 0 },
        { name = 'Ion Cannon',                 charge = 0 },
        { name = 'Computer Assisted Handling', charge = 1 }
    }
}

masterPilotDB[1060] = {
    name = 'Colonel Jendon',
    XWS = 'coloneljendon-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tiededefender',
    cost = 7,
    init = 6,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',                  charge = 0 },
        { name = 'Push The Limit',             charge = 0 },
        { name = 'Proton Cannons',             charge = 2 },
        { name = 'Computer Assisted Handling', charge = 1 },
    }
}

masterPilotDB[1061] = {
    name = 'Lieutenant Hebsly',
    XWS = 'lieutenanthebsly-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 3,
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Collected', charge = 0 },
        { name = 'Elusive',   charge = 1 },
        { name = 'No Escape', charge = 0 },
    }
}

masterPilotDB[1062] = {
    name = 'Major Mianda',
    XWS = 'majormianda-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 3,
    init = 5,
    Shield = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' },
    addSqdAction = { 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',     charge = 0 },
        { name = 'Ruthless',      charge = 0 },
        { name = 'Swarm Tactics', charge = 0 },
    }
}

masterPilotDB[1063] = {
    name = 'Scythe 6',
    XWS = 'scythe6-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    cost = 3,
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',           charge = 0 },
        { name = 'Predator',            charge = 0 },
        { name = 'Ion Maneuvering Jet', charge = 2 },
        { name = 'Targeting Matrix',    charge = 0 },
    }
}

masterPilotDB[1064] = {
    name = 'Maus Monare',
    XWS = 'mausmonare-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 5,
    init = 3,
    Shield = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'B', '2B', '2BR', 'C' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',               charge = 0 },
        { name = 'Outmaneuver',             charge = 0 },
        { name = 'Fuel Injection Override', charge = 2 },
    }
}

masterPilotDB[1065] = {
    name = 'Sapphire 2',
    XWS = 'sapphire2-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    cost = 5,
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TR', 'B', 'Dare' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',        charge = 0 },
        { name = 'Reckless',         charge = 0 },
        { name = 'Primed Thrusters', charge = 0 },
        { name = 'Targeting Matrix', charge = 0 },
    }
}

masterPilotDB[1066] = {
    name = 'Soontir Fel',
    XWS = 'soontirfel-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    Charge = 2,
    ship_type = 'tieininterceptor',
    cost = 5,
    init = 6,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Apex Predator',    charge = 0 },
        { name = 'No Escape',        charge = 0 },
        { name = 'Blank Signature',  charge = 1 },
        { name = 'Feedback Emitter', charge = 1 },
    }
}

masterPilotDB[1067] = {
    name = 'Scimitar 1',
    XWS = 'scimitar1-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
    cost = 3,
    init = 3,
    Charge = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Marksmanship',     charge = 0 },
        { name = 'No Escape',        charge = 0 },
        { name = 'Proton Torpedoes', charge = 2 },
        { name = 'Ion Bombs',        charge = 2 },
    }
}

masterPilotDB[1068] = {
    name = 'Scimitar 3',
    XWS = 'scimitar3-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
    cost = 3,
    init = 4,
    Charge = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',        charge = 0 },
        { name = 'Parting Gift',     charge = 0 },
        { name = 'Proton Torpedoes', charge = 2 },
        { name = 'Proton Bombs',     charge = 2 },
    }
}

masterPilotDB[1069] = {
    name = 'Kendy Idele',
    XWS = 'kendyidele-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 5,
    init = 4,
    texture = 'redder',
    actSet = { 'F', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = "It's a Trap",        charge = 0 },
        { name = 'Ion Missiles',       charge = 3 },
        { name = 'Modified R4-P Unit', charge = 1 },
        { name = 'Chaff Particles',    charge = 0 }
    }
}

masterPilotDB[1070] = {
    name = 'Wedge Antilles',
    XWS = 'wedgeantilles-battleoverendor',
    Faction = 1,
    limited = 1,
    title = 'Battle over Endor',
    ship_type = 't65xwing',
    cost = 5,
    init = 6,
    Shield = 3,
    texture = 'wedge',
    actSet = { 'F', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = "It's a Trap",           charge = 0 },
        { name = 'Predator',              charge = 0 },
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'R2-A3',                 charge = 1 }
    }
}

masterPilotDB[1071] = {
    name = 'Yendor',
    XWS = 'yendor-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    cost = 5,
    init = 5,
    texture = 'redder',
    actSet = { 'F', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = "It's a Trap",           charge = 0 },
        { name = 'Plasma Torpedoes',      charge = 2 },
        { name = 'Stabilizing Astromech', charge = 1 }
    }
}

masterPilotDB[1072] = {
    name = 'Arvel Crynyd',
    XWS = 'arvelcrynyd-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    arcs = { turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
    cost = 4,
    init = 3,
    Shield = 3,
    texture = 'arvel',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Heroic Sacrifice', charge = 0 },
        { name = "It's a Trap",      charge = 0 },
        { name = 'Proton Rockets',   charge = 1 },
    }
}

masterPilotDB[1073] = {
    name = 'Gemmer Sojan',
    XWS = 'gemmersojan-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    arcs = { turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
    cost = 3,
    init = 2,
    texture = 'arvel',
    actSet = { 'F', 'TL', 'E', 'BR', 'B', 'C' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = "It's a Trap",             charge = 0 },
        { name = 'Precision-Tuned Cannons', charge = 0 },
        { name = 'Chaff Particles',         charge = 0 },
        { name = 'Target-Assist Algorithm', charge = 0 },
    }
}

masterPilotDB[1074] = {
    name = 'Braylen Stramm',
    XWS = 'braylenstramm-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    Charge = 2,
    Shield = 5,
    ship_type = 'asf01bwing',
    Bomb = true,
    cost = 4,
    init = 4,
    texture = 'braylen',
    actSet = { 'F', 'TL', 'BR', 'E' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = "It's a Trap",     charge = 0 },
        { name = 'Homing Missiles', charge = 2 },
        { name = 'Proton Bombs',    charge = 2 },
        { name = 'Delayed Fuses',   charge = 0 },
    }
}

masterPilotDB[1075] = {
    name = 'Adon Fox',
    XWS = 'adonfox-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    Charge = 2,
    ship_type = 'asf01bwing',
    Bomb = true,
    cost = 4,
    init = 1,
    texture = 'blade',
    actSet = { 'F', 'TL', 'BR', 'E' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = "It's a Trap",    charge = 0 },
        { name = 'Parting Gift',   charge = 0 },
        { name = 'Proton Rockets', charge = 1 },
        { name = 'Proton Bombs',   charge = 2 },
    }
}


masterPilotDB[1076] = {
    name = 'Gina Moonsong',
    XWS = 'ginamoonsong-battleoverendor',
    Faction = 1,
    limited = 1,
    title = 'Battle over Endor',
    Shield = 5,
    Charge = 2,
    ship_type = 'asf01bwing',
    Bomb = true,
    cost = 4,
    init = 5,
    texture = 'gina',
    actSet = { 'F', 'TL', 'BR', 'E' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = "It's a Trap",      charge = 0 },
        { name = 'Juke',             charge = 0 },
        { name = 'Proton Torpedoes', charge = 2 },
        { name = 'Ion Bombs',        charge = 2 },
    }
}

masterPilotDB[1077] = {
    name = 'Tycho Celchu',
    XWS = 'tychocelchu-battleoverendor',
    Faction = 1,
    limited = 1,
    title = 'Battle over Endor',
    Shield = 3,
    ship_type = 'rz1awing',
    arcs = { turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
    cost = 4,
    init = 5,
    texture = 'arvel',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = "It's a Trap",     charge = 0 },
        { name = 'Juke',            charge = 0 },
        { name = 'Proton Rockets',  charge = 1 },
        { name = 'Chaff Particles', charge = 0 },
    }
}

masterPilotDB[1078] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    cost = 7,
    Charge = 2,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ace inthe Hole',    charge = 2 },
        { name = "It's a Trap",       charge = 0 },
        { name = 'Nien Nunb',         charge = 0 },
        { name = "Airen Cracken",     charge = 0 },
        { name = 'Millennium Falcon', charge = 0 },
    }
}

masterPilotDB[1079] = {
    name = '"Echo"',
    title = 'Copycat',
    XWS = 'echo-ssl',
    Faction = 2,
    limited = 1,
    Charge = 1,
    ship_type = 'tiephphantom',
    cost = 5,
    init = 4,
    texture = 'echo',
    actSet = { 'F', 'E', 'BR', 'CL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Silent Hunter',     charge = 0 },
        { name = 'Stealth Gambit',    charge = 0 },
        { name = 'Manual Ailerons',   charge = 2 }
    }
}

masterPilotDB[1080] = {
    name = '"Whisper"',
    title = 'Unseen Assailant',
    XWS = 'whisper-ssl',
    Faction = 2,
    limited = 1,
    Charge = 2,
    ship_type = 'tiephphantom',
    cost = 5,
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'CL', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Without a Trace',  charge = 0 },
        { name = 'Relay System',     charge = 0 },
        { name = 'Stygium Reserve',  charge = 1 }
    }
}

masterPilotDB[1081] = {
    name = 'Major Vynder',
    title = 'Helping Hand',
    XWS = 'majorvynder-ssl',
    Faction = 2,
    limited = 1,
    ship_type = 'alphaclassstarwing',
    cost = 5,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Long-Range Scanners',     charge = 2 },
        { name = 'Ion Cannon',              charge = 0 },
        { name = 'Heavy Plasma Missiles',   charge = 2 }
    }
}

masterPilotDB[1082] = {
    name = 'Lieutenant Karsabi',
    title = 'Payload Courier',
    XWS = 'lieutenantkarsabi-ssl',
    Faction = 2,
    limited = 1,
    ship_type = 'alphaclassstarwing',
    cost = 5,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Proton Torpedoes',  charge = 2 },
        { name = 'Saturation Rockets',     charge = 4 },
        { name = 'Electronic Baffle',  charge = 0 }
    }
}


masterPilotDB[1083] = {
    name = 'New Republic Patrol',
    XWS = 'newrepublicpatrol-wartime',
    Faction = 4,
    ship_type = 'btanr2ywing-wartime',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[1084] = {
    name = 'Kijimi Spice Runner',
    XWS = 'kijimispicerunner-wartime',
    Faction = 4,
    ship_type = 'btanr2ywing-wartime',
    init = 2,
    texture = 'plain',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[1085] = {
    name = 'Teza Nasz',
    XWS = 'tezanasz-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 4,
    texture = 'teza',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[1086] = {
    name = 'Shasa Zaro',
    XWS = 'shasazaro-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[1087] = {
    name = 'Corus Kapellim',
    XWS = 'coruskapellim-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 1,
    texture = 'corus',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[1088] = {
    name = "C'ai Threnalli",
    XWS = 'caithrenalli-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 2,
    texture = 'cai',
    actSet = { 'F', 'TL', 'BR', 'B', 'C', 'E' },
    movethrough = true
}

masterPilotDB[1089] = {
    name = 'Wilsa Teshlo',
    XWS = 'wilsateshlo-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 4,
    texture = 'wilsa',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[1090] = {
    name = 'Zorii Bliss',
    XWS = 'zoriibliss-wartime',
    Charge = 1,
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 5,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[1091] = {
    name = 'Aftab Ackbar',
    XWS = 'aftabackbar-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 2,
    texture = 'cai',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB[1092] = {
    name = 'Lega Fossang',
    XWS = 'legafossang-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 3,
    texture = 'lega',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

return masterPilotDB
