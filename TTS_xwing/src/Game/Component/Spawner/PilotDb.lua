masterPilotDB = {}
masterPilotDB[''] = {
    ['name'] = '',
    ['XWS'] = '',
    ['Faction'] = 0,
    ['ship_type'] = 0,
    ['slot'] = {},
    ['Shield'] = 0,
    ['card'] = '',
    ['cardB'] = '',
    ['init'] = 0,
    ['actSet'] = {}
}



-- Huge ships
masterPilotDB['alderaanianguard'] = {
    name = 'Alderaanian Guard',
    XWS = 'alderaanianguard',
    Faction = 1,
    ship_type = 'cr90corvette',
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'red'
}

masterPilotDB['republicjudiciary'] = {
    name = 'Republic Judiciary',
    XWS = 'republicjudiciary',
    Faction = 6,
    ship_type = 'cr90corvette',
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'blue'
}

masterPilotDB['separatistprivateers'] = {
    name = 'Separatist Privateers',
    XWS = 'separatistprivateers',
    Faction = 7,
    ship_type = 'croccruiser',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['syndicatesmugglers'] = {
    name = 'Syndicate Smugglers',
    XWS = 'syndicatesmugglers',
    Faction = 3,
    ship_type = 'croccruiser',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['firstordersympathizers'] = {
    name = 'First Order Sympathizers',
    XWS = 'firstordersympathizers',
    Docking = true,
    Faction = 5,
    ship_type = 'gozanticlasscruiser',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['outerrimgarrison'] = {
    name = 'Outer Rim Garrison',
    XWS = 'outerrimgarrison',
    Docking = true,
    Faction = 2,
    ship_type = 'gozanticlasscruiser',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['echobaseevacuees'] = {
    name = 'Echo Base Evacuees',
    XWS = 'echobaseevacuees',
    Faction = 1,
    ship_type = 'gr75mediumtransport',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['newrepublicvolunteers'] = {
    name = 'New Republic Volunteers',
    XWS = 'newrepublicvolunteers',
    Faction = 4,
    ship_type = 'gr75mediumtransport',
    init = 7,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['firstordercollaborators'] = {
    name = 'First Order Collaborators',
    XWS = 'firstordercollaborators',
    Faction = 5,
    ship_type = 'raiderclasscorvette',
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['outerrimpatrol'] = {
    name = 'Outer Rim Patrol',
    XWS = 'outerrimpatrol',
    Faction = 2,
    ship_type = 'raiderclasscorvette',
    init = 8,
    actSet = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['lawlesspirates'] = {
    name = 'Lawless Pirates',
    XWS = 'lawlesspirates',
    Faction = 3,
    ship_type = 'tridentclassassaultship',
    init = 8,
    actSet = { 'F', 'E', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['colicoiddestroyer'] = {
    name = 'Colicoid Destroyer',
    XWS = 'colicoiddestroyer',
    Faction = 7,
    ship_type = 'tridentclassassaultship',
    init = 8,
    actSet = { 'F', 'E', 'TL', 'R' },
    texture = 'standard'
}


masterPilotDB['wedgeantilles'] = {
    name = 'Wedge Antilles',
    XWS = 'wedgeantilles',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    init = 6,
    texture = 'wedge',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['lukeskywalker'] = {
    name = 'Luke Skywalker',
    XWS = 'lukeskywalker',
    title = 'Red Five',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    Force = 2,
    init = 5,
    texture = 'luke',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Light Side' }
}

masterPilotDB['thanekyrell'] = {
    name = 'Thane Kyrell',
    XWS = 'thanekyrell',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    init = 5,
    texture = 'thane',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['garvendreis-t65xwing'] = {
    name = 'Garven Dreis',
    XWS = 'garvendreis-t65xwing',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    init = 4,
    texture = 'garven',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['jekporkins'] = {
    name = 'Jek Porkins',
    XWS = 'jekporkins',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    init = 4,
    texture = 'porkins',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['kullbeesperado'] = {
    name = 'Kullbee Sperado',
    XWS = 'kullbeesperado',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    init = 4,
    texture = 'renegade',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB['biggsdarklighter'] = {
    name = 'Biggs Darklighter',
    XWS = 'biggsdarklighter',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    init = 3,
    texture = 'biggs',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['leevantenza'] = {
    name = 'Leevan Tenza',
    XWS = 'leevantenza',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    init = 3,
    texture = 'renegade',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB['edriotwotubes'] = {
    name = 'Edrio Two Tubes',
    XWS = 'edriotwotubes',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    init = 2,
    texture = 'renegade',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB['redsquadronveteran'] = {
    name = 'Red Squadron Veteran',
    XWS = 'redsquadronveteran',
    Faction = 1,
    ship_type = 't65xwing',
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['bluesquadronescort'] = {
    name = 'Blue Squadron Escort',
    XWS = 'bluesquadronescort',
    Faction = 1,
    ship_type = 't65xwing',
    init = 2,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['cavernangelszealot'] = {
    name = 'Cavern Angels Zealot',
    XWS = 'cavernangelszealot',
    Faction = 1,
    ship_type = 't65xwing',
    init = 1,
    texture = 'renegade',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB['norrawexley-btla4ywing'] = {
    name = 'Norra Wexley',
    XWS = 'norrawexley-btla4ywing',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 5,
    texture = 'norra',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['dutchvander'] = {
    name = '"Dutch" Vander',
    XWS = 'dutchvander',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 4,
    texture = 'gold',
    addSqdAction = { 'TL' },
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['hortonsalm'] = {
    name = 'Horton Salm',
    XWS = 'hortonsalm',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 4,
    texture = 'horton',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['evaanverlaine'] = {
    name = 'Evaan Verlaine',
    XWS = 'evaanverlaine',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 3,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['goldsquadronveteran'] = {
    name = 'Gold Squadron Veteran',
    XWS = 'goldsquadronveteran',
    Faction = 1,
    ship_type = 'btla4ywing',
    init = 3,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['graysquadronbomber'] = {
    name = 'Gray Squadron Bomber',
    XWS = 'graysquadronbomber',
    Faction = 1,
    ship_type = 'btla4ywing',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['jakefarrell'] = {
    name = 'Jake Farrell',
    XWS = 'jakefarrell',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    init = 4,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['arvelcrynyd'] = {
    name = 'Arvel Crynyd',
    XWS = 'arvelcrynyd',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    init = 3,
    texture = 'arvel',
    actSet = { 'F', 'TL', 'E', 'Ail', 'BR' }
}

masterPilotDB['greensquadronpilot'] = {
    name = 'Green Squadron Pilot',
    XWS = 'greensquadronpilot',
    Faction = 1,
    ship_type = 'rz1awing',
    init = 3,
    texture = 'green',
    actSet = { 'F', 'TL', 'E', 'B', 'BR' }
}

masterPilotDB['phoenixsquadronpilot'] = {
    name = 'Phoenix Squadron Pilot',
    XWS = 'phoenixsquadronpilot',
    Faction = 1,
    ship_type = 'rz1awing',
    init = 1,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'B', 'BR' }
}


masterPilotDB['herasyndulla-rz1awing'] = {
    name = 'Hera Syndulla',
    XWS = 'herasyndulla-rz1awing',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    init = 6,
    texture = 'hera',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    keywords = { 'Spectre' }
}

masterPilotDB['wedgeantilles-rz1awing'] = {
    name = 'Wedge Antilles',
    XWS = 'wedgeantilles-rz1awing',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    init = 4,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['derekklivian'] = {
    name = 'Derek Klivian',
    XWS = 'derekklivian',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    init = 3,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['sharabey-rz1awing'] = {
    name = 'Shara Bey',
    XWS = 'sharabey-rz1awing',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    init = 4,
    texture = 'shara',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['ahsokatano-rz1awing'] = {
    name = 'Ahsoka Tano',
    XWS = 'ahsokatano-rz1awing',
    Faction = 1,
    limited = 1,
    Force = 3,
    ship_type = 'rz1awing',
    init = 5,
    texture = 'jake',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    keywords = { 'Light Side' }
}

masterPilotDB['sabinewren-rz1awing'] = {
    name = 'Sabine Wren',
    XWS = 'sabinewren-rz1awing',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    init = 3,
    texture = 'sabines',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['braylenstramm'] = {
    name = 'Braylen Stramm',
    XWS = 'braylenstramm',
    Faction = 1,
    limited = 1,
    ship_type = 'asf01bwing',
    init = 4,
    texture = 'braylen',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['tennumb'] = {
    name = 'Ten Numb',
    XWS = 'tennumb',
    Faction = 1,
    limited = 1,
    ship_type = 'asf01bwing',
    init = 4,
    texture = 'tennumb',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['bladesquadronveteran'] = {
    name = 'Blade Squadron Veteran',
    XWS = 'bladesquadronveteran',
    Faction = 1,
    ship_type = 'asf01bwing',
    init = 3,
    texture = 'blade',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['bluesquadronpilot'] = {
    name = 'Blue Squadron Pilot',
    XWS = 'bluesquadronpilot',
    Faction = 1,
    ship_type = 'asf01bwing',
    init = 2,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['ginamoonsong'] = {
    name = 'Gina Moonsong',
    XWS = 'ginamoonsong',
    Faction = 1,
    limited = 1,
    ship_type = 'asf01bwing',
    init = 5,
    texture = 'gina',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['herasyndulla-asf01bwing'] = {
    name = 'Hera Syndulla',
    XWS = 'herasyndulla-asf01bwing',
    Faction = 1,
    limited = 1,
    ship_type = 'asf01bwing',
    init = 6,
    texture = 'hera',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB['netrempollard'] = {
    name = 'Netrem Pollard',
    XWS = 'netrempollard',
    Faction = 1,
    limited = 1,
    ship_type = 'asf01bwing',
    init = 3,
    texture = 'netrem',
    actSet = { 'F', 'TL', 'BR', 'Piv' }
}

masterPilotDB['airencracken'] = {
    name = 'Airen Cracken',
    XWS = 'airencracken',
    Faction = 1,
    limited = 1,
    ship_type = 'z95af4headhunter',
    init = 5,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['lieutenantblount'] = {
    name = 'Lieutenant Blount',
    XWS = 'lieutenantblount',
    Faction = 1,
    limited = 1,
    ship_type = 'z95af4headhunter',
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['talasquadronpilot'] = {
    name = 'Tala Squadron Pilot',
    XWS = 'talasquadronpilot',
    Faction = 1,
    ship_type = 'z95af4headhunter',
    init = 2,
    texture = 'tala',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['banditsquadronpilot'] = {
    name = 'Bandit Squadron Pilot',
    XWS = 'banditsquadronpilot',
    Faction = 1,
    ship_type = 'z95af4headhunter',
    init = 1,
    texture = 'bandit',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['wullffwarro'] = {
    name = 'Wullffwarro',
    XWS = 'wullffwarro',
    Faction = 1,
    limited = 1,
    ship_type = 'auzituckgunship',
    init = 4,
    texture = 'cream',
    actSet = { 'F', 'R', 'BR' }
}

masterPilotDB['lowhhrick'] = {
    name = 'Lowhhrick',
    XWS = 'lowhhrick',
    Faction = 1,
    limited = 1,
    ship_type = 'auzituckgunship',
    init = 3,
    texture = 'orange',
    actSet = { 'F', 'R', 'BR' }
}

masterPilotDB['kashyyykdefender'] = {
    name = 'Kashyyyk Defender',
    XWS = 'kashyyykdefender',
    Faction = 1,
    ship_type = 'auzituckgunship',
    init = 1,
    texture = 'cream',
    actSet = { 'F', 'R', 'BR' }
}

masterPilotDB['herasyndulla'] = {
    name = 'Hera Syndulla',
    XWS = 'herasyndulla',
    Faction = 1,
    limited = 1,
    ship_type = 'attackshuttle',
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

masterPilotDB['sabinewren'] = {
    name = 'Sabine Wren',
    XWS = 'sabinewren',
    Faction = 1,
    limited = 1,
    ship_type = 'attackshuttle',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'B', 'BR' },
    keywords = { 'Spectre', 'Mandalorian' }
}

masterPilotDB['ezrabridger'] = {
    name = 'Ezra Bridger',
    XWS = 'ezrabridger',
    Faction = 1,
    limited = 1,
    ship_type = 'attackshuttle',
    Force = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Spectre', 'Light Side' }
}

masterPilotDB['zeborrelios'] = {
    name = '"Zeb" Orrelios',
    XWS = 'zeborrelios',
    Faction = 1,
    limited = 1,
    ship_type = 'attackshuttle',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB['fennrau-sheathipedeclassshuttle'] = {
    name = 'Fenn Rau',
    XWS = 'fennrau-sheathipedeclassshuttle',
    Faction = 1,
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    init = 6,
    texture = 'standard',
    actSet = { 'F' },
    keywords = { 'Spectre', 'Mandalorian' }
}

masterPilotDB['ezrabridger-sheathipedeclassshuttle'] = {
    name = 'Ezra Bridger',
    XWS = 'ezrabridger-sheathipedeclassshuttle',
    Faction = 1,
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    Force = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F' },
    keywords = { 'Spectre', 'Light Side' }
}

masterPilotDB['zeborrelios-sheathipedeclassshuttle'] = {
    name = '"Zeb" Orrelios',
    XWS = 'zeborrelios-sheathipedeclassshuttle',
    Faction = 1,
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    init = 2,
    texture = 'standard',
    actSet = { 'F' },
    keywords = { 'Spectre' }
}

masterPilotDB['ap5'] = {
    name = 'AP-5',
    XWS = 'ap5',
    Faction = 1,
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    init = 1,
    texture = 'standard',
    actSet = { 'C' },
    keywords = { 'Spectre', 'Droid' }
}

masterPilotDB['janors'] = {
    name = 'Jan Ors',
    XWS = 'janors',
    Faction = 1,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    init = 5,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['kylekatarn'] = {
    name = 'Kyle Katarn',
    XWS = 'kylekatarn',
    Faction = 1,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    init = 3,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['roarkgarnet'] = {
    name = 'Roark Garnet',
    XWS = 'roarkgarnet',
    Faction = 1,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    init = 4,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['rebelscout'] = {
    name = 'Rebel Scout',
    XWS = 'rebelscout',
    Faction = 1,
    ship_type = 'hwk290lightfreighter',
    init = 2,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['ezrabridger-tielnfighter'] = {
    name = 'Ezra Bridger',
    XWS = 'ezrabridger-tielnfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    Force = 1,
    init = 3,
    texture = 'rebel',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Light Side', 'Spectre' }
}

masterPilotDB['sabinewren-tielnfighter'] = {
    name = 'Sabine Wren',
    XWS = 'sabinewren-tielnfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 3,
    texture = 'rebel',
    actSet = { 'F', 'E', 'B', 'BR' },
    keywords = { 'Spectre', 'Mandalorian' }
}

masterPilotDB['captainrex'] = {
    name = 'Captain Rex',
    XWS = 'captainrex',
    Condition = 'Suppressive Fire',
    Faction = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 2,
    texture = 'rebel',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['zeborrelios-tielnfighter'] = {
    name = '"Zeb" Orrelios',
    XWS = 'zeborrelios-tielnfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 2,
    texture = 'rebel',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB['corranhorn'] = {
    name = 'Corran Horn',
    XWS = 'corranhorn',
    Faction = 1,
    limited = 1,
    ship_type = 'ewing',
    init = 5,
    texture = 'corran',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB['gavindarklighter'] = {
    name = 'Gavin Darklighter',
    XWS = 'gavindarklighter',
    Faction = 1,
    limited = 1,
    ship_type = 'ewing',
    init = 4,
    texture = 'gavin',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB['roguesquadronescort'] = {
    name = 'Rogue Squadron Escort',
    XWS = 'roguesquadronescort',
    Faction = 1,
    ship_type = 'ewing',
    init = 4,
    texture = 'rogue',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB['knavesquadronescort'] = {
    name = 'Knave Squadron Escort',
    XWS = 'knavesquadronescort',
    Faction = 1,
    ship_type = 'ewing',
    init = 2,
    texture = 'knave',
    actSet = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB['bodhirook'] = {
    name = 'Bodhi Rook',
    XWS = 'bodhirook',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    init = 4,
    texture = 'captain',
    actSet = { 'F', 'TL' }
}

masterPilotDB['sawgerrera'] = {
    name = 'Saw Gerrera',
    XWS = 'sawgerrera',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    init = 4,
    texture = 'renegade',
    actSet = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB['cassianandor'] = {
    name = 'Cassian Andor',
    XWS = 'cassianandor',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    init = 3,
    texture = 'captain',
    actSet = { 'F', 'TL' }
}

masterPilotDB['magvayarro'] = {
    name = 'Magva Yarro',
    XWS = 'magvayarro',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    init = 3,
    texture = 'renegade',
    actSet = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB['benthictwotubes'] = {
    name = 'Benthic Two Tubes',
    XWS = 'benthictwotubes',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    init = 2,
    texture = 'renegade',
    actSet = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB['hefftobber'] = {
    name = 'Heff Tobber',
    XWS = 'hefftobber',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB['bluesquadronscout'] = {
    name = 'Blue Squadron Scout',
    XWS = 'bluesquadronscout',
    Faction = 1,
    ship_type = 'ut60duwing',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB['partisanrenegade'] = {
    name = 'Partisan Renegade',
    XWS = 'partisanrenegade',
    Faction = 1,
    ship_type = 'ut60duwing',
    init = 1,
    texture = 'renegade',
    actSet = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB['k2so'] = {
    name = 'K-2SO',
    XWS = 'k2so',
    Faction = 1,
    limited = 1,
    ship_type = 'ut60duwing',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL' },
    keywords = { 'Droid' }
}


masterPilotDB['mirandadoni'] = {
    name = 'Miranda Doni',
    XWS = 'mirandadoni',
    Faction = 1,
    limited = 1,
    ship_type = 'btls8kwing',
    init = 4,
    texture = 'miranda',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB['esegetuketu'] = {
    name = 'Esege Tuketu',
    XWS = 'esegetuketu',
    Faction = 1,
    limited = 1,
    ship_type = 'btls8kwing',
    init = 3,
    texture = 'esege',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB['wardensquadronpilot'] = {
    name = 'Warden Squadron Pilot',
    XWS = 'wardensquadronpilot',
    Faction = 1,
    ship_type = 'btls8kwing',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB['norrawexley'] = {
    name = 'Norra Wexley',
    XWS = 'norrawexley',
    Faction = 1,
    limited = 1,
    ship_type = 'arc170starfighter',
    init = 5,
    texture = 'rebel',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['garvendreis'] = {
    name = 'Garven Dreis',
    XWS = 'garvendreis',
    Faction = 1,
    limited = 1,
    ship_type = 'arc170starfighter',
    init = 4,
    texture = 'rebel',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['sharabey'] = {
    name = 'Shara Bey',
    XWS = 'sharabey',
    Faction = 1,
    limited = 1,
    ship_type = 'arc170starfighter',
    init = 4,
    texture = 'rebel',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['ibtisam'] = {
    name = 'Ibtisam',
    XWS = 'ibtisam',
    Faction = 1,
    limited = 1,
    ship_type = 'arc170starfighter',
    init = 3,
    texture = 'rebel',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['hansolo-modifiedyt1300lightfreighter'] = {
    name = 'Han Solo',
    XWS = 'hansolo-modifiedyt1300lightfreighter',
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['landocalrissian-modifiedyt1300lightfreighter'] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian-modifiedyt1300lightfreighter',
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['chewbacca'] = {
    name = 'Chewbacca',
    XWS = 'chewbacca',
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    Charge = 1,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['outerrimsmuggler'] = {
    name = 'Outer Rim Smuggler',
    XWS = 'outerrimsmuggler',
    Faction = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['leiaorgana'] = {
    name = 'Leia Organa',
    XWS = 'leiaorgana',
    Force = 1,
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' },
    keywords = { 'Light Side' }
}

masterPilotDB['herasyndulla-vcx100lightfreighter'] = {
    name = 'Hera Syndulla',
    XWS = 'herasyndulla-vcx100lightfreighter',
    Faction = 1,
    limited = 1,
    ship_type = 'vcx100lightfreighter',
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

masterPilotDB['kananjarrus'] = {
    name = 'Kanan Jarrus',
    XWS = 'kananjarrus',
    Faction = 1,
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    Force = 2,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    keywords = { 'Jedi', 'Light Side', 'Spectre' }
}

masterPilotDB['chopper'] = {
    name = '"Chopper"',
    XWS = 'chopper',
    Faction = 1,
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    init = 2,
    texture = 'standard',
    actSet = { 'C', 'TL', 'R' },
    keywords = { 'Droid', 'Spectre' }
}

masterPilotDB['lothalrebel'] = {
    name = 'Lothal Rebel',
    XWS = 'lothalrebel',
    Faction = 1,
    ship_type = 'vcx100lightfreighter',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB['alexsandrkallus'] = {
    name = 'Alexsandr Kallus',
    XWS = 'alexsandrkallus',
    Faction = 1,
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    keywords = { 'Spectre' }
}

masterPilotDB['dashrendar'] = {
    name = 'Dash Rendar',
    XWS = 'dashrendar',
    Faction = 1,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['leebo'] = {
    name = '"Leebo"',
    XWS = 'leebo',
    Faction = 1,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' }
}

masterPilotDB['wildspacefringer'] = {
    name = 'Wild Space Fringer',
    XWS = 'wildspacefringer',
    Faction = 1,
    ship_type = 'yt2400lightfreighter',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['maulermithel'] = {
    name = '"Mauler" Mithel',
    XWS = 'maulermithel',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['howlrunner'] = {
    name = '"Howlrunner"',
    XWS = 'howlrunner',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['scourgeskutu'] = {
    name = '"Scourge" Skutu',
    XWS = 'scourgeskutu',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['idenversio'] = {
    name = 'Iden Versio',
    XWS = 'idenversio',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    Shield = 0,
    Charge = 1,
    init = 4,
    texture = 'inferno',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['gideonhask'] = {
    name = 'Gideon Hask',
    XWS = 'gideonhask',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 4,
    texture = 'inferno',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['delmeeko'] = {
    name = 'Del Meeko',
    XWS = 'delmeeko',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 4,
    texture = 'inferno',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['seynmarana'] = {
    name = 'Seyn Marana',
    XWS = 'seynmarana',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 4,
    texture = 'inferno',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['valenrudor'] = {
    name = 'Valen Rudor',
    XWS = 'valenrudor',
    Faction = 2,
    limited = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['nightbeast'] = {
    name = '"Night Beast"',
    XWS = 'nightbeast',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['wampa'] = {
    name = '"Wampa"',
    XWS = 'wampa',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    Charge = 1,
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['blacksquadronace'] = {
    name = 'Black Squadron Ace',
    XWS = 'blacksquadronace',
    Faction = 2,
    ship_type = 'tielnfighter',
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['obsidiansquadronpilot'] = {
    name = 'Obsidian Squadron Pilot',
    XWS = 'obsidiansquadronpilot',
    Faction = 2,
    ship_type = 'tielnfighter',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['academypilot'] = {
    name = 'Academy Pilot',
    XWS = 'academypilot',
    Faction = 2,
    ship_type = 'tielnfighter',
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['darthvader'] = {
    name = 'Darth Vader',
    XWS = 'darthvader',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    Force = 3,
    init = 6,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB['maarekstele'] = {
    name = 'Maarek Stele',
    XWS = 'maarekstele',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    init = 5,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['vedfoslo'] = {
    name = 'Ved Foslo',
    XWS = 'vedfoslo',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
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

masterPilotDB['zertikstrom'] = {
    name = 'Zertik Strom',
    XWS = 'zertikstrom',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['stormsquadronace'] = {
    name = 'Storm Squadron Ace',
    XWS = 'stormsquadronace',
    Faction = 2,
    ship_type = 'tieadvancedx1',
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['tempestsquadronpilot'] = {
    name = 'Tempest Squadron Pilot',
    XWS = 'tempestsquadronpilot',
    Faction = 2,
    ship_type = 'tieadvancedx1',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['grandinquisitor'] = {
    name = 'Grand Inquisitor',
    XWS = 'grandinquisitor',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedv1',
    Force = 2,
    init = 5,
    texture = 'grey',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side' }
}

masterPilotDB['seventhsister'] = {
    name = 'Seventh Sister',
    XWS = 'seventhsister',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedv1',
    Force = 2,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['baronoftheempire'] = {
    name = 'Baron of the Empire',
    XWS = 'baronoftheempire',
    Faction = 2,
    ship_type = 'tieadvancedv1',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['inquisitor'] = {
    name = 'Inquisitor',
    XWS = 'inquisitor',
    Faction = 2,
    ship_type = 'tieadvancedv1',
    Force = 1,
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['fifthbrother'] = {
    name = 'Fifth Brother',
    XWS = 'fifthbrother',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedv1',
    Force = 2,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' }
}


masterPilotDB['soontirfel'] = {
    name = 'Soontir Fel',
    XWS = 'soontirfel',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    init = 6,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['turrphennir'] = {
    name = 'Turr Phennir',
    XWS = 'turrphennir',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    init = 4,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['sabersquadronace'] = {
    name = 'Saber Squadron Ace',
    XWS = 'sabersquadronace',
    Faction = 2,
    ship_type = 'tieininterceptor',
    init = 4,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['alphasquadronpilot'] = {
    name = 'Alpha Squadron Pilot',
    XWS = 'alphasquadronpilot',
    Faction = 2,
    ship_type = 'tieininterceptor',
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['cienaree'] = {
    name = 'Ciena Ree',
    XWS = 'cienaree',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    init = 6,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['vultskerris-tieininterceptor'] = {
    name = 'Vult Skerris',
    XWS = 'vultskerris-tieininterceptor',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    Charge = 1,
    init = 5,
    texture = 'skystrike',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['commandantgoran'] = {
    name = 'Commandant Goran',
    XWS = 'commandantgoran',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    init = 4,
    texture = 'skystrike',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['gideonhask-tieininterceptor'] = {
    name = 'Gideon Hask',
    XWS = 'gideonhask-tieininterceptor',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['nashwindrider'] = {
    name = 'Nash Windrider',
    XWS = 'nashwindrider',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    Charge = 1,
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['lieutenantlorrir'] = {
    name = 'Lieutenant Lorrir',
    XWS = 'lieutenantlorrir',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    init = 3,
    texture = 'the181',
    actSet = { 'F', 'E', 'VR', 'B' }
}

masterPilotDB['tomaxbren'] = {
    name = 'Tomax Bren',
    XWS = 'tomaxbren',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['captainjonus'] = {
    name = 'Captain Jonus',
    XWS = 'captainjonus',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    init = 4,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['majorrhymer'] = {
    name = 'Major Rhymer',
    XWS = 'majorrhymer',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['deathfire'] = {
    name = '"Deathfire"',
    XWS = 'deathfire',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['gammasquadronace'] = {
    name = 'Gamma Squadron Ace',
    XWS = 'gammasquadronace',
    Faction = 2,
    ship_type = 'tiesabomber',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['scimitarsquadronpilot'] = {
    name = 'Scimitar Squadron Pilot',
    XWS = 'scimitarsquadronpilot',
    Faction = 2,
    ship_type = 'tiesabomber',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['majorvermeil'] = {
    name = 'Major Vermeil',
    XWS = 'majorvermeil',
    Faction = 2,
    limited = 1,
    ship_type = 'tierereaper',
    init = 4,
    texture = 'blue',
    actSet = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB['captainferoph'] = {
    name = 'Captain Feroph',
    XWS = 'captainferoph',
    Faction = 2,
    limited = 1,
    ship_type = 'tierereaper',
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB['vizier'] = {
    name = '"Vizier"',
    XWS = 'vizier',
    Faction = 2,
    limited = 1,
    ship_type = 'tierereaper',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB['scarifbasepilot'] = {
    name = 'Scarif Base Pilot',
    XWS = 'scarifbasepilot',
    Faction = 2,
    ship_type = 'tierereaper',
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB['duchess'] = {
    name = '"Duchess"',
    XWS = 'duchess',
    Faction = 2,
    limited = 1,
    ship_type = 'tieskstriker',
    init = 5,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['countdown'] = {
    name = '"Countdown"',
    XWS = 'countdown',
    Faction = 2,
    limited = 1,
    ship_type = 'tieskstriker',
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['puresabacc'] = {
    name = '"Pure Sabacc"',
    XWS = 'puresabacc',
    Faction = 2,
    limited = 1,
    ship_type = 'tieskstriker',
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['blacksquadronscout'] = {
    name = 'Black Squadron Scout',
    XWS = 'blacksquadronscout',
    Faction = 2,
    ship_type = 'tieskstriker',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['planetarysentinel'] = {
    name = 'Planetary Sentinel',
    XWS = 'planetarysentinel',
    Faction = 2,
    ship_type = 'tieskstriker',
    init = 1,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['vagabond'] = {
    name = '"Vagabond"',
    XWS = 'vagabond',
    Faction = 2,
    limited = 1,
    ship_type = 'tieskstriker',
    init = 2,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['rexlerbrath'] = {
    name = 'Rexler Brath',
    XWS = 'rexlerbrath',
    Faction = 2,
    limited = 1,
    ship_type = 'tiededefender',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['colonelvessery'] = {
    name = 'Colonel Vessery',
    XWS = 'colonelvessery',
    Faction = 2,
    limited = 1,
    ship_type = 'tiededefender',
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['countessryad'] = {
    name = 'Countess Ryad',
    XWS = 'countessryad',
    Faction = 2,
    limited = 1,
    ship_type = 'tiededefender',
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

masterPilotDB['onyxsquadronace'] = {
    name = 'Onyx Squadron Ace',
    XWS = 'onyxsquadronace',
    Faction = 2,
    ship_type = 'tiededefender',
    init = 4,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['deltasquadronpilot'] = {
    name = 'Delta Squadron Pilot',
    XWS = 'deltasquadronpilot',
    Faction = 2,
    ship_type = 'tiededefender',
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}


masterPilotDB['darthvader-tieddefender'] = {
    name = 'Darth Vader',
    XWS = 'darthvader-tieddefender',
    Faction = 2,
    ship_type = 'tiededefender',
    Force = 3,
    init = 6,
    texture = 'vader',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' },
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB['vultskerris'] = {
    name = 'Vult Skerris',
    XWS = 'vultskerris',
    Faction = 2,
    ship_type = 'tiededefender',
    Charge = 1,
    init = 5,
    texture = 'skystrike',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['captaindobbs'] = {
    name = 'Captain Dobbs',
    XWS = 'captaindobbs',
    Faction = 2,
    ship_type = 'tiededefender',
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['lieutenantkestal'] = {
    name = 'Lieutenant Kestal',
    XWS = 'lieutenantkestal',
    Faction = 2,
    limited = 1,
    ship_type = 'tieagaggressor',
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB['doubleedge'] = {
    name = '"Double Edge"',
    XWS = 'doubleedge',
    Faction = 2,
    limited = 1,
    ship_type = 'tieagaggressor',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB['onyxsquadronscout'] = {
    name = 'Onyx Squadron Scout',
    XWS = 'onyxsquadronscout',
    Faction = 2,
    ship_type = 'tieagaggressor',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB['sienarspecialist'] = {
    name = 'Sienar Specialist',
    XWS = 'sienarspecialist',
    Faction = 2,
    ship_type = 'tieagaggressor',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB['whisper'] = {
    name = '"Whisper"',
    title = 'Soft-Spoken Slayer',
    XWS = 'whisper',
    Faction = 2,
    limited = 1,
    ship_type = 'tiephphantom',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB['echo'] = {
    name = '"Echo"',
    title = 'Slippery Trickster',
    XWS = 'echo',
    Faction = 2,
    limited = 1,
    ship_type = 'tiephphantom',
    init = 4,
    texture = 'echo',
    actSet = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB['sigmasquadronace'] = {
    name = 'Sigma Squadron Ace',
    XWS = 'sigmasquadronace',
    Faction = 2,
    ship_type = 'tiephphantom',
    init = 4,
    texture = 'sigma',
    actSet = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB['imdaartestpilot'] = {
    name = 'Imdaar Test Pilot',
    XWS = 'imdaartestpilot',
    Faction = 2,
    ship_type = 'tiephphantom',
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB['majorvynder'] = {
    name = 'Major Vynder',
    title = 'Pragmatic Survivor',
    XWS = 'majorvynder',
    Faction = 2,
    limited = 1,
    ship_type = 'alphaclassstarwing',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB['lieutenantkarsabi'] = {
    name = 'Lieutenant Karsabi',
    title = 'Brash Noble',
    XWS = 'lieutenantkarsabi',
    Faction = 2,
    limited = 1,
    ship_type = 'alphaclassstarwing',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB['rhosquadronpilot'] = {
    name = 'Rho Squadron Pilot',
    XWS = 'rhosquadronpilot',
    Faction = 2,
    ship_type = 'alphaclassstarwing',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB['nusquadronpilot'] = {
    name = 'Nu Squadron Pilot',
    XWS = 'nusquadronpilot',
    Faction = 2,
    ship_type = 'alphaclassstarwing',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB['redline'] = {
    name = '"Redline"',
    XWS = 'redline',
    Faction = 2,
    limited = 1,
    ship_type = 'tiecapunisher',
    init = 5,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR', "B" }
}
masterPilotDB['deathrain'] = {
    name = '"Deathrain"',
    XWS = 'deathrain',
    Faction = 2,
    limited = 1,
    ship_type = 'tiecapunisher',
    init = 4,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', "B" }
}

masterPilotDB['cutlasssquadronpilot'] = {
    name = 'Cutlass Squadron Pilot',
    XWS = 'cutlasssquadronpilot',
    Faction = 2,
    ship_type = 'tiecapunisher',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR', "B" }
}

masterPilotDB['captainkagi'] = {
    name = 'Captain Kagi',
    XWS = 'captainkagi',
    Faction = 2,
    limited = 1,
    ship_type = 'lambdaclasst4ashuttle',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'R' }
}

masterPilotDB['coloneljendon'] = {
    name = 'Colonel Jendon',
    XWS = 'coloneljendon',
    Faction = 2,
    limited = 1,
    ship_type = 'lambdaclasst4ashuttle',
    Charge = 2,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'R' }
}

masterPilotDB['lieutenantsai'] = {
    name = 'Lieutenant Sai',
    XWS = 'lieutenantsai',
    Faction = 2,
    limited = 1,
    ship_type = 'lambdaclasst4ashuttle',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'R' }
}

masterPilotDB['omicrongrouppilot'] = {
    name = 'Omicron Group Pilot',
    XWS = 'omicrongrouppilot',
    Faction = 2,
    ship_type = 'lambdaclasst4ashuttle',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'R' }
}

masterPilotDB['captainoicunn'] = {
    name = 'Captain Oicunn',
    XWS = 'captainoicunn',
    Faction = 2,
    limited = 1,
    ship_type = 'vt49decimator',
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB['rearadmiralchiraneau'] = {
    name = 'Rear Admiral Chiraneau',
    XWS = 'rearadmiralchiraneau',
    Faction = 2,
    limited = 1,
    ship_type = 'vt49decimator',
    init = 5,
    texture = 'grey',
    actSet = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB['patrolleader'] = {
    name = 'Patrol Leader',
    XWS = 'patrolleader',
    Faction = 2,
    ship_type = 'vt49decimator',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB['mornakee'] = {
    name = 'Morna Kee',
    XWS = 'mornakee',
    Faction = 2,
    limited = 1,
    ship_type = 'vt49decimator',
    Charge = 3,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB['bobafett'] = {
    name = 'Boba Fett',
    XWS = 'bobafett',
    title = 'Notorious Bounty Hunter',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    init = 5,
    texture = 'boba',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['emonazzameen'] = {
    name = 'Emon Azzameen',
    XWS = 'emonazzameen',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    init = 4,
    texture = 'emon',
    actSet = { 'F', 'R', 'TL', 'B' }
}

masterPilotDB['kathscarlet'] = {
    name = 'Kath Scarlet',
    XWS = 'kathscarlet',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    init = 4,
    texture = 'kath',
    actSet = { 'F', 'R', 'TL', 'B' }
}

masterPilotDB['koshkafrost'] = {
    name = 'Koshka Frost',
    XWS = 'koshkafrost',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    init = 3,
    texture = 'koshka',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['krassistrelix'] = {
    name = 'Krassis Trelix',
    XWS = 'krassistrelix',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    init = 3,
    texture = 'krassis',
    actSet = { 'F', 'R', 'TL', 'B' }
}

masterPilotDB['bountyhunter'] = {
    name = 'Bounty Hunter',
    XWS = 'bountyhunter',
    Faction = 3,
    ship_type = 'firesprayclasspatrolcraft',
    init = 2,
    texture = 'bountyhunter',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['fennrau'] = {
    name = 'Fenn Rau',
    XWS = 'fennrau',
    Faction = 3,
    limited = 1,
    ship_type = 'fangfighter',
    init = 6,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['oldteroch'] = {
    name = 'Old Teroch',
    XWS = 'oldteroch',
    Faction = 3,
    limited = 1,
    ship_type = 'fangfighter',
    init = 5,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['joyrekkoff'] = {
    name = 'Joy Rekkoff',
    XWS = 'joyrekkoff',
    Faction = 3,
    limited = 1,
    ship_type = 'fangfighter',
    init = 4,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['kadsolus'] = {
    name = 'Kad Solus',
    XWS = 'kadsolus',
    Faction = 3,
    limited = 1,
    ship_type = 'fangfighter',
    init = 4,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['skullsquadronpilot'] = {
    name = 'Skull Squadron Pilot',
    XWS = 'skullsquadronpilot',
    Faction = 3,
    ship_type = 'fangfighter',
    init = 4,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['zealousrecruit'] = {
    name = 'Zealous Recruit',
    XWS = 'zealousrecruit',
    Faction = 3,
    ship_type = 'fangfighter',
    init = 1,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['constablezuvio'] = {
    name = 'Constable Zuvio',
    XWS = 'constablezuvio',
    limited = 1,
    Faction = 3,
    ship_type = 'quadrijettransferspacetug',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['sarcoplank'] = {
    name = 'Sarco Plank',
    XWS = 'sarcoplank',
    Faction = 3,
    limited = 1,
    ship_type = 'quadrijettransferspacetug',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['unkarplutt'] = {
    name = 'Unkar Plutt',
    XWS = 'unkarplutt',
    Faction = 3,
    limited = 1,
    ship_type = 'quadrijettransferspacetug',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['jakkugunrunner'] = {
    name = 'Jakku Gunrunner',
    XWS = 'jakkugunrunner',
    Faction = 3,
    ship_type = 'quadrijettransferspacetug',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['kavil'] = {
    name = 'Kavil',
    XWS = 'kavil',
    Faction = 3,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 5,
    texture = 'kavil',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['drearenthal'] = {
    name = 'Drea Renthal',
    XWS = 'drearenthal',
    Faction = 3,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 4,
    texture = 'drea',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['hiredgun'] = {
    name = 'Hired Gun',
    XWS = 'hiredgun',
    Faction = 3,
    ship_type = 'btla4ywing',
    init = 2,
    texture = 'hiredgun',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['crymorahgoon'] = {
    name = 'Crymorah Goon',
    XWS = 'crymorahgoon',
    Faction = 3,
    ship_type = 'btla4ywing',
    init = 1,
    texture = 'crymorah',
    actSet = { 'F', 'TL', 'BR' }
}


masterPilotDB['arlizhadrassian'] = {
    name = 'Arliz Hadrassian',
    XWS = 'arlizhadrassian',
    Faction = 3,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 4,
    texture = 'amaxine',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['leemakai'] = {
    name = 'Leema Kai',
    XWS = 'leemakai',
    Faction = 3,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 5,
    texture = 'jinata',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['padric'] = {
    name = 'Padric',
    XWS = 'padric',
    Faction = 3,
    ship_type = 'btla4ywing',
    init = 3,
    texture = 'padric',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['amaxinewarrior'] = {
    name = 'Amaxine Warrior',
    XWS = 'amaxinewarrior',
    Faction = 3,
    ship_type = 'btla4ywing',
    init = 3,
    texture = 'amaxine',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['jinatasecurityofficer'] = {
    name = 'Jinata Security Officer',
    XWS = 'jinatasecurityofficer',
    Faction = 3,
    ship_type = 'btla4ywing',
    init = 2,
    texture = 'jinata',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['ndrusuhlak'] = {
    name = "N'dru Suhlak",
    XWS = 'ndrusuhlak',
    Faction = 3,
    limited = 1,
    ship_type = 'z95af4headhunter',
    init = 4,
    texture = 'ndru',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['kaatoleeachos'] = {
    name = "Kaa'to Leeachos",
    XWS = 'kaatoleeachos',
    Faction = 3,
    limited = 1,
    ship_type = 'z95af4headhunter',
    init = 3,
    texture = 'orange',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['nashtahpup'] = {
    name = 'Nashtah Pup',
    XWS = 'nashtahpup',
    Faction = 3,
    limited = 1,
    ship_type = 'z95af4headhunter',
    init = 0,
    texture = 'nashtah',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['blacksunsoldier'] = {
    name = 'Black Sun Soldier',
    XWS = 'blacksunsoldier',
    Faction = 3,
    ship_type = 'z95af4headhunter',
    init = 3,
    texture = 'blacksun',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['binayrepirate'] = {
    name = 'Binayre Pirate',
    XWS = 'binayrepirate',
    Faction = 3,
    ship_type = 'z95af4headhunter',
    init = 1,
    texture = 'pirate',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['bossk-z95af4headhunter'] = {
    name = 'Bossk',
    XWS = 'bossk-z95af4headhunter',
    Faction = 3,
    limited = 1,
    ship_type = 'z95af4headhunter',
    init = 4,
    texture = 'bossk',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['dacebonearm'] = {
    name = 'Dace Bonearm',
    XWS = 'dacebonearm',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    Charge = 3,
    init = 4,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['palobgodalhi'] = {
    name = 'Palob Godalhi',
    XWS = 'palobgodalhi',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    init = 3,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['torkilmux'] = {
    name = 'Torkil Mux',
    XWS = 'torkilmux',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    init = 2,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['spicerunner'] = {
    name = 'Spice Runner',
    XWS = 'spicerunner',
    Faction = 3,
    ship_type = 'hwk290lightfreighter',
    init = 1,
    texture = 'brown',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}


masterPilotDB['kananjarrus-hwk290lightfreighter'] = {
    name = 'Kanan Jarrus',
    XWS = 'kananjarrus-hwk290lightfreighter',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    Force = 1,
    init = 3,
    texture = 'black',
    actSet = { 'F', 'TL', 'B', 'Rot' },
    keywords = { 'Jedi', 'Light Side' }
}

masterPilotDB['gamutkey'] = {
    name = 'Gamut Key',
    XWS = 'gamutkey',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    Charge = 2,
    init = 3,
    texture = 'black',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['tapusk'] = {
    name = 'TÃ¡pusk',
    XWS = 'tapusk',
    Faction = 3,
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    Charge = 2,
    init = 5,
    texture = 'black',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['guri'] = {
    name = 'Guri',
    XWS = 'guri',
    Faction = 3,
    limited = 1,
    ship_type = 'starviperclassattackplatform',
    init = 5,
    texture = 'white',
    actSet = { 'C', 'F', 'TL', 'B', 'VR' },
    keywords = { 'Droid' }
}

masterPilotDB['dalanoberos-starviperclassattackplatform'] = {
    name = 'Dalan Oberos',
    XWS = 'dalanoberos-starviperclassattackplatform',
    Faction = 3,
    limited = 1,
    ship_type = 'starviperclassattackplatform',
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'B', 'VR', 'Piv' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['princexizor'] = {
    name = 'Prince Xizor',
    XWS = 'princexizor',
    Faction = 3,
    limited = 1,
    ship_type = 'starviperclassattackplatform',
    init = 4,
    texture = 'white',
    actSet = { 'F', 'TL', 'B', 'VR' }
}

masterPilotDB['blacksunassassin'] = {
    name = 'Black Sun Assassin',
    XWS = 'blacksunassassin',
    Faction = 3,
    ship_type = 'starviperclassattackplatform',
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'B', 'VR' }
}

masterPilotDB['blacksunenforcer'] = {
    name = 'Black Sun Enforcer',
    XWS = 'blacksunenforcer',
    Faction = 3,
    ship_type = 'starviperclassattackplatform',
    init = 2,
    texture = 'white',
    actSet = { 'F', 'TL', 'B', 'VR' }
}

masterPilotDB['serissu'] = {
    name = 'Serissu',
    XWS = 'serissu',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    addSlot = { 99 },
    init = 5,
    texture = 'tansarii',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['genesisred'] = {
    name = 'Genesis Red',
    XWS = 'genesisred',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    addSlot = { 99 },
    init = 4,
    texture = 'genesis',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['laetinashera'] = {
    name = "Laetin A'shera",
    XWS = 'laetinashera',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    addSlot = { 99 },
    init = 3,
    texture = 'cartel',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['quinnjast'] = {
    name = 'Quinn Jast',
    XWS = 'quinnjast',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    addSlot = { 99 },
    init = 3,
    texture = 'tansarii',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['inaldra'] = {
    name = 'Inaldra',
    XWS = 'inaldra',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    addSlot = { 99 },
    init = 2,
    texture = 'tansarii',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['sunnybounder'] = {
    name = 'Sunny Bounder',
    XWS = 'sunnybounder',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    addSlot = { 99 },
    init = 1,
    texture = 'sunny',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['tansariipointveteran'] = {
    name = 'Tansarii Point Veteran',
    XWS = 'tansariipointveteran',
    Faction = 3,
    ship_type = 'm3ainterceptor',
    addSlot = { 99 },
    init = 3,
    texture = 'tansarii',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['cartelspacer'] = {
    name = 'Cartel Spacer',
    XWS = 'cartelspacer',
    Faction = 3,
    ship_type = 'm3ainterceptor',
    addSlot = { 99 },
    init = 1,
    texture = 'cartel',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['g4rgorvm'] = {
    name = 'G4R-G0R V/M',
    XWS = 'g4rgorvm',
    Faction = 3,
    limited = 1,
    ship_type = 'm3ainterceptor',
    addSlot = { 99 },
    init = 0,
    texture = 'gargor',
    actSet = { 'C', 'E', 'TL', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB['talonbanecobra'] = {
    name = 'Talonbane Cobra',
    XWS = 'talonbanecobra',
    Faction = 3,
    limited = 1,
    ship_type = 'kihraxzfighter',
    init = 5,
    texture = 'talonbane',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['graz'] = {
    name = 'Graz',
    XWS = 'graz',
    Faction = 3,
    limited = 1,
    ship_type = 'kihraxzfighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['viktorhel'] = {
    name = 'Viktor Hel',
    XWS = 'viktorhel',
    Faction = 3,
    limited = 1,
    ship_type = 'kihraxzfighter',
    init = 4,
    texture = 'green',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['captainjostero'] = {
    name = 'Captain Jostero',
    XWS = 'captainjostero',
    Faction = 3,
    limited = 1,
    ship_type = 'kihraxzfighter',
    init = 3,
    texture = 'orange',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['blacksunace'] = {
    name = 'Black Sun Ace',
    XWS = 'blacksunace',
    Faction = 3,
    ship_type = 'kihraxzfighter',
    init = 3,
    texture = 'blacksun',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['cartelmarauder'] = {
    name = 'Cartel Marauder',
    XWS = 'cartelmarauder',
    Faction = 3,
    ship_type = 'kihraxzfighter',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['ig88a'] = {
    name = 'IG-88A',
    XWS = 'ig88a',
    Faction = 3,
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB['ig88b'] = {
    name = 'IG-88B',
    XWS = 'ig88b',
    Faction = 3,
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB['ig88c'] = {
    name = 'IG-88C',
    XWS = 'ig88c',
    Faction = 3,
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB['ig88d'] = {
    name = 'IG-88D',
    XWS = 'ig88d',
    Faction = 3,
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    executeOptions = {
        rbl3s = { [1] = 'rtl3s', [2] = 'rbl3s', [3] = 'rk3' },
        rbr3s = { [1] = 'rk3', [2] = 'rbr3s', [3] = 'rtr3s' }
    },
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB['4lom'] = {
    name = '4-LOM',
    XWS = '4lom',
    Faction = 3,
    limited = 1,
    ship_type = 'g1astarfighter',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB['zuckuss'] = {
    name = 'Zuckuss',
    XWS = 'zuckuss',
    Faction = 3,
    limited = 1,
    ship_type = 'g1astarfighter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['gandfindsman'] = {
    name = 'Gand Findsman',
    XWS = 'gandfindsman',
    Faction = 3,
    ship_type = 'g1astarfighter',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['captainnym'] = {
    name = 'Captain Nym',
    XWS = 'captainnym',
    Faction = 3,
    limited = 1,
    ship_type = 'scurrgh6bomber',
    Charge = 1,
    init = 5,
    texture = 'orange',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['solsixxa'] = {
    name = 'Sol Sixxa',
    XWS = 'solsixxa',
    Faction = 3,
    limited = 1,
    ship_type = 'scurrgh6bomber',
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['lokrevenant'] = {
    name = 'Lok Revenant',
    XWS = 'lokrevenant',
    Faction = 3,
    ship_type = 'scurrgh6bomber',
    init = 2,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['toranikulda'] = {
    name = 'Torani Kulda',
    XWS = 'toranikulda',
    Faction = 3,
    limited = 1,
    ship_type = 'm12lkimogilafighter',
    init = 4,
    texture = 'torani',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['dalanoberos'] = {
    name = 'Dalan Oberos',
    XWS = 'dalanoberos',
    Faction = 3,
    limited = 1,
    ship_type = 'm12lkimogilafighter',
    Charge = 2,
    init = 3,
    texture = 'dalan',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['cartelexecutioner'] = {
    name = 'Cartel Executioner',
    XWS = 'cartelexecutioner',
    Faction = 3,
    ship_type = 'm12lkimogilafighter',
    init = 3,
    texture = 'cartel',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['bossk'] = {
    name = 'Bossk',
    XWS = 'bossk',
    Faction = 3,
    limited = 1,
    ship_type = 'yv666lightfreighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['moraloeval'] = {
    name = 'Moralo Eval',
    XWS = 'moraloeval',
    Faction = 3,
    limited = 1,
    ship_type = 'yv666lightfreighter',
    Charge = 2,
    init = 4,
    texture = 'moralo',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB['lattsrazzi'] = {
    name = 'Latts Razzi',
    XWS = 'lattsrazzi',
    Faction = 3,
    limited = 1,
    ship_type = 'yv666lightfreighter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['trandoshanslaver'] = {
    name = 'Trandoshan Slaver',
    XWS = 'trandoshanslaver',
    Faction = 3,
    ship_type = 'yv666lightfreighter',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB['dengar'] = {
    name = 'Dengar',
    XWS = 'dengar',
    Faction = 3,
    limited = 1,
    ship_type = 'jumpmaster5000',
    Charge = 1,
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['manaroo'] = {
    name = 'Manaroo',
    XWS = 'manaroo',
    Faction = 3,
    limited = 1,
    ship_type = 'jumpmaster5000',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['teltrevura'] = {
    name = 'Tel Trevura',
    XWS = 'teltrevura',
    Faction = 3,
    limited = 1,
    ship_type = 'jumpmaster5000',
    Charge = 1,
    init = 4,
    texture = 'tel',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['contractedscout'] = {
    name = 'Contracted Scout',
    XWS = 'contractedscout',
    Faction = 3,
    ship_type = 'jumpmaster5000',
    init = 2,
    texture = 'scout',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['nomlumb'] = {
    name = 'Nom Lumb',
    XWS = 'nomlumb',
    Faction = 3,
    limited = 1,
    ship_type = 'jumpmaster5000',
    init = 1,
    texture = 'nom',
    actSet = { 'F', 'TL', 'BR', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['ketsuonyo'] = {
    name = 'Ketsu Onyo',
    XWS = 'ketsuonyo',
    Faction = 3,
    limited = 1,
    ship_type = 'lancerclasspursuitcraft',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['asajjventress'] = {
    name = 'Asajj Ventress',
    XWS = 'asajjventress',
    Faction = 3,
    limited = 1,
    ship_type = 'lancerclasspursuitcraft',
    Force = 2,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Bounty Hunter', 'Dark Side' }
}

masterPilotDB['sabinewren-lancerclasspursuitcraft'] = {
    name = 'Sabine Wren',
    XWS = 'sabinewren-lancerclasspursuitcraft',
    Faction = 3,
    limited = 1,
    ship_type = 'lancerclasspursuitcraft',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['shadowporthunter'] = {
    name = 'Shadowport Hunter',
    XWS = 'shadowporthunter',
    Faction = 3,
    ship_type = 'lancerclasspursuitcraft',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['hansolo'] = {
    name = 'Han Solo',
    XWS = 'hansolo',
    Faction = 3,
    limited = 1,
    ship_type = 'customizedyt1300lightfreighter',
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['landocalrissian'] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian',
    Faction = 3,
    limited = 1,
    ship_type = 'customizedyt1300lightfreighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['l337'] = {
    name = 'L3-37',
    XWS = 'l337',
    Faction = 3,
    limited = 1,
    ship_type = 'customizedyt1300lightfreighter',
    init = 2,
    texture = 'standard',
    actSet = { 'C', 'TL', 'B', 'Rot' },
    keywords = { 'Droid' }
}

masterPilotDB['freightercaptain'] = {
    name = 'Freighter Captain',
    XWS = 'freightercaptain',
    Faction = 3,
    ship_type = 'customizedyt1300lightfreighter',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['landocalrissian-escapecraft'] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian-escapecraft',
    Faction = 3,
    limited = 1,
    ship_type = 'escapecraft',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'BR' }
}

masterPilotDB['outerrimpioneer'] = {
    name = 'Outer Rim Pioneer',
    XWS = 'outerrimpioneer',
    Faction = 3,
    limited = 1,
    ship_type = 'escapecraft',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'BR' }
}

masterPilotDB['l337-escapecraft'] = {
    name = 'L3-37',
    XWS = 'l337-escapecraft',
    Faction = 3,
    limited = 1,
    ship_type = 'escapecraft',
    init = 2,
    texture = 'standard',
    actSet = { 'C', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB['autopilotdrone'] = {
    name = 'Autopilot Drone',
    XWS = 'autopilotdrone',
    Faction = 3,
    limited = 1,
    ship_type = 'escapecraft',
    Charge = 3,
    init = 1,
    texture = 'standard',
    actSet = { 'C', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB['midnight'] = {
    name = '"Midnight"',
    XWS = 'midnight',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    Shield = 1,
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['scorch'] = {
    name = '"Scorch"',
    XWS = 'scorch',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['static'] = {
    name = '"Static"',
    XWS = 'static',
    Faction = 5,
    limited = 1,
    ship_type = 'tiefofighter',
    Shield = 1,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['longshot'] = {
    name = '"Longshot"',
    XWS = 'longshot',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    Shield = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['muse'] = {
    limited = 1,
    name = '"Muse"',
    XWS = 'muse',
    Faction = 5,
    ship_type = 'tiefofighter',
    Shield = 1,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['null'] = {
    limited = 1,
    name = '"Null"',
    XWS = 'null',
    Faction = 5,
    ship_type = 'tiefofighter',
    Shield = 1,
    init = 0,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['omegasquadronace'] = {
    name = 'Omega Squadron Ace',
    XWS = 'omegasquadronace',
    Faction = 5,
    ship_type = 'tiefofighter',
    Shield = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['zetasquadronpilot'] = {
    name = 'Zeta Squadron Pilot',
    XWS = 'zetasquadronpilot',
    Faction = 5,
    ship_type = 'tiefofighter',
    Shield = 1,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['epsilonsquadroncadet'] = {
    name = 'Epsilon Squadron Cadet',
    XWS = 'epsilonsquadroncadet',
    Faction = 5,
    ship_type = 'tiefofighter',
    Shield = 1,
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['quickdraw'] = {
    limited = 1,
    name = '"Quickdraw"',
    XWS = 'quickdraw',
    Faction = 5,
    ship_type = 'tiesffighter',
    Charge = 1,
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['backdraft'] = {
    limited = 1,
    name = '"Backdraft"',
    XWS = 'backdraft',
    Faction = 5,
    ship_type = 'tiesffighter',
    Shield = 3,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['omegasquadronexpert'] = {
    name = 'Omega Squadron Expert',
    XWS = 'omegasquadronexpert',
    Faction = 5,
    ship_type = 'tiesffighter',
    Shield = 3,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['zetasquadronsurvivor'] = {
    name = 'Zeta Squadron Survivor',
    XWS = 'zetasquadronsurvivor',
    Faction = 5,
    ship_type = 'tiesffighter',
    Shield = 3,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['lieutenantlehuse'] = {
    name = 'Lieutenant LeHuse',
    XWS = 'lieutenantlehuse',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesffighter',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['captainphasma'] = {
    name = 'Captain Phasma',
    XWS = 'captainphasma',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesffighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['majorstridan'] = {
    name = 'Major Stridan',
    XWS = 'majorstridan',
    limited = 1,
    Faction = 5,
    ship_type = 'upsilonclasscommandshuttle',
    Shield = 6,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB['lieutenanttavson'] = {
    name = 'Lieutenant Tavson',
    XWS = 'lieutenanttavson',
    Faction = 5,
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    Shield = 6,
    Charge = 2,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB['lieutenantdormitz'] = {
    name = 'Lieutenant Dormitz',
    XWS = 'lieutenantdormitz',
    Faction = 5,
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    Shield = 6,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB['starkillerbasepilot'] = {
    name = 'Starkiller Base Pilot',
    XWS = 'starkillerbasepilot',
    Faction = 5,
    ship_type = 'upsilonclasscommandshuttle',
    Shield = 6,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB['kyloren'] = {
    name = 'Kylo Ren',
    XWS = 'kyloren',
    Condition = "I'll Show You the Dark Side",
    Faction = 5,
    limited = 1,
    ship_type = 'tievnsilencer',
    Shield = 2,
    Force = 2,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side' }
}

masterPilotDB['blackout'] = {
    name = '"Blackout"',
    XWS = 'blackout',
    Faction = 5,
    limited = 1,
    ship_type = 'tievnsilencer',
    Shield = 2,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB['firstordertestpilot'] = {
    name = 'First Order Test Pilot',
    XWS = 'firstordertestpilot',
    Faction = 5,
    ship_type = 'tievnsilencer',
    Shield = 2,
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB['sienarjaemusengineer'] = {
    name = 'Sienar-Jaemus Engineer',
    XWS = 'sienarjaemusengineer',
    Faction = 5,
    ship_type = 'tievnsilencer',
    Shield = 2,
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB['rush'] = {
    name = '"Rush"',
    XWS = 'rush',
    Faction = 5,
    limited = 1,
    ship_type = 'tievnsilencer',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'B', 'TL', 'BR' }
}

masterPilotDB['poedameron'] = {
    name = 'Poe Dameron',
    XWS = 'poedameron',
    title = 'Trigger-Happy Flyboy',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    Charge = 1,
    init = 6,
    texture = 'blackone',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['elloasty'] = {
    name = 'Ello Asty',
    XWS = 'elloasty',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['niennunb'] = {
    name = 'Nien Nunb',
    XWS = 'niennunb',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['karekun'] = {
    name = 'Kare Kun',
    XWS = 'karekun',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Dare' }
}

masterPilotDB['temminwexley'] = {
    name = 'Temmin Wexley',
    XWS = 'temminwexley',
    title = 'Snap',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['jessikapava'] = {
    name = 'Jessika Pava',
    XWS = 'jessikapava',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    Charge = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['jophseastriker'] = {
    name = 'Joph Seastriker',
    XWS = 'jophseastriker',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['redsquadronexpert'] = {
    name = 'Red Squadron Expert',
    XWS = 'redsquadronexpert',
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['bluesquadronrookie'] = {
    name = 'Blue Squadron Rookie',
    XWS = 'bluesquadronrookie',
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}


masterPilotDB['nimichireen'] = {
    name = 'Nimi Chireen',
    XWS = 'nimichireen',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' },
}

masterPilotDB['caithrenalli'] = {
    name = "C'ai Threnalli",
    XWS = 'caithrenalli',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'E' },
    movethrough = true
}


masterPilotDB['temminwexley-swz68'] = {
    name = "Temmin Wexley",
    XWS = 'temminwexley-swz68',
    title = "Black Two",
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 4,
    texture = 'snap',
    actSet = { 'F', 'TL', 'B' },
    addSqdAction = { 'C' }
}

masterPilotDB['poedameron-swz68'] = {
    name = "Poe Dameron",
    XWS = 'poedameron-swz68',
    title = "Resistance Commander",
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    Charge = 2,
    init = 6,
    texture = 'commanderpoe',
    actSet = { 'F', 'TL', 'B' },
}

masterPilotDB['hansolo-scavengedyt1300'] = {
    name = "Han Solo",
    XWS = 'hansolo-scavengedyt1300',
    Faction = 4,
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['rey'] = {
    name = "Rey",
    XWS = 'rey',
    Faction = 4,
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    Force = 2,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' },
    keywords = { 'Light Side' }
}

masterPilotDB['chewbacca-scavengedyt1300'] = {
    name = "Chewbacca",
    XWS = 'chewbacca-scavengedyt1300',
    Faction = 4,
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['resistancesympathizer'] = {
    name = "Resistance Sympathizer",
    XWS = 'resistancesympathizer',
    Faction = 4,
    ship_type = 'scavengedyt1300lightfreighter',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['finchdallow'] = {
    name = "Finch Dallow",
    XWS = 'finchdallow',
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB['benteene'] = {
    name = "Ben Teene",
    XWS = 'benteene',
    Condition = "Rattled",
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    init = 3,
    texture = 'vennie',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB['cat'] = {
    name = "Cat",
    XWS = 'cat',
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB['cobaltsquadronbomber'] = {
    name = "Cobalt Squadron Bomber",
    XWS = 'cobaltsquadronbomber',
    Faction = 4,
    ship_type = 'mg100starfortress',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB['lulolampar'] = {
    name = "L'ulo L'ampar",
    XWS = 'lulolampar',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    init = 5,
    texture = 'orange',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['tallissanlintra'] = {
    name = "Tallissan Lintra",
    XWS = 'tallissanlintra',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    Charge = 1,
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['greersonnel'] = {
    name = "Greer Sonnel",
    XWS = 'greersonnel',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    init = 4,
    texture = 'orange',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['zaribangel'] = {
    name = "Zari Bangel",
    XWS = 'zaribangel',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['greensquadronexpert'] = {
    name = "Green Squadron Expert",
    XWS = 'greensquadronexpert',
    Faction = 4,
    ship_type = 'rz2awing',
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['bluesquadronrecruit'] = {
    name = "Blue Squadron Recruit",
    XWS = 'bluesquadronrecruit',
    Faction = 4,
    ship_type = 'rz2awing',
    init = 1,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['zizitlo'] = {
    name = "Zizi Tlo",
    XWS = 'zizitlo',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    Charge = 1,
    init = 5,
    texture = 'red',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['ronithblario'] = {
    name = "Ronith Blario",
    XWS = 'ronithblario',
    Faction = 4,
    limited = 1,
    ship_type = 'rz2awing',
    init = 2,
    texture = 'red',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}


masterPilotDB['seftinvanik'] = {
    name = "Seftin Vanik",
    XWS = 'seftinvanik',
    limited = 1,
    Faction = 4,
    ship_type = 'rz2awing',
    init = 5,
    texture = 'green',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['merlcobben'] = {
    name = "Merl Cobben",
    XWS = 'merlcobben',
    limited = 1,
    Faction = 4,
    ship_type = 'rz2awing',
    init = 1,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['suralindajavos'] = {
    name = "Suralinda Javos",
    XWS = 'suralindajavos',
    limited = 1,
    Faction = 4,
    ship_type = 'rz2awing',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR', 'Piv' }
}

masterPilotDB['wrobietyce'] = {
    name = "Wrobie Tyce",
    XWS = 'wrobietyce',
    limited = 1,
    Faction = 4,
    ship_type = 'rz2awing',
    init = 4,
    texture = 'green',
    actSet = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}


masterPilotDB['foremanproach'] = {
    name = 'Foreman Proach',
    XWS = 'foremanproach',
    Faction = 3,
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['ahhav'] = {
    name = 'Ahhav',
    XWS = 'ahhav',
    Faction = 3,
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['captainseevor'] = {
    name = 'Captain Seevor',
    XWS = 'captainseevor',
    Faction = 3,
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    Charge = 1,
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['overseeryushyn'] = {
    name = 'Overseer Yushyn',
    XWS = 'overseeryushyn',
    Faction = 3,
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    Charge = 1,
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['miningguildsurveyor'] = {
    name = 'Mining Guild Surveyor',
    XWS = 'miningguildsurveyor',
    Faction = 3,
    ship_type = 'modifiedtielnfighter',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['miningguildsentry'] = {
    name = 'Mining Guild Sentry',
    XWS = 'miningguildsentry',
    Faction = 3,
    ship_type = 'modifiedtielnfighter',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['edonkappehl'] = {
    name = "Edon Kappehl",
    XWS = 'edonkappehl',
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB['vennie'] = {
    name = "Vennie",
    XWS = 'vennie',
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    init = 2,
    texture = 'vennie',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB['paigetico'] = {
    name = "Paige Tico",
    XWS = 'paigetico',
    Faction = 4,
    limited = 1,
    ship_type = 'mg100starfortress',
    Charge = 1,
    init = 5,
    texture = 'paige',
    actSet = { 'F', 'TL', 'Rot' }
}

masterPilotDB['lieutenantbastian'] = {
    name = 'Lieutenant Bastian',
    XWS = 'lieutenantbastian',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['jaycristubbs'] = {
    name = 'Jaycris Tubbs',
    XWS = 'jaycristubbs',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['blacksquadronace-t70xwing'] = {
    name = 'Black Squadron Ace',
    XWS = 'blacksquadronace-t70xwing',
    Faction = 4,
    ship_type = 't70xwing',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['commandermalarus'] = {
    name = 'Commander Malarus',
    XWS = 'commandermalarus',
    Faction = 5,
    limited = 1,
    ship_type = 'tiefofighter',
    Charge = 2,
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['tn3465'] = {
    name = 'TN-3465',
    XWS = 'tn3465',
    Faction = 5,
    limited = 1,
    ship_type = 'tiefofighter',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['lieutenantrivas'] = {
    name = 'Lieutenant Rivas',
    XWS = 'lieutenantrivas',
    Faction = 5,
    limited = 1,
    ship_type = 'tiefofighter',
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['recoil'] = {
    name = '"Recoil"',
    XWS = 'recoil',
    Faction = 5,
    limited = 1,
    ship_type = 'tievnsilencer',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'B', 'TL', 'BR' }
}

masterPilotDB['avenger'] = {
    name = '"Avenger"',
    XWS = 'avenger',
    Faction = 5,
    limited = 1,
    ship_type = 'tievnsilencer',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'B', 'TL', 'BR' }
}

masterPilotDB['captaincardinal'] = {
    name = 'Captain Cardinal',
    XWS = 'captaincardinal',
    Faction = 5,
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    Charge = 2,
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'R' }
}

masterPilotDB['pettyofficerthanisson'] = {
    name = 'Petty Officer Thanisson',
    XWS = 'pettyofficerthanisson',
    Faction = 5,
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    Charge = 1,
    init = 1,
    texture = 'standard',
    actSet = { 'F', 'TL', 'R' }
}

--w3pilot

masterPilotDB['generalgrievous'] = {
    name = 'General Grievous',
    XWS = 'generalgrievous',
    Faction = 7,
    limited = 1,
    ship_type = 'belbulab22starfighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'BR' }
}

masterPilotDB['wattambor'] = {
    name = 'Wat Tambor',
    XWS = 'wattambor',
    Faction = 7,
    limited = 1,
    ship_type = 'belbulab22starfighter',
    init = 3,
    actSet = { 'F', 'TL', 'B', 'BR' },
    texture = 'wat',
}

masterPilotDB['captainsear'] = {
    name = 'Captain Sear',
    XWS = 'captainsear',
    Faction = 7,
    limited = 1,
    ship_type = 'belbulab22starfighter',
    init = 2,
    actSet = { 'F', 'TL', 'B', 'BR' },
    texture = 'standard',
}
masterPilotDB['skakoanace'] = {
    name = 'Skakoan Ace',
    XWS = 'skakoanace',
    Faction = 7,
    ship_type = 'belbulab22starfighter',
    init = 3,
    actSet = { 'F', 'TL', 'B', 'BR' },
    texture = 'standard',
}

masterPilotDB['feethanottrawautopilot'] = {
    name = 'Feethan Ottraw Autopilot',
    XWS = 'feethanottrawautopilot',
    Faction = 7,
    ship_type = 'belbulab22starfighter',
    init = 1,
    actSet = { 'C', 'TL', 'B', 'BR' },
    texture = 'standard',
    keywords = { 'Droid' }
}

masterPilotDB['separatistdrone'] = {
    name = 'Separatist Drone',
    XWS = 'separatistdrone',
    Faction = 7,
    ship_type = 'vultureclassdroidfighter',
    init = 3,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'drone',
}

masterPilotDB['tradefederationdrone'] = {
    name = 'Trade Federation Drone',
    XWS = 'tradefederationdrone',
    Faction = 7,
    ship_type = 'vultureclassdroidfighter',
    init = 1,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'drone',
}

masterPilotDB['dfs081'] = {
    name = 'DFS-081',
    XWS = 'dfs081',
    Faction = 7,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    init = 3,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'dfs081',
}

masterPilotDB['precisehunter'] = {
    name = 'Precise Hunter',
    XWS = 'precisehunter',
    Faction = 7,
    limited = 3,
    ship_type = 'vultureclassdroidfighter',
    init = 3,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'hunter',
}

masterPilotDB['dfs311'] = {
    name = 'DFS-311',
    XWS = 'dfs311',
    Faction = 7,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    init = 1,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'dfs311',
}

masterPilotDB['haorchallprototype'] = {
    name = 'Haor Chall Prototype',
    XWS = 'haorchallprototype',
    Faction = 7,
    limited = 2,
    ship_type = 'vultureclassdroidfighter',
    init = 1,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'proto',
}

masterPilotDB['darthmaul'] = {
    name = 'Darth Maul',
    XWS = 'darthmaul',
    Faction = 7,
    limited = 1,
    ship_type = 'sithinfiltrator',
    Force = 3,
    init = 5,
    actSet = { 'F', 'TL', 'BR' },
    texture = 'maul',
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB['countdooku'] = {
    name = 'Count Dooku',
    XWS = 'countdooku',
    Faction = 7,
    limited = 1,
    ship_type = 'sithinfiltrator',
    Force = 3,
    init = 3,
    actSet = { 'F', 'TL', 'BR' },
    texture = 'standard',
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB['066'] = {
    name = 'O-66',
    XWS = '066',
    Faction = 7,
    limited = 1,
    ship_type = 'sithinfiltrator',
    init = 3,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'standard',
    keywords = { 'Droid' }
}

masterPilotDB['darkcourier'] = {
    name = 'Dark Courier',
    XWS = 'darkcourier',
    Faction = 7,
    ship_type = 'sithinfiltrator',
    init = 2,
    actSet = { 'F', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB['anakinskywalker'] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    Force = 3,
    init = 6,
    texture = 'anakin',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['luminaraunduli'] = {
    name = 'Luminara Unduli',
    XWS = 'luminaraunduli',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    Force = 2,
    init = 4,
    texture = 'lumi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['barrissoffee'] = {
    name = 'Barriss Offee',
    XWS = 'barrissoffee',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    Force = 1,
    init = 4,
    texture = 'barriss',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['ahsokatano'] = {
    name = 'Ahsoka Tano',
    XWS = 'ahsokatano',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    Force = 2,
    init = 3,
    texture = 'ahsoka',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['obiwankenobi'] = {
    name = 'Obi-Wan Kenobi',
    XWS = 'obiwankenobi',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    Force = 3,
    init = 5,
    texture = 'obi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['macewindu'] = {
    name = 'Mace Windu',
    XWS = 'macewindu',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    Force = 3,
    init = 4,
    texture = 'mace',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['plokoon'] = {
    name = 'Plo Koon',
    XWS = 'plokoon',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    Force = 2,
    init = 5,
    texture = 'plo',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['saeseetiin'] = {
    name = 'Saesee Tiin',
    XWS = 'saeseetiin',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7aethersprite',
    Force = 2,
    init = 4,
    texture = 'saesee',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['jediknight'] = {
    name = 'Jedi Knight',
    XWS = 'jediknight',
    Faction = 6,
    ship_type = 'delta7aethersprite',
    Force = 1,
    init = 3,
    texture = 'knight',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    --tintFriendly = {mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/Small/delta7aethersprite/Jedi_Delta7_tint.obj',
    --                texture = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships/Small/GRP_Delta7/JediKnight-tint.png',}
}

masterPilotDB['oddball'] = {
    name = '"Odd Ball"',
    XWS = 'oddball',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['kickback'] = {
    name = '"Kickback"',
    XWS = 'kickback',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['axe'] = {
    name = '"Axe"',
    XWS = 'axe',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['swoop'] = {
    name = '"Swoop"',
    XWS = 'swoop',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['tucker'] = {
    name = '"Tucker"',
    XWS = 'tucker',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['bluesquadronprotector'] = {
    name = 'Blue Squadron Protector',
    XWS = 'bluesquadronprotector',
    Faction = 6,
    ship_type = 'v19torrentstarfighter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['goldsquadrontrooper'] = {
    name = 'Gold Squadron Trooper',
    XWS = 'goldsquadrontrooper',
    Faction = 6,
    ship_type = 'v19torrentstarfighter',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['oddball-arc170starfighter'] = {
    name = '"Odd Ball"',
    XWS = 'oddball-arc170starfighter',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    init = 5,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['wolffe'] = {
    name = '"Wolffe"',
    XWS = 'wolffe',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    Charge = 1,
    init = 4,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['jag'] = {
    name = '"Jag"',
    XWS = 'jag',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    init = 3,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['sinker'] = {
    name = '"Sinker"',
    XWS = 'sinker',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
    init = 3,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['squadsevenveteran'] = {
    name = 'Squad Seven Veteran',
    XWS = 'squadsevenveteran',
    Faction = 6,
    ship_type = 'arc170starfighter',
    init = 3,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['104thbattalionpilot'] = {
    name = '104th Battalion Pilot',
    XWS = '104thbattalionpilot',
    Faction = 6,
    ship_type = 'arc170starfighter',
    init = 2,
    texture = 'republic',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

--w4 Pilots
--N-1
masterPilotDB['ricolie'] = {
    name = 'Ric OliÃ©',
    XWS = 'ricolie',
    Faction = 6,
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    init = 5,
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB['anakinskywalker-nabooroyaln1starfighter'] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker-nabooroyaln1starfighter',
    Faction = 6,
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    Force = 1,
    init = 4,
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' },
    keywords = { 'Light Side' }
}

masterPilotDB['padmeamidala'] = {
    name = 'PadmÃ© Amidala',
    XWS = 'padmeamidala',
    Faction = 6,
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    init = 4,
    texture = 'silver',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB['dineeellberger'] = {
    name = 'DineÃ© Ellberger',
    XWS = 'dineeellberger',
    Faction = 6,
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    init = 3,
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB['naboohandmaiden'] = {
    name = 'Naboo Handmaiden',
    XWS = 'naboohandmaiden',
    Faction = 6,
    limited = 2,
    ship_type = 'nabooroyaln1starfighter',
    init = 1,
    Condition = 'Decoyed',
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB['bravoflightofficer'] = {
    name = 'Bravo Flight Officer',
    XWS = 'bravoflightofficer',
    Faction = 6,
    ship_type = 'nabooroyaln1starfighter',
    init = 2,
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

--Resistance Transport
masterPilotDB['covanell'] = {
    name = 'Cova Nell',
    XWS = 'covanell',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransport',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB['pammichnerrogoode'] = {
    name = 'Pammich Nerro Goode',
    XWS = 'pammichnerrogoode',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransport',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB['nodinchavdri'] = {
    name = 'Nodin Chavdri',
    XWS = 'nodinchavdri',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransport',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB['logisticsdivisionpilot'] = {
    name = 'Logistics Division Pilot',
    XWS = 'logisticsdivisionpilot',
    Faction = 4,
    ship_type = 'resistancetransport',
    init = 1,
    texture = 'red',
    actSet = { 'F', 'TL' }
}

masterPilotDB['rosetico'] = {
    name = 'Rose Tico',
    XWS = 'rosetico',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransportpod',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['bb8'] = {
    name = 'BB-8',
    XWS = 'bb8',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransportpod',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR', 'B' },
    keywords = { 'Droid' }
}

masterPilotDB['finn'] = {
    name = 'Finn',
    XWS = 'finn',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransportpod',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['vimoradi'] = {
    name = 'Vi Moradi',
    XWS = 'vimoradi',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransportpod',
    init = 1,
    Condition = "Compromising Intel",
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' }
}

masterPilotDB['dbs404'] = {
    name = 'DBS-404',
    XWS = 'dbs404',
    Faction = 7,
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
    init = 4,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'fourohfour',
}

masterPilotDB['dbs32c'] = {
    name = 'DBS-32C',
    XWS = 'dbs32c',
    Faction = 7,
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
    init = 3,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB['bombardmentdrone'] = {
    name = 'Bombardment Drone',
    XWS = 'bombardmentdrone',
    Faction = 7,
    limited = 3,
    ship_type = 'hyenaclassdroidbomber',
    init = 3,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB['baktoidprototype'] = {
    name = 'Baktoid Prototype',
    XWS = 'baktoidprototype',
    Faction = 7,
    limited = 2,
    ship_type = 'hyenaclassdroidbomber',
    init = 1,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'baktoid',
}

masterPilotDB['separatistbomber'] = {
    name = 'Separatist Bomber',
    XWS = 'separatistbomber',
    Faction = 7,
    ship_type = 'hyenaclassdroidbomber',
    init = 3,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB['technounionbomber'] = {
    name = 'Techno Union Bomber',
    XWS = 'technounionbomber',
    Faction = 7,
    ship_type = 'hyenaclassdroidbomber',
    init = 1,
    actSet = { 'C', 'TL', 'BR' },
    texture = 'baktoid',
}

--Republic Y-Wing
masterPilotDB['anakinskywalker-btlbywing'] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker-btlbywing',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    Force = 3,
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['oddball-btlbywing'] = {
    name = '"Odd Ball"',
    XWS = 'oddball-btlbywing',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['matchstick'] = {
    name = '"Matchstick"',
    XWS = 'matchstick',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['broadside'] = {
    name = '"Broadside"',
    XWS = 'broadside',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['r2d2'] = {
    name = 'R2-D2',
    XWS = 'r2d2',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    init = 2,
    texture = 'green',
    actSet = { 'C', 'TL', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB['goji'] = {
    name = '"Goji"',
    XWS = 'goji',
    Faction = 6,
    limited = 1,
    ship_type = 'btlbywing',
    init = 2,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['shadowsquadronveteran'] = {
    name = 'Shadow Squadron Veteran',
    XWS = 'shadowsquadronveteran',
    Faction = 6,
    ship_type = 'btlbywing',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['redsquadronbomber'] = {
    name = 'Red Squadron Bomber',
    XWS = 'redsquadronbomber',
    Faction = 6,
    ship_type = 'btlbywing',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

--Nantex
masterPilotDB['sunfac'] = {
    name = 'Sun Fac',
    XWS = 'sunfac',
    Faction = 7,
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    init = 6,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB['berwerkret'] = {
    name = 'Berwer Kret',
    XWS = 'berwerkret',
    Faction = 7,
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    init = 5,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB['chertek'] = {
    name = 'Chertek',
    XWS = 'chertek',
    Faction = 7,
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    init = 4,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB['gorgol'] = {
    name = 'Gorgol',
    XWS = 'gorgol',
    Faction = 7,
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    init = 2,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB['petranakiarenaace'] = {
    name = 'Petranaki Arena Ace',
    XWS = 'petranakiarenaace',
    Faction = 7,
    ship_type = 'nantexclassstarfighter',
    init = 4,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB['stalgasinhiveguard'] = {
    name = 'Stalgasin Hive Guard',
    XWS = 'stalgasinhiveguard',
    Faction = 7,
    ship_type = 'nantexclassstarfighter',
    init = 3,
    actSet = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

--w7
--TIE/ba
masterPilotDB['firstorderprovocateur'] = {
    name = 'First Order Provocateur',
    XWS = 'firstorderprovocateur',
    Faction = 5,
    ship_type = 'tiebainterceptor',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['ember'] = {
    name = '"Ember"',
    XWS = 'ember',
    Faction = 5,
    limited = 1,
    ship_type = 'tiebainterceptor',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['holo'] = {
    name = '"Holo"',
    XWS = 'holo',
    Faction = 5,
    limited = 1,
    ship_type = 'tiebainterceptor',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['majorvonreg'] = {
    name = 'Major Vonreg',
    XWS = 'majorvonreg',
    Faction = 5,
    limited = 1,
    ship_type = 'tiebainterceptor',
    init = 6,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

--FireBall
masterPilotDB['jarekyeager'] = {
    name = 'Jarek Yeager',
    XWS = 'jarekyeager',
    Faction = 4,
    limited = 1,
    ship_type = 'fireball',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['kazudaxiono'] = {
    name = 'Kazuda Xiono',
    XWS = 'kazudaxiono',
    Faction = 4,
    limited = 1,
    ship_type = 'fireball',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['r1j5'] = {
    name = 'R1-J5',
    XWS = 'r1j5',
    Faction = 4,
    limited = 1,
    ship_type = 'fireball',
    init = 1,
    texture = 'standard',
    actSet = { 'C', 'E', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB['colossusstationmechanic'] = {
    name = 'Colossus Station Mechanic',
    XWS = 'colossusstationmechanic',
    Faction = 4,
    ship_type = 'fireball',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['commandermalarus-xiclasslightshuttle'] = {
    name = 'Commander Malarus',
    XWS = 'commandermalarus-xiclasslightshuttle',
    Faction = 5,
    limited = 1,
    ship_type = 'xiclasslightshuttle',
    init = 5,
    texture = 'light',
    actSet = { 'F', 'TL' }
}

masterPilotDB['gideonhask-xiclasslightshuttle'] = {
    name = 'Gideon Hask',
    XWS = 'gideonhask-xiclasslightshuttle',
    Faction = 5,
    limited = 1,
    ship_type = 'xiclasslightshuttle',
    init = 4,
    texture = 'light',
    actSet = { 'F', 'TL' }
}

masterPilotDB['agentterex'] = {
    name = 'Agent Terex',
    XWS = 'agentterex',
    Faction = 5,
    limited = 1,
    ship_type = 'xiclasslightshuttle',
    init = 3,
    texture = 'dark',
    actSet = { 'F', 'TL' }
}

masterPilotDB['firstordercourier'] = {
    name = 'First Order Courier',
    XWS = 'firstordercourier',
    Faction = 5,
    ship_type = 'xiclasslightshuttle',
    init = 2,
    texture = 'light',
    actSet = { 'F', 'TL' }
}

masterPilotDB['hawk'] = {
    name = '"Hawk"',
    XWS = 'hawk',
    limited = 1,
    Faction = 6,
    ship_type = 'laatigunship',
    init = 4,
    texture = 'munilist',
    actSet = { 'F', 'R', 'TL', 'Rot' },
    addSqdAction = { 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB['warthog'] = {
    name = '"Warthog"',
    XWS = 'warthog',
    limited = 1,
    Faction = 6,
    ship_type = 'laatigunship',
    init = 3,
    texture = 'warthog',
    actSet = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' }
}

masterPilotDB['hound'] = {
    name = '"Hound"',
    XWS = 'hound',
    limited = 1,
    Faction = 6,
    ship_type = 'laatigunship',
    init = 2,
    texture = 'hound1',
    actSet = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' }
}

masterPilotDB['212thbattalionpilot'] = {
    name = '212th Battalion Pilot',
    XWS = '212thbattalionpilot',
    Faction = 6,
    ship_type = 'laatigunship',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' }
}

masterPilotDB['onderonoppressor'] = {
    name = 'Onderon Oppressor',
    XWS = 'onderonoppressor',
    limited = 2,
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB['geonosianprototype'] = {
    name = 'Geonosian Prototype',
    XWS = 'geonosianprototype',
    limited = 2,
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    init = 2,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB['dgs047'] = {
    name = 'DGS-047',
    XWS = 'dgs047',
    limited = 1,
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    init = 1,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB['dgs286'] = {
    name = 'DGS-286',
    XWS = 'dgs286',
    limited = 1,
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB['separatistpredator'] = {
    name = 'Separatist Predator',
    XWS = 'separatistpredator',
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB['baktoiddrone'] = {
    name = 'Baktoid Drone',
    XWS = 'baktoiddrone',
    Faction = 7,
    ship_type = 'hmpdroidgunship',
    init = 1,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR' },
}

masterPilotDB['rampage'] = {
    name = '"Rampage"',
    XWS = 'rampage',
    limited = 1,
    Faction = 2,
    ship_type = 'tierbheavy',
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB['lyttandree'] = {
    name = 'Lyttan Dree',
    XWS = 'lyttandree',
    limited = 1,
    Faction = 2,
    ship_type = 'tierbheavy',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB['onyxsquadronsentry'] = {
    name = 'Onyx Squadron Sentry',
    XWS = 'onyxsquadronsentry',
    Faction = 2,
    ship_type = 'tierbheavy',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB['caridaacademycadet'] = {
    name = 'Carida Academy Cadet',
    XWS = 'caridaacademycadet',
    Faction = 2,
    ship_type = 'tierbheavy',
    init = 1,
    texture = 'grey',
    actSet = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB['anakinskywalker-eta2actis'] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker-eta2actis',
    limited = 1,
    Faction = 6,
    Force = 3,
    ship_type = 'eta2actis',
    init = 6,
    texture = 'anakin',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side', 'Light Side', 'Jedi' }
}

masterPilotDB['obiwankenobi-eta2actis'] = {
    name = 'Obi-Wan Kenobi',
    XWS = 'obiwankenobi-eta2actis',
    limited = 1,
    Faction = 6,
    Force = 3,
    ship_type = 'eta2actis',
    init = 5,
    texture = 'obi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['aaylasecura'] = {
    name = 'Aayla Secura',
    XWS = 'aaylasecura',
    limited = 1,
    Faction = 6,
    Force = 2,
    ship_type = 'eta2actis',
    init = 5,
    texture = 'aayla',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['shaakti'] = {
    name = 'Shaak Ti',
    XWS = 'shaakti',
    limited = 1,
    Faction = 6,
    Force = 2,
    ship_type = 'eta2actis',
    init = 4,
    texture = 'shaak',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['yoda'] = {
    name = 'Yoda',
    XWS = 'yoda',
    limited = 1,
    Faction = 6,
    Force = 3,
    ship_type = 'eta2actis',
    init = 3,
    texture = 'yoda',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    mesh = "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/eta2actis-Yoda.obj"
}

masterPilotDB['jedigeneral'] = {
    name = 'Jedi General',
    XWS = 'jedigeneral',
    Faction = 6,
    Force = 2,
    ship_type = 'eta2actis',
    init = 4,
    texture = 'jedi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['oddball-nimbusclassvwing'] = {
    name = '"Odd Ball"',
    XWS = 'oddball-nimbusclassvwing',
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB['contrail'] = {
    name = '"Contrail"',
    XWS = 'contrail',
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    init = 5,
    texture = 'contrail',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB['klick'] = {
    name = '"Klick"',
    XWS = 'klick',
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    Charge = 1,
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB['wilhufftarkin'] = {
    name = 'Wilhuff Tarkin',
    XWS = 'wilhufftarkin',
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B' },
}

masterPilotDB['shadowsquadronescort'] = {
    name = 'Shadow Squadron Escort',
    XWS = 'shadowsquadronescort',
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB['loyalistvolunteer'] = {
    name = 'Loyalist Volunteer',
    XWS = 'loyalistvolunteer',
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    init = 2,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B' },
}

masterPilotDB['phlacarphoccprototype'] = {
    name = "Phlac-Arphocc Prototype",
    XWS = 'phlacarphoccprototype',
    limited = 2,
    Faction = 7,
    ship_type = 'droidtrifighter',
    init = 5,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['dist81'] = {
    name = "DIS-T81",
    XWS = 'dist81',
    limited = 1,
    Faction = 7,
    ship_type = 'droidtrifighter',
    init = 4,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['dis347'] = {
    name = "DIS-347",
    XWS = 'dis347',
    limited = 1,
    Faction = 7,
    ship_type = 'droidtrifighter',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['fearsomepredator'] = {
    name = "Fearsome Predator",
    XWS = 'fearsomepredator',
    limited = 3,
    Faction = 7,
    ship_type = 'droidtrifighter',
    Condition = "Fearful Prey",
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['separatistinterceptor'] = {
    name = "Separatist Interceptor",
    XWS = 'separatistinterceptor',
    Faction = 7,
    ship_type = 'droidtrifighter',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['colicoidinterceptor'] = {
    name = "Colicoid Interceptor",
    XWS = 'colicoidinterceptor',
    Faction = 7,
    ship_type = 'droidtrifighter',
    init = 1,
    texture = 'standard',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['jangofett'] = {
    name = 'Jango Fett',
    XWS = 'jangofett',
    limited = 1,
    Faction = 7,
    ship_type = 'firesprayclasspatrolcraft',
    init = 6,
    texture = 'jango',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['zamwesell'] = {
    name = 'Zam Wesell',
    XWS = 'zamwesell',
    limited = 1,
    Faction = 7,
    Condition = 'Zam Wesell',
    Charge = 4,
    ship_type = 'firesprayclasspatrolcraft',
    init = 5,
    texture = 'zam',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['bobafett-firesprayclasspatrolcraft'] = {
    name = 'Boba Fett',
    XWS = 'bobafett-firesprayclasspatrolcraft',
    title = 'Survivor',
    limited = 1,
    Faction = 7,
    ship_type = 'firesprayclasspatrolcraft',
    init = 3,
    texture = 'jango',
    actSet = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['separatistracketeer'] = {
    name = 'Separatist Racketeer',
    XWS = 'separatistracketeer',
    Faction = 7,
    ship_type = 'firesprayclasspatrolcraft',
    init = 2,
    texture = 'zam',
    actSet = { 'F', 'R', 'TL', 'B' }
}

-- Tie Whisper

masterPilotDB['709thlegionace'] = {
    name = '709th Legion Ace',
    XWS = '709thlegionace',
    Faction = 5,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['wrath'] = {
    name = '"Wrath"',
    XWS = 'wrath',
    Faction = 5,
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['whirlwind'] = {
    name = '"Whirlwind"',
    XWS = 'whirlwind',
    Faction = 5,
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['nightfall'] = {
    name = '"Nightfall"',
    XWS = 'nightfall',
    Faction = 5,
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' },
    movethrough = true
}

masterPilotDB['kyloren-tiewiwhispermodifiedinterceptor'] = {
    name = 'Kylo Ren',
    XWS = 'kyloren-tiewiwhispermodifiedinterceptor',
    Faction = 5,
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    init = 5,
    Force = 3,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['redfuryzealot'] = {
    name = 'Red Fury Zealot',
    XWS = 'redfuryzealot',
    Faction = 5,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

-- First Order Bomber

masterPilotDB['firstordercadet'] = {
    name = 'First Order Cadet',
    XWS = 'firstordercadet',
    Faction = 5,
    ship_type = 'tiesebomber',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['sienarjaemustestpilot'] = {
    name = 'Sienar-Jaemus Test Pilot',
    XWS = 'sienarjaemustestpilot',
    Faction = 5,
    ship_type = 'tiesebomber',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['grudge'] = {
    name = '"Grudge"',
    XWS = 'grudge',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesebomber',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['scorch-tiesebomber'] = {
    name = '"Scorch"',
    XWS = 'scorch-tiesebomber',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesebomber',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['breach'] = {
    name = '"Breach"',
    XWS = 'breach',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesebomber',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['dread'] = {
    name = '"Dread"',
    XWS = 'dread',
    Faction = 5,
    limited = 1,
    ship_type = 'tiesebomber',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

-- Resistance Y-Wing

masterPilotDB['newrepublicpatrol'] = {
    name = 'New Republic Patrol',
    XWS = 'newrepublicpatrol',
    Faction = 4,
    ship_type = 'btanr2ywing',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['kijimispicerunner'] = {
    name = 'Kijimi Spice Runner',
    XWS = 'kijimispicerunner',
    Faction = 4,
    ship_type = 'btanr2ywing',
    init = 2,
    texture = 'plain',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['tezanasz'] = {
    name = 'Teza Nasz',
    XWS = 'tezanasz',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    init = 4,
    texture = 'teza',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['shasazaro'] = {
    name = 'Shasa Zaro',
    XWS = 'shasazaro',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['coruskapellim'] = {
    name = 'Corus Kapellim',
    XWS = 'coruskapellim',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    init = 1,
    texture = 'corus',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['caithrenalli-btanr2ywing'] = {
    name = "C'ai Threnalli",
    XWS = 'caithrenalli-btanr2ywing',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    init = 2,
    texture = 'cai',
    actSet = { 'F', 'TL', 'BR', 'B', 'C', 'E' },
    movethrough = true
}

masterPilotDB['wilsateshlo'] = {
    name = 'Wilsa Teshlo',
    XWS = 'wilsateshlo',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    init = 4,
    texture = 'wilsa',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['zoriibliss'] = {
    name = 'Zorii Bliss',
    XWS = 'zoriibliss',
    Charge = 1,
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    init = 5,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['aftabackbar'] = {
    name = 'Aftab Ackbar',
    XWS = 'aftabackbar',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    init = 2,
    texture = 'cai',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['legafossang'] = {
    name = 'Lega Fossang',
    XWS = 'legafossang',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing',
    init = 3,
    texture = 'lega',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}


--- NEW SHIT:
masterPilotDB['fennrau-fangfighter'] = {
    name = 'Fenn Rau',
    XWS = 'fennrau-fangfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'fangfighter',
    init = 6,
    texture = 'rebelfenn',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['bodicavenj'] = {
    name = 'Bodica Venj',
    XWS = 'bodicavenj',
    Faction = 1,
    limited = 1,
    ship_type = 'fangfighter',
    init = 4,
    texture = 'bodica',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['dirkullodin'] = {
    name = 'Dirk Ullodin',
    XWS = 'dirkullodin',
    Faction = 1,
    limited = 1,
    ship_type = 'fangfighter',
    init = 3,
    init = 3,
    texture = 'dirk',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['clanwrenvolunteer'] = {
    name = 'Clan Wren Volunteer',
    XWS = 'clanwrenvolunteer',
    Faction = 1,
    limited = 2,
    ship_type = 'fangfighter',
    init = 3,
    texture = 'volunteer',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['mandalorianroyalguard'] = {
    name = 'Mandalorian Royal Guard',
    XWS = 'mandalorianroyalguard',
    Faction = 3,
    limited = 2,
    ship_type = 'fangfighter',
    init = 4,
    texture = 'original',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

-- New TIE Ln

masterPilotDB['moffgideon'] = {
    name = 'Moff Gideon',
    XWS = 'moffgideon',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    Charge = 2,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['isbjingoist'] = {
    name = 'ISB Jingoist',
    XWS = 'isbjingoist',
    Faction = 2,
    limited = 2,
    ship_type = 'tielnfighter',
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' }
}


-- Gauntlet fighter:
masterPilotDB['maul'] = {
    name = 'Maul',
    XWS = 'maul',
    Faction = 3,
    limited = 1,
    ship_type = 'gauntletfighter',
    Force = 3,
    init = 5,
    texture = 'maul',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['bokatankryze'] = {
    name = 'Bo-Katan Kryze',
    title = 'Nite Owl Commander',
    XWS = 'bokatankryze',
    Faction = 6,
    limited = 1,
    ship_type = 'gauntletfighter',
    init = 4,
    texture = 'bokatan',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['bokatankryze-separatistalliance'] = {
    name = 'Bo-Katan Kryze',
    title = "Vizsla's Lieutenant",
    XWS = 'bokatankryze-separatistalliance',
    Faction = 7,
    limited = 1,
    Charge = 1,
    ship_type = 'gauntletfighter',
    init = 4,
    texture = 'bokatancis',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['previzsla'] = {
    name = 'Pre Vizsla',
    XWS = 'previzsla',
    Faction = 7,
    limited = 1,
    Charge = 2,
    ship_type = 'gauntletfighter',
    init = 3,
    texture = 'previzsla',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['rookkast'] = {
    name = 'Rook Kast',
    XWS = 'rookkast',
    Faction = 3,
    limited = 1,
    ship_type = 'gauntletfighter',
    init = 3,
    texture = 'scum',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['deathwatchwarrior'] = {
    name = 'Death Watch Warrior',
    XWS = 'deathwatchwarrior',
    Faction = 7,
    limited = 1,
    ship_type = 'gauntletfighter',
    init = 2,
    texture = 'deathwatch',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['niteowlliberator'] = {
    name = 'Nite Owl Liberator',
    XWS = 'niteowlliberator',
    Faction = 6,
    limited = 1,
    ship_type = 'gauntletfighter',
    init = 2,
    texture = 'default',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['shadowcollectiveoperator'] = {
    name = 'Shadow Collective Operator',
    XWS = 'shadowcollectiveoperator',
    Faction = 3,
    ship_type = 'gauntletfighter',
    init = 1,
    texture = 'scum',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['ezrabridger-gauntletfighter'] = {
    name = 'Ezra Bridger',
    XWS = 'ezrabridger-gauntletfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'gauntletfighter',
    Force = 1,
    init = 3,
    texture = 'scum',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['chopper-gauntletfighter'] = {
    name = '"Chopper"',
    XWS = 'chopper-gauntletfighter',
    Faction = 1,
    limited = 1,
    ship_type = 'gauntletfighter',
    init = 2,
    texture = 'scum',
    actSet = { 'C', 'TL', 'R', 'Piv' },
}

masterPilotDB['mandalorianresistancepilot'] = {
    name = 'Mandalorian Resistance Pilot',
    XWS = 'mandalorianresistancepilot',
    Faction = 1,
    limited = 1,
    ship_type = 'gauntletfighter',
    init = 2,
    texture = 'default',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['captainhark'] = {
    name = 'Captain Hark',
    XWS = 'captainhark',
    Faction = 2,
    limited = 1,
    ship_type = 'gauntletfighter',
    init = 3,
    texture = 'imperial',
    actSet = { 'F', 'TL', 'R' },
    executeOptions = {
        rs0 = { 'rbl1z', 'rs0', 'rbr1z' }
    },
}

masterPilotDB['garsaxon'] = {
    name = 'Gar Saxon',
    XWS = 'garsaxon',
    Charge = 2,
    Faction = 2,
    limited = 1,
    ship_type = 'gauntletfighter',
    init = 3,
    texture = 'deathwatch',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}


-- razorcrest pilots

masterPilotDB['themandalorian'] = {
    name = 'The Mandalorian',
    XWS = 'themandalorian',
    Faction = 3,
    limited = 1,
    ship_type = 'st70assaultship',
    init = 5,
    texture = 'mandalorian',
    actSet = { 'F', 'TL', 'E', 'BR' },
}

masterPilotDB['q90'] = {
    name = 'Q9-0',
    XWS = 'q90',
    Faction = 3,
    limited = 1,
    ship_type = 'st70assaultship',
    init = 5,
    texture = 'guildbountyhunter',
    actSet = { 'C', 'TL', 'E', 'BR' },
}

masterPilotDB['guildbountyhunter'] = {
    name = 'Guild Bounty Hunter',
    XWS = 'guildbountyhunter',
    Faction = 3,
    limited = 2,
    ship_type = 'st70assaultship',
    init = 3,
    texture = 'guildbountyhunter',
    actSet = { 'F', 'TL', 'E', 'BR' },
}



masterPilotDB['anakinskywalker-delta7baethersprite'] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    Force = 3,
    init = 6,
    texture = 'anakin',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['luminaraunduli-delta7baethersprite'] = {
    name = 'Luminara Unduli',
    XWS = 'luminaraunduli-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    Force = 2,
    init = 4,
    texture = 'lumi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['barrissoffee-delta7baethersprite'] = {
    name = 'Barriss Offee',
    XWS = 'barrissoffee-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    Force = 1,
    init = 4,
    texture = 'barriss',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['ahsokatano-delta7baethersprite'] = {
    name = 'Ahsoka Tano',
    XWS = 'ahsokatano-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    Force = 2,
    init = 3,
    texture = 'ahsoka',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['obiwankenobi-delta7baethersprite'] = {
    name = 'Obi-Wan Kenobi',
    XWS = 'obiwankenobi-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    Force = 3,
    init = 5,
    texture = 'obi',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['macewindu-delta7baethersprite'] = {
    name = 'Mace Windu',
    XWS = 'macewindu-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    Force = 3,
    init = 4,
    texture = 'mace',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['plokoon-delta7baethersprite'] = {
    name = 'Plo Koon',
    XWS = 'plokoon-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    Force = 2,
    init = 5,
    texture = 'plo',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['saeseetiin-delta7baethersprite'] = {
    name = 'Saesee Tiin',
    XWS = 'saeseetiin-delta7baethersprite',
    Faction = 6,
    limited = 1,
    ship_type = 'delta7baethersprite',
    Force = 2,
    init = 4,
    texture = 'saesee',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['jediknight-delta7baethersprite'] = {
    name = 'Jedi Knight',
    XWS = 'jediknight-delta7baethersprite',
    Faction = 6,
    ship_type = 'delta7baethersprite',
    Force = 1,
    init = 3,
    texture = 'knight',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    --tintFriendly = {mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/Small/delta7baethersprite/Jedi_Delta7_tint.obj',
    --                texture = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/Small/delta7baethersprite/JediKnight-tint.png',}
}

-- Rogue class starfighter

masterPilotDB['cadbane-separatistalliance'] = {
    name = 'Cad Bane',
    XWS = 'cadbane-separatistalliance',
    Faction = 7,
    Charge = 1,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['ig101'] = {
    name = 'IG-101',
    XWS = 'ig101',
    Faction = 7,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    init = 4,
    texture = 'grey',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['ig102'] = {
    name = 'IG-102',
    XWS = 'ig102',
    Faction = 7,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    init = 4,
    texture = 'grey',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['ig111'] = {
    name = 'IG-111',
    XWS = 'ig111',
    Faction = 7,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    init = 1,
    texture = 'grey',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['magnaguardprotector'] = {
    name = 'MagnaGuard Protector',
    XWS = 'magnaguardprotector',
    Faction = 7,
    limited = 2,
    ship_type = 'rogueclassstarfighter',
    Condition = 'Guarded',
    init = 4,
    texture = 'grey',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['magnaguardexecutioner'] = {
    name = 'MagnaGuard Executioner',
    XWS = 'magnaguardexecutioner',
    Faction = 7,
    ship_type = 'rogueclassstarfighter',
    init = 3,
    texture = 'grey',
    actSet = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['cadbane'] = {
    name = 'Cad Bane',
    XWS = 'cadbane',
    Faction = 3,
    Charge = 2,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    init = 4,
    texture = 'green',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['viktorhel-rogueclassstarfighter'] = {
    name = 'Viktor Hel',
    XWS = 'viktorhel-rogueclassstarfighter',
    Faction = 3,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    init = 4,
    texture = 'green',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['nomlumb-rogueclassstarfighter'] = {
    name = 'Nom Lumb',
    XWS = 'nomlumb-rogueclassstarfighter',
    Faction = 3,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    init = 1,
    texture = 'green',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['outerrimhunter'] = {
    name = 'Outer Rim Hunter',
    XWS = 'outerrimhunter',
    Faction = 3,
    ship_type = 'rogueclassstarfighter',
    init = 3,
    texture = 'green',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

-- Clone Z-95

masterPilotDB['hawk-clonez95headhunter'] = {
    name = '"Hawk"',
    XWS = 'hawk-clonez95headhunter',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    init = 4,
    limited = 1,
    texture = 'standard',
    addSqdAction = { 'BR', 'B' },
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['slider'] = {
    name = '"Slider"',
    XWS = 'slider',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    Charge = 2,
    init = 4,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
    executeOptions = {
        bbl2 = { 'bbl2', 'bbl2z' },
        bbr2 = { 'bbr2', 'bbr2z' },
    },
}

masterPilotDB['boost'] = {
    name = '"Boost"',
    XWS = 'boost',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    init = 3,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'B', 'TL' },
}

masterPilotDB['drift'] = {
    name = '"Drift"',
    XWS = 'drift',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    init = 3,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['stub'] = {
    name = '"Stub"',
    XWS = 'stub',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    init = 3,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['warthog-clonez95headhunter'] = {
    name = '"Warthog"',
    XWS = 'warthog-clonez95headhunter',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    init = 3,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['killer'] = {
    name = '"Killer"',
    XWS = 'killer',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    init = 2,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['knack'] = {
    name = '"Knack"',
    XWS = 'knack',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    init = 5,
    limited = 1,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['reapersquadronscout'] = {
    name = 'Reaper Squadron Scout',
    XWS = 'reapersquadronscout',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['7thskycorpspilot'] = {
    name = '7th Sky Corps Pilot',
    XWS = '7thskycorpspilot',
    Faction = 6,
    ship_type = 'clonez95headhunter',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'BR', 'TL', 'B' },
}

-- Missing ships
masterPilotDB['imperialsupercommando'] = {
    name = 'Imperial Super Commando',
    XWS = 'imperialsupercommando',
    Faction = 2,
    ship_type = 'gauntletfighter',
    init = 2,
    texture = 'imperial',
    actSet = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['outerrimenforcer'] = {
    name = 'Outer Rim Enforcer',
    XWS = 'outerrimenforcer',
    Faction = 3,
    ship_type = 'st70assaultship',
    init = 2,
    texture = 'guildbountyhunter',
    actSet = { 'F', 'TL', 'E', 'BR' },
}

-- Battle of Yavin standardized pilots

masterPilotDB['lukeskywalker-battleofyavin'] = {
    name = 'Luke Skywalker',
    XWS = 'lukeskywalker-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
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

masterPilotDB['wedgeantilles-battleofyavin'] = {
    name = 'Wedge Antilles',
    XWS = 'wedgeantilles-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
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

masterPilotDB['jekporkins-battleofyavin'] = {
    name = 'Jek Porkins',
    XWS = 'jekporkins-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
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

masterPilotDB['garvendreis-battleofyavin'] = {
    name = 'Garven Dreis',
    XWS = 'garvendreis-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
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

masterPilotDB['biggsdarklighter-battleofyavin'] = {
    name = 'Biggs Darklighter',
    XWS = 'biggsdarklighter-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
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

masterPilotDB['dextiree-battleofyavin'] = {
    name = 'Dex Tiree',
    XWS = 'dextiree-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 2,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR', 'B' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'dorsal turret', range = 2, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Dorsal Turret',         charge = 0 },
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'R4 Astromech',          charge = 0 },
    }
}

masterPilotDB['holokand-battleofyavin'] = {
    name = 'Hol Okand',
    XWS = 'holokand-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 4,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR', 'B' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'dorsal turret', range = 2, type = { 'singleturret' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Dorsal Turret',         charge = 0 },
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'Precise Astromech',     charge = 2 },
    }
}

masterPilotDB['popskrail-battleofyavin'] = {
    name = '"Pops" Krail',
    XWS = 'popskrail-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 4,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR', 'B' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' }, ion = true } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Cannon Turret',     charge = 0 },
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'R4 Astromech',          charge = 2 },
    }
}

masterPilotDB['hansolo-battleofyavin'] = {
    name = 'Han Solo',
    XWS = 'hansolo-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
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


masterPilotDB['darthvader-battleofyavin'] = {
    name = 'Darth Vader',
    XWS = 'darthvader-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
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

masterPilotDB['maulermithel-battleofyavin'] = {
    name = '"Mauler" Mithel',
    XWS = 'maulermithel-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator',     charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB['wampa-battleofyavin'] = {
    name = '"Wampa"',
    XWS = 'wampa-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
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

masterPilotDB['darkcurse-battleofyavin'] = {
    name = '"Dark Curse"',
    XWS = 'darkcurse-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
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

masterPilotDB['backstabber-battleofyavin'] = {
    name = '"Backstabber"',
    XWS = 'backstabber-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
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

masterPilotDB['idenversio-battleofyavin'] = {
    name = 'Iden Versio',
    XWS = 'idenversio-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    Shield = 1,
    ship_type = 'tieininterceptor',
    Charge = 2,
    init = 4,
    texture = 'the181',
    actSet = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator', charge = 0 },
        { name = 'Fanatic',  charge = 0 },
    }
}

masterPilotDB['sigma4-battleofyavin'] = {
    name = 'Sigma 4',
    XWS = 'sigma4-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
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

masterPilotDB['sigma5-battleofyavin'] = {
    name = 'Sigma 5',
    XWS = 'sigma5-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
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

masterPilotDB['sigma6-battleofyavin'] = {
    name = 'Sigma 6',
    XWS = 'sigma6-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
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

masterPilotDB['sigma7-battleofyavin'] = {
    name = 'Sigma 7',
    XWS = 'sigma7-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
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

masterPilotDB['dutchvander-battleofyavin'] = {
    name = '"Dutch" Vander',
    XWS = 'dutchvander-battleofyavin',
    title = 'Battle of Yavin',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 4,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR', 'B' },
    addSqdAction = { 'TL' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' }, ion = true } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Cannon Turret',     charge = 0 },
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'Targeting Astromech',   charge = 0 },
    }
}
-- Siege of corruscant

masterPilotDB['anakinskywalker-siegeofcoruscant'] = {
    name = 'Anakin Skywalker',
    XWS = 'anakinskywalker-siegeofcoruscant',
    title = 'Siege of Coruscant',
    limited = 1,
    Faction = 6,
    Force = 3,
    ship_type = 'eta2actis',
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

masterPilotDB['obiwankenobi-siegeofcoruscant'] = {
    name = 'Obi-Wan Kenobi',
    XWS = 'obiwankenobi-siegeofcoruscant',
    title = 'Siege of Coruscant',
    limited = 1,
    Faction = 6,
    Force = 3,
    ship_type = 'eta2actis',
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

masterPilotDB['shaakti-siegeofcoruscant'] = {
    name = 'Shaak Ti',
    XWS = 'shaakti-siegeofcoruscant',
    title = 'Siege of Coruscant',
    limited = 1,
    Faction = 6,
    Force = 2,
    ship_type = 'eta2actis',
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

masterPilotDB['axe-siegeofcoruscant'] = {
    name = '"Axe"',
    XWS = 'axe-siegeofcoruscant',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    title = 'Siege of Coruscant',
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

masterPilotDB['kickback-siegeofcoruscant'] = {
    name = '"Kickback"',
    XWS = 'kickback-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
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

masterPilotDB['contrail-siegeofcoruscant'] = {
    name = '"Contrail"',
    XWS = 'contrail-siegeofcoruscant',
    title = 'Siege of Coruscant',
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
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

masterPilotDB['jag-siegeofcoruscant'] = {
    name = '"Jag"',
    XWS = 'jag-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
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

masterPilotDB['wolffe-siegeofcoruscant'] = {
    name = '"Wolffe"',
    XWS = 'wolffe-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
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

masterPilotDB['oddball-siegeofcoruscant'] = {
    name = '"Odd Ball"',
    XWS = 'oddball-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 6,
    limited = 1,
    ship_type = 'arc170starfighter',
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

masterPilotDB['countdooku-siegeofcoruscant'] = {
    name = 'Count Dooku',
    XWS = 'countdooku-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 7,
    limited = 1,
    ship_type = 'sithinfiltrator',
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

masterPilotDB['dfs081-siegeofcoruscant'] = {
    name = 'DFS-081',
    XWS = 'dfs081-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 7,
    Charge = 2,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
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


masterPilotDB['dfs311-siegeofcoruscant'] = {
    name = 'DFS-311',
    XWS = 'dfs311-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 7,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
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

masterPilotDB['haorchallprototype-siegeofcoruscant'] = {
    name = 'Haor Chall Prototype',
    XWS = 'haorchallprototype-siegeofcoruscant',
    title = 'Siege of Coruscant',
    Faction = 7,
    limited = 2,
    ship_type = 'vultureclassdroidfighter',
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

masterPilotDB['adigallia'] = {
    name = 'Adi Gallia',
    XWS = 'adigallia',
    Faction = 6,
    ship_type = 'delta7aethersprite',
    Force = 2,
    init = 5,
    texture = 'plo',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
}

masterPilotDB['adigallia-delta7baethersprite'] = {
    name = 'Adi Gallia',
    XWS = 'adigallia-delta7baethersprite',
    Faction = 6,
    ship_type = 'delta7baethersprite',
    limited = 1,
    Force = 2,
    init = 5,
    texture = 'plo',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
}

masterPilotDB['corranhorn-t65xwing'] = {
    name = 'Corran Horn',
    XWS = 'corranhorn-t65xwing',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR' },
    addSqdAction = { 'TL' }
}

masterPilotDB['doctoraphra'] = {
    name = 'Doctor Aphra',
    XWS = 'doctoraphra',
    Faction = 3,
    limited = 1,
    ship_type = 'yv666lightfreighter',
    init = 3,
    Charge = 3,
    texture = 'aphra',
    actSet = { 'F', 'TL', 'R' },
}

masterPilotDB['durge'] = {
    name = 'Durge',
    XWS = 'durge',
    Faction = 3,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    init = 5,
    texture = 'durge',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['flightleaderubbel'] = {
    name = 'Flight Leader Ubbel',
    XWS = 'flightleaderubbel',
    limited = 1,
    Faction = 2,
    ship_type = 'tierbheavy',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB['gavynsykes'] = {
    name = 'Gavyn Sykes',
    XWS = 'gavynsykes',
    Faction = 6,
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    init = 3,
    texture = 'yellow',
    actSet = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB['hondoohnaka'] = {
    name = 'Hondo Ohnaka',
    XWS = 'hondoohnaka',
    Faction = 3,
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    init = 1,
    texture = 'blue',
    actSet = { 'F', 'R', 'TL', 'B', 'C' },
    addSqdAction = { 'F', 'R', 'TL', 'B' },
}

masterPilotDB['junoeclipse'] = {
    name = 'Juno Eclipse',
    XWS = 'junoeclipse',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
    init = 5,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB['keovenzee'] = {
    name = 'Keo Venzee',
    XWS = 'keovenzee',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
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

masterPilotDB['kitfisto'] = {
    name = 'Kit Fisto',
    XWS = 'kitfisto',
    limited = 1,
    Faction = 6,
    Force = 2,
    ship_type = 'eta2actis',
    init = 4,
    texture = 'kit',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['lapin'] = {
    name = 'Lapin',
    XWS = 'lapin',
    Faction = 3,
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['magnatolvan'] = {
    name = 'Magna Tolvan',
    XWS = 'magnatolvan',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR' }
}

masterPilotDB['popskrail'] = {
    name = '"Pops" Krail',
    XWS = 'popskrail',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 3,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR' },
}

masterPilotDB['secondsister'] = {
    name = 'Second Sister',
    XWS = 'secondsister',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
    Force = 2,
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['sicko'] = {
    name = '"Sicko"',
    XWS = 'sicko',
    limited = 1,
    Faction = 6,
    ship_type = 'laatigunship',
    Condition = 'Sickening Maneuver',
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

masterPilotDB['slammer'] = {
    name = '"Slammer"',
    XWS = 'slammer',
    Faction = 6,
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    init = 1,
    Charge = 2,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['torphun'] = {
    name = 'Tor Phun',
    XWS = 'torphun',
    Faction = 3,
    limited = 1,
    ship_type = 'fangfighter',
    init = 3,
    texture = 'new',
    actSet = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['tychocelchu'] = {
    name = 'Tycho Celchu',
    XWS = 'tychocelchu',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    init = 5,
    texture = 'arvel',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['wesjanson'] = {
    name = 'Wes Janson',
    XWS = 'wesjanson',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
    init = 5,
    Charge = 1,
    texture = 'wes',
    actSet = { 'F', 'TL', 'BR' },
}

masterPilotDB['yricaquell'] = {
    name = 'Yrica Quell',
    XWS = 'yricaquell',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB['takajamoreesa'] = {
    name = 'Taka Jamoreesa',
    XWS = 'takajamoreesa',
    Faction = 4,
    limited = 1,
    ship_type = 'resistancetransport',
    init = 2,
    texture = 'standard',
    actSet = { 'F', 'TL' }
}

masterPilotDB['zayversio'] = {
    name = 'Zay Versio',
    XWS = 'zayversio',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' }
}

masterPilotDB['venisadoza'] = {
    name = 'Venisa Doza',
    XWS = 'venisadoza',
    limited = 1,
    Faction = 4,
    ship_type = 't70xwing',
    addSlot = { 99 },
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B' },
    arcs = { fixed = { range = 3, type = { 'front', 'back' } } },
}

masterPilotDB['landocalrissian-scavengedyt1300'] = {
    name = "Lando Calrissian",
    XWS = 'landocalrissian-scavengedyt1300',
    Faction = 4,
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    init = 5,
    Charge = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['poedameron-scavengedyt1300'] = {
    name = "Poe Dameron",
    XWS = 'poedameron-scavengedyt1300',
    Faction = 4,
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    init = 6,
    Charge = 2,
    texture = 'standard',
    actSet = { 'F', 'TL', 'B', 'BR', 'Rot' }
}

masterPilotDB['theironassembler'] = {
    name = 'The Iron Assembler',
    XWS = 'theironassembler',
    Faction = 7,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    Charge = 3,
    init = 1,
    actSet = { 'C', 'BR', 'TL' },
    texture = 'proto',
}

masterPilotDB['kelrodoaiholdout'] = {
    name = 'Kelrodo-Ai Holdout',
    XWS = 'kelrodoaiholdout',
    Faction = 7,
    limited = 3,
    ship_type = 'vultureclassdroidfighter',
    init = 1,
    actSet = { 'F', 'BR', 'TL', 'C' },
    texture = 'proto',
}

masterPilotDB['aurrasing'] = {
    name = 'Aurra Sing',
    XWS = 'aurrasing',
    limited = 1,
    Faction = 7,
    Force = 1,
    ship_type = 'firesprayclasspatrolcraft',
    init = 4,
    texture = 'zam',
    actSet = { 'F', 'R', 'TL', 'B' },
}

masterPilotDB['agenttierny'] = {
    name = 'Agent Tierny',
    XWS = 'agenttierny',
    Faction = 5,
    limited = 1,
    Condition = 'Broken Trust',
    ship_type = 'xiclasslightshuttle',
    init = 3,
    texture = 'light',
    actSet = { 'F', 'TL' }
}

masterPilotDB['lingaava'] = {
    name = 'Lin Gaava',
    XWS = 'lingaava',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    Condition = 'Primed for Speed',
    init = 3,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['lieutenantgalek'] = {
    name = 'Lieutenant Galek',
    XWS = 'lieutenantgalek',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['dt798'] = {
    name = 'DT-798',
    XWS = 'dt798',
    limited = 1,
    Faction = 5,
    ship_type = 'tiefofighter',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['phlacarphoccprototype-siegeofcoruscant'] = {
    name = "Phlac-Arphocc Prototype",
    XWS = 'phlacarphoccprototype-siegeofcoruscant',
    title = "Siege of Coruscant",
    limited = 2,
    Faction = 7,
    ship_type = 'droidtrifighter',
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

masterPilotDB['dist81-siegeofcoruscant'] = {
    name = "DIS-T81",
    XWS = 'dist81-siegeofcoruscant',
    title = "Siege of Coruscant",
    limited = 1,
    Faction = 7,
    ship_type = 'droidtrifighter',
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

masterPilotDB['dis347-siegeofcoruscant'] = {
    name = "DIS-347",
    XWS = 'dis347-siegeofcoruscant',
    title = "Siege of Coruscant",
    limited = 1,
    Faction = 7,
    ship_type = 'droidtrifighter',
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

masterPilotDB['baktoidprototype-siegeofcoruscant'] = {
    name = 'Baktoid Prototype',
    XWS = 'baktoidprototype-siegeofcoruscant',
    title = "Siege of Coruscant",
    Faction = 7,
    limited = 2,
    ship_type = 'hyenaclassdroidbomber',
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

masterPilotDB['dbs404-siegeofcoruscant'] = {
    name = 'DBS-404',
    XWS = 'dbs404-siegeofcoruscant',
    title = "Siege of Coruscant",
    Faction = 7,
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
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

masterPilotDB['dbs32c-siegeofcoruscant'] = {
    name = 'DBS-32C',
    XWS = 'dbs32c-siegeofcoruscant',
    title = "Siege of Coruscant",
    Faction = 7,
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
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

masterPilotDB['volandas'] = {
    name = "Volan Das",
    XWS = 'volandas',
    limited = 1,
    Faction = 7,
    ship_type = 'droidtrifighter',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['durge-separatistalliance'] = {
    name = 'Durge',
    XWS = 'durge-separatistalliance',
    Faction = 7,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    Charge = 1,
    init = 5,
    texture = 'durge',
    actSet = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['klick-siegeofcoruscant'] = {
    name = '"Klick"',
    XWS = 'klick-siegeofcoruscant',
    title = "Siege of Coruscant",
    limited = 1,
    Faction = 6,
    ship_type = 'nimbusclassvwing',
    Charge = 1,
    init = 4,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' },
    Shield = 3,
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


masterPilotDB['juljerjerrod'] = {
    name = 'Jul Jerjerrod',
    XWS = 'juljerjerrod',
    Faction = 5,
    limited = 1,
    Charge = 3,
    ship_type = 'tiesebomber',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['lukeskywalker-swz106'] = {
    name = 'Luke Skywalker',
    XWS = 'lukeskywalker-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
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

masterPilotDB['jekporkins-swz106'] = {
    name = 'Jek Porkins',
    XWS = 'jekporkins-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
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

masterPilotDB['dutchvander-swz106'] = {
    name = '"Dutch" Vander',
    XWS = 'dutchvander-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 4,
    texture = 'gold',
    actSet = { 'F', 'TL', 'BR', 'B' },
    addSqdAction = { 'TL' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' }, ion = true } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Cannon Turret', charge = 0 },
        { name = 'Proton Bombs',      charge = 2 },
    }
}

masterPilotDB['hortonsalm-swz106'] = {
    name = 'Horton Salm',
    XWS = 'hortonsalm-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 'btla4ywing',
    init = 4,
    texture = 'horton',
    actSet = { 'F', 'TL', 'BR' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' }, ion = true } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Cannon Turret', charge = 0 },
        { name = 'Proximity Mines',   charge = 2 },
    }
}

masterPilotDB['arvelcrynyd-swz106'] = {
    name = 'Arvel Crynyd',
    XWS = 'arvelcrynyd-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    init = 3,
    texture = 'arvel',
    actSet = { 'F', 'TL', 'E', 'Ail', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator',     charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB['jakefarrell-swz106'] = {
    name = 'Jake Farrell',
    XWS = 'jakefarrell-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
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

masterPilotDB['sharabey-swz106'] = {
    name = 'Shara Bey',
    XWS = 'sharabey-swz106',
    title = 'Squadron Starter Pack',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    init = 4,
    texture = 'shara',
    actSet = { 'F', 'TL', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Hopeful',             charge = 0 },
        { name = 'Concussion Missiles', charge = 3 },
    }
}

masterPilotDB['darthvader-swz105'] = {
    name = 'Darth Vader',
    XWS = 'darthvader-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
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

masterPilotDB['maarekstele-swz105'] = {
    name = 'Maarek Stele',
    XWS = 'maarekstele-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tieadvancedx1',
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

masterPilotDB['captainjonus-swz105'] = {
    name = 'Captain Jonus',
    XWS = 'captainjonus-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
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

masterPilotDB['tomaxbren-swz105'] = {
    name = 'Tomax Bren',
    XWS = 'tomaxbren-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
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

masterPilotDB['nightbeast-swz105'] = {
    name = '"Night Beast"',
    XWS = 'nightbeast-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Disciplined', charge = 0 },
        { name = 'Predator',    charge = 0 },
    }
}

masterPilotDB['valenrudor-swz105'] = {
    name = 'Valen Rudor',
    XWS = 'valenrudor-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
    init = 3,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Disciplined',           charge = 0 },
        { name = 'Precision Ion Engines', charge = 2 },
    }
}

masterPilotDB['idenversio-swz105'] = {
    name = 'Iden Versio',
    XWS = 'idenversio-swz105',
    title = 'Squadron Starter Pack',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
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

masterPilotDB['deathfire-swz98'] = {
    name = '"Deathfire"',
    title = 'SL',
    XWS = 'deathfire-swz98',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
    Charge = 2,
    init = 2,
    texture = 'grey',
    actSet = { 'F', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Swift Approach', charge = 0 },
        { name = 'Conner Nets',    charge = 1 },
        { name = 'Proton Bombs',   charge = 2 },
    }
}

masterPilotDB['captainjonus-swz98'] = {
    name = 'Captain Jonus',
    title = 'SL',
    XWS = 'captainjonus-swz98',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
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

masterPilotDB['tomaxbren-swz98'] = {
    name = 'Tomax Bren',
    title = 'SL',
    XWS = 'tomaxbren-swz98',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
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


masterPilotDB['majorrhymer-swz98'] = {
    name = 'Major Rhymer',
    title = 'SL',
    XWS = 'majorrhymer-swz98',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
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

masterPilotDB['dashrendar-swz103-sl-rebelalliance'] = {
    name = 'Dash Rendar',
    title = 'Rebel (SL)',
    XWS = 'dashrendar-swz103-sl-rebelalliance',
    Faction = 1,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
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

masterPilotDB['dashrendar-swz103-sl-scumandvillainy'] = {
    name = 'Dash Rendar',
    title = 'Scum (SL)',
    XWS = 'dashrendar-swz103-sl-scumandvillainy',
    Faction = 3,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
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

masterPilotDB['leebo-swz103-sl-scumandvillainy'] = {
    name = '"Leebo"',
    title = 'Scum (SL)',
    XWS = 'leebo-swz103-sl-scumandvillainy',
    Faction = 3,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
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

masterPilotDB['leebo-swz103-sl-rebelalliance'] = {
    name = '"Leebo"',
    title = 'Rebel (SL)',
    XWS = 'leebo-swz103-sl-rebelalliance',
    Faction = 1,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
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

masterPilotDB['dashrendar-swz103-rebelalliance'] = {
    name = 'Dash Rendar',
    title = 'Rebel',
    XWS = 'dashrendar-swz103-rebelalliance',
    Faction = 1,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['dashrendar-swz103-scumandvillainy'] = {
    name = 'Dash Rendar',
    title = 'Scum',
    XWS = 'dashrendar-swz103-scumandvillainy',
    Faction = 3,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    init = 5,
    texture = 'standard',
    actSet = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['leebo-swz103-rebelalliance'] = {
    name = '"Leebo"',
    XWS = 'leebo-swz103-rebelalliance',
    title = 'Rebel',
    Faction = 1,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' }
}

masterPilotDB['leebo-swz103-scumandvillainy'] = {
    name = '"Leebo"',
    title = 'Scum',
    XWS = 'leebo-swz103-scumandvillainy',
    Faction = 3,
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    init = 3,
    texture = 'standard',
    actSet = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' }
}

--Battle over Endor Standardized Pilots

masterPilotDB['captainyorr-battleoverendor'] = {
    name = 'Captain Yorr',
    XWS = 'captainyorr-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    Charge = 2,
    ship_type = 'tiededefender',
    init = 4,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' },
    arcs = { fixed = { range = 3, type = { 'front' } }, weapon = { { name = 'Ion Cannon', range = 3, type = { 'front' }, ion = true } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',                  charge = 0 },
        { name = 'Predator',                   charge = 0 },
        { name = 'Ion Cannon',                 charge = 0 },
        { name = 'Computer Assisted Handling', charge = 1 }
    }
}

masterPilotDB['coloneljendon-battleoverendor'] = {
    name = 'Colonel Jendon',
    XWS = 'coloneljendon-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tiededefender',
    init = 6,
    texture = 'grey',
    actSet = { 'F', 'E', 'BR', 'TL', 'B' },
    arcs = { fixed = { range = 3, type = { 'front' } }, weapon = { { name = 'Proton Cannons', range = 2, type = { 'front' } } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',                  charge = 0 },
        { name = 'Push The Limit',             charge = 0 },
        { name = 'Proton Cannons',             charge = 2 },
        { name = 'Computer Assisted Handling', charge = 1 },
    }
}

masterPilotDB['lieutenanthebsly-battleoverendor'] = {
    name = 'Lieutenant Hebsly',
    XWS = 'lieutenanthebsly-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
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

masterPilotDB['majormianda-battleoverendor'] = {
    name = 'Major Mianda',
    XWS = 'majormianda-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
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

masterPilotDB['scythe6-battleoverendor'] = {
    name = 'Scythe 6',
    XWS = 'scythe6-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tielnfighter',
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

masterPilotDB['mausmonare-battleoverendor'] = {
    name = 'Maus Monare',
    XWS = 'mausmonare-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
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

masterPilotDB['sapphire2-battleoverendor'] = {
    name = 'Sapphire 2',
    XWS = 'sapphire2-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tieininterceptor',
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

masterPilotDB['soontirfel-battleoverendor'] = {
    name = 'Soontir Fel',
    XWS = 'soontirfel-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    Charge = 2,
    ship_type = 'tieininterceptor',
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

masterPilotDB['scimitar1-battleoverendor'] = {
    name = 'Scimitar 1',
    XWS = 'scimitar1-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
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

masterPilotDB['scimitar3-battleoverendor'] = {
    name = 'Scimitar 3',
    XWS = 'scimitar3-battleoverendor',
    title = 'Battle over Endor',
    Faction = 2,
    limited = 1,
    ship_type = 'tiesabomber',
    Bomb = true,
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

masterPilotDB['kendyidele-battleoverendor'] = {
    name = 'Kendy Idele',
    XWS = 'kendyidele-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
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

masterPilotDB['wedgeantilles-battleoverendor'] = {
    name = 'Wedge Antilles',
    XWS = 'wedgeantilles-battleoverendor',
    Faction = 1,
    limited = 1,
    title = 'Battle over Endor',
    ship_type = 't65xwing',
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

masterPilotDB['yendor-battleoverendor'] = {
    name = 'Yendor',
    XWS = 'yendor-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    ship_type = 't65xwing',
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

masterPilotDB['arvelcrynyd-battleoverendor'] = {
    name = 'Arvel Crynyd',
    XWS = 'arvelcrynyd-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    arcs = { turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
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

masterPilotDB['gemmersojan-battleoverendor'] = {
    name = 'Gemmer Sojan',
    XWS = 'gemmersojan-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    ship_type = 'rz1awing',
    arcs = {
        turret = { main = { name = 'primary', type = { 'front', 'back' } } },
        weapon = { { name = 'Precision-Tuned Cannons', range = 3, type = { 'front' } } }
    },
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

masterPilotDB['braylenstramm-battleoverendor'] = {
    name = 'Braylen Stramm',
    XWS = 'braylenstramm-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    Charge = 2,
    Shield = 5,
    ship_type = 'asf01bwing',
    Bomb = true,
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

masterPilotDB['adonfox-battleoverendor'] = {
    name = 'Adon Fox',
    XWS = 'adonfox-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    Charge = 2,
    ship_type = 'asf01bwing',
    Bomb = true,
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


masterPilotDB['ginamoonsong-battleoverendor'] = {
    name = 'Gina Moonsong',
    XWS = 'ginamoonsong-battleoverendor',
    Faction = 1,
    limited = 1,
    title = 'Battle over Endor',
    Shield = 5,
    Charge = 2,
    ship_type = 'asf01bwing',
    Bomb = true,
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

masterPilotDB['tychocelchu-battleoverendor'] = {
    name = 'Tycho Celchu',
    XWS = 'tychocelchu-battleoverendor',
    Faction = 1,
    limited = 1,
    title = 'Battle over Endor',
    Shield = 3,
    ship_type = 'rz1awing',
    arcs = { turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
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

masterPilotDB['landocalrissian-battleoverendor'] = {
    name = 'Lando Calrissian',
    XWS = 'landocalrissian-battleoverendor',
    title = 'Battle over Endor',
    Faction = 1,
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
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

masterPilotDB['echo-ssl'] = {
    name = '"Echo"',
    title = 'Copycat',
    XWS = 'echo-ssl',
    Faction = 2,
    limited = 1,
    Charge = 1,
    ship_type = 'tiephphantom',
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

masterPilotDB['whisper-ssl'] = {
    name = '"Whisper"',
    title = 'Unseen Assailant',
    XWS = 'whisper-ssl',
    Faction = 2,
    limited = 1,
    Charge = 2,
    ship_type = 'tiephphantom',
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

masterPilotDB['majorvynder-ssl'] = {
    name = 'Major Vynder',
    title = 'Helping Hand',
    XWS = 'majorvynder-ssl',
    Faction = 2,
    limited = 1,
    ship_type = 'alphaclassstarwing',
    init = 4,
    texture = 'standard',
    actSet = { 'F', 'TL' },
    arcs = { fixed = { range = 3, type = { 'front' } }, weapon = { { name = 'Ion Cannon', range = 3, type = { 'front' }, ion = true } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Long-Range Scanners',     charge = 2 },
        { name = 'Ion Cannon',              charge = 0 },
        { name = 'Heavy Plasma Missiles',   charge = 2 }
    }
}

masterPilotDB['lieutenantkarsabi-ssl'] = {
    name = 'Lieutenant Karsabi',
    title = 'Payload Courier',
    XWS = 'lieutenantkarsabi-ssl',
    Faction = 2,
    limited = 1,
    ship_type = 'alphaclassstarwing',
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


masterPilotDB['newrepublicpatrol-wartime'] = {
    name = 'New Republic Patrol',
    XWS = 'newrepublicpatrol-wartime',
    Faction = 4,
    ship_type = 'btanr2ywing-wartime',
    init = 3,
    texture = 'blue',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['kijimispicerunner-wartime'] = {
    name = 'Kijimi Spice Runner',
    XWS = 'kijimispicerunner-wartime',
    Faction = 4,
    ship_type = 'btanr2ywing-wartime',
    init = 2,
    texture = 'plain',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['tezanasz-wartime'] = {
    name = 'Teza Nasz',
    XWS = 'tezanasz-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 4,
    texture = 'teza',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['shasazaro-wartime'] = {
    name = 'Shasa Zaro',
    XWS = 'shasazaro-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 3,
    texture = 'red',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['coruskapellim-wartime'] = {
    name = 'Corus Kapellim',
    XWS = 'coruskapellim-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 1,
    texture = 'corus',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['caithrenalli-wartime'] = {
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

masterPilotDB['wilsateshlo-wartime'] = {
    name = 'Wilsa Teshlo',
    XWS = 'wilsateshlo-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 4,
    texture = 'wilsa',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['zoriibliss-wartime'] = {
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

masterPilotDB['aftabackbar-wartime'] = {
    name = 'Aftab Ackbar',
    XWS = 'aftabackbar-wartime',
    Faction = 4,
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    init = 2,
    texture = 'cai',
    actSet = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['legafossang-wartime'] = {
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

