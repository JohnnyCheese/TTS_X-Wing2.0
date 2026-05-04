masterPilotDB = {}
masterPilotDB[''] = {
    ['name'] = '',
    ['faction'] = 'dummy',
    ['ship_type'] = 0,
    ['slots'] = {},
    ['shield'] = 0,
    ['card'] = '',
    ['card_back'] = '',
    ['initiative'] = 0,
    ['action_set'] = {}
}



-- Huge ships
masterPilotDB['alderaanianguard'] = {
    name = 'Alderaanian Guard',
    faction = 'rebelalliance',
    ship_type = 'cr90corvette',
    initiative = 8,
    action_set = { 'F', 'TL', 'R' },
    texture = 'red'
}

masterPilotDB['republicjudiciary'] = {
    name = 'Republic Judiciary',
    faction = 'galacticrepublic',
    ship_type = 'cr90corvette',
    initiative = 8,
    action_set = { 'F', 'TL', 'R' },
    texture = 'blue'
}

masterPilotDB['separatistprivateers'] = {
    name = 'Separatist Privateers',
    faction = 'separatistalliance',
    ship_type = 'croccruiser',
    initiative = 7,
    action_set = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['syndicatesmugglers'] = {
    name = 'Syndicate Smugglers',
    faction = 'scumandvillainy',
    ship_type = 'croccruiser',
    initiative = 7,
    action_set = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['firstordersympathizers'] = {
    name = 'First Order Sympathizers',
    docking = true,
    faction = 'firstorder',
    ship_type = 'gozanticlasscruiser',
    initiative = 7,
    action_set = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['outerrimgarrison'] = {
    name = 'Outer Rim Garrison',
    docking = true,
    faction = 'galacticempire',
    ship_type = 'gozanticlasscruiser',
    initiative = 7,
    action_set = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['echobaseevacuees'] = {
    name = 'Echo Base Evacuees',
    faction = 'rebelalliance',
    ship_type = 'gr75mediumtransport',
    initiative = 7,
    action_set = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['newrepublicvolunteers'] = {
    name = 'New Republic Volunteers',
    faction = 'resistance',
    ship_type = 'gr75mediumtransport',
    initiative = 7,
    action_set = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['firstordercollaborators'] = {
    name = 'First Order Collaborators',
    faction = 'firstorder',
    ship_type = 'raiderclasscorvette',
    initiative = 8,
    action_set = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['outerrimpatrol'] = {
    name = 'Outer Rim Patrol',
    faction = 'galacticempire',
    ship_type = 'raiderclasscorvette',
    initiative = 8,
    action_set = { 'F', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['lawlesspirates'] = {
    name = 'Lawless Pirates',
    faction = 'scumandvillainy',
    ship_type = 'tridentclassassaultship',
    initiative = 8,
    action_set = { 'F', 'E', 'TL', 'R' },
    texture = 'standard'
}

masterPilotDB['colicoiddestroyer'] = {
    name = 'Colicoid Destroyer',
    faction = 'separatistalliance',
    ship_type = 'tridentclassassaultship',
    initiative = 8,
    action_set = { 'F', 'E', 'TL', 'R' },
    texture = 'standard'
}


masterPilotDB['wedgeantilles'] = {
    name = 'Wedge Antilles',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 6,
    texture = 'wedge',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['lukeskywalker'] = {
    name = 'Luke Skywalker',
    title = 'Red Five',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    force = 2,
    initiative = 5,
    texture = 'luke',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Light Side' }
}

masterPilotDB['thanekyrell'] = {
    name = 'Thane Kyrell',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 5,
    texture = 'thane',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['garvendreis-t65xwing'] = {
    name = 'Garven Dreis',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 4,
    texture = 'garven',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['jekporkins'] = {
    name = 'Jek Porkins',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 4,
    texture = 'porkins',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['kullbeesperado'] = {
    name = 'Kullbee Sperado',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 4,
    texture = 'renegade',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB['biggsdarklighter'] = {
    name = 'Biggs Darklighter',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 3,
    texture = 'biggs',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['leevantenza'] = {
    name = 'Leevan Tenza',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 3,
    texture = 'renegade',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB['edriotwotubes'] = {
    name = 'Edrio Two Tubes',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 2,
    texture = 'renegade',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB['redsquadronveteran'] = {
    name = 'Red Squadron Veteran',
    faction = 'rebelalliance',
    ship_type = 't65xwing',
    initiative = 3,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['bluesquadronescort'] = {
    name = 'Blue Squadron Escort',
    faction = 'rebelalliance',
    ship_type = 't65xwing',
    initiative = 2,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['cavernangelszealot'] = {
    name = 'Cavern Angels Zealot',
    faction = 'rebelalliance',
    ship_type = 't65xwing',
    initiative = 1,
    texture = 'renegade',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Partisan' }
}

masterPilotDB['norrawexley-btla4ywing'] = {
    name = 'Norra Wexley',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 5,
    texture = 'norra',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['dutchvander'] = {
    name = '"Dutch" Vander',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 4,
    texture = 'gold',
    add_squad_action = { 'TL' },
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['hortonsalm'] = {
    name = 'Horton Salm',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 4,
    texture = 'horton',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['evaanverlaine'] = {
    name = 'Evaan Verlaine',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 3,
    texture = 'gold',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['goldsquadronveteran'] = {
    name = 'Gold Squadron Veteran',
    faction = 'rebelalliance',
    ship_type = 'btla4ywing',
    initiative = 3,
    texture = 'gold',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['graysquadronbomber'] = {
    name = 'Gray Squadron Bomber',
    faction = 'rebelalliance',
    ship_type = 'btla4ywing',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['jakefarrell'] = {
    name = 'Jake Farrell',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 4,
    texture = 'jake',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['arvelcrynyd'] = {
    name = 'Arvel Crynyd',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 3,
    texture = 'arvel',
    action_set = { 'F', 'TL', 'E', 'Ail', 'BR' }
}

masterPilotDB['greensquadronpilot'] = {
    name = 'Green Squadron Pilot',
    faction = 'rebelalliance',
    ship_type = 'rz1awing',
    initiative = 3,
    texture = 'green',
    action_set = { 'F', 'TL', 'E', 'B', 'BR' }
}

masterPilotDB['phoenixsquadronpilot'] = {
    name = 'Phoenix Squadron Pilot',
    faction = 'rebelalliance',
    ship_type = 'rz1awing',
    initiative = 1,
    texture = 'jake',
    action_set = { 'F', 'TL', 'E', 'B', 'BR' }
}


masterPilotDB['herasyndulla-rz1awing'] = {
    name = 'Hera Syndulla',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 6,
    texture = 'hera',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' },
    keywords = { 'Spectre' }
}

masterPilotDB['wedgeantilles-rz1awing'] = {
    name = 'Wedge Antilles',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 4,
    texture = 'jake',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['derekklivian'] = {
    name = 'Derek Klivian',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 3,
    texture = 'jake',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['sharabey-rz1awing'] = {
    name = 'Shara Bey',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 4,
    texture = 'shara',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['ahsokatano-rz1awing'] = {
    name = 'Ahsoka Tano',
    faction = 'rebelalliance',
    limited = 1,
    force = 3,
    ship_type = 'rz1awing',
    initiative = 5,
    texture = 'jake',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' },
    keywords = { 'Light Side' }
}

masterPilotDB['sabinewren-rz1awing'] = {
    name = 'Sabine Wren',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 3,
    texture = 'sabines',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['braylenstramm'] = {
    name = 'Braylen Stramm',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'asf01bwing',
    initiative = 4,
    texture = 'braylen',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['tennumb'] = {
    name = 'Ten Numb',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'asf01bwing',
    initiative = 4,
    texture = 'tennumb',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['bladesquadronveteran'] = {
    name = 'Blade Squadron Veteran',
    faction = 'rebelalliance',
    ship_type = 'asf01bwing',
    initiative = 3,
    texture = 'blade',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['bluesquadronpilot'] = {
    name = 'Blue Squadron Pilot',
    faction = 'rebelalliance',
    ship_type = 'asf01bwing',
    initiative = 2,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['ginamoonsong'] = {
    name = 'Gina Moonsong',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'asf01bwing',
    initiative = 5,
    texture = 'gina',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['herasyndulla-asf01bwing'] = {
    name = 'Hera Syndulla',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'asf01bwing',
    initiative = 6,
    texture = 'hera',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB['netrempollard'] = {
    name = 'Netrem Pollard',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'asf01bwing',
    initiative = 3,
    texture = 'netrem',
    action_set = { 'F', 'TL', 'BR', 'Piv' }
}

masterPilotDB['airencracken'] = {
    name = 'Airen Cracken',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'z95af4headhunter',
    initiative = 5,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['lieutenantblount'] = {
    name = 'Lieutenant Blount',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'z95af4headhunter',
    initiative = 4,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['talasquadronpilot'] = {
    name = 'Tala Squadron Pilot',
    faction = 'rebelalliance',
    ship_type = 'z95af4headhunter',
    initiative = 2,
    texture = 'tala',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['banditsquadronpilot'] = {
    name = 'Bandit Squadron Pilot',
    faction = 'rebelalliance',
    ship_type = 'z95af4headhunter',
    initiative = 1,
    texture = 'bandit',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['wullffwarro'] = {
    name = 'Wullffwarro',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'auzituckgunship',
    initiative = 4,
    texture = 'cream',
    action_set = { 'F', 'R', 'BR' }
}

masterPilotDB['lowhhrick'] = {
    name = 'Lowhhrick',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'auzituckgunship',
    initiative = 3,
    texture = 'orange',
    action_set = { 'F', 'R', 'BR' }
}

masterPilotDB['kashyyykdefender'] = {
    name = 'Kashyyyk Defender',
    faction = 'rebelalliance',
    ship_type = 'auzituckgunship',
    initiative = 1,
    texture = 'cream',
    action_set = { 'F', 'R', 'BR' }
}

masterPilotDB['herasyndulla'] = {
    name = 'Hera Syndulla',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'attackshuttle',
    execute_options = {
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
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB['sabinewren'] = {
    name = 'Sabine Wren',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'attackshuttle',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'E', 'B', 'BR' },
    keywords = { 'Spectre', 'Mandalorian' }
}

masterPilotDB['ezrabridger'] = {
    name = 'Ezra Bridger',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'attackshuttle',
    force = 1,
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' },
    keywords = { 'Spectre', 'Light Side' }
}

masterPilotDB['zeborrelios'] = {
    name = '"Zeb" Orrelios',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'attackshuttle',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB['fennrau-sheathipedeclassshuttle'] = {
    name = 'Fenn Rau',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    initiative = 6,
    texture = 'standard',
    action_set = { 'F' },
    keywords = { 'Spectre', 'Mandalorian' }
}

masterPilotDB['ezrabridger-sheathipedeclassshuttle'] = {
    name = 'Ezra Bridger',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    force = 1,
    initiative = 3,
    texture = 'standard',
    action_set = { 'F' },
    keywords = { 'Spectre', 'Light Side' }
}

masterPilotDB['zeborrelios-sheathipedeclassshuttle'] = {
    name = '"Zeb" Orrelios',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F' },
    keywords = { 'Spectre' }
}

masterPilotDB['ap5'] = {
    name = 'AP-5',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'sheathipedeclassshuttle',
    initiative = 1,
    texture = 'standard',
    action_set = { 'C' },
    keywords = { 'Spectre', 'Droid' }
}

masterPilotDB['janors'] = {
    name = 'Jan Ors',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    initiative = 5,
    texture = 'brown',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['kylekatarn'] = {
    name = 'Kyle Katarn',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    initiative = 3,
    texture = 'brown',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['roarkgarnet'] = {
    name = 'Roark Garnet',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    initiative = 4,
    texture = 'brown',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['rebelscout'] = {
    name = 'Rebel Scout',
    faction = 'rebelalliance',
    ship_type = 'hwk290lightfreighter',
    initiative = 2,
    texture = 'brown',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['ezrabridger-tielnfighter'] = {
    name = 'Ezra Bridger',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'tielnfighter',
    force = 1,
    initiative = 3,
    texture = 'rebel',
    action_set = { 'F', 'E', 'BR' },
    keywords = { 'Light Side', 'Spectre' }
}

masterPilotDB['sabinewren-tielnfighter'] = {
    name = 'Sabine Wren',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 3,
    texture = 'rebel',
    action_set = { 'F', 'E', 'B', 'BR' },
    keywords = { 'Spectre', 'Mandalorian' }
}

masterPilotDB['captainrex'] = {
    name = 'Captain Rex',
    condition = 'Suppressive Fire',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 2,
    texture = 'rebel',
    action_set = { 'F', 'E', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['zeborrelios-tielnfighter'] = {
    name = '"Zeb" Orrelios',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 2,
    texture = 'rebel',
    action_set = { 'F', 'E', 'BR' },
    keywords = { 'Spectre' }
}

masterPilotDB['corranhorn'] = {
    name = 'Corran Horn',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'ewing',
    initiative = 5,
    texture = 'corran',
    action_set = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB['gavindarklighter'] = {
    name = 'Gavin Darklighter',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'ewing',
    initiative = 4,
    texture = 'gavin',
    action_set = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB['roguesquadronescort'] = {
    name = 'Rogue Squadron Escort',
    faction = 'rebelalliance',
    ship_type = 'ewing',
    initiative = 4,
    texture = 'rogue',
    action_set = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB['knavesquadronescort'] = {
    name = 'Knave Squadron Escort',
    faction = 'rebelalliance',
    ship_type = 'ewing',
    initiative = 2,
    texture = 'knave',
    action_set = { 'F', 'E', 'BR', 'B', 'TL' }
}

masterPilotDB['bodhirook'] = {
    name = 'Bodhi Rook',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'ut60duwing',
    initiative = 4,
    texture = 'captain',
    action_set = { 'F', 'TL' }
}

masterPilotDB['sawgerrera'] = {
    name = 'Saw Gerrera',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'ut60duwing',
    initiative = 4,
    texture = 'renegade',
    action_set = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB['cassianandor'] = {
    name = 'Cassian Andor',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'ut60duwing',
    initiative = 3,
    texture = 'captain',
    action_set = { 'F', 'TL' }
}

masterPilotDB['magvayarro'] = {
    name = 'Magva Yarro',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'ut60duwing',
    initiative = 3,
    texture = 'renegade',
    action_set = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB['benthictwotubes'] = {
    name = 'Benthic Two Tubes',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'ut60duwing',
    initiative = 2,
    texture = 'renegade',
    action_set = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB['hefftobber'] = {
    name = 'Heff Tobber',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'ut60duwing',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL' }
}

masterPilotDB['bluesquadronscout'] = {
    name = 'Blue Squadron Scout',
    faction = 'rebelalliance',
    ship_type = 'ut60duwing',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL' }
}

masterPilotDB['partisanrenegade'] = {
    name = 'Partisan Renegade',
    faction = 'rebelalliance',
    ship_type = 'ut60duwing',
    initiative = 1,
    texture = 'renegade',
    action_set = { 'F', 'TL' },
    keywords = { 'Partisan' }
}

masterPilotDB['k2so'] = {
    name = 'K-2SO',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'ut60duwing',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL' },
    keywords = { 'Droid' }
}


masterPilotDB['mirandadoni'] = {
    name = 'Miranda Doni',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btls8kwing',
    initiative = 4,
    texture = 'miranda',
    action_set = { 'F', 'TL', 'Rot' }
}

masterPilotDB['esegetuketu'] = {
    name = 'Esege Tuketu',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btls8kwing',
    initiative = 3,
    texture = 'esege',
    action_set = { 'F', 'TL', 'Rot' }
}

masterPilotDB['wardensquadronpilot'] = {
    name = 'Warden Squadron Pilot',
    faction = 'rebelalliance',
    ship_type = 'btls8kwing',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'Rot' }
}

masterPilotDB['norrawexley'] = {
    name = 'Norra Wexley',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'arc170starfighter',
    initiative = 5,
    texture = 'rebel',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['garvendreis'] = {
    name = 'Garven Dreis',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'arc170starfighter',
    initiative = 4,
    texture = 'rebel',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['sharabey'] = {
    name = 'Shara Bey',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'arc170starfighter',
    initiative = 4,
    texture = 'rebel',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['ibtisam'] = {
    name = 'Ibtisam',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'arc170starfighter',
    initiative = 3,
    texture = 'rebel',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['hansolo-modifiedyt1300lightfreighter'] = {
    name = 'Han Solo',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    initiative = 6,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['landocalrissian-modifiedyt1300lightfreighter'] = {
    name = 'Lando Calrissian',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['chewbacca'] = {
    name = 'Chewbacca',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    charge = 1,
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['outerrimsmuggler'] = {
    name = 'Outer Rim Smuggler',
    faction = 'rebelalliance',
    ship_type = 'modifiedyt1300lightfreighter',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['leiaorgana'] = {
    name = 'Leia Organa',
    force = 1,
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' },
    keywords = { 'Light Side' }
}

masterPilotDB['herasyndulla-vcx100lightfreighter'] = {
    name = 'Hera Syndulla',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    execute_options = {
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
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' },
    keywords = { 'Spectre' }
}

masterPilotDB['kananjarrus'] = {
    name = 'Kanan Jarrus',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    force = 2,
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' },
    keywords = { 'Jedi', 'Light Side', 'Spectre' }
}

masterPilotDB['chopper'] = {
    name = '"Chopper"',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'C', 'TL', 'R' },
    keywords = { 'Droid', 'Spectre' }
}

masterPilotDB['lothalrebel'] = {
    name = 'Lothal Rebel',
    faction = 'rebelalliance',
    ship_type = 'vcx100lightfreighter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' }
}

masterPilotDB['alexsandrkallus'] = {
    name = 'Alexsandr Kallus',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'vcx100lightfreighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' },
    keywords = { 'Spectre' }
}

masterPilotDB['dashrendar'] = {
    name = 'Dash Rendar',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['leebo'] = {
    name = '"Leebo"',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' }
}

masterPilotDB['wildspacefringer'] = {
    name = 'Wild Space Fringer',
    faction = 'rebelalliance',
    ship_type = 'yt2400lightfreighter',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['maulermithel'] = {
    name = '"Mauler" Mithel',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['howlrunner'] = {
    name = '"Howlrunner"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['scourgeskutu'] = {
    name = '"Scourge" Skutu',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['idenversio'] = {
    name = 'Iden Versio',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    shield = 0,
    charge = 1,
    initiative = 4,
    texture = 'inferno',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['gideonhask'] = {
    name = 'Gideon Hask',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 4,
    texture = 'inferno',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['delmeeko'] = {
    name = 'Del Meeko',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 4,
    texture = 'inferno',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['seynmarana'] = {
    name = 'Seyn Marana',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 4,
    texture = 'inferno',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['valenrudor'] = {
    name = 'Valen Rudor',
    faction = 'galacticempire',
    limited = 1,
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 3,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['nightbeast'] = {
    name = '"Night Beast"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['wampa'] = {
    name = '"Wampa"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    charge = 1,
    initiative = 1,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['blacksquadronace'] = {
    name = 'Black Squadron Ace',
    faction = 'galacticempire',
    ship_type = 'tielnfighter',
    initiative = 3,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['obsidiansquadronpilot'] = {
    name = 'Obsidian Squadron Pilot',
    faction = 'galacticempire',
    ship_type = 'tielnfighter',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['academypilot'] = {
    name = 'Academy Pilot',
    faction = 'galacticempire',
    ship_type = 'tielnfighter',
    initiative = 1,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['darthvader'] = {
    name = 'Darth Vader',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedx1',
    force = 3,
    initiative = 6,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB['maarekstele'] = {
    name = 'Maarek Stele',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedx1',
    initiative = 5,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['vedfoslo'] = {
    name = 'Ved Foslo',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedx1',
    execute_options = {
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
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['zertikstrom'] = {
    name = 'Zertik Strom',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedx1',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['stormsquadronace'] = {
    name = 'Storm Squadron Ace',
    faction = 'galacticempire',
    ship_type = 'tieadvancedx1',
    initiative = 3,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['tempestsquadronpilot'] = {
    name = 'Tempest Squadron Pilot',
    faction = 'galacticempire',
    ship_type = 'tieadvancedx1',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['grandinquisitor'] = {
    name = 'Grand Inquisitor',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedv1',
    force = 2,
    initiative = 5,
    texture = 'grey',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side' }
}

masterPilotDB['seventhsister'] = {
    name = 'Seventh Sister',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedv1',
    force = 2,
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['baronoftheempire'] = {
    name = 'Baron of the Empire',
    faction = 'galacticempire',
    ship_type = 'tieadvancedv1',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['inquisitor'] = {
    name = 'Inquisitor',
    faction = 'galacticempire',
    ship_type = 'tieadvancedv1',
    force = 1,
    initiative = 3,
    texture = 'grey',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['fifthbrother'] = {
    name = 'Fifth Brother',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedv1',
    force = 2,
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' }
}


masterPilotDB['soontirfel'] = {
    name = 'Soontir Fel',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    initiative = 6,
    texture = 'the181',
    action_set = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['turrphennir'] = {
    name = 'Turr Phennir',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    initiative = 4,
    texture = 'the181',
    action_set = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['sabersquadronace'] = {
    name = 'Saber Squadron Ace',
    faction = 'galacticempire',
    ship_type = 'tieininterceptor',
    initiative = 4,
    texture = 'the181',
    action_set = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['alphasquadronpilot'] = {
    name = 'Alpha Squadron Pilot',
    faction = 'galacticempire',
    ship_type = 'tieininterceptor',
    initiative = 1,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['cienaree'] = {
    name = 'Ciena Ree',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    initiative = 6,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['vultskerris-tieininterceptor'] = {
    name = 'Vult Skerris',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    charge = 1,
    initiative = 5,
    texture = 'skystrike',
    action_set = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['commandantgoran'] = {
    name = 'Commandant Goran',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    initiative = 4,
    texture = 'skystrike',
    action_set = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['gideonhask-tieininterceptor'] = {
    name = 'Gideon Hask',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['nashwindrider'] = {
    name = 'Nash Windrider',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    charge = 1,
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['lieutenantlorrir'] = {
    name = 'Lieutenant Lorrir',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    initiative = 3,
    texture = 'the181',
    action_set = { 'F', 'E', 'VR', 'B' }
}

masterPilotDB['tomaxbren'] = {
    name = 'Tomax Bren',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['captainjonus'] = {
    name = 'Captain Jonus',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    initiative = 4,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['majorrhymer'] = {
    name = 'Major Rhymer',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['deathfire'] = {
    name = '"Deathfire"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['gammasquadronace'] = {
    name = 'Gamma Squadron Ace',
    faction = 'galacticempire',
    ship_type = 'tiesabomber',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['scimitarsquadronpilot'] = {
    name = 'Scimitar Squadron Pilot',
    faction = 'galacticempire',
    ship_type = 'tiesabomber',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['majorvermeil'] = {
    name = 'Major Vermeil',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tierereaper',
    initiative = 4,
    texture = 'blue',
    action_set = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB['captainferoph'] = {
    name = 'Captain Feroph',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tierereaper',
    initiative = 3,
    texture = 'grey',
    action_set = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB['vizier'] = {
    name = '"Vizier"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tierereaper',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB['scarifbasepilot'] = {
    name = 'Scarif Base Pilot',
    faction = 'galacticempire',
    ship_type = 'tierereaper',
    initiative = 1,
    texture = 'grey',
    action_set = { 'F', 'E', 'Ail', 'B' }
}

masterPilotDB['duchess'] = {
    name = '"Duchess"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieskstriker',
    initiative = 5,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['countdown'] = {
    name = '"Countdown"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieskstriker',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['puresabacc'] = {
    name = '"Pure Sabacc"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieskstriker',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['blacksquadronscout'] = {
    name = 'Black Squadron Scout',
    faction = 'galacticempire',
    ship_type = 'tieskstriker',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['planetarysentinel'] = {
    name = 'Planetary Sentinel',
    faction = 'galacticempire',
    ship_type = 'tieskstriker',
    initiative = 1,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['vagabond'] = {
    name = '"Vagabond"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieskstriker',
    initiative = 2,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'Ail', 'B' }
}

masterPilotDB['rexlerbrath'] = {
    name = 'Rexler Brath',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiededefender',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['colonelvessery'] = {
    name = 'Colonel Vessery',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiededefender',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['countessryad'] = {
    name = 'Countess Ryad',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiededefender',
    initiative = 4,
    execute_options = {
        bs2 = { [1] = 'bs2', [2] = 'wk2' },
        bs3 = { [1] = 'bs3', [2] = 'wk3' },
        bs4 = { [1] = 'bs4', [2] = 'wk4' },
        bs5 = { [1] = 'bs5', [2] = 'wk5' }
    },
    texture = 'red',
    action_set = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['onyxsquadronace'] = {
    name = 'Onyx Squadron Ace',
    faction = 'galacticempire',
    ship_type = 'tiededefender',
    initiative = 4,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['deltasquadronpilot'] = {
    name = 'Delta Squadron Pilot',
    faction = 'galacticempire',
    ship_type = 'tiededefender',
    initiative = 1,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'TL', 'B' }
}


masterPilotDB['darthvader-tieddefender'] = {
    name = 'Darth Vader',
    faction = 'galacticempire',
    ship_type = 'tiededefender',
    force = 3,
    initiative = 6,
    texture = 'vader',
    action_set = { 'F', 'E', 'BR', 'TL', 'B' },
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB['vultskerris'] = {
    name = 'Vult Skerris',
    faction = 'galacticempire',
    ship_type = 'tiededefender',
    charge = 1,
    initiative = 5,
    texture = 'skystrike',
    action_set = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['captaindobbs'] = {
    name = 'Captain Dobbs',
    faction = 'galacticempire',
    ship_type = 'tiededefender',
    initiative = 3,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'TL', 'B' }
}

masterPilotDB['lieutenantkestal'] = {
    name = 'Lieutenant Kestal',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieagaggressor',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB['doubleedge'] = {
    name = '"Double Edge"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieagaggressor',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB['onyxsquadronscout'] = {
    name = 'Onyx Squadron Scout',
    faction = 'galacticempire',
    ship_type = 'tieagaggressor',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB['sienarspecialist'] = {
    name = 'Sienar Specialist',
    faction = 'galacticempire',
    ship_type = 'tieagaggressor',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB['whisper'] = {
    name = '"Whisper"',
    title = 'Soft-Spoken Slayer',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiephphantom',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB['echo'] = {
    name = '"Echo"',
    title = 'Slippery Trickster',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiephphantom',
    initiative = 4,
    texture = 'echo',
    action_set = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB['sigmasquadronace'] = {
    name = 'Sigma Squadron Ace',
    faction = 'galacticempire',
    ship_type = 'tiephphantom',
    initiative = 4,
    texture = 'sigma',
    action_set = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB['imdaartestpilot'] = {
    name = 'Imdaar Test Pilot',
    faction = 'galacticempire',
    ship_type = 'tiephphantom',
    initiative = 3,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'CL' }
}

masterPilotDB['majorvynder'] = {
    name = 'Major Vynder',
    title = 'Pragmatic Survivor',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'alphaclassstarwing',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL' }
}

masterPilotDB['lieutenantkarsabi'] = {
    name = 'Lieutenant Karsabi',
    title = 'Brash Noble',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'alphaclassstarwing',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL' }
}

masterPilotDB['rhosquadronpilot'] = {
    name = 'Rho Squadron Pilot',
    faction = 'galacticempire',
    ship_type = 'alphaclassstarwing',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL' }
}

masterPilotDB['nusquadronpilot'] = {
    name = 'Nu Squadron Pilot',
    faction = 'galacticempire',
    ship_type = 'alphaclassstarwing',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL' }
}

masterPilotDB['redline'] = {
    name = '"Redline"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiecapunisher',
    initiative = 5,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR', "B" }
}
masterPilotDB['deathrain'] = {
    name = '"Deathrain"',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiecapunisher',
    initiative = 4,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR', "B" }
}

masterPilotDB['cutlasssquadronpilot'] = {
    name = 'Cutlass Squadron Pilot',
    faction = 'galacticempire',
    ship_type = 'tiecapunisher',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR', "B" }
}

masterPilotDB['captainkagi'] = {
    name = 'Captain Kagi',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'lambdaclasst4ashuttle',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'R' }
}

masterPilotDB['coloneljendon'] = {
    name = 'Colonel Jendon',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'lambdaclasst4ashuttle',
    charge = 2,
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'R' }
}

masterPilotDB['lieutenantsai'] = {
    name = 'Lieutenant Sai',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'lambdaclasst4ashuttle',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'R' }
}

masterPilotDB['omicrongrouppilot'] = {
    name = 'Omicron Group Pilot',
    faction = 'galacticempire',
    ship_type = 'lambdaclasst4ashuttle',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'R' }
}

masterPilotDB['captainoicunn'] = {
    name = 'Captain Oicunn',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'vt49decimator',
    initiative = 3,
    texture = 'grey',
    action_set = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB['rearadmiralchiraneau'] = {
    name = 'Rear Admiral Chiraneau',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'vt49decimator',
    initiative = 5,
    texture = 'grey',
    action_set = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB['patrolleader'] = {
    name = 'Patrol Leader',
    faction = 'galacticempire',
    ship_type = 'vt49decimator',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB['mornakee'] = {
    name = 'Morna Kee',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'vt49decimator',
    charge = 3,
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'R', 'TL', 'Rot' }
}

masterPilotDB['bobafett'] = {
    name = 'Boba Fett',
    title = 'Notorious Bounty Hunter',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 5,
    texture = 'boba',
    action_set = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['emonazzameen'] = {
    name = 'Emon Azzameen',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 4,
    texture = 'emon',
    action_set = { 'F', 'R', 'TL', 'B' }
}

masterPilotDB['kathscarlet'] = {
    name = 'Kath Scarlet',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 4,
    texture = 'kath',
    action_set = { 'F', 'R', 'TL', 'B' }
}

masterPilotDB['koshkafrost'] = {
    name = 'Koshka Frost',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 3,
    texture = 'koshka',
    action_set = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['krassistrelix'] = {
    name = 'Krassis Trelix',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 3,
    texture = 'krassis',
    action_set = { 'F', 'R', 'TL', 'B' }
}

masterPilotDB['bountyhunter'] = {
    name = 'Bounty Hunter',
    faction = 'scumandvillainy',
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 2,
    texture = 'bountyhunter',
    action_set = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['fennrau'] = {
    name = 'Fenn Rau',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'fangfighter',
    initiative = 6,
    texture = 'new',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['oldteroch'] = {
    name = 'Old Teroch',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'fangfighter',
    initiative = 5,
    texture = 'new',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['joyrekkoff'] = {
    name = 'Joy Rekkoff',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'fangfighter',
    initiative = 4,
    texture = 'new',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['kadsolus'] = {
    name = 'Kad Solus',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'fangfighter',
    initiative = 4,
    texture = 'new',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['skullsquadronpilot'] = {
    name = 'Skull Squadron Pilot',
    faction = 'scumandvillainy',
    ship_type = 'fangfighter',
    initiative = 4,
    texture = 'new',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['zealousrecruit'] = {
    name = 'Zealous Recruit',
    faction = 'scumandvillainy',
    ship_type = 'fangfighter',
    initiative = 1,
    texture = 'new',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['constablezuvio'] = {
    name = 'Constable Zuvio',
    limited = 1,
    faction = 'scumandvillainy',
    ship_type = 'quadrijettransferspacetug',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['sarcoplank'] = {
    name = 'Sarco Plank',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'quadrijettransferspacetug',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['unkarplutt'] = {
    name = 'Unkar Plutt',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'quadrijettransferspacetug',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['jakkugunrunner'] = {
    name = 'Jakku Gunrunner',
    faction = 'scumandvillainy',
    ship_type = 'quadrijettransferspacetug',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['kavil'] = {
    name = 'Kavil',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 5,
    texture = 'kavil',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['drearenthal'] = {
    name = 'Drea Renthal',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 4,
    texture = 'drea',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['hiredgun'] = {
    name = 'Hired Gun',
    faction = 'scumandvillainy',
    ship_type = 'btla4ywing',
    initiative = 2,
    texture = 'hiredgun',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['crymorahgoon'] = {
    name = 'Crymorah Goon',
    faction = 'scumandvillainy',
    ship_type = 'btla4ywing',
    initiative = 1,
    texture = 'crymorah',
    action_set = { 'F', 'TL', 'BR' }
}


masterPilotDB['arlizhadrassian'] = {
    name = 'Arliz Hadrassian',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 4,
    texture = 'amaxine',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['leemakai'] = {
    name = 'Leema Kai',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 5,
    texture = 'jinata',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['padric'] = {
    name = 'Padric',
    faction = 'scumandvillainy',
    ship_type = 'btla4ywing',
    initiative = 3,
    texture = 'padric',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['amaxinewarrior'] = {
    name = 'Amaxine Warrior',
    faction = 'scumandvillainy',
    ship_type = 'btla4ywing',
    initiative = 3,
    texture = 'amaxine',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['jinatasecurityofficer'] = {
    name = 'Jinata Security Officer',
    faction = 'scumandvillainy',
    ship_type = 'btla4ywing',
    initiative = 2,
    texture = 'jinata',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['ndrusuhlak'] = {
    name = "N'dru Suhlak",
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'z95af4headhunter',
    initiative = 4,
    texture = 'ndru',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['kaatoleeachos'] = {
    name = "Kaa'to Leeachos",
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'z95af4headhunter',
    initiative = 3,
    texture = 'orange',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['nashtahpup'] = {
    name = 'Nashtah Pup',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'z95af4headhunter',
    initiative = 0,
    texture = 'nashtah',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['blacksunsoldier'] = {
    name = 'Black Sun Soldier',
    faction = 'scumandvillainy',
    ship_type = 'z95af4headhunter',
    initiative = 3,
    texture = 'blacksun',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['binayrepirate'] = {
    name = 'Binayre Pirate',
    faction = 'scumandvillainy',
    ship_type = 'z95af4headhunter',
    initiative = 1,
    texture = 'pirate',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['bossk-z95af4headhunter'] = {
    name = 'Bossk',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'z95af4headhunter',
    initiative = 4,
    texture = 'bossk',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['dacebonearm'] = {
    name = 'Dace Bonearm',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    charge = 3,
    initiative = 4,
    texture = 'brown',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['palobgodalhi'] = {
    name = 'Palob Godalhi',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    initiative = 3,
    texture = 'brown',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['torkilmux'] = {
    name = 'Torkil Mux',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    initiative = 2,
    texture = 'brown',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['spicerunner'] = {
    name = 'Spice Runner',
    faction = 'scumandvillainy',
    ship_type = 'hwk290lightfreighter',
    initiative = 1,
    texture = 'brown',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}


masterPilotDB['kananjarrus-hwk290lightfreighter'] = {
    name = 'Kanan Jarrus',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    force = 1,
    initiative = 3,
    texture = 'black',
    action_set = { 'F', 'TL', 'B', 'Rot' },
    keywords = { 'Jedi', 'Light Side' }
}

masterPilotDB['gamutkey'] = {
    name = 'Gamut Key',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    charge = 2,
    initiative = 3,
    texture = 'black',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['tapusk'] = {
    name = 'Tápusk',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'hwk290lightfreighter',
    charge = 2,
    initiative = 5,
    texture = 'black',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['guri'] = {
    name = 'Guri',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'starviperclassattackplatform',
    initiative = 5,
    texture = 'white',
    action_set = { 'C', 'F', 'TL', 'B', 'VR' },
    keywords = { 'Droid' }
}

masterPilotDB['dalanoberos-starviperclassattackplatform'] = {
    name = 'Dalan Oberos',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'starviperclassattackplatform',
    initiative = 4,
    texture = 'red',
    action_set = { 'F', 'TL', 'B', 'VR', 'Piv' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['princexizor'] = {
    name = 'Prince Xizor',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'starviperclassattackplatform',
    initiative = 4,
    texture = 'white',
    action_set = { 'F', 'TL', 'B', 'VR' }
}

masterPilotDB['blacksunassassin'] = {
    name = 'Black Sun Assassin',
    faction = 'scumandvillainy',
    ship_type = 'starviperclassattackplatform',
    initiative = 3,
    texture = 'red',
    action_set = { 'F', 'TL', 'B', 'VR' }
}

masterPilotDB['blacksunenforcer'] = {
    name = 'Black Sun Enforcer',
    faction = 'scumandvillainy',
    ship_type = 'starviperclassattackplatform',
    initiative = 2,
    texture = 'white',
    action_set = { 'F', 'TL', 'B', 'VR' }
}

masterPilotDB['serissu'] = {
    name = 'Serissu',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'm3ainterceptor',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 5,
    texture = 'tansarii',
    action_set = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['genesisred'] = {
    name = 'Genesis Red',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'm3ainterceptor',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 4,
    texture = 'genesis',
    action_set = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['laetinashera'] = {
    name = "Laetin A'shera",
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'm3ainterceptor',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 3,
    texture = 'cartel',
    action_set = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['quinnjast'] = {
    name = 'Quinn Jast',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'm3ainterceptor',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 3,
    texture = 'tansarii',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['inaldra'] = {
    name = 'Inaldra',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'm3ainterceptor',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 2,
    texture = 'tansarii',
    action_set = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['sunnybounder'] = {
    name = 'Sunny Bounder',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'm3ainterceptor',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 1,
    texture = 'sunny',
    action_set = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['tansariipointveteran'] = {
    name = 'Tansarii Point Veteran',
    faction = 'scumandvillainy',
    ship_type = 'm3ainterceptor',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 3,
    texture = 'tansarii',
    action_set = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['cartelspacer'] = {
    name = 'Cartel Spacer',
    faction = 'scumandvillainy',
    ship_type = 'm3ainterceptor',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 1,
    texture = 'cartel',
    action_set = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['g4rgorvm'] = {
    name = 'G4R-G0R V/M',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'm3ainterceptor',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 0,
    texture = 'gargor',
    action_set = { 'C', 'E', 'TL', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB['talonbanecobra'] = {
    name = 'Talonbane Cobra',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'kihraxzfighter',
    initiative = 5,
    texture = 'talonbane',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['graz'] = {
    name = 'Graz',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'kihraxzfighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['viktorhel'] = {
    name = 'Viktor Hel',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'kihraxzfighter',
    initiative = 4,
    texture = 'green',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['captainjostero'] = {
    name = 'Captain Jostero',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'kihraxzfighter',
    initiative = 3,
    texture = 'orange',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['blacksunace'] = {
    name = 'Black Sun Ace',
    faction = 'scumandvillainy',
    ship_type = 'kihraxzfighter',
    initiative = 3,
    texture = 'blacksun',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['cartelmarauder'] = {
    name = 'Cartel Marauder',
    faction = 'scumandvillainy',
    ship_type = 'kihraxzfighter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['ig88a'] = {
    name = 'IG-88A',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB['ig88b'] = {
    name = 'IG-88B',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB['ig88c'] = {
    name = 'IG-88C',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB['ig88d'] = {
    name = 'IG-88D',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'aggressorassaultfighter',
    execute_options = {
        rbl3s = { [1] = 'rtl3s', [2] = 'rbl3s', [3] = 'rk3' },
        rbr3s = { [1] = 'rk3', [2] = 'rbr3s', [3] = 'rtr3s' }
    },
    initiative = 4,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'B' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB['4lom'] = {
    name = '4-LOM',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'g1astarfighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL' },
    keywords = { 'Droid', 'Bounty Hunter' }
}

masterPilotDB['zuckuss'] = {
    name = 'Zuckuss',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'g1astarfighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['gandfindsman'] = {
    name = 'Gand Findsman',
    faction = 'scumandvillainy',
    ship_type = 'g1astarfighter',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['captainnym'] = {
    name = 'Captain Nym',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'scurrgh6bomber',
    charge = 1,
    initiative = 5,
    texture = 'orange',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['solsixxa'] = {
    name = 'Sol Sixxa',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'scurrgh6bomber',
    initiative = 3,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['lokrevenant'] = {
    name = 'Lok Revenant',
    faction = 'scumandvillainy',
    ship_type = 'scurrgh6bomber',
    initiative = 2,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['toranikulda'] = {
    name = 'Torani Kulda',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'm12lkimogilafighter',
    initiative = 4,
    texture = 'torani',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['dalanoberos'] = {
    name = 'Dalan Oberos',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'm12lkimogilafighter',
    charge = 2,
    initiative = 3,
    texture = 'dalan',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['cartelexecutioner'] = {
    name = 'Cartel Executioner',
    faction = 'scumandvillainy',
    ship_type = 'm12lkimogilafighter',
    initiative = 3,
    texture = 'cartel',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['bossk'] = {
    name = 'Bossk',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'yv666lightfreighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['moraloeval'] = {
    name = 'Moralo Eval',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'yv666lightfreighter',
    charge = 2,
    initiative = 4,
    texture = 'moralo',
    action_set = { 'F', 'TL', 'R' }
}

masterPilotDB['lattsrazzi'] = {
    name = 'Latts Razzi',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'yv666lightfreighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['trandoshanslaver'] = {
    name = 'Trandoshan Slaver',
    faction = 'scumandvillainy',
    ship_type = 'yv666lightfreighter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' }
}

masterPilotDB['dengar'] = {
    name = 'Dengar',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'jumpmaster5000',
    charge = 1,
    initiative = 6,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['manaroo'] = {
    name = 'Manaroo',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'jumpmaster5000',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['teltrevura'] = {
    name = 'Tel Trevura',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'jumpmaster5000',
    charge = 1,
    initiative = 4,
    texture = 'tel',
    action_set = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['contractedscout'] = {
    name = 'Contracted Scout',
    faction = 'scumandvillainy',
    ship_type = 'jumpmaster5000',
    initiative = 2,
    texture = 'scout',
    action_set = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['nomlumb'] = {
    name = 'Nom Lumb',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'jumpmaster5000',
    initiative = 1,
    texture = 'nom',
    action_set = { 'F', 'TL', 'BR', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['ketsuonyo'] = {
    name = 'Ketsu Onyo',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'lancerclasspursuitcraft',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['asajjventress'] = {
    name = 'Asajj Ventress',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'lancerclasspursuitcraft',
    force = 2,
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Bounty Hunter', 'Dark Side' }
}

masterPilotDB['sabinewren-lancerclasspursuitcraft'] = {
    name = 'Sabine Wren',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'lancerclasspursuitcraft',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['shadowporthunter'] = {
    name = 'Shadowport Hunter',
    faction = 'scumandvillainy',
    ship_type = 'lancerclasspursuitcraft',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'Rot' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['hansolo'] = {
    name = 'Han Solo',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'customizedyt1300lightfreighter',
    initiative = 6,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['landocalrissian'] = {
    name = 'Lando Calrissian',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'customizedyt1300lightfreighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['l337'] = {
    name = 'L3-37',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'customizedyt1300lightfreighter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'C', 'TL', 'B', 'Rot' },
    keywords = { 'Droid' }
}

masterPilotDB['freightercaptain'] = {
    name = 'Freighter Captain',
    faction = 'scumandvillainy',
    ship_type = 'customizedyt1300lightfreighter',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['landocalrissian-escapecraft'] = {
    name = 'Lando Calrissian',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'escapecraft',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'BR' }
}

masterPilotDB['outerrimpioneer'] = {
    name = 'Outer Rim Pioneer',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'escapecraft',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'BR' }
}

masterPilotDB['l337-escapecraft'] = {
    name = 'L3-37',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'escapecraft',
    initiative = 2,
    texture = 'standard',
    action_set = { 'C', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB['autopilotdrone'] = {
    name = 'Autopilot Drone',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'escapecraft',
    charge = 3,
    initiative = 1,
    texture = 'standard',
    action_set = { 'C', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB['midnight'] = {
    name = '"Midnight"',
    limited = 1,
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    shield = 1,
    initiative = 6,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['scorch'] = {
    name = '"Scorch"',
    limited = 1,
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['static'] = {
    name = '"Static"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiefofighter',
    shield = 1,
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['longshot'] = {
    name = '"Longshot"',
    limited = 1,
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    shield = 1,
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['muse'] = {
    limited = 1,
    name = '"Muse"',
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    shield = 1,
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['null'] = {
    limited = 1,
    name = '"Null"',
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    shield = 1,
    initiative = 0,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['omegasquadronace'] = {
    name = 'Omega Squadron Ace',
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    shield = 1,
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['zetasquadronpilot'] = {
    name = 'Zeta Squadron Pilot',
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    shield = 1,
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['epsilonsquadroncadet'] = {
    name = 'Epsilon Squadron Cadet',
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    shield = 1,
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['quickdraw'] = {
    limited = 1,
    name = '"Quickdraw"',
    faction = 'firstorder',
    ship_type = 'tiesffighter',
    charge = 1,
    initiative = 6,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['backdraft'] = {
    limited = 1,
    name = '"Backdraft"',
    faction = 'firstorder',
    ship_type = 'tiesffighter',
    shield = 3,
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['omegasquadronexpert'] = {
    name = 'Omega Squadron Expert',
    faction = 'firstorder',
    ship_type = 'tiesffighter',
    shield = 3,
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['zetasquadronsurvivor'] = {
    name = 'Zeta Squadron Survivor',
    faction = 'firstorder',
    ship_type = 'tiesffighter',
    shield = 3,
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['lieutenantlehuse'] = {
    name = 'Lieutenant LeHuse',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiesffighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['captainphasma'] = {
    name = 'Captain Phasma',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiesffighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR', 'Rot' }
}

masterPilotDB['majorstridan'] = {
    name = 'Major Stridan',
    limited = 1,
    faction = 'firstorder',
    ship_type = 'upsilonclasscommandshuttle',
    shield = 6,
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' }
}

masterPilotDB['lieutenanttavson'] = {
    name = 'Lieutenant Tavson',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    shield = 6,
    charge = 2,
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' }
}

masterPilotDB['lieutenantdormitz'] = {
    name = 'Lieutenant Dormitz',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    shield = 6,
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' }
}

masterPilotDB['starkillerbasepilot'] = {
    name = 'Starkiller Base Pilot',
    faction = 'firstorder',
    ship_type = 'upsilonclasscommandshuttle',
    shield = 6,
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' }
}

masterPilotDB['kyloren'] = {
    name = 'Kylo Ren',
    condition = "I'll Show You the Dark Side",
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tievnsilencer',
    shield = 2,
    force = 2,
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side' }
}

masterPilotDB['blackout'] = {
    name = '"Blackout"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tievnsilencer',
    shield = 2,
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB['firstordertestpilot'] = {
    name = 'First Order Test Pilot',
    faction = 'firstorder',
    ship_type = 'tievnsilencer',
    shield = 2,
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB['sienarjaemusengineer'] = {
    name = 'Sienar-Jaemus Engineer',
    faction = 'firstorder',
    ship_type = 'tievnsilencer',
    shield = 2,
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB['rush'] = {
    name = '"Rush"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tievnsilencer',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'B', 'TL', 'BR' }
}

masterPilotDB['poedameron'] = {
    name = 'Poe Dameron',
    title = 'Trigger-Happy Flyboy',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    charge = 1,
    initiative = 6,
    texture = 'blackone',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['elloasty'] = {
    name = 'Ello Asty',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['niennunb'] = {
    name = 'Nien Nunb',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['karekun'] = {
    name = 'Kare Kun',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'Dare' }
}

masterPilotDB['temminwexley'] = {
    name = 'Temmin Wexley',
    title = 'Snap',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['jessikapava'] = {
    name = 'Jessika Pava',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    charge = 1,
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['jophseastriker'] = {
    name = 'Joph Seastriker',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['redsquadronexpert'] = {
    name = 'Red Squadron Expert',
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['bluesquadronrookie'] = {
    name = 'Blue Squadron Rookie',
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}


masterPilotDB['nimichireen'] = {
    name = 'Nimi Chireen',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' },
}

masterPilotDB['caithrenalli'] = {
    name = "C'ai Threnalli",
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'E' },
    movethrough = true
}


masterPilotDB['temminwexley-swz68'] = {
    name = "Temmin Wexley",
    title = "Black Two",
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 4,
    texture = 'snap',
    action_set = { 'F', 'TL', 'B' },
    add_squad_action = { 'C' }
}

masterPilotDB['poedameron-swz68'] = {
    name = "Poe Dameron",
    title = "Resistance Commander",
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    charge = 2,
    initiative = 6,
    texture = 'commanderpoe',
    action_set = { 'F', 'TL', 'B' },
}

masterPilotDB['hansolo-scavengedyt1300'] = {
    name = "Han Solo",
    faction = 'resistance',
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    initiative = 6,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['rey'] = {
    name = "Rey",
    faction = 'resistance',
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    force = 2,
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'Rot' },
    keywords = { 'Light Side' }
}

masterPilotDB['chewbacca-scavengedyt1300'] = {
    name = "Chewbacca",
    faction = 'resistance',
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['resistancesympathizer'] = {
    name = "Resistance Sympathizer",
    faction = 'resistance',
    ship_type = 'scavengedyt1300lightfreighter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['finchdallow'] = {
    name = "Finch Dallow",
    faction = 'resistance',
    limited = 1,
    ship_type = 'mg100starfortress',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'Rot' }
}

masterPilotDB['benteene'] = {
    name = "Ben Teene",
    condition = "Rattled",
    faction = 'resistance',
    limited = 1,
    ship_type = 'mg100starfortress',
    initiative = 3,
    texture = 'vennie',
    action_set = { 'F', 'TL', 'Rot' }
}

masterPilotDB['cat'] = {
    name = "Cat",
    faction = 'resistance',
    limited = 1,
    ship_type = 'mg100starfortress',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL', 'Rot' }
}

masterPilotDB['cobaltsquadronbomber'] = {
    name = "Cobalt Squadron Bomber",
    faction = 'resistance',
    ship_type = 'mg100starfortress',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL', 'Rot' }
}

masterPilotDB['lulolampar'] = {
    name = "L'ulo L'ampar",
    faction = 'resistance',
    limited = 1,
    ship_type = 'rz2awing',
    initiative = 5,
    texture = 'orange',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['tallissanlintra'] = {
    name = "Tallissan Lintra",
    faction = 'resistance',
    limited = 1,
    ship_type = 'rz2awing',
    charge = 1,
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['greersonnel'] = {
    name = "Greer Sonnel",
    faction = 'resistance',
    limited = 1,
    ship_type = 'rz2awing',
    initiative = 4,
    texture = 'orange',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['zaribangel'] = {
    name = "Zari Bangel",
    faction = 'resistance',
    limited = 1,
    ship_type = 'rz2awing',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['greensquadronexpert'] = {
    name = "Green Squadron Expert",
    faction = 'resistance',
    ship_type = 'rz2awing',
    initiative = 3,
    texture = 'red',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['bluesquadronrecruit'] = {
    name = "Blue Squadron Recruit",
    faction = 'resistance',
    ship_type = 'rz2awing',
    initiative = 1,
    texture = 'blue',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['zizitlo'] = {
    name = "Zizi Tlo",
    faction = 'resistance',
    limited = 1,
    ship_type = 'rz2awing',
    charge = 1,
    initiative = 5,
    texture = 'red',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['ronithblario'] = {
    name = "Ronith Blario",
    faction = 'resistance',
    limited = 1,
    ship_type = 'rz2awing',
    initiative = 2,
    texture = 'red',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}


masterPilotDB['seftinvanik'] = {
    name = "Seftin Vanik",
    limited = 1,
    faction = 'resistance',
    ship_type = 'rz2awing',
    initiative = 5,
    texture = 'green',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['merlcobben'] = {
    name = "Merl Cobben",
    limited = 1,
    faction = 'resistance',
    ship_type = 'rz2awing',
    initiative = 1,
    texture = 'blue',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}

masterPilotDB['suralindajavos'] = {
    name = "Suralinda Javos",
    limited = 1,
    faction = 'resistance',
    ship_type = 'rz2awing',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR', 'Piv' }
}

masterPilotDB['wrobietyce'] = {
    name = "Wrobie Tyce",
    limited = 1,
    faction = 'resistance',
    ship_type = 'rz2awing',
    initiative = 4,
    texture = 'green',
    action_set = { 'F', 'TL', 'Rot180', 'E', 'B', 'BR' }
}


masterPilotDB['foremanproach'] = {
    name = 'Foreman Proach',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['ahhav'] = {
    name = 'Ahhav',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['captainseevor'] = {
    name = 'Captain Seevor',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    charge = 1,
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['overseeryushyn'] = {
    name = 'Overseer Yushyn',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    charge = 1,
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['miningguildsurveyor'] = {
    name = 'Mining Guild Surveyor',
    faction = 'scumandvillainy',
    ship_type = 'modifiedtielnfighter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['miningguildsentry'] = {
    name = 'Mining Guild Sentry',
    faction = 'scumandvillainy',
    ship_type = 'modifiedtielnfighter',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['edonkappehl'] = {
    name = "Edon Kappehl",
    faction = 'resistance',
    limited = 1,
    ship_type = 'mg100starfortress',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'Rot' }
}

masterPilotDB['vennie'] = {
    name = "Vennie",
    faction = 'resistance',
    limited = 1,
    ship_type = 'mg100starfortress',
    initiative = 2,
    texture = 'vennie',
    action_set = { 'F', 'TL', 'Rot' }
}

masterPilotDB['paigetico'] = {
    name = "Paige Tico",
    faction = 'resistance',
    limited = 1,
    ship_type = 'mg100starfortress',
    charge = 1,
    initiative = 5,
    texture = 'paige',
    action_set = { 'F', 'TL', 'Rot' }
}

masterPilotDB['lieutenantbastian'] = {
    name = 'Lieutenant Bastian',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['jaycristubbs'] = {
    name = 'Jaycris Tubbs',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['blacksquadronace-t70xwing'] = {
    name = 'Black Squadron Ace',
    faction = 'resistance',
    ship_type = 't70xwing',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['commandermalarus'] = {
    name = 'Commander Malarus',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiefofighter',
    charge = 2,
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['tn3465'] = {
    name = 'TN-3465',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiefofighter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['lieutenantrivas'] = {
    name = 'Lieutenant Rivas',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiefofighter',
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' }
}

masterPilotDB['recoil'] = {
    name = '"Recoil"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tievnsilencer',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'B', 'TL', 'BR' }
}

masterPilotDB['avenger'] = {
    name = '"Avenger"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tievnsilencer',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'B', 'TL', 'BR' }
}

masterPilotDB['captaincardinal'] = {
    name = 'Captain Cardinal',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    charge = 2,
    initiative = 4,
    texture = 'red',
    action_set = { 'F', 'TL', 'R' }
}

masterPilotDB['pettyofficerthanisson'] = {
    name = 'Petty Officer Thanisson',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'upsilonclasscommandshuttle',
    charge = 1,
    initiative = 1,
    texture = 'standard',
    action_set = { 'F', 'TL', 'R' }
}

--w3pilot

masterPilotDB['generalgrievous'] = {
    name = 'General Grievous',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'belbulab22starfighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'BR' }
}

masterPilotDB['wattambor'] = {
    name = 'Wat Tambor',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'belbulab22starfighter',
    initiative = 3,
    action_set = { 'F', 'TL', 'B', 'BR' },
    texture = 'wat',
}

masterPilotDB['captainsear'] = {
    name = 'Captain Sear',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'belbulab22starfighter',
    initiative = 2,
    action_set = { 'F', 'TL', 'B', 'BR' },
    texture = 'standard',
}
masterPilotDB['skakoanace'] = {
    name = 'Skakoan Ace',
    faction = 'separatistalliance',
    ship_type = 'belbulab22starfighter',
    initiative = 3,
    action_set = { 'F', 'TL', 'B', 'BR' },
    texture = 'standard',
}

masterPilotDB['feethanottrawautopilot'] = {
    name = 'Feethan Ottraw Autopilot',
    faction = 'separatistalliance',
    ship_type = 'belbulab22starfighter',
    initiative = 1,
    action_set = { 'C', 'TL', 'B', 'BR' },
    texture = 'standard',
    keywords = { 'Droid' }
}

masterPilotDB['separatistdrone'] = {
    name = 'Separatist Drone',
    faction = 'separatistalliance',
    ship_type = 'vultureclassdroidfighter',
    initiative = 3,
    action_set = { 'C', 'BR', 'TL' },
    texture = 'drone',
}

masterPilotDB['tradefederationdrone'] = {
    name = 'Trade Federation Drone',
    faction = 'separatistalliance',
    ship_type = 'vultureclassdroidfighter',
    initiative = 1,
    action_set = { 'C', 'BR', 'TL' },
    texture = 'drone',
}

masterPilotDB['dfs081'] = {
    name = 'DFS-081',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    initiative = 3,
    action_set = { 'C', 'BR', 'TL' },
    texture = 'dfs081',
}

masterPilotDB['precisehunter'] = {
    name = 'Precise Hunter',
    faction = 'separatistalliance',
    limited = 3,
    ship_type = 'vultureclassdroidfighter',
    initiative = 3,
    action_set = { 'C', 'BR', 'TL' },
    texture = 'hunter',
}

masterPilotDB['dfs311'] = {
    name = 'DFS-311',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    initiative = 1,
    action_set = { 'C', 'BR', 'TL' },
    texture = 'dfs311',
}

masterPilotDB['haorchallprototype'] = {
    name = 'Haor Chall Prototype',
    faction = 'separatistalliance',
    limited = 2,
    ship_type = 'vultureclassdroidfighter',
    initiative = 1,
    action_set = { 'C', 'BR', 'TL' },
    texture = 'proto',
}

masterPilotDB['darthmaul'] = {
    name = 'Darth Maul',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'sithinfiltrator',
    force = 3,
    initiative = 5,
    action_set = { 'F', 'TL', 'BR' },
    texture = 'maul',
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB['countdooku'] = {
    name = 'Count Dooku',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'sithinfiltrator',
    force = 3,
    initiative = 3,
    action_set = { 'F', 'TL', 'BR' },
    texture = 'standard',
    keywords = { 'Dark Side', 'Sith' }
}

masterPilotDB['066'] = {
    name = 'O-66',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'sithinfiltrator',
    initiative = 3,
    action_set = { 'C', 'TL', 'BR' },
    texture = 'standard',
    keywords = { 'Droid' }
}

masterPilotDB['darkcourier'] = {
    name = 'Dark Courier',
    faction = 'separatistalliance',
    ship_type = 'sithinfiltrator',
    initiative = 2,
    action_set = { 'F', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB['anakinskywalker'] = {
    name = 'Anakin Skywalker',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7aethersprite',
    force = 3,
    initiative = 6,
    texture = 'anakin',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['luminaraunduli'] = {
    name = 'Luminara Unduli',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7aethersprite',
    force = 2,
    initiative = 4,
    texture = 'lumi',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['barrissoffee'] = {
    name = 'Barriss Offee',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7aethersprite',
    force = 1,
    initiative = 4,
    texture = 'barriss',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['ahsokatano'] = {
    name = 'Ahsoka Tano',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7aethersprite',
    force = 2,
    initiative = 3,
    texture = 'ahsoka',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['obiwankenobi'] = {
    name = 'Obi-Wan Kenobi',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7aethersprite',
    force = 3,
    initiative = 5,
    texture = 'obi',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['macewindu'] = {
    name = 'Mace Windu',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7aethersprite',
    force = 3,
    initiative = 4,
    texture = 'mace',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['plokoon'] = {
    name = 'Plo Koon',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7aethersprite',
    force = 2,
    initiative = 5,
    texture = 'plo',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['saeseetiin'] = {
    name = 'Saesee Tiin',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7aethersprite',
    force = 2,
    initiative = 4,
    texture = 'saesee',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['jediknight'] = {
    name = 'Jedi Knight',
    faction = 'galacticrepublic',
    ship_type = 'delta7aethersprite',
    force = 1,
    initiative = 3,
    texture = 'knight',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    --tint_friendly = {mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/Small/delta7aethersprite/Jedi_Delta7_tint.obj',
    --                texture = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships/Small/GRP_Delta7/JediKnight-tint.png',}
}

masterPilotDB['oddball'] = {
    name = '"Odd Ball"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['kickback'] = {
    name = '"Kickback"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['axe'] = {
    name = '"Axe"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['swoop'] = {
    name = '"Swoop"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['tucker'] = {
    name = '"Tucker"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['bluesquadronprotector'] = {
    name = 'Blue Squadron Protector',
    faction = 'galacticrepublic',
    ship_type = 'v19torrentstarfighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['goldsquadrontrooper'] = {
    name = 'Gold Squadron Trooper',
    faction = 'galacticrepublic',
    ship_type = 'v19torrentstarfighter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['oddball-arc170starfighter'] = {
    name = '"Odd Ball"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'arc170starfighter',
    initiative = 5,
    texture = 'republic',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['wolffe'] = {
    name = '"Wolffe"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'arc170starfighter',
    charge = 1,
    initiative = 4,
    texture = 'republic',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['jag'] = {
    name = '"Jag"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'arc170starfighter',
    initiative = 3,
    texture = 'republic',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['sinker'] = {
    name = '"Sinker"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'arc170starfighter',
    initiative = 3,
    texture = 'republic',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['squadsevenveteran'] = {
    name = 'Squad Seven Veteran',
    faction = 'galacticrepublic',
    ship_type = 'arc170starfighter',
    initiative = 3,
    texture = 'republic',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['104thbattalionpilot'] = {
    name = '104th Battalion Pilot',
    faction = 'galacticrepublic',
    ship_type = 'arc170starfighter',
    initiative = 2,
    texture = 'republic',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

--w4 Pilots
--N-1
masterPilotDB['ricolie'] = {
    name = 'Ric Olié',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    initiative = 5,
    texture = 'yellow',
    action_set = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB['anakinskywalker-nabooroyaln1starfighter'] = {
    name = 'Anakin Skywalker',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    force = 1,
    initiative = 4,
    texture = 'yellow',
    action_set = { 'F', 'TL', 'B', 'BR', 'E' },
    keywords = { 'Light Side' }
}

masterPilotDB['padmeamidala'] = {
    name = 'Padmé Amidala',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    initiative = 4,
    texture = 'silver',
    action_set = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB['dineeellberger'] = {
    name = 'Dineé Ellberger',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    initiative = 3,
    texture = 'yellow',
    action_set = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB['naboohandmaiden'] = {
    name = 'Naboo Handmaiden',
    faction = 'galacticrepublic',
    limited = 2,
    ship_type = 'nabooroyaln1starfighter',
    initiative = 1,
    condition = 'Decoyed',
    texture = 'yellow',
    action_set = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB['bravoflightofficer'] = {
    name = 'Bravo Flight Officer',
    faction = 'galacticrepublic',
    ship_type = 'nabooroyaln1starfighter',
    initiative = 2,
    texture = 'yellow',
    action_set = { 'F', 'TL', 'B', 'BR', 'E' }
}

--Resistance Transport
masterPilotDB['covanell'] = {
    name = 'Cova Nell',
    faction = 'resistance',
    limited = 1,
    ship_type = 'resistancetransport',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL' }
}

masterPilotDB['pammichnerrogoode'] = {
    name = 'Pammich Nerro Goode',
    faction = 'resistance',
    limited = 1,
    ship_type = 'resistancetransport',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL' }
}

masterPilotDB['nodinchavdri'] = {
    name = 'Nodin Chavdri',
    faction = 'resistance',
    limited = 1,
    ship_type = 'resistancetransport',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL' }
}

masterPilotDB['logisticsdivisionpilot'] = {
    name = 'Logistics Division Pilot',
    faction = 'resistance',
    ship_type = 'resistancetransport',
    initiative = 1,
    texture = 'red',
    action_set = { 'F', 'TL' }
}

masterPilotDB['rosetico'] = {
    name = 'Rose Tico',
    faction = 'resistance',
    limited = 1,
    ship_type = 'resistancetransportpod',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['bb8'] = {
    name = 'BB-8',
    faction = 'resistance',
    limited = 1,
    ship_type = 'resistancetransportpod',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR', 'B' },
    keywords = { 'Droid' }
}

masterPilotDB['finn'] = {
    name = 'Finn',
    faction = 'resistance',
    limited = 1,
    ship_type = 'resistancetransportpod',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['vimoradi'] = {
    name = 'Vi Moradi',
    faction = 'resistance',
    limited = 1,
    ship_type = 'resistancetransportpod',
    initiative = 1,
    condition = "Compromising Intel",
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR' }
}

masterPilotDB['dbs404'] = {
    name = 'DBS-404',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
    initiative = 4,
    action_set = { 'C', 'TL', 'BR' },
    texture = 'fourohfour',
}

masterPilotDB['dbs32c'] = {
    name = 'DBS-32C',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
    initiative = 3,
    action_set = { 'C', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB['bombardmentdrone'] = {
    name = 'Bombardment Drone',
    faction = 'separatistalliance',
    limited = 3,
    ship_type = 'hyenaclassdroidbomber',
    initiative = 3,
    action_set = { 'C', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB['baktoidprototype'] = {
    name = 'Baktoid Prototype',
    faction = 'separatistalliance',
    limited = 2,
    ship_type = 'hyenaclassdroidbomber',
    initiative = 1,
    action_set = { 'C', 'TL', 'BR' },
    texture = 'baktoid',
}

masterPilotDB['separatistbomber'] = {
    name = 'Separatist Bomber',
    faction = 'separatistalliance',
    ship_type = 'hyenaclassdroidbomber',
    initiative = 3,
    action_set = { 'C', 'TL', 'BR' },
    texture = 'standard',
}

masterPilotDB['technounionbomber'] = {
    name = 'Techno Union Bomber',
    faction = 'separatistalliance',
    ship_type = 'hyenaclassdroidbomber',
    initiative = 1,
    action_set = { 'C', 'TL', 'BR' },
    texture = 'baktoid',
}

--Republic Y-Wing
masterPilotDB['anakinskywalker-btlbywing'] = {
    name = 'Anakin Skywalker',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'btlbywing',
    force = 3,
    initiative = 6,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['oddball-btlbywing'] = {
    name = '"Odd Ball"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'btlbywing',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['matchstick'] = {
    name = '"Matchstick"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'btlbywing',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['broadside'] = {
    name = '"Broadside"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'btlbywing',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['r2d2'] = {
    name = 'R2-D2',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'btlbywing',
    initiative = 2,
    texture = 'green',
    action_set = { 'C', 'TL', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB['goji'] = {
    name = '"Goji"',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'btlbywing',
    initiative = 2,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['shadowsquadronveteran'] = {
    name = 'Shadow Squadron Veteran',
    faction = 'galacticrepublic',
    ship_type = 'btlbywing',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['redsquadronbomber'] = {
    name = 'Red Squadron Bomber',
    faction = 'galacticrepublic',
    ship_type = 'btlbywing',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR' },
    keywords = { 'Clone' }
}

--Nantex
masterPilotDB['sunfac'] = {
    name = 'Sun Fac',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    initiative = 6,
    action_set = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB['berwerkret'] = {
    name = 'Berwer Kret',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    initiative = 5,
    action_set = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB['chertek'] = {
    name = 'Chertek',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    initiative = 4,
    action_set = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB['gorgol'] = {
    name = 'Gorgol',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'nantexclassstarfighter',
    initiative = 2,
    action_set = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB['petranakiarenaace'] = {
    name = 'Petranaki Arena Ace',
    faction = 'separatistalliance',
    ship_type = 'nantexclassstarfighter',
    initiative = 4,
    action_set = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

masterPilotDB['stalgasinhiveguard'] = {
    name = 'Stalgasin Hive Guard',
    faction = 'separatistalliance',
    ship_type = 'nantexclassstarfighter',
    initiative = 3,
    action_set = { 'F', 'E', 'Nantex' },
    texture = 'standard',
}

--w7
--TIE/ba
masterPilotDB['firstorderprovocateur'] = {
    name = 'First Order Provocateur',
    faction = 'firstorder',
    ship_type = 'tiebainterceptor',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['ember'] = {
    name = '"Ember"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiebainterceptor',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['holo'] = {
    name = '"Holo"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiebainterceptor',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['majorvonreg'] = {
    name = 'Major Vonreg',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiebainterceptor',
    initiative = 6,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' }
}

--FireBall
masterPilotDB['jarekyeager'] = {
    name = 'Jarek Yeager',
    faction = 'resistance',
    limited = 1,
    ship_type = 'fireball',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['kazudaxiono'] = {
    name = 'Kazuda Xiono',
    faction = 'resistance',
    limited = 1,
    ship_type = 'fireball',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['r1j5'] = {
    name = 'R1-J5',
    faction = 'resistance',
    limited = 1,
    ship_type = 'fireball',
    initiative = 1,
    texture = 'standard',
    action_set = { 'C', 'E', 'BR' },
    keywords = { 'Droid' }
}

masterPilotDB['colossusstationmechanic'] = {
    name = 'Colossus Station Mechanic',
    faction = 'resistance',
    ship_type = 'fireball',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['commandermalarus-xiclasslightshuttle'] = {
    name = 'Commander Malarus',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'xiclasslightshuttle',
    initiative = 5,
    texture = 'light',
    action_set = { 'F', 'TL' }
}

masterPilotDB['gideonhask-xiclasslightshuttle'] = {
    name = 'Gideon Hask',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'xiclasslightshuttle',
    initiative = 4,
    texture = 'light',
    action_set = { 'F', 'TL' }
}

masterPilotDB['agentterex'] = {
    name = 'Agent Terex',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'xiclasslightshuttle',
    initiative = 3,
    texture = 'dark',
    action_set = { 'F', 'TL' }
}

masterPilotDB['firstordercourier'] = {
    name = 'First Order Courier',
    faction = 'firstorder',
    ship_type = 'xiclasslightshuttle',
    initiative = 2,
    texture = 'light',
    action_set = { 'F', 'TL' }
}

masterPilotDB['hawk'] = {
    name = '"Hawk"',
    limited = 1,
    faction = 'galacticrepublic',
    ship_type = 'laatigunship',
    initiative = 4,
    texture = 'munilist',
    action_set = { 'F', 'R', 'TL', 'Rot' },
    add_squad_action = { 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB['warthog'] = {
    name = '"Warthog"',
    limited = 1,
    faction = 'galacticrepublic',
    ship_type = 'laatigunship',
    initiative = 3,
    texture = 'warthog',
    action_set = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' }
}

masterPilotDB['hound'] = {
    name = '"Hound"',
    limited = 1,
    faction = 'galacticrepublic',
    ship_type = 'laatigunship',
    initiative = 2,
    texture = 'hound1',
    action_set = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' }
}

masterPilotDB['212thbattalionpilot'] = {
    name = '212th Battalion Pilot',
    faction = 'galacticrepublic',
    ship_type = 'laatigunship',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' }
}

masterPilotDB['onderonoppressor'] = {
    name = 'Onderon Oppressor',
    limited = 2,
    faction = 'separatistalliance',
    ship_type = 'hmpdroidgunship',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR' },
}

masterPilotDB['geonosianprototype'] = {
    name = 'Geonosian Prototype',
    limited = 2,
    faction = 'separatistalliance',
    ship_type = 'hmpdroidgunship',
    initiative = 2,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR' },
}

masterPilotDB['dgs047'] = {
    name = 'DGS-047',
    limited = 1,
    faction = 'separatistalliance',
    ship_type = 'hmpdroidgunship',
    initiative = 1,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR' },
}

masterPilotDB['dgs286'] = {
    name = 'DGS-286',
    limited = 1,
    faction = 'separatistalliance',
    ship_type = 'hmpdroidgunship',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR' },
}

masterPilotDB['separatistpredator'] = {
    name = 'Separatist Predator',
    faction = 'separatistalliance',
    ship_type = 'hmpdroidgunship',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR' },
}

masterPilotDB['baktoiddrone'] = {
    name = 'Baktoid Drone',
    faction = 'separatistalliance',
    ship_type = 'hmpdroidgunship',
    initiative = 1,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR' },
}

masterPilotDB['rampage'] = {
    name = '"Rampage"',
    limited = 1,
    faction = 'galacticempire',
    ship_type = 'tierbheavy',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB['lyttandree'] = {
    name = 'Lyttan Dree',
    limited = 1,
    faction = 'galacticempire',
    ship_type = 'tierbheavy',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB['onyxsquadronsentry'] = {
    name = 'Onyx Squadron Sentry',
    faction = 'galacticempire',
    ship_type = 'tierbheavy',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB['caridaacademycadet'] = {
    name = 'Carida Academy Cadet',
    faction = 'galacticempire',
    ship_type = 'tierbheavy',
    initiative = 1,
    texture = 'grey',
    action_set = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB['anakinskywalker-eta2actis'] = {
    name = 'Anakin Skywalker',
    limited = 1,
    faction = 'galacticrepublic',
    force = 3,
    ship_type = 'eta2actis',
    initiative = 6,
    texture = 'anakin',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Dark Side', 'Light Side', 'Jedi' }
}

masterPilotDB['obiwankenobi-eta2actis'] = {
    name = 'Obi-Wan Kenobi',
    limited = 1,
    faction = 'galacticrepublic',
    force = 3,
    ship_type = 'eta2actis',
    initiative = 5,
    texture = 'obi',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['aaylasecura'] = {
    name = 'Aayla Secura',
    limited = 1,
    faction = 'galacticrepublic',
    force = 2,
    ship_type = 'eta2actis',
    initiative = 5,
    texture = 'aayla',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['shaakti'] = {
    name = 'Shaak Ti',
    limited = 1,
    faction = 'galacticrepublic',
    force = 2,
    ship_type = 'eta2actis',
    initiative = 4,
    texture = 'shaak',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['yoda'] = {
    name = 'Yoda',
    limited = 1,
    faction = 'galacticrepublic',
    force = 3,
    ship_type = 'eta2actis',
    initiative = 3,
    texture = 'yoda',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    mesh = "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/eta2actis-Yoda.obj"
}

masterPilotDB['jedigeneral'] = {
    name = 'Jedi General',
    faction = 'galacticrepublic',
    force = 2,
    ship_type = 'eta2actis',
    initiative = 4,
    texture = 'jedi',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['oddball-nimbusclassvwing'] = {
    name = '"Odd Ball"',
    limited = 1,
    faction = 'galacticrepublic',
    ship_type = 'nimbusclassvwing',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB['contrail'] = {
    name = '"Contrail"',
    limited = 1,
    faction = 'galacticrepublic',
    ship_type = 'nimbusclassvwing',
    initiative = 5,
    texture = 'contrail',
    action_set = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB['klick'] = {
    name = '"Klick"',
    limited = 1,
    faction = 'galacticrepublic',
    ship_type = 'nimbusclassvwing',
    charge = 1,
    initiative = 4,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB['wilhufftarkin'] = {
    name = 'Wilhuff Tarkin',
    limited = 1,
    faction = 'galacticrepublic',
    ship_type = 'nimbusclassvwing',
    initiative = 3,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR', 'B' },
}

masterPilotDB['shadowsquadronescort'] = {
    name = 'Shadow Squadron Escort',
    faction = 'galacticrepublic',
    ship_type = 'nimbusclassvwing',
    initiative = 3,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' }
}

masterPilotDB['loyalistvolunteer'] = {
    name = 'Loyalist Volunteer',
    faction = 'galacticrepublic',
    ship_type = 'nimbusclassvwing',
    initiative = 2,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR', 'B' },
}

masterPilotDB['phlacarphoccprototype'] = {
    name = "Phlac-Arphocc Prototype",
    limited = 2,
    faction = 'separatistalliance',
    ship_type = 'droidtrifighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['dist81'] = {
    name = "DIS-T81",
    limited = 1,
    faction = 'separatistalliance',
    ship_type = 'droidtrifighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['dis347'] = {
    name = "DIS-347",
    limited = 1,
    faction = 'separatistalliance',
    ship_type = 'droidtrifighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['fearsomepredator'] = {
    name = "Fearsome Predator",
    limited = 3,
    faction = 'separatistalliance',
    ship_type = 'droidtrifighter',
    condition = "Fearful Prey",
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['separatistinterceptor'] = {
    name = "Separatist Interceptor",
    faction = 'separatistalliance',
    ship_type = 'droidtrifighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['colicoidinterceptor'] = {
    name = "Colicoid Interceptor",
    faction = 'separatistalliance',
    ship_type = 'droidtrifighter',
    initiative = 1,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['jangofett'] = {
    name = 'Jango Fett',
    limited = 1,
    faction = 'separatistalliance',
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 6,
    texture = 'jango',
    action_set = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['zamwesell'] = {
    name = 'Zam Wesell',
    limited = 1,
    faction = 'separatistalliance',
    condition = 'Zam Wesell',
    charge = 4,
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 5,
    texture = 'zam',
    action_set = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['bobafett-firesprayclasspatrolcraft'] = {
    name = 'Boba Fett',
    title = 'Survivor',
    limited = 1,
    faction = 'separatistalliance',
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 3,
    texture = 'jango',
    action_set = { 'F', 'R', 'TL', 'B' },
    keywords = { 'Bounty Hunter' }
}

masterPilotDB['separatistracketeer'] = {
    name = 'Separatist Racketeer',
    faction = 'separatistalliance',
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 2,
    texture = 'zam',
    action_set = { 'F', 'R', 'TL', 'B' }
}

-- Tie Whisper

masterPilotDB['709thlegionace'] = {
    name = '709th Legion Ace',
    faction = 'firstorder',
    ship_type = 'tiewiwhispermodifiedinterceptor',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['wrath'] = {
    name = '"Wrath"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['whirlwind'] = {
    name = '"Whirlwind"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['nightfall'] = {
    name = '"Nightfall"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' },
    movethrough = true
}

masterPilotDB['kyloren-tiewiwhispermodifiedinterceptor'] = {
    name = 'Kylo Ren',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiewiwhispermodifiedinterceptor',
    initiative = 5,
    force = 3,
    texture = 'standard',
    action_set = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['redfuryzealot'] = {
    name = 'Red Fury Zealot',
    faction = 'firstorder',
    ship_type = 'tiewiwhispermodifiedinterceptor',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'Rot', 'E', 'TL', 'BR', 'B' }
}

-- First Order Bomber

masterPilotDB['firstordercadet'] = {
    name = 'First Order Cadet',
    faction = 'firstorder',
    ship_type = 'tiesebomber',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['sienarjaemustestpilot'] = {
    name = 'Sienar-Jaemus Test Pilot',
    faction = 'firstorder',
    ship_type = 'tiesebomber',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['grudge'] = {
    name = '"Grudge"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiesebomber',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['scorch-tiesebomber'] = {
    name = '"Scorch"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiesebomber',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['breach'] = {
    name = '"Breach"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiesebomber',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['dread'] = {
    name = '"Dread"',
    faction = 'firstorder',
    limited = 1,
    ship_type = 'tiesebomber',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B', 'E' }
}

-- Resistance Y-Wing

masterPilotDB['newrepublicpatrol'] = {
    name = 'New Republic Patrol',
    faction = 'resistance',
    ship_type = 'btanr2ywing',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['kijimispicerunner'] = {
    name = 'Kijimi Spice Runner',
    faction = 'resistance',
    ship_type = 'btanr2ywing',
    initiative = 2,
    texture = 'plain',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['tezanasz'] = {
    name = 'Teza Nasz',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing',
    initiative = 4,
    texture = 'teza',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['shasazaro'] = {
    name = 'Shasa Zaro',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing',
    initiative = 3,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['coruskapellim'] = {
    name = 'Corus Kapellim',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing',
    initiative = 1,
    texture = 'corus',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['caithrenalli-btanr2ywing'] = {
    name = "C'ai Threnalli",
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing',
    initiative = 2,
    texture = 'cai',
    action_set = { 'F', 'TL', 'BR', 'B', 'C', 'E' },
    movethrough = true
}

masterPilotDB['wilsateshlo'] = {
    name = 'Wilsa Teshlo',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing',
    initiative = 4,
    texture = 'wilsa',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['zoriibliss'] = {
    name = 'Zorii Bliss',
    charge = 1,
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing',
    initiative = 5,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['aftabackbar'] = {
    name = 'Aftab Ackbar',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing',
    initiative = 2,
    texture = 'cai',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['legafossang'] = {
    name = 'Lega Fossang',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing',
    initiative = 3,
    texture = 'lega',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}


--- NEW SHIT:
masterPilotDB['fennrau-fangfighter'] = {
    name = 'Fenn Rau',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'fangfighter',
    initiative = 6,
    texture = 'rebelfenn',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['bodicavenj'] = {
    name = 'Bodica Venj',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'fangfighter',
    initiative = 4,
    texture = 'bodica',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['dirkullodin'] = {
    name = 'Dirk Ullodin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'fangfighter',
    initiative = 3,
    initiative = 3,
    texture = 'dirk',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['clanwrenvolunteer'] = {
    name = 'Clan Wren Volunteer',
    faction = 'rebelalliance',
    limited = 2,
    ship_type = 'fangfighter',
    initiative = 3,
    texture = 'volunteer',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['mandalorianroyalguard'] = {
    name = 'Mandalorian Royal Guard',
    faction = 'scumandvillainy',
    limited = 2,
    ship_type = 'fangfighter',
    initiative = 4,
    texture = 'original',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

-- New TIE Ln

masterPilotDB['moffgideon'] = {
    name = 'Moff Gideon',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    charge = 2,
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['isbjingoist'] = {
    name = 'ISB Jingoist',
    faction = 'galacticempire',
    limited = 2,
    ship_type = 'tielnfighter',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' }
}


-- Gauntlet fighter:
masterPilotDB['maul'] = {
    name = 'Maul',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'gauntletfighter',
    force = 3,
    initiative = 5,
    texture = 'maul',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['bokatankryze'] = {
    name = 'Bo-Katan Kryze',
    title = 'Nite Owl Commander',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'gauntletfighter',
    initiative = 4,
    texture = 'bokatan',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['bokatankryze-separatistalliance'] = {
    name = 'Bo-Katan Kryze',
    title = "Vizsla's Lieutenant",
    faction = 'separatistalliance',
    limited = 1,
    charge = 1,
    ship_type = 'gauntletfighter',
    initiative = 4,
    texture = 'bokatancis',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['previzsla'] = {
    name = 'Pre Vizsla',
    faction = 'separatistalliance',
    limited = 1,
    charge = 2,
    ship_type = 'gauntletfighter',
    initiative = 3,
    texture = 'previzsla',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['rookkast'] = {
    name = 'Rook Kast',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'gauntletfighter',
    initiative = 3,
    texture = 'scum',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['deathwatchwarrior'] = {
    name = 'Death Watch Warrior',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'gauntletfighter',
    initiative = 2,
    texture = 'deathwatch',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['niteowlliberator'] = {
    name = 'Nite Owl Liberator',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'gauntletfighter',
    initiative = 2,
    texture = 'default',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['shadowcollectiveoperator'] = {
    name = 'Shadow Collective Operator',
    faction = 'scumandvillainy',
    ship_type = 'gauntletfighter',
    initiative = 1,
    texture = 'scum',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['ezrabridger-gauntletfighter'] = {
    name = 'Ezra Bridger',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'gauntletfighter',
    force = 1,
    initiative = 3,
    texture = 'scum',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['chopper-gauntletfighter'] = {
    name = '"Chopper"',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'gauntletfighter',
    initiative = 2,
    texture = 'scum',
    action_set = { 'C', 'TL', 'R', 'Piv' },
}

masterPilotDB['mandalorianresistancepilot'] = {
    name = 'Mandalorian Resistance Pilot',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'gauntletfighter',
    initiative = 2,
    texture = 'default',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['captainhark'] = {
    name = 'Captain Hark',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'gauntletfighter',
    initiative = 3,
    texture = 'imperial',
    action_set = { 'F', 'TL', 'R' },
    execute_options = {
        rs0 = { 'rbl1z', 'rs0', 'rbr1z' }
    },
}

masterPilotDB['garsaxon'] = {
    name = 'Gar Saxon',
    charge = 2,
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'gauntletfighter',
    initiative = 3,
    texture = 'deathwatch',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}


-- razorcrest pilots

masterPilotDB['themandalorian'] = {
    name = 'The Mandalorian',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'st70assaultship',
    initiative = 5,
    texture = 'mandalorian',
    action_set = { 'F', 'TL', 'E', 'BR' },
}

masterPilotDB['q90'] = {
    name = 'Q9-0',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'st70assaultship',
    initiative = 5,
    texture = 'guildbountyhunter',
    action_set = { 'C', 'TL', 'E', 'BR' },
}

masterPilotDB['guildbountyhunter'] = {
    name = 'Guild Bounty Hunter',
    faction = 'scumandvillainy',
    limited = 2,
    ship_type = 'st70assaultship',
    initiative = 3,
    texture = 'guildbountyhunter',
    action_set = { 'F', 'TL', 'E', 'BR' },
}



masterPilotDB['anakinskywalker-delta7baethersprite'] = {
    name = 'Anakin Skywalker',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7baethersprite',
    force = 3,
    initiative = 6,
    texture = 'anakin',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['luminaraunduli-delta7baethersprite'] = {
    name = 'Luminara Unduli',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7baethersprite',
    force = 2,
    initiative = 4,
    texture = 'lumi',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['barrissoffee-delta7baethersprite'] = {
    name = 'Barriss Offee',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7baethersprite',
    force = 1,
    initiative = 4,
    texture = 'barriss',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['ahsokatano-delta7baethersprite'] = {
    name = 'Ahsoka Tano',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7baethersprite',
    force = 2,
    initiative = 3,
    texture = 'ahsoka',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['obiwankenobi-delta7baethersprite'] = {
    name = 'Obi-Wan Kenobi',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7baethersprite',
    force = 3,
    initiative = 5,
    texture = 'obi',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['macewindu-delta7baethersprite'] = {
    name = 'Mace Windu',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7baethersprite',
    force = 3,
    initiative = 4,
    texture = 'mace',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['plokoon-delta7baethersprite'] = {
    name = 'Plo Koon',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7baethersprite',
    force = 2,
    initiative = 5,
    texture = 'plo',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['saeseetiin-delta7baethersprite'] = {
    name = 'Saesee Tiin',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'delta7baethersprite',
    force = 2,
    initiative = 4,
    texture = 'saesee',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['jediknight-delta7baethersprite'] = {
    name = 'Jedi Knight',
    faction = 'galacticrepublic',
    ship_type = 'delta7baethersprite',
    force = 1,
    initiative = 3,
    texture = 'knight',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
    --tint_friendly = {mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/Small/delta7baethersprite/Jedi_Delta7_tint.obj',
    --                texture = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/Small/delta7baethersprite/JediKnight-tint.png',}
}

-- Rogue class starfighter

masterPilotDB['cadbane-separatistalliance'] = {
    name = 'Cad Bane',
    faction = 'separatistalliance',
    charge = 1,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['ig101'] = {
    name = 'IG-101',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    initiative = 4,
    texture = 'grey',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['ig102'] = {
    name = 'IG-102',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    initiative = 4,
    texture = 'grey',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['ig111'] = {
    name = 'IG-111',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    initiative = 1,
    texture = 'grey',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['magnaguardprotector'] = {
    name = 'MagnaGuard Protector',
    faction = 'separatistalliance',
    limited = 2,
    ship_type = 'rogueclassstarfighter',
    condition = 'Guarded',
    initiative = 4,
    texture = 'grey',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['magnaguardexecutioner'] = {
    name = 'MagnaGuard Executioner',
    faction = 'separatistalliance',
    ship_type = 'rogueclassstarfighter',
    initiative = 3,
    texture = 'grey',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['cadbane'] = {
    name = 'Cad Bane',
    faction = 'scumandvillainy',
    charge = 2,
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    initiative = 4,
    texture = 'green',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['viktorhel-rogueclassstarfighter'] = {
    name = 'Viktor Hel',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    initiative = 4,
    texture = 'green',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['nomlumb-rogueclassstarfighter'] = {
    name = 'Nom Lumb',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    initiative = 1,
    texture = 'green',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['outerrimhunter'] = {
    name = 'Outer Rim Hunter',
    faction = 'scumandvillainy',
    ship_type = 'rogueclassstarfighter',
    initiative = 3,
    texture = 'green',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
}

-- Clone Z-95

masterPilotDB['hawk-clonez95headhunter'] = {
    name = '"Hawk"',
    faction = 'galacticrepublic',
    ship_type = 'clonez95headhunter',
    initiative = 4,
    limited = 1,
    texture = 'standard',
    add_squad_action = { 'BR', 'B' },
    action_set = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['slider'] = {
    name = '"Slider"',
    faction = 'galacticrepublic',
    ship_type = 'clonez95headhunter',
    charge = 2,
    initiative = 4,
    limited = 1,
    texture = 'standard',
    action_set = { 'F', 'BR', 'TL', 'B' },
    execute_options = {
        bbl2 = { 'bbl2', 'bbl2z' },
        bbr2 = { 'bbr2', 'bbr2z' },
    },
}

masterPilotDB['boost'] = {
    name = '"Boost"',
    faction = 'galacticrepublic',
    ship_type = 'clonez95headhunter',
    initiative = 3,
    limited = 1,
    texture = 'standard',
    action_set = { 'F', 'BR', 'B', 'TL' },
}

masterPilotDB['drift'] = {
    name = '"Drift"',
    faction = 'galacticrepublic',
    ship_type = 'clonez95headhunter',
    initiative = 3,
    limited = 1,
    texture = 'standard',
    action_set = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['stub'] = {
    name = '"Stub"',
    faction = 'galacticrepublic',
    ship_type = 'clonez95headhunter',
    initiative = 3,
    limited = 1,
    texture = 'standard',
    action_set = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['warthog-clonez95headhunter'] = {
    name = '"Warthog"',
    faction = 'galacticrepublic',
    ship_type = 'clonez95headhunter',
    initiative = 3,
    limited = 1,
    texture = 'standard',
    action_set = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['killer'] = {
    name = '"Killer"',
    faction = 'galacticrepublic',
    ship_type = 'clonez95headhunter',
    initiative = 2,
    limited = 1,
    texture = 'standard',
    action_set = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['knack'] = {
    name = '"Knack"',
    faction = 'galacticrepublic',
    ship_type = 'clonez95headhunter',
    initiative = 5,
    limited = 1,
    texture = 'standard',
    action_set = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['reapersquadronscout'] = {
    name = 'Reaper Squadron Scout',
    faction = 'galacticrepublic',
    ship_type = 'clonez95headhunter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'BR', 'TL', 'B' },
}

masterPilotDB['7thskycorpspilot'] = {
    name = '7th Sky Corps Pilot',
    faction = 'galacticrepublic',
    ship_type = 'clonez95headhunter',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'BR', 'TL', 'B' },
}

-- Missing ships
masterPilotDB['imperialsupercommando'] = {
    name = 'Imperial Super Commando',
    faction = 'galacticempire',
    ship_type = 'gauntletfighter',
    initiative = 2,
    texture = 'imperial',
    action_set = { 'F', 'TL', 'R', 'Piv' },
}

masterPilotDB['outerrimenforcer'] = {
    name = 'Outer Rim Enforcer',
    faction = 'scumandvillainy',
    ship_type = 'st70assaultship',
    initiative = 2,
    texture = 'guildbountyhunter',
    action_set = { 'F', 'TL', 'E', 'BR' },
}

-- Battle of Yavin standardized pilots

masterPilotDB['lukeskywalker-battleofyavin'] = {
    name = 'Luke Skywalker',
    title = 'Battle of Yavin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    force = 2,
    initiative = 5,
    texture = 'luke',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    title = 'Battle of Yavin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 5,
    texture = 'wedge',
    action_set = { 'F', 'TL', 'BR', 'B' },

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
    title = 'Battle of Yavin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 4,
    texture = 'porkins',
    action_set = { 'F', 'TL', 'BR', 'B' },

    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Adv. Proton Torpedoes',     charge = 1 },
        { name = 'Proton Torpedoes',          charge = 2 },
        { name = 'Unstable Sublight Engines', charge = 0 }
    }
}

masterPilotDB['garvendreis-battleofyavin'] = {
    name = 'Garven Dreis',
    title = 'Battle of Yavin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 4,
    texture = 'garven',
    action_set = { 'F', 'TL', 'BR', 'B' },
    add_squad_action = { 'F' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Adv. Proton Torpedoes', charge = 1 },
        { name = 'R5-K6',                 charge = 2 }
    }
}

masterPilotDB['biggsdarklighter-battleofyavin'] = {
    name = 'Biggs Darklighter',
    title = 'Battle of Yavin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 3,
    texture = 'biggs',
    action_set = { 'F', 'TL', 'BR', 'B' },

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
    title = 'Battle of Yavin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 2,
    texture = 'gold',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    title = 'Battle of Yavin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 4,
    texture = 'gold',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    title = 'Battle of Yavin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 4,
    texture = 'gold',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    title = 'Battle of Yavin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    charge = 4,
    initiative = 6,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'E' },
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
    title = 'Battle of Yavin',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedx1',
    force = 3,
    initiative = 6,
    shield = 3,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    title = 'Battle of Yavin',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator',     charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB['wampa-battleofyavin'] = {
    name = '"Wampa"',
    title = 'Battle of Yavin',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    charge = 1,
    initiative = 1,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Elusive',  charge = 1 },
        { name = 'Vengeful', charge = 0 },
    }
}

masterPilotDB['darkcurse-battleofyavin'] = {
    name = '"Dark Curse"',
    title = 'Battle of Yavin',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 6,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    execute_options = {
        rk3 = { [1] = 'rk3', [2] = 'rbl3s', [3] = 'rbr3s' },
    },
    standardized_upgrades = {
        { name = 'Ruthless',              charge = 0 },
        { name = 'Precision Ion Engines', charge = 2 },
    }
}

masterPilotDB['backstabber-battleofyavin'] = {
    name = '"Backstabber"',
    title = 'Battle of Yavin',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'B', 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Crackshot',    charge = 1 },
        { name = 'Disciplined',  charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB['idenversio-battleofyavin'] = {
    name = 'Iden Versio',
    title = 'Battle of Yavin',
    faction = 'galacticempire',
    limited = 1,
    shield = 1,
    ship_type = 'tieininterceptor',
    charge = 2,
    initiative = 4,
    texture = 'the181',
    action_set = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator', charge = 0 },
        { name = 'Fanatic',  charge = 0 },
    }
}

masterPilotDB['sigma4-battleofyavin'] = {
    name = 'Sigma 4',
    title = 'Battle of Yavin',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    charge = 2,
    initiative = 4,
    texture = 'the181',
    action_set = { 'F', 'E', 'BR', 'B', 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Disciplined',      charge = 0 },
        { name = 'Primed Thrusters', charge = 0 },
    }
}

masterPilotDB['sigma5-battleofyavin'] = {
    name = 'Sigma 5',
    title = 'Battle of Yavin',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    charge = 2,
    initiative = 4,
    texture = 'the181',
    action_set = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Sensor Jammer', charge = 0 },
        { name = 'Elusive',       charge = 1 },
    }
}

masterPilotDB['sigma6-battleofyavin'] = {
    name = 'Sigma 6',
    title = 'Battle of Yavin',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    charge = 2,
    initiative = 4,
    texture = 'the181',
    action_set = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Daredevil',    charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB['sigma7-battleofyavin'] = {
    name = 'Sigma 7',
    title = 'Battle of Yavin',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    charge = 2,
    initiative = 4,
    texture = 'the181',
    action_set = { 'F', 'E', 'BR', 'B', 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Marksmanship',        charge = 0 },
        { name = 'Fire-Control System', charge = 0 },
    }
}

masterPilotDB['dutchvander-battleofyavin'] = {
    name = '"Dutch" Vander',
    title = 'Battle of Yavin',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 4,
    texture = 'gold',
    action_set = { 'F', 'TL', 'BR', 'B' },
    add_squad_action = { 'TL' },
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
    title = 'Siege of Coruscant',
    limited = 1,
    faction = 'galacticrepublic',
    force = 3,
    ship_type = 'eta2actis',
    initiative = 6,
    texture = 'anakin',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
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
    title = 'Siege of Coruscant',
    limited = 1,
    faction = 'galacticrepublic',
    force = 3,
    ship_type = 'eta2actis',
    initiative = 5,
    texture = 'obi',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
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
    title = 'Siege of Coruscant',
    limited = 1,
    faction = 'galacticrepublic',
    force = 2,
    ship_type = 'eta2actis',
    initiative = 4,
    texture = 'shaak',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
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
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    title = 'Siege of Coruscant',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' },
    add_squad_action = { 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Deadeye Shot',    charge = 0 },
        { name = 'Barrage Rockets', charge = 5 },
    }
}

masterPilotDB['kickback-siegeofcoruscant'] = {
    name = '"Kickback"',
    title = 'Siege of Coruscant',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Diamond-Boron Missiles', charge = 3 },
        { name = 'Munitions Failsafe',     charge = 0 },
    }
}

masterPilotDB['contrail-siegeofcoruscant'] = {
    name = '"Contrail"',
    title = 'Siege of Coruscant',
    limited = 1,
    faction = 'galacticrepublic',
    ship_type = 'nimbusclassvwing',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    title = 'Siege of Coruscant',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'arc170starfighter',
    initiative = 3,
    texture = 'republic',
    action_set = { 'F', 'TL', 'BR' },
    add_squad_action = { 'TL' },
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
    title = 'Siege of Coruscant',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'arc170starfighter',
    charge = 1,
    initiative = 4,
    texture = 'republic',
    action_set = { 'F', 'TL', 'BR' },
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
    title = 'Siege of Coruscant',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'arc170starfighter',
    initiative = 5,
    shield = 4,
    texture = 'republic',
    action_set = { 'F', 'TL', 'BR' },
    add_squad_action = { 'TL' },
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
    title = 'Siege of Coruscant',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'sithinfiltrator',
    force = 3,
    initiative = 5,
    action_set = { 'F', 'TL', 'BR' },
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
    title = 'Siege of Coruscant',
    faction = 'separatistalliance',
    charge = 2,
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    initiative = 3,
    action_set = { 'C', 'BR', 'TL' },
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
    title = 'Siege of Coruscant',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    initiative = 1,
    action_set = { 'C', 'BR', 'TL' },
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
    title = 'Siege of Coruscant',
    faction = 'separatistalliance',
    limited = 2,
    ship_type = 'vultureclassdroidfighter',
    initiative = 1,
    action_set = { 'C', 'BR', 'TL' },
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
    faction = 'galacticrepublic',
    ship_type = 'delta7aethersprite',
    force = 2,
    initiative = 5,
    texture = 'plo',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
}

masterPilotDB['adigallia-delta7baethersprite'] = {
    name = 'Adi Gallia',
    faction = 'galacticrepublic',
    ship_type = 'delta7baethersprite',
    limited = 1,
    force = 2,
    initiative = 5,
    texture = 'plo',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' },
}

masterPilotDB['corranhorn-t65xwing'] = {
    name = 'Corran Horn',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' },
    add_squad_action = { 'TL' }
}

masterPilotDB['doctoraphra'] = {
    name = 'Doctor Aphra',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'yv666lightfreighter',
    initiative = 3,
    charge = 3,
    texture = 'aphra',
    action_set = { 'F', 'TL', 'R' },
}

masterPilotDB['durge'] = {
    name = 'Durge',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    initiative = 5,
    texture = 'durge',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['flightleaderubbel'] = {
    name = 'Flight Leader Ubbel',
    limited = 1,
    faction = 'galacticempire',
    ship_type = 'tierbheavy',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'C', 'TL', 'BR', 'R', 'Rot' },
}

masterPilotDB['gavynsykes'] = {
    name = 'Gavyn Sykes',
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'nabooroyaln1starfighter',
    initiative = 3,
    texture = 'yellow',
    action_set = { 'F', 'TL', 'B', 'BR', 'E' }
}

masterPilotDB['hondoohnaka'] = {
    name = 'Hondo Ohnaka',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 1,
    texture = 'blue',
    action_set = { 'F', 'R', 'TL', 'B', 'C' },
    add_squad_action = { 'F', 'R', 'TL', 'B' },
}

masterPilotDB['junoeclipse'] = {
    name = 'Juno Eclipse',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedx1',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR', 'B' }
}

masterPilotDB['keovenzee'] = {
    name = 'Keo Venzee',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 3,
    force = 1,
    texture = 'keo',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' },
    execute_options = {
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
    limited = 1,
    faction = 'galacticrepublic',
    force = 2,
    ship_type = 'eta2actis',
    initiative = 4,
    texture = 'kit',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
    keywords = { 'Light Side', 'Jedi' }
}

masterPilotDB['lapin'] = {
    name = 'Lapin',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'modifiedtielnfighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['magnatolvan'] = {
    name = 'Magna Tolvan',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR' }
}

masterPilotDB['popskrail'] = {
    name = '"Pops" Krail',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 3,
    texture = 'gold',
    action_set = { 'F', 'TL', 'BR' },
}

masterPilotDB['secondsister'] = {
    name = 'Second Sister',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    force = 2,
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'B' }
}

masterPilotDB['sicko'] = {
    name = '"Sicko"',
    limited = 1,
    faction = 'galacticrepublic',
    ship_type = 'laatigunship',
    condition = 'Sickening Maneuver',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'R', 'TL', 'Rot' },
    keywords = { 'Clone' },
    execute_options = {
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
    faction = 'galacticrepublic',
    limited = 1,
    ship_type = 'v19torrentstarfighter',
    initiative = 1,
    charge = 2,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR' },
    keywords = { 'Clone' }
}

masterPilotDB['torphun'] = {
    name = 'Tor Phun',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'fangfighter',
    initiative = 3,
    texture = 'new',
    action_set = { 'F', 'TL', 'B', 'BR' },
    keywords = { 'Mandalorian' }
}

masterPilotDB['tychocelchu'] = {
    name = 'Tycho Celchu',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 5,
    texture = 'arvel',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' }
}

masterPilotDB['wesjanson'] = {
    name = 'Wes Janson',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 5,
    charge = 1,
    texture = 'wes',
    action_set = { 'F', 'TL', 'BR' },
}

masterPilotDB['yricaquell'] = {
    name = 'Yrica Quell',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'TL' }
}

masterPilotDB['takajamoreesa'] = {
    name = 'Taka Jamoreesa',
    faction = 'resistance',
    limited = 1,
    ship_type = 'resistancetransport',
    initiative = 2,
    texture = 'standard',
    action_set = { 'F', 'TL' }
}

masterPilotDB['zayversio'] = {
    name = 'Zay Versio',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' }
}

masterPilotDB['venisadoza'] = {
    name = 'Venisa Doza',
    limited = 1,
    faction = 'resistance',
    ship_type = 't70xwing',
    add_slots = { 'Weapon Hardpoint' },
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B' },
    arcs = { fixed = { range = 3, type = { 'front', 'back' } } },
}

masterPilotDB['landocalrissian-scavengedyt1300'] = {
    name = "Lando Calrissian",
    faction = 'resistance',
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    initiative = 5,
    charge = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'Rot' }
}

masterPilotDB['poedameron-scavengedyt1300'] = {
    name = "Poe Dameron",
    faction = 'resistance',
    limited = 1,
    ship_type = 'scavengedyt1300lightfreighter',
    initiative = 6,
    charge = 2,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'BR', 'Rot' }
}

masterPilotDB['theironassembler'] = {
    name = 'The Iron Assembler',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'vultureclassdroidfighter',
    charge = 3,
    initiative = 1,
    action_set = { 'C', 'BR', 'TL' },
    texture = 'proto',
}

masterPilotDB['kelrodoaiholdout'] = {
    name = 'Kelrodo-Ai Holdout',
    faction = 'separatistalliance',
    limited = 3,
    ship_type = 'vultureclassdroidfighter',
    initiative = 1,
    action_set = { 'F', 'BR', 'TL', 'C' },
    texture = 'proto',
}

masterPilotDB['aurrasing'] = {
    name = 'Aurra Sing',
    limited = 1,
    faction = 'separatistalliance',
    force = 1,
    ship_type = 'firesprayclasspatrolcraft',
    initiative = 4,
    texture = 'zam',
    action_set = { 'F', 'R', 'TL', 'B' },
}

masterPilotDB['agenttierny'] = {
    name = 'Agent Tierny',
    faction = 'firstorder',
    limited = 1,
    condition = 'Broken Trust',
    ship_type = 'xiclasslightshuttle',
    initiative = 3,
    texture = 'light',
    action_set = { 'F', 'TL' }
}

masterPilotDB['lingaava'] = {
    name = 'Lin Gaava',
    limited = 1,
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    condition = 'Primed for Speed',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['lieutenantgalek'] = {
    name = 'Lieutenant Galek',
    limited = 1,
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['dt798'] = {
    name = 'DT-798',
    limited = 1,
    faction = 'firstorder',
    ship_type = 'tiefofighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'E', 'BR' }
}

masterPilotDB['phlacarphoccprototype-siegeofcoruscant'] = {
    name = "Phlac-Arphocc Prototype",
    title = "Siege of Coruscant",
    limited = 2,
    faction = 'separatistalliance',
    ship_type = 'droidtrifighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Afterburners',         charge = 2 },
        { name = 'Contingency Protocol', charge = 0 },
        { name = 'Evasion Sequence 7',   charge = 0 },
    }
}

masterPilotDB['dist81-siegeofcoruscant'] = {
    name = "DIS-T81",
    title = "Siege of Coruscant",
    limited = 1,
    faction = 'separatistalliance',
    ship_type = 'droidtrifighter',
    initiative = 4,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Outmaneuver',          charge = 0 },
        { name = 'Afterburners',         charge = 2 },
        { name = 'Contingency Protocol', charge = 0 },
    }
}

masterPilotDB['dis347-siegeofcoruscant'] = {
    name = "DIS-347",
    title = "Siege of Coruscant",
    limited = 1,
    faction = 'separatistalliance',
    ship_type = 'droidtrifighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'E', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Marksmanship',         charge = 0 },
        { name = 'Afterburners',         charge = 2 },
        { name = 'Contingency Protocol', charge = 0 },
    }
}

masterPilotDB['baktoidprototype-siegeofcoruscant'] = {
    name = 'Baktoid Prototype',
    title = "Siege of Coruscant",
    faction = 'separatistalliance',
    limited = 2,
    ship_type = 'hyenaclassdroidbomber',
    initiative = 1,
    action_set = { 'C', 'TL', 'BR' },
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
    title = "Siege of Coruscant",
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
    initiative = 4,
    action_set = { 'C', 'TL', 'BR' },
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
    title = "Siege of Coruscant",
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'hyenaclassdroidbomber',
    initiative = 3,
    action_set = { 'C', 'TL', 'BR' },
    charge = 2,
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
    limited = 1,
    faction = 'separatistalliance',
    ship_type = 'droidtrifighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' }
}

masterPilotDB['durge-separatistalliance'] = {
    name = 'Durge',
    faction = 'separatistalliance',
    limited = 1,
    ship_type = 'rogueclassstarfighter',
    charge = 1,
    initiative = 5,
    texture = 'durge',
    action_set = { 'F', 'E', 'TL', 'BR', 'B' },
}

masterPilotDB['klick-siegeofcoruscant'] = {
    name = '"Klick"',
    title = "Siege of Coruscant",
    limited = 1,
    faction = 'galacticrepublic',
    ship_type = 'nimbusclassvwing',
    charge = 1,
    initiative = 4,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR', 'B' },
    keywords = { 'Clone' },
    shield = 3,
    standardized_loadout = true,
    execute_options = {
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
    faction = 'firstorder',
    limited = 1,
    charge = 3,
    ship_type = 'tiesebomber',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'B', 'E' }
}

masterPilotDB['lukeskywalker-swz106'] = {
    name = 'Luke Skywalker',
    title = 'Squadron Starter Pack',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    force = 2,
    initiative = 5,
    texture = 'luke',
    action_set = { 'F', 'TL', 'BR', },
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
    title = 'Squadron Starter Pack',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 4,
    texture = 'porkins',
    action_set = { 'F', 'TL', 'BR', },

    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator',         charge = 0 },
        { name = 'Proton Torpedoes', charge = 2 },
        { name = 'R5-D8',            charge = 3 }
    }
}

masterPilotDB['dutchvander-swz106'] = {
    name = '"Dutch" Vander',
    title = 'Squadron Starter Pack',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 4,
    texture = 'gold',
    action_set = { 'F', 'TL', 'BR', 'B' },
    add_squad_action = { 'TL' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' }, ion = true } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Cannon Turret', charge = 0 },
        { name = 'Proton Bombs',      charge = 2 },
    }
}

masterPilotDB['hortonsalm-swz106'] = {
    name = 'Horton Salm',
    title = 'Squadron Starter Pack',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'btla4ywing',
    initiative = 4,
    texture = 'horton',
    action_set = { 'F', 'TL', 'BR' },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'ion cannon turret', range = 2, type = { 'singleturret' }, ion = true } } },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Ion Cannon Turret', charge = 0 },
        { name = 'Proximity Mines',   charge = 2 },
    }
}

masterPilotDB['arvelcrynyd-swz106'] = {
    name = 'Arvel Crynyd',
    title = 'Squadron Starter Pack',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 3,
    texture = 'arvel',
    action_set = { 'F', 'TL', 'E', 'Ail', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Predator',     charge = 0 },
        { name = 'Afterburners', charge = 2 },
    }
}

masterPilotDB['jakefarrell-swz106'] = {
    name = 'Jake Farrell',
    title = 'Squadron Starter Pack',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 4,
    texture = 'jake',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Elusive',      charge = 1 },
        { name = 'Outmaneuver',  charge = 0 },
        { name = 'Ion Missiles', charge = 3 },
    }
}

masterPilotDB['sharabey-swz106'] = {
    name = 'Shara Bey',
    title = 'Squadron Starter Pack',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    initiative = 4,
    texture = 'shara',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Hopeful',             charge = 0 },
        { name = 'Concussion Missiles', charge = 3 },
    }
}

masterPilotDB['darthvader-swz105'] = {
    name = 'Darth Vader',
    title = 'Squadron Starter Pack',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedx1',
    force = 3,
    initiative = 6,
    shield = 3,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    title = 'Squadron Starter Pack',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieadvancedx1',
    initiative = 6,
    shield = 2,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    title = 'Squadron Starter Pack',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    bomb = true,
    initiative = 4,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Feedback Ping',    charge = 0 },
        { name = 'Plasma Torpedoes', charge = 2 },
        { name = 'Proton Bombs',     charge = 2 },
    }
}

masterPilotDB['tomaxbren-swz105'] = {
    name = 'Tomax Bren',
    title = 'Squadron Starter Pack',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    bomb = true,
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Elusive',         charge = 1 },
        { name = 'Barrage Rockets', charge = 5 },
        { name = 'Proximity Mines', charge = 2 },
    }
}

masterPilotDB['nightbeast-swz105'] = {
    name = '"Night Beast"',
    title = 'Squadron Starter Pack',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Disciplined', charge = 0 },
        { name = 'Predator',    charge = 0 },
    }
}

masterPilotDB['valenrudor-swz105'] = {
    name = 'Valen Rudor',
    title = 'Squadron Starter Pack',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 3,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Disciplined',           charge = 0 },
        { name = 'Precision Ion Engines', charge = 2 },
    }
}

masterPilotDB['idenversio-swz105'] = {
    name = 'Iden Versio',
    title = 'Squadron Starter Pack',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    shield = 0,
    charge = 1,
    initiative = 4,
    texture = 'inferno',
    action_set = { 'F', 'E', 'BR' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Disciplined', charge = 0 },
        { name = 'Elusive',     charge = 1 },
    }
}

masterPilotDB['deathfire-swz98'] = {
    name = '"Deathfire"',
    title = 'SL',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    bomb = true,
    charge = 2,
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    bomb = true,
    initiative = 4,
    texture = 'blue',
    action_set = { 'F', 'TL', 'E', 'BR' },
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
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    bomb = true,
    initiative = 5,
    charge = 2,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR' },
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
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'TL', 'B', 'BR' },
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
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'Rot' },
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
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'Rot' },
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
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR', 'Rot' },
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
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR', 'Rot' },
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
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['dashrendar-swz103-scumandvillainy'] = {
    name = 'Dash Rendar',
    title = 'Scum',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'BR', 'Rot' }
}

masterPilotDB['leebo-swz103-rebelalliance'] = {
    name = '"Leebo"',
    title = 'Rebel',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' }
}

masterPilotDB['leebo-swz103-scumandvillainy'] = {
    name = '"Leebo"',
    title = 'Scum',
    faction = 'scumandvillainy',
    limited = 1,
    ship_type = 'yt2400lightfreighter',
    initiative = 3,
    texture = 'standard',
    action_set = { 'C', 'TL', 'BR', 'Rot' },
    keywords = { 'Droid' }
}

--Battle over Endor Standardized Pilots

masterPilotDB['captainyorr-battleoverendor'] = {
    name = 'Captain Yorr',
    title = 'Battle over Endor',
    faction = 'galacticempire',
    limited = 1,
    charge = 2,
    ship_type = 'tiededefender',
    initiative = 4,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'TL', 'B' },
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
    title = 'Battle over Endor',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiededefender',
    initiative = 6,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'TL', 'B' },
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
    title = 'Battle over Endor',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 3,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Collected', charge = 0 },
        { name = 'Elusive',   charge = 1 },
        { name = 'No Escape', charge = 0 },
    }
}

masterPilotDB['majormianda-battleoverendor'] = {
    name = 'Major Mianda',
    title = 'Battle over Endor',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 5,
    shield = 1,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' },
    add_squad_action = { 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',     charge = 0 },
        { name = 'Ruthless',      charge = 0 },
        { name = 'Swarm Tactics', charge = 0 },
    }
}

masterPilotDB['scythe6-battleoverendor'] = {
    name = 'Scythe 6',
    title = 'Battle over Endor',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tielnfighter',
    initiative = 2,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR' },
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
    title = 'Battle over Endor',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    initiative = 3,
    shield = 1,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'B', '2B', '2BR', 'C' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'No Escape',               charge = 0 },
        { name = 'Outmaneuver',             charge = 0 },
        { name = 'Fuel Injection Override', charge = 2 },
    }
}

masterPilotDB['sapphire2-battleoverendor'] = {
    name = 'Sapphire 2',
    title = 'Battle over Endor',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tieininterceptor',
    initiative = 1,
    texture = 'grey',
    action_set = { 'F', 'E', 'BR', 'TR', 'B', 'Dare' },
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
    title = 'Battle over Endor',
    faction = 'galacticempire',
    limited = 1,
    charge = 2,
    ship_type = 'tieininterceptor',
    initiative = 6,
    texture = 'the181',
    action_set = { 'F', 'E', 'BR', 'B' },
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
    title = 'Battle over Endor',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    bomb = true,
    initiative = 3,
    charge = 2,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR' },
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
    title = 'Battle over Endor',
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'tiesabomber',
    bomb = true,
    initiative = 4,
    charge = 2,
    texture = 'grey',
    action_set = { 'F', 'TL', 'BR' },
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
    title = 'Battle over Endor',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 4,
    texture = 'redder',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    faction = 'rebelalliance',
    limited = 1,
    title = 'Battle over Endor',
    ship_type = 't65xwing',
    initiative = 6,
    shield = 3,
    texture = 'wedge',
    action_set = { 'F', 'TL', 'BR', 'B' },
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
    title = 'Battle over Endor',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 't65xwing',
    initiative = 5,
    texture = 'redder',
    action_set = { 'F', 'TL', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = "It's a Trap",           charge = 0 },
        { name = 'Plasma Torpedoes',      charge = 2 },
        { name = 'Stabilizing Astromech', charge = 1 }
    }
}

masterPilotDB['arvelcrynyd-battleoverendor'] = {
    name = 'Arvel Crynyd',
    title = 'Battle over Endor',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    arcs = { turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
    initiative = 3,
    shield = 3,
    texture = 'arvel',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Heroic Sacrifice', charge = 0 },
        { name = "It's a Trap",      charge = 0 },
        { name = 'Proton Rockets',   charge = 1 },
    }
}

masterPilotDB['gemmersojan-battleoverendor'] = {
    name = 'Gemmer Sojan',
    title = 'Battle over Endor',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'rz1awing',
    arcs = {
        turret = { main = { name = 'primary', type = { 'front', 'back' } } },
        weapon = { { name = 'Precision-Tuned Cannons', range = 3, type = { 'front' } } }
    },
    initiative = 2,
    texture = 'arvel',
    action_set = { 'F', 'TL', 'E', 'BR', 'B', 'C' },
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
    title = 'Battle over Endor',
    faction = 'rebelalliance',
    limited = 1,
    charge = 2,
    shield = 5,
    ship_type = 'asf01bwing',
    bomb = true,
    initiative = 4,
    texture = 'braylen',
    action_set = { 'F', 'TL', 'BR', 'E' },
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
    title = 'Battle over Endor',
    faction = 'rebelalliance',
    limited = 1,
    charge = 2,
    ship_type = 'asf01bwing',
    bomb = true,
    initiative = 1,
    texture = 'blade',
    action_set = { 'F', 'TL', 'BR', 'E' },
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
    faction = 'rebelalliance',
    limited = 1,
    title = 'Battle over Endor',
    shield = 5,
    charge = 2,
    ship_type = 'asf01bwing',
    bomb = true,
    initiative = 5,
    texture = 'gina',
    action_set = { 'F', 'TL', 'BR', 'E' },
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
    faction = 'rebelalliance',
    limited = 1,
    title = 'Battle over Endor',
    shield = 3,
    ship_type = 'rz1awing',
    arcs = { turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
    initiative = 5,
    texture = 'arvel',
    action_set = { 'F', 'TL', 'E', 'BR', 'B' },
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
    title = 'Battle over Endor',
    faction = 'rebelalliance',
    limited = 1,
    ship_type = 'modifiedyt1300lightfreighter',
    charge = 2,
    initiative = 5,
    texture = 'standard',
    action_set = { 'F', 'TL', 'B', 'BR', 'E' },
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
    faction = 'galacticempire',
    limited = 1,
    charge = 1,
    ship_type = 'tiephphantom',
    initiative = 4,
    texture = 'echo',
    action_set = { 'F', 'E', 'BR', 'CL' },
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
    faction = 'galacticempire',
    limited = 1,
    charge = 2,
    ship_type = 'tiephphantom',
    initiative = 5,
    texture = 'blue',
    action_set = { 'F', 'E', 'BR', 'CL', 'B' },
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
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'alphaclassstarwing',
    initiative = 4,
    texture = 'standard',
    action_set = { 'F', 'TL' },
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
    faction = 'galacticempire',
    limited = 1,
    ship_type = 'alphaclassstarwing',
    initiative = 3,
    texture = 'standard',
    action_set = { 'F', 'TL' },
    standardized_loadout = true,
    standardized_upgrades = {
        { name = 'Proton Torpedoes',  charge = 2 },
        { name = 'Saturation Rockets',     charge = 4 },
        { name = 'Electronic Baffle',  charge = 0 }
    }
}


masterPilotDB['newrepublicpatrol-wartime'] = {
    name = 'New Republic Patrol',
    faction = 'resistance',
    ship_type = 'btanr2ywing-wartime',
    initiative = 3,
    texture = 'blue',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['kijimispicerunner-wartime'] = {
    name = 'Kijimi Spice Runner',
    faction = 'resistance',
    ship_type = 'btanr2ywing-wartime',
    initiative = 2,
    texture = 'plain',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['tezanasz-wartime'] = {
    name = 'Teza Nasz',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    initiative = 4,
    texture = 'teza',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['shasazaro-wartime'] = {
    name = 'Shasa Zaro',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    initiative = 3,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['coruskapellim-wartime'] = {
    name = 'Corus Kapellim',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    initiative = 1,
    texture = 'corus',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['caithrenalli-wartime'] = {
    name = "C'ai Threnalli",
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    initiative = 2,
    texture = 'cai',
    action_set = { 'F', 'TL', 'BR', 'B', 'C', 'E' },
    movethrough = true
}

masterPilotDB['wilsateshlo-wartime'] = {
    name = 'Wilsa Teshlo',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    initiative = 4,
    texture = 'wilsa',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['zoriibliss-wartime'] = {
    name = 'Zorii Bliss',
    charge = 1,
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    initiative = 5,
    texture = 'red',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['aftabackbar-wartime'] = {
    name = 'Aftab Ackbar',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    initiative = 2,
    texture = 'cai',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

masterPilotDB['legafossang-wartime'] = {
    name = 'Lega Fossang',
    faction = 'resistance',
    limited = 1,
    ship_type = 'btanr2ywing-wartime',
    initiative = 3,
    texture = 'lega',
    action_set = { 'F', 'TL', 'BR', 'B', 'C' }
}

return masterPilotDB

