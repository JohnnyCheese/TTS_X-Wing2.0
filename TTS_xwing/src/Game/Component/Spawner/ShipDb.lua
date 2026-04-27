-- Attempt on Unified Data Base, based on XWS (dropped after w1, too much hassle) and FFG conversion table
masterShipDB = {}
masterShipDB[0] = {
    ['name'] = '',
    ['hull'] = 0,
    ['shield'] = 0,
    ['size'] = 'small',
    ['agility'] = 1,
    ['energy'] = 0,
    ['factions'] = { ['dummy'] = true },
    ['arcs'] = { fixed = { range = 3, type = { 'front' } } }
}

masterShipDB['modifiedyt1300lightfreighter'] = {
    name = 'Modified YT-1300',
    hull = 8,
    shield = 5,
    size = 'large',
    proximity_hider = true,
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/Textures/1/standard.jpg',
        dirty =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/Textures/1/dirty.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/Textures/1/plain.jpg',
        rebel =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/Textures/1/rebel.jpg',
        sabine =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/Textures/1/sabine.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/Textures/1/red.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/Textures/1/blue.jpg',
        dark =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/Textures/1/dark.jpg',
        yellow =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/Textures/1/yellow.jpg',
        brown =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/Textures/1/brown.jpg',
    },
    factions = { ['rebelalliance'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'doubleturret' } } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/modifiedyt1300lightfreighter/yt1300modified.obj',
    move_set = { 'wbl1', 'bs1', 'wbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbl3s', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rbr3s', 'ws4', 'rk4' },
    keywords = { 'Freighter', 'YT-1300' }
}

masterShipDB['starviperclassattackplatform'] = {
    name = 'StarViper',
    hull = 4,
    shield = 1,
    size = 'small',
    agility = 3,
    textures = {
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/starviperclassattackplatform/Textures/blacksunassassin.jpg',
        white =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/starviperclassattackplatform/Textures/blacksunenforcer.jpg',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/starviperclassattackplatform/starviper2.obj',
    move_set = { 'wtl1', 'bbl1', 'bs1', 'bbr1', 'wtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbl3s', 'wbl3', 'bs3', 'wbr3', 'rbr3s', 'ws4' }
}

masterShipDB['scurrgh6bomber'] = {
    name = 'Scurrg H6 Bomber',
    hull = 6,
    shield = 4,
    size = 'medium',
    agility = 1,
    textures = {
        orange =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/scurrgh6bomber/Textures/orange.png',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/scurrgh6bomber/Textures/red.png',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/scurrgh6bomber/scurrg.obj',
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3t', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'rtr3t', 'rs4' }
}

masterShipDB['yt2400lightfreighter'] = {
    name = 'YT-2400',
    hull = 6,
    shield = 4,
    size = 'large',
    proximity_hider = true,
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/yt2400lightfreighter/Textures/standard.jpg',
    },
    factions = { ['rebelalliance'] = true, ['scumandvillainy'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'doubleturret' } } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/yt2400lightfreighter/yt2400.obj',
    move_set = { 'wtl1', 'bbl1', 'bs1', 'bbr1', 'wtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'wtl3', 'wbl3', 'ws3', 'wbr3', 'wtr3', 'ws4', 'rk4' },
    keywords = { 'Freighter' }
}

masterShipDB['auzituckgunship'] = {
    name = 'Auzituck Gunship',
    hull = 6,
    shield = 2,
    size = 'small',
    agility = 1,
    textures = {
        orange =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/auzituckgunship/Textures/orange.jpg',
        cream =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/auzituckgunship/Textures/cream.jpg',
        tarfful =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/auzituckgunship/Textures/tarfful.png',
    },
    factions = { ['rebelalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'fullfront' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/auzituckgunship/auzituck.obj',
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'ws4', 'rs0' }
}

masterShipDB['kihraxzfighter'] = {
    name = 'Khiraxz Fighter',
    hull = 5,
    shield = 1,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/kihraxzfighter/Textures/standard.jpg',
        green =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/kihraxzfighter/Textures/green.jpg',
        orange =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/kihraxzfighter/Textures/orange.jpg',
        blacksun =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/kihraxzfighter/Textures/blacksun.jpg',
        talonbane =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/kihraxzfighter/Textures/talonbane.jpg',
        vaksai =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/kihraxzfighter/Textures/vaksai.png',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/kihraxzfighter/khiraxz.obj',
    move_set = { 'wtl1', 'bbl1', 'bbr1', 'wtr1', 'rtl2t', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtr2t', 'wbl3', 'bs3', 'wbr3', 'ws4', 'rk4' }
}

masterShipDB['sheathipedeclassshuttle'] = {
    name = 'Sheathipede Shuttle',
    hull = 3,
    shield = 1,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/sheathipedeclassshuttle/Textures/standard.jpg',
    },
    factions = { ['rebelalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'frontback' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/sheathipedeclassshuttle/Sheathipede2.obj',
    move_set = { 'rs1r', 'wbl1', 'bs1', 'wbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtl3', 'wbl3', 'bs3', 'wbr3', 'rtr3', 'rk3', 'rs4' }
}

masterShipDB['quadrijettransferspacetug'] = {
    name = 'Quad Jumper',
    hull = 6,
    shield = 0,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/quadrijettransferspacetug/Textures/standard.jpg',
        mining =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/quadrijettransferspacetug/Textures/mining.jpg',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/quadrijettransferspacetug/quadjumper.obj',
    move_set = { 'rbl1r', 'rbr1r', 'wtl1', 'wbl1', 'ws1', 'wbr1', 'wtr1', 'rs2r', 'rbl2s', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbr2s', 'wbl3', 'bs3', 'wbr3' }
}

masterShipDB['firesprayclasspatrolcraft'] = {
    name = 'FireSpray',
    hull = 6,
    shield = 4,
    size = 'medium',
    agility = 2,
    textures = {
        bountyhunter =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/bountyhunter.jpg',
        boba =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/boba.jpg',
        emon =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/emon.jpg',
        jango =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/jango.jpg',
        kath =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/kath.jpg',
        koshka =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/koshka.jpg',
        krassis =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/krassis.jpg',
        zam =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/zam.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/blue.jpg',
        merc =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/mercenary.jpg',
        sabine =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/sabine.jpg',
        white =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/white.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/plain.jpg',
        skull =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/Textures/1/skull.jpg',
    },
    factions = { ['scumandvillainy'] = true, ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'frontback' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/firesprayV2.obj',
    move_set = { 'wtl1', 'bbl1', 'bs1', 'bbr1', 'wtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3t', 'wbl3', 'bs3', 'wbr3', 'rtr3t', 'ws4', 'rk4' },
    customization_parts = {
        canopy = {
            model =
            'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/firesprayV3-canopy.obj',
            specular_sharpness = 6,
            specular_intensity = 0.9,
            tintable = true
        }
    }
}

masterShipDB['tielnfighter'] = {
    name = 'TIE/ln Fighter',
    hull = 3,
    shield = 0,
    size = 'small',
    agility = 3,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tielnfighter/textures/Tie-Fighter-Blue2.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tielnfighter/textures/Tie-Fighter-Grey2.jpg',
        inferno =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tielnfighter/textures/Tie-Fighter-Inferno2.jpg',
        rebel =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tielnfighter/textures/Tie-Fighter-Rebel.jpg',
    },
    factions = { ['rebelalliance'] = true, ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tielnfighter/TIE_LN.obj',
    move_set = { 'wtl1', 'wtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rk3', 'ws4', 'rk4', 'ws5' },
    keywords = { "TIE" }
}

masterShipDB['btla4ywing'] = {
    name = 'Y-Wing',
    hull = 6,
    shield = 2,
    size = 'small',
    agility = 1,
    textures = {
        gold =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/gold.png',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/grey.png',
        horton =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/hortonsalm.png',
        amaxine =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/amaxine.png',
        crymorah =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/crymorah.png',
        drea =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/drearenthal.png',
        norra =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/norrawexley.png',
        hiredgun =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/hiredgun.png',
        jinata =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/JinataSecurityOfficer.png',
        kavil =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/kavil.png',
        padric =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/padric.png',
        blank =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/Textures/blank.png',
    },
    factions = { ['rebelalliance'] = true, ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btla4ywing/btla4_ywingv2.obj',
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'rs4', 'rk4' },
    keywords = { 'Y-Wing' }
}

masterShipDB['tieadvancedx1'] = {
    name = 'TIE Advanced x1',
    hull = 3,
    shield = 2,
    size = 'small',
    agility = 3,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieadvancedx1/textures/1/tieadvancedx1blue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieadvancedx1/textures/1/tieadvancedx1grey.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieadvancedx1/tieadvancedx1v2.obj',
    move_set = { 'bbl1', 'ws1', 'bbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtl3t', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rtr3t', 'ws4', 'rk4', 'ws5' },
    keywords = { 'TIE' }
}

masterShipDB['alphaclassstarwing'] = {
    name = 'Alpha Class StarWing',
    hull = 4,
    shield = 3,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/alphaclassstarwing/textures/standard.png',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/alphaclassstarwing/Alpha%20Class2.obj',
    move_set = { 'wbl1', 'bs1', 'wbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'ws3', 'wbr3', 'wtr3', 'rs4' }
}

masterShipDB['ut60duwing'] = {
    name = 'U-Wing',
    hull = 5,
    shield = 3,
    size = 'medium',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/ut60duwing/Textures/standard.jpg',
        captain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/ut60duwing/Textures/captain.jpg',
        renegade =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/ut60duwing/Textures/renegade.jpg',
        yellow =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/ut60duwing/Textures/yellow.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/ut60duwing/Textures/plain.jpg',
        rebel =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/ut60duwing/Textures/rebel.jpg',
    },
    factions = { ['rebelalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wbl3', 'ws3', 'wbr3', 'ws4', 'rs0' },
    --mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/ut60duwing/UWing_Base.obj',
    config = {
        States = {
            [1] = {
                Name = "Pivot Wing (Open)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/ut60duwing/UwingOpen.obj",
                ZRot = 0,
                Message = " opened their wings.",
            },
            [2] = {
                Name = "Pivot Wing (Closed)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/ut60duwing/UwingClose.obj",
                ZRot = 180,
                Message = " closed their wings.",
            }
        },
        ContextText = "Open/Close pivot wings",
        Token = "http://nnxwing.com/Content/TTS/Config/UWing.png"
    }
}

masterShipDB['tieskstriker'] = {
    name = 'TIE/sk Striker',
    hull = 4,
    shield = 0,
    size = 'small',
    agility = 2,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieskstriker/textures/tieskstrikerblue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieskstriker/textures/tieskstrikergrey.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'bbl1', 'bs1', 'bbr1', 'wtr1', 'rk1', 'rbl2s', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbr2s', 'wbl3', 'bs3', 'wbr3' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieskstriker/tiestriker.obj',
    keywords = { 'TIE' }
}

masterShipDB['asf01bwing'] = {
    name = 'B-Wing',
    hull = 4,
    shield = 4,
    size = 'small',
    agility = 1,
    factions = { ['rebelalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rtl1t', 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'rtr1t', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rk2', 'rbl3', 'bs3', 'rbr3', 'rs4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/bwing-base.obj',
    keywords = { 'B-Wing' },
    peg = 'bwing',
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/textures/blue.png',
        blade =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/textures/blade.png',
        gina =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/textures/gina.png',
        hera =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/textures/hera.png',
        braylen =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/textures/braylen.png',
        blade =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/textures/blade.png',
        netrem =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/textures/netrem.png',
        tennumb =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/textures/tennumb.png',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/textures/plain.png',
        nera =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/textures/nera.png',
    },
    config = {
        States = {
            [1] = {
                Name = "S-Foils (Open)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/bwing-open.obj",
                ZRot = 0,
                Message = " opened their S-Foils.",
            },
            [2] = {
                Name = "S-Foils (Closed)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/asf01bwing/bwing-closed.obj",
                ZRot = 180,
                Message = " closed their S-Foils.",
            }
        },
        ContextText = "Open/Close S-Foils",
        Token = "http://nnxwing.com/Content/TTS/Config/BWing.png"
    }
}

masterShipDB['tiededefender'] = {
    name = 'TIE/de Defender',
    hull = 3,
    shield = 4,
    size = 'small',
    agility = 3,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiededefender/textures/tiededefenderblue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiededefender/textures/tiededefendergrey.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiededefender/textures/tiededefenderred.jpg',
        skystrike =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiededefender/textures/tiededefenderss.jpg',
        vader =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiededefender/textures/tiededefendervader.jpg',
        kyber =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiededefender/textures/Kyber.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rtl1', 'bbl1', 'bbr1', 'rtr1', 'rtl2', 'wbl2', 'bs2', 'wbr2', 'rtr2', 'rk2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'bs4', 'wk4', 'bs5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiededefender/defender.obj',
    keywords = { 'TIE' }
}

masterShipDB['tiesabomber'] = {
    name = 'TIE/sa Bomber',
    hull = 6,
    shield = 0,
    size = 'small',
    agility = 2,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiesabomber/textures/tiesabomberblue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiesabomber/textures/tiesabombergrey.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wbl1', 'bs1', 'wbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rk3', 'ws4', 'rk5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiesabomber/tiebomber.obj',
    keywords = { 'TIE' }
}

masterShipDB['tiecapunisher'] = {
    name = 'TIE/ca Punisher',
    hull = 6,
    shield = 3,
    size = 'medium',
    agility = 1,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/tiecapunisher/textures/tiecapunisherblue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/tiecapunisher/textures/tiecapunishergrey.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'rk4', 'rs0' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/tiecapunisher/TiePunisher.obj',
    keywords = { 'TIE' }
}

masterShipDB['aggressorassaultfighter'] = {
    name = 'Aggressor',
    hull = 5,
    shield = 3,
    size = 'medium',
    agility = 3,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/aggressorassaultfighter/Textures/standard.jpg',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'bbl1', 'bs1', 'bbr1', 'wtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbl3s', 'bbl3', 'bs3', 'bbr3', 'rbr3s', 'ws4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/aggressorassaultfighter/aggressor.obj'
}

masterShipDB['g1astarfighter'] = {
    name = 'G-1A StarFighter',
    hull = 5,
    shield = 4,
    size = 'medium',
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/g1astarfighter/Textures/standard.png',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rk2', 'rbl3', 'ws3', 'rbr3', 'rs4', 'rk4', 'rs0' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/g1astarfighter/g1a.obj'
}

masterShipDB['vcx100lightfreighter'] = {
    name = 'VCX-100',
    hull = 10,
    shield = 4,
    size = 'large',
    proximity_hider = true,
    agility = 0,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/vcx100lightfreighter/Textures/standard.jpg',
    },
    factions = { ['rebelalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    docking = true,
    move_set = { 'rtl1', 'wbl1', 'bs1', 'wbr1', 'rtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'ws4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/vcx100lightfreighter/vcx100.obj',
    keywords = { 'Freighter' }
}

masterShipDB['yv666lightfreighter'] = {
    name = 'YV-666',
    hull = 9,
    shield = 3,
    size = 'large',
    proximity_hider = true,
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/yv666lightfreighter/Textures/1/standard.jpg',
        moralo =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/yv666lightfreighter/Textures/1/moralo.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/yv666lightfreighter/Textures/1/grey.jpg',
        aphra =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/yv666lightfreighter/Textures/1/aphra.jpg',
        blacksun =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/yv666lightfreighter/Textures/1/blacksun.jpg',
        mytho =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/yv666lightfreighter/Textures/1/mytho.jpg',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'fullfront' } } },
    move_set = { 'bbl1', 'bs1', 'bbr1', 'rtl2', 'wbl2', 'bs2', 'wbr2', 'rtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'ws4', 'rs0' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/yv666lightfreighter/yv666v2.obj',
    keywords = { 'Frighter' }
}

masterShipDB['tieadvancedv1'] = {
    name = 'TIE Advanced v1',
    hull = 2,
    shield = 2,
    size = 'small',
    agility = 3,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieadvancedv1/textures/1/tieadvancedv1blue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieadvancedv1/textures/1/tieadvancedv1grey.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'btl1', 'bbl1', 'bbr1', 'btr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl2t', 'rtr2t', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'ws4', 'rk4', 'ws5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieadvancedv1/tieadvv1v2.obj',
    keywords = { 'TIE' }
}

masterShipDB['lambdaclasst4ashuttle'] = {
    name = 'Lambda Class Shuttle',
    hull = 6,
    shield = 4,
    size = 'large',
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/lambdaclasst4ashuttle/textures/standard.png',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'frontback' } } },
    move_set = { 'bbl1', 'bs1', 'bbr1', 'rtl2', 'wbl2', 'bs2', 'wbr2', 'rtr2', 'rbl3', 'ws3', 'rbr3', 'rs0' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/lambdaclasst4ashuttle/lambda.obj'
}

masterShipDB['tiephphantom'] = {
    name = 'TIE/ph Phantom',
    hull = 3,
    shield = 2,
    size = 'small',
    agility = 2,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiephphantom/textures/tiephphantomblue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiephphantom/textures/tiephphantomgrey.jpg',
        sigma =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiephphantom/textures/tiephphantomsigma.jpg',
        echo =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiephphantom/textures/tiephphantomwhite.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'wbl1', 'wbr1', 'wtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rk3', 'ws4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiephphantom/Tie%20Phantom.obj',
    keywords = { 'TIE' }
}

masterShipDB['vt49decimator'] = {
    name = 'VT-49 Decimator',
    hull = 12,
    shield = 4,
    size = 'large',
    proximity_hider = true,
    agility = 0,
    textures = {
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/vt49decimator/textures/grey.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/vt49decimator/textures/black.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'doubleturret' } } } },
    move_set = { 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'wtl3', 'wbl3', 'ws3', 'wbr3', 'wtr3', 'ws4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/vt49decimator/vt49decimator.obj'
}

masterShipDB['tieagaggressor'] = {
    name = 'TIE/ag Aggressor',
    hull = 4,
    shield = 1,
    size = 'small',
    agility = 2,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieagaggressor/textures/tieagaggressorblue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieagaggressor/textures/tieagaggressorgrey.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wbl1', 'bs1', 'wbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'ws4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieagaggressor/tieagaggressor.obj',
    keywords = { 'TIE' }
}

masterShipDB['btls8kwing'] = {
    name = 'K-Wing',
    hull = 6,
    shield = 3,
    size = 'medium',
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/btls8kwing/Textures/standard.png',
        miranda =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/btls8kwing/Textures/MirandaDoni.png',
        esege =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/btls8kwing/Textures/EsegeTuketu.png',
    },
    factions = { ['rebelalliance'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'doubleturret' } } } },
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'wbl3', 'ws3', 'wbr3' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/btls8kwing/kwing.obj'
}

masterShipDB['arc170starfighter'] = {
    name = 'ARC-170',
    hull = 6,
    shield = 3,
    size = 'medium',
    agility = 1,
    textures = {
        rebel =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/arc170starfighter/Textures/rebel.jpg',
        republic =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/arc170starfighter/Textures/republicred.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/arc170starfighter/Textures/republicblue.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/arc170starfighter/Textures/black.jpg',
    },
    factions = { ['rebelalliance'] = true, ['galacticrepublic'] = true },
    arcs = { fixed = { range = 3, type = { 'frontback' } } },
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'rs4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/arc170starfighter/arc.obj'
}

masterShipDB['attackshuttle'] = {
    name = 'Attack Shuttle',
    hull = 3,
    shield = 1,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/attackshuttle/Textures/standard.jpg',
    },
    factions = { ['rebelalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'ws4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/attackshuttle/attackshuttle.obj'
}

masterShipDB['t65xwing'] = {
    name = 'X-Wing',
    hull = 4,
    shield = 2,
    size = 'small',
    agility = 2,
    textures = {
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/red.jpg',
        redder =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/redder.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/blue.jpg',
        renegade =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/cavernangels.jpg',
        biggs =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/biggs.jpg',
        garven =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/garven.jpg',
        porkins =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/porkins.jpg',
        luke =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/luke.jpg',
        thane =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/thane.jpg',
        wedge =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/wedge.jpg',
        wes =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/wes.jpg',
        merrick =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/Textures/2/merrick.png',
    },
    factions = { ['rebelalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'ws3', 'wbr3', 'wtr3', 'ws4', 'rtl3t', 'rtr3t', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/xwingbasev3.obj',
    keywords = { 'X-Wing' },
    config = {
        States = {
            [1] = {
                Name = "S-Foils (Open)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/xwingopenv3.obj",
                ZRot = 0,
                Message = " opened their wings.",
            },
            [2] = {
                Name = "S-Foils (Closed)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t65xwing/xwingclosedv3.obj",
                ZRot = 180,
                Message = " closed their wings.",
            }
        },
        ContextText = "Open/Close S-Foils",
        Token = "http://nnxwing.com/Content/TTS/Config/T65.png"
    }
}

masterShipDB['hwk290lightfreighter'] = {
    name = 'HWK-290',
    hull = 3,
    shield = 2,
    size = 'small',
    agility = 2,
    textures = {
        brown =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hwk290lightfreighter/Textures/1/brown.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hwk290lightfreighter/Textures/1/black.jpg',
        kyber =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hwk290lightfreighter/Textures/1/kyber.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hwk290lightfreighter/Textures/1/plain.jpg',
        white =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hwk290lightfreighter/Textures/1/white.jpg',
        mytho =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hwk290lightfreighter/Textures/1/mytho.jpg',
        kasmir =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hwk290lightfreighter/Textures/1/kasmir.png',
    },
    factions = { ['rebelalliance'] = true, ['scumandvillainy'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'singleturret' } } } },
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3', 'wbl3', 'bs3', 'wbr3', 'rtr3', 'ws4', 'rs0' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hwk290lightfreighter/hwkv2.obj',
    freighter = { 'Freighter' }
}

masterShipDB['rz1awing'] = {
    name = 'A-Wing',
    hull = 2,
    shield = 2,
    size = 'small',
    agility = 3,
    textures = {
        arvel =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz1awing/Textures/arvel.jpg',
        shara =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz1awing/Textures/shara.jpg',
        green =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz1awing/Textures/green.jpg',
        jake =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz1awing/Textures/blue.jpg',
        sabines =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz1awing/Textures/sabines.jpg',
        hera =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz1awing/Textures/hera.jpg',
        blank =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz1awing/Textures/plain.jpg',
        kyber =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz1awing/Textures/kyber.jpg',
        keo =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz1awing/Textures/keo.jpg',
    },
    factions = { ['rebelalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'wtr1', 'btl2', 'bbl2', 'bs2', 'bbr2', 'btr2', 'rbl3s', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rbr3s', 'bs4', 'bs5', 'rk5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz1awing/rz1awing.obj',
    keywords = { 'A-Wing' }
}

masterShipDB['fangfighter'] = {
    name = 'Fang Fighter',
    textures = {
        blank =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fangfighter/textures/Blank.jpg',
        bodica =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fangfighter/textures/Bodica.jpg',
        dirk =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fangfighter/textures/Dirk.jpg',
        new =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fangfighter/textures/New.jpg',
        original =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fangfighter/textures/Original.jpg',
        rebelfenn =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fangfighter/textures/Rebel-Fenn.jpg',
        volunteer =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fangfighter/textures/Volunteer.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fangfighter/textures/red.jpg',
        sabine =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fangfighter/textures/Sabine-Fang.jpg',
    },
    hull = 4,
    shield = 0,
    size = 'small',
    agility = 3,
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'wtr1', 'rtl2t', 'btl2', 'bbl2', 'bs2', 'bbr2', 'btr2', 'rtr2t', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'ws4', 'rk4', 'ws5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fangfighter/ship-base.obj'
}

masterShipDB['z95af4headhunter'] = {
    name = 'Z-95 Headhunter',
    hull = 2,
    shield = 2,
    size = 'small',
    agility = 2,
    textures = {
        bandit =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/bandit.jpg',
        tala =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/tala.jpg',
        pirate =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/binayre.jpg',
        blacksun =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/blacksun.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/plain.jpg',
        nashtah =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/nashtah.jpg',
        bossk =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/bossk.jpg',
        ndru =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/ndru.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/red.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/blue.jpg',
        orange =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Textures/1/orange.jpg',
    },
    factions = { ['rebelalliance'] = true, ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wbl1', 'bs1', 'wbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rk3', 'ws4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/z95af4headhunter/Z95v3.obj'
}

masterShipDB['m12lkimogilafighter'] = {
    name = 'M12-L Kimogila',
    hull = 7,
    shield = 2,
    size = 'medium',
    agility = 2,
    textures = {
        cartel =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/m12lkimogilafighter/Textures/CartelExecutioner.png',
        dalan =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/m12lkimogilafighter/Textures/DalanOberos.png',
        torani =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/m12lkimogilafighter/Textures/ToraniKulda.png',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rtl1', 'wbl1', 'bs1', 'wbr1', 'rtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/m12lkimogilafighter/kimogila.obj'
}

masterShipDB['ewing'] = {
    name = 'E-Wing',
    hull = 3,
    shield = 3,
    size = 'small',
    agility = 3,
    textures = {
        rogue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/ewing/Textures/RogueSquadronEscort.jpg',
        knave =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/ewing/Textures/KnaveSquadronEscort.jpg',
        gavin =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/ewing/Textures/GavinDarklighter.jpg',
        corran =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/ewing/Textures/CorranHorn.jpg',
    },
    factions = { ['rebelalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rbl3s', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rbr3s', 'bs4', 'rk4', 'ws5' },
    mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/ewing/ewing.obj'
}

masterShipDB['tieininterceptor'] = {
    name = 'TIE/in Interceptor',
    hull = 3,
    shield = 0,
    size = 'small',
    agility = 3,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieininterceptor/textures/tieininterceptorblue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieininterceptor/textures/tieininterceptorgrey.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieininterceptor/textures/tieininterceptorred.jpg',
        skystrike =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieininterceptor/textures/tieininterceptorss.jpg',
        the181 =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieininterceptor/textures/tieinterceptor181.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'wtr1', 'btl2', 'bbl2', 'bs2', 'bbr2', 'btr2', 'rbl3s', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rbr3s', 'bs4', 'rk4', 'ws5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tieininterceptor/tieinterceptor.obj',
    keywords = { 'TIE' }
}

masterShipDB['lancerclasspursuitcraft'] = {
    name = 'Lancer Pursuit Craft',
    hull = 8,
    shield = 2,
    size = 'large',
    proximity_hider = true,
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/lancerclasspursuitcraft/Textures/Standard.jpg',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'primary', type = { 'singleturret' } } } },
    move_set = { 'wbl1', 'ws1', 'wbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'btl3', 'bbl3', 'bs3', 'bbr3', 'btr3', 'bs4', 'ws5', 'rk5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/lancerclasspursuitcraft/lancer.obj',
}

masterShipDB['tierereaper'] = {
    name = 'TIE/re Reaper',
    hull = 6,
    shield = 2,
    size = 'medium',
    agility = 1,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/tierereaper/textures/tierereaperblue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/tierereaper/textures/tierereapergrey.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rbl1s', 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'rbr1s', 'rtl2', 'wbl2', 'bs2', 'wbr2', 'rtr2', 'wbl3', 'bs3', 'wbr3', 'rs0' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/tierereaper/tiereaper.obj',
    keywords = { 'TIE' }
}

masterShipDB['m3ainterceptor'] = {
    name = 'M3-A Interceptor',
    hull = 3,
    shield = 1,
    size = 'small',
    agility = 3,
    textures = {
        cartel =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/m3ainterceptor/Textures/CartelSpacer.jpg',
        tansarii =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/m3ainterceptor/Textures/TansariiPointVeteran.jpg',
        gargor =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/m3ainterceptor/Textures/G4rG0r.jpg',
        sunny =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/m3ainterceptor/Textures/SunnyBounder.jpg',
        genesis =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/m3ainterceptor/Textures/GenesisRed.jpg',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'bbl1', 'bbr1', 'wtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'wbl3', 'bs3', 'wbr3', 'rk3', 'ws4', 'ws5', 'rk5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/m3ainterceptor/m3a.obj'
}

masterShipDB['jumpmaster5000'] = {
    name = 'JumpMaster 5000',
    hull = 6,
    shield = 3,
    size = 'large',
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/jumpmaster5000/Textures/standard.jpg',
        tel =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/jumpmaster5000/Textures/teltrevura.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/jumpmaster5000/Textures/plain.jpg',
        scout =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/jumpmaster5000/Textures/scout.jpg',
        nom =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/jumpmaster5000/Textures/nomlumb.jpg',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'singleturret' } } } },
    move_set = { 'wtl1', 'bbl1', 'bs1', 'wbr1', 'rtr1', 'wtl2', 'bbl2', 'bs2', 'wbr2', 'rtr2', 'rbl3s', 'bbl3', 'bs3', 'wbr3', 'ws4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/jumpmaster5000/jm2k.obj'
}

masterShipDB['customizedyt1300lightfreighter'] = {
    name = 'Customized YT-1300',
    hull = 8,
    shield = 3,
    size = 'large',
    proximity_hider = true,
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/Textures/1/standard.jpg',
        blacksun =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/Textures/1/blacksun.jpg',
        mytho =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/Textures/1/mytho.jpg',
        maul =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/Textures/1/maul.jpg',
        dark =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/Textures/1/dark.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/Textures/1/red.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/Textures/1/blue.jpg',
        yellow =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/Textures/1/yellow.jpg',
        brown =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/Textures/1/brown.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/Textures/1/plain.jpg',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'doubleturret' } } } },
    docking = true,
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rbl3s', 'rbr3s', 'ws4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/customizedyt1300lightfreighter/yt1300customized.obj',
    keywords = { 'Freighter', 'YT-1300' }
}

masterShipDB['escapecraft'] = {
    name = 'Escape Craft',
    hull = 2,
    shield = 2,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/escapecraft/Textures/standard.jpg',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'bbl1', 'bs1', 'bbr1', 'rtl2', 'wbl2', 'bs2', 'wbr2', 'rtr2', 'wbl3', 'ws3', 'wbr3', 'rk3', 'rs0' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/escapecraft/escapecraft1.obj'
}

masterShipDB['tiefofighter'] = {
    name = 'TIE/fo FO',
    hull = 3,
    shield = 1,
    size = 'small',
    agility = 3,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiefofighter/Textures/2/standard.jpg',
        fn2187 =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiefofighter/Textures/2/fn2187.png',
    },
    factions = { ['firstorder'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'wtr1', 'rbl2s', 'btl2', 'bbl2', 'bs2', 'bbr2', 'btr2', 'rbr2s', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'ws4', 'rk4', 'ws5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiefofighter/TieFOv2.obj',
    keywords = { 'TIE' }
}

masterShipDB['tiesffighter'] = {
    name = 'TIE/sf SF',
    hull = 3,
    shield = 3,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiesffighter/Textures/1/standard.jpg',
        strife =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiesffighter/Textures/1/strife.png',
    },
    factions = { ['firstorder'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
    move_set = { 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbl3s', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rbr3s', 'ws4', 'ws5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiesffighter/TieSFv2.obj',
    keywords = { 'TIE' }
}

masterShipDB['upsilonclasscommandshuttle'] = {
    name = 'Upsilon Class Shuttle',
    hull = 6,
    shield = 6,
    size = 'large',
    proximity_hider = true,
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/upsilonclasscommandshuttle/Textures/standard.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/upsilonclasscommandshuttle/Textures/red.jpg',
    },
    factions = { ['firstorder'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rtl1', 'wbl1', 'bs1', 'wbr1', 'rtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'rs0' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/upsilonclasscommandshuttle/Upsilon_Shuttle.obj'
}
masterShipDB['tievnsilencer'] = {
    name = 'TIE Silencer',
    hull = 4,
    shield = 2,
    size = 'small',
    agility = 3,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tievnsilencer/Textures/1/standard.jpg',
    },
    factions = { ['firstorder'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'wtr1', 'btl2', 'bbl2', 'bs2', 'bbr2', 'btr2', 'rtl3t', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rtr3t', 'bs4', 'rk4', 'bs5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tievnsilencer/Tie_VN2.obj',
    keywords = { 'TIE' }
}

masterShipDB['t70xwing'] = {
    name = 'T-70 X-Wing',
    hull = 4,
    shield = 3,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t70xwing/Textures/1/blue.jpg',
        snap =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t70xwing/Textures/1/snap.jpg',
        commanderpoe =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t70xwing/Textures/1/poeHoH.jpg',
        blackone =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t70xwing/Textures/1/poe.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t70xwing/Textures/1/plain.jpg',
    },
    factions = { ['resistance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtl3t', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rtr3t', 'ws4', 'rk4' },
    keywords = { 'X-Wing' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t70xwing/t70_basev2.obj',
    config = {
        States = {
            [1] = {
                Name = "S-Foils (Open)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t70xwing/t70_openv2.obj",
                ZRot = 0,
                Message = " opened their wings.",
            },
            [2] = {
                Name = "S-Foils (Closed)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/t70xwing/t70_closedv2.obj",
                ZRot = 180,
                Message = " closed their wings.",
            }
        },
        ContextText = "Open/Close S-Foils",
        Token = "http://nnxwing.com/Content/TTS/Config/T70.png"
    }
}

masterShipDB['rz2awing'] = {
    name = 'A-Wing RZ-2',
    hull = 2,
    shield = 2,
    size = 'small',
    agility = 3,
    textures = {
        green =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz2awing/Textures/green.png',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz2awing/Textures/red.png',
        orange =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz2awing/Textures/orange.png',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz2awing/Textures/blue.png',
    },
    factions = { ['resistance'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rz2awing/res_awing.obj',
    move_set = { 'wtl1', 'wtr1', 'btl2', 'bbl2', 'bs2', 'bbr2', 'btr2', 'rbl3s', 'wtl3', 'bbl3', 'bs3', 'bbr3', 'wtr3', 'rbr3s', 'bs4', 'bs5', 'rk5' },
    keywords = { 'A-Wing' }
}

masterShipDB['mg100starfortress'] = {
    name = 'MG-100 StarFortress',
    hull = 9,
    shield = 3,
    size = 'large',
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/mg100starfortress/Textures/Standard.jpg',
        vennie =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/mg100starfortress/Textures/Vennie.jpg',
        paige =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/mg100starfortress/Textures/PaigeTico.jpg',
    },
    factions = { ['resistance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } }, turret = { main = { name = 'primary', type = { 'doubleturret' } } } },
    move_set = { 'rs0', 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rbl3', 'ws3', 'rbr3' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/mg100starfortress/starfortress.obj'
}

masterShipDB['modifiedtielnfighter'] = {
    name = 'Modified TIE/ln Fighter',
    hull = 3,
    shield = 0,
    size = 'small',
    agility = 3,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/modifiedtielnfighter/Textures/standard.png',
    },
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'wtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rk3', 'ws4', 'rs5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/modifiedtielnfighter/miningguildtie.obj',
    keywords = { 'TIE' }
}

masterShipDB['scavengedyt1300lightfreighter'] = {
    name = 'Scavenged YT-1300',
    hull = 8,
    shield = 3,
    size = 'large',
    proximity_hider = true,
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/standard.jpg',
        classic =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/classic.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/plain.jpg',
        blackone =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/blackone.jpg',
        rebel =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/rebel.jpg',
        sabine =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/sabine.jpg',
        dark =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/dark.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/red.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/blue.jpg',
        yellow =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/yellow.jpg',
        brown =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/Textures/1/brown.jpg',
    },
    factions = { ['resistance'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'doubleturret' } } } },
    move_set = { 'wbl1', 'bs1', 'wbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'ws3', 'wbr3', 'wtr3', 'rbl3s', 'rbr3s', 'rs4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/scavengedyt1300lightfreighter/yt1300scavenged.obj',
    keywords = { 'Freighter', 'YT-1300' }
}

--w3ship
masterShipDB['delta7aethersprite'] = {
    name = 'Delta-7',
    hull = 3,
    shield = 1,
    size = 'small',
    agility = 3,
    textures = {
        ahsoka =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/AhsokaTano.jpg',
        anakin =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/AnakinSkywalker.jpg',
        barriss =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/BarrissOffee.jpg',
        knight =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/JediKnight.jpg',
        lumi =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/LuminaraUnduli.jpg',
        mace =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/MaceWindu.jpg',
        obi =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/Obi-WanKenobi.jpg',
        plo =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/PloKoon.jpg',
        saesee =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/SaeseeTiin.jpg',
        depa =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/depa.png',
    },
    factions = { ['galacticrepublic'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'bbl1', 'bbr1', 'wtr1', 'rbl2s', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbr2s', 'wbl3', 'bs3', 'wbr3', 'ws4', 'rk4', 'ws5', 'rk5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Delta7.obj',
    config = {
        States = {
            [1] = {
                Name = "Normal",
                Model = nil,
                ZRot = 0,
                Message = " removed hyperspace ring,",
            },
            [2] = {
                Name = "Hyperspace ring mounted",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships/Small/GRP_Hyperspace_Ring/hyperspace_ring_attachment.obj",
                ZRot = 180,
                Message = " mounted an hyperspace ring.",
            }
        },
        ContextText = "Mount/unmount hyperspace ring",
    }
}

masterShipDB['delta7baethersprite'] = {
    name = 'Delta-7B',
    hull = 3,
    shield = 3,
    size = 'small',
    agility = 2,
    textures = {
        ahsoka =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/AhsokaTano.jpg',
        anakin =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/AnakinSkywalker.jpg',
        barriss =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/BarrissOffee.jpg',
        knight =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/JediKnight.jpg',
        lumi =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/LuminaraUnduli.jpg',
        mace =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/MaceWindu.jpg',
        obi =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/Obi-WanKenobi.jpg',
        plo =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/PloKoon.jpg',
        saesee =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/SaeseeTiin.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/plain.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/plain.jpg',
        depa =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Textures/depa.png',
    },
    factions = { ['galacticrepublic'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'bbl1', 'bbr1', 'wtr1', 'rbl2s', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbr2s', 'wbl3', 'bs3', 'wbr3', 'ws4', 'rk4', 'ws5', 'rk5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/delta7aethersprite/Delta7.obj',
    config = {
        States = {
            [1] = {
                Name = "Normal",
                Model = nil,
                ZRot = 0,
                Message = " removed hyperspace ring,",
            },
            [2] = {
                Name = "Hyperspace ring mounted",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships/Small/GRP_Hyperspace_Ring/hyperspace_ring_attachment.obj",
                ZRot = 180,
                Message = " mounted an hyperspace ring.",
            }
        },
        ContextText = "Mount/unmount hyperspace ring",
    }
}

masterShipDB['v19torrentstarfighter'] = {
    name = 'V-19',
    hull = 5,
    shield = 0,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/v19torrentstarfighter/Textures/1/red.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/v19torrentstarfighter/Textures/1/blue.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/v19torrentstarfighter/Textures/1/plain.jpg',
        logo =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/v19torrentstarfighter/Textures/1/logo.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/v19torrentstarfighter/Textures/1/black.jpg',
    },
    factions = { ['galacticrepublic'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'rtl2t', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtr2t', 'rbl3', 'bs3', 'rbr3', 'rk3', 'ws4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/v19torrentstarfighter/V-19_Torrentv2.obj'
}


masterShipDB['vultureclassdroidfighter'] = {
    name = 'Vulture-Class Droid',
    hull = 3,
    shield = 0,
    size = 'small',
    agility = 2,
    textures = {
        drone =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/vultureclassdroidfighter/Textures/SeperatistDrone.png',
        hunter =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/vultureclassdroidfighter/Textures/PreciseHunter.png',
        proto =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/vultureclassdroidfighter/Textures/HaorChallPrototype.png',
        dfs311 =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/vultureclassdroidfighter/Textures/DFS-311.png',
        dfs081 =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/vultureclassdroidfighter/Textures/DFS-081.png',
        dfs420 =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/vultureclassdroidfighter/Textures/dfs420.png',
        p00m =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/vultureclassdroidfighter/Textures/00m.png',
    },
    factions = { ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'wtr1', 'rk1', 'rtl2t', 'btl2', 'wbl2', 'bs2', 'wbr2', 'btr2', 'rtr2t', 'wtl3', 'rbl3', 'bs3', 'rbr3', 'wtr3', 'bs4', 'ws5' },
    keywords = { 'Droid' },
    config = {
        States = {
            [1] = {
                Name = "Struts (Closed)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/vultureclassdroidfighter/Vulture_Closed.obj",
                ZRot = 0,
                Message = " closed their struts.",
            },
            [2] = {
                Name = "Struts (Open)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/vultureclassdroidfighter/Vulture_Open.obj",
                ZRot = 180,
                Message = " opened their struts.",
            }
        },
        ContextText = "Open/Close Struts",
        Token = "http://nnxwing.com/Content/TTS/Config/VultureDroid.png?1.0.1"
    }
}
masterShipDB['belbulab22starfighter'] = {
    name = 'Belbullab-22',
    hull = 4,
    shield = 2,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/belbulab22starfighter/Textures/standard.jpg',
        wat =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/belbulab22starfighter/Textures/WatTambor.jpg',
        trench =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/belbulab22starfighter/Textures/HotRod.jpg',
        white =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/belbulab22starfighter/Textures/white.jpg',
        bas =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/belbulab22starfighter/Textures/bas.png',
    },
    factions = { ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'wbl1', 'wbr1', 'wtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbl3s', 'rtl3', 'wbl3', 'bs3', 'wbr3', 'rtr3', 'rbr3s', 'ws4', 'ws5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/belbulab22starfighter/Belbullab1.obj'
}

masterShipDB['sithinfiltrator'] = {
    name = 'Sith Infiltrator',
    hull = 6,
    shield = 4,
    size = 'large',
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/sithinfiltrator/Textures/standard.jpg',
        maul =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/sithinfiltrator/Textures/maul.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/sithinfiltrator/Textures/red.jpg',
        white =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/sithinfiltrator/Textures/white.jpg',
    },
    factions = { ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'rbl2s', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbr2s', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'ws4', 'rk5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/sithinfiltrator/sithinfiltrator.obj'
}

masterShipDB['resistancetransport'] = {
    name = 'Resistance Transport',
    hull = 5,
    shield = 3,
    size = 'small',
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/resistancetransport/Textures/standard.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/resistancetransport/Textures/red.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/resistancetransport/Textures/plain.jpg',
        jannah =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/resistancetransport/Textures/jannah.png',
    },
    factions = { ['resistance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/resistancetransport/transport2.obj',
    move_set = { 'rbl1r', 'rbr1r', 'rs0', 'rbl1r', 'rbr1r', 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rbl3', 'ws3', 'rbr3', 'rs4' }
}

masterShipDB['resistancetransportpod'] = {
    name = 'Resistance Transport Pod',
    shield = 1,
    hull = 3,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/resistancetransportpod/Textures/standard2.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/resistancetransportpod/Textures/plain2.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/resistancetransportpod/Textures/red2.jpg',
        dj =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/resistancetransportpod/Textures/dj.png',
    },
    factions = { ['resistance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/resistancetransportpod/pod2.obj',
    move_set = { 'rtl1', 'bbl1', 'bs1', 'bbr1', 'rtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rbl3', 'ws3', 'rbr3', 'rk3', 'rs4' }
}

masterShipDB['hyenaclassdroidbomber'] = {
    name = 'Hyena-Class Droid Bomber',
    hull = 5,
    shield = 0,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hyenaclassdroidbomber/Textures/1/standard.jpg',
        fourohfour =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hyenaclassdroidbomber/Textures/1/fourohfour.jpg',
        baktoid =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hyenaclassdroidbomber/Textures/1/baktoid.jpg',
        white =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hyenaclassdroidbomber/Textures/1/white.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hyenaclassdroidbomber/Textures/1/plain.jpg',
    },
    factions = { ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'rbl1', 'ws1', 'rbr1', 'wtr1', 'btl2', 'wbl2', 'bs2', 'wbr2', 'btr2', 'rk2', 'rtl2t', 'rtr2t', 'wtl3', 'bs3', 'wtr3', 'ws4', 'rs5' },
    keywords = { 'Droid' },
    config = {
        States = {
            [1] = {
                Name = "Struts (Closed)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hyenaclassdroidbomber/Hyena_Closedv2.obj",
                ZRot = 0,
                Message = " closed their struts.",
            },
            [2] = {
                Name = "Struts (Open)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hyenaclassdroidbomber/Hyena_Openv2.obj",
                ZRot = 180,
                Message = " opened their struts.",
            }
        },
        ContextText = "Open/Close Struts",
        Token = "http://nnxwing.com/Content/TTS/Config/HyenaDroid.png?1.0.1",

    }
}

masterShipDB['nabooroyaln1starfighter'] = {
    name = 'N-1 StarFighter',
    hull = 3,
    shield = 2,
    size = 'small',
    agility = 2,
    textures = {
        yellow =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nabooroyaln1starfighter/Textures/yellow.jpg',
        silver =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nabooroyaln1starfighter/Textures/silver.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nabooroyaln1starfighter/Textures/black.jpg',
        jinata =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nabooroyaln1starfighter/Textures/jinata.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nabooroyaln1starfighter/Textures/red.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nabooroyaln1starfighter/Textures/blue.jpg',
        mandalorian =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nabooroyaln1starfighter/Textures/mandalorian.jpg',
    },
    factions = { ['scumandvillainy'] = true, ['galacticrepublic'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wbl1', 'ws1', 'wbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'bbl3', 'bs3', 'bbr3', 'wtr3', 'rtl3t', 'rtr3t', 'ws4', 'ws5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nabooroyaln1starfighter/N1.obj'
}

masterShipDB['nantexclassstarfighter'] = {
    name = 'Nantex-Class StarFighter',
    hull = 4,
    shield = 0,
    size = 'small',
    agility = 3,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nantexclassstarfighter/Textures/newstandard.jpg',
        white =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nantexclassstarfighter/Textures/white.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nantexclassstarfighter/Textures/blue.png',
    },
    factions = { ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'bullseye' } }, turret = { main = { name = 'primary', type = { 'left', 'front', 'right' } } } },
    move_set = { 'wtl1', 'bbl1', 'bbr1', 'wtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'bbl3', 'bs3', 'bbr3', 'wtr3', 'rbl3s', 'rbr3s', 'ws4', 'ws5', 'rk5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nantexclassstarfighter/Nantex2.obj'
}

masterShipDB['btlbywing'] = {
    name = 'BTL-B Y-Wing',
    hull = 5,
    shield = 3,
    size = 'small',
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btlbywing/Textures/1/standard.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btlbywing/Textures/1/red.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btlbywing/Textures/1/blue.jpg',
        green =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btlbywing/Textures/1/green.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btlbywing/Textures/1/black.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btlbywing/Textures/1/plain.jpg',
    },
    factions = { ['galacticrepublic'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wbl1', 'bs1', 'wbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'rs4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btlbywing/BTLB_YWINGv2.obj',
    keywords = { 'Y-Wing' }
}

masterShipDB['fireball'] = {
    name = 'FireBall',
    hull = 6,
    shield = 0,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fireball/Textures/standard.jpg',
        doza =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fireball/Textures/doza.png',
    },
    factions = { ['resistance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'bbl1', 'bs1', 'bbr1', 'wtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'rtl3t', 'rtr3t', 'rs4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/fireball/fireball.obj'
}


masterShipDB['tiebainterceptor'] = {
    name = 'TIE/ba Interceptor',
    hull = 2,
    shield = 2,
    size = 'small',
    agility = 3,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiebainterceptor/Textures/standard.jpg',
        white =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiebainterceptor/Textures/white.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiebainterceptor/Textures/black.jpg',
        jank =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiebainterceptor/Textures/jank.jpg',
    },
    factions = { ['firstorder'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiebainterceptor/TieBaron.obj',
    move_set = { 'btl1', 'bbl1', 'bbr1', 'btr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rbl2s', 'rbr2s', 'bs4', 'ws5', 'rk5' },
    keywords = { 'TIE' }
}

masterShipDB['nimbusclassvwing'] = {
    name = 'Nimbus-class V-wing',
    hull = 2,
    shield = 2,
    size = 'small',
    agility = 3,
    textures = {
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nimbusclassvwing/Textures/red.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nimbusclassvwing/Textures/blue.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nimbusclassvwing/Textures/plain.jpg',
        jinata =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nimbusclassvwing/Textures/jinata.jpg',
        contrail =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nimbusclassvwing/Textures/contrail.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nimbusclassvwing/Textures/black.jpg',
    },
    factions = { ['galacticrepublic'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/nimbusclassvwing/vwing.obj',
    move_set = { 'wtl1', 'rbl1', 'rbr1', 'wtr1', 'btl2', 'bbl2', 'bs2', 'bbr2', 'btr2', 'rk2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'ws4', 'rk4', 'ws5' },
    keywords = { 'TIE' },
    config = {
        States = {
            [1] = {
                Name = "Normal",
                Model = nil,
                ZRot = 0,
                Message = " removed hyperspace ring,",
            },
            [2] = {
                Name = "Hyperspace ring mounted",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships/Small/GRP_Hyperspace_Ring/hyperspace_ring_attachment.obj",
                ZRot = 180,
                Message = " mounted an hyperspace ring.",
            }
        },
        ContextText = "Mount/unmount hyperspace ring",
    }

}

masterShipDB['tierbheavy'] = {
    name = 'TIE/rb Heavy',
    hull = 8,
    shield = 0,
    size = 'medium',
    agility = 1,
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/tierbheavy/textures/tierbheavyblue.jpg',
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/tierbheavy/textures/tierbheavygrey.jpg',
    },
    factions = { ['galacticempire'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
    cannon_follow_turret = 'main',
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/tierbheavy/tieheavy.obj',
    move_set = { 'rtl1', 'wbl1', 'bs1', 'wbr1', 'rtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtl3t', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'rtr3t', 'ws4' },
    keywords = { 'TIE' }
}

masterShipDB['xiclasslightshuttle'] = {
    name = 'Xi-class Light Shuttle',
    hull = 5,
    shield = 2,
    size = 'medium',
    agility = 2,
    textures = {
        light =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/xiclasslightshuttle/Textures/Light.jpg',
        dark =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/xiclasslightshuttle/Textures/Dark.jpg',
    },
    factions = { ['firstorder'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/xiclasslightshuttle/XiClassLightShuttle.obj',
    move_set = { 'rs0', 'bbl1', 'bs1', 'bbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'ws4' }
}

masterShipDB['laatigunship'] = {
    name = 'LAAT/i Gunship',
    hull = 8,
    shield = 2,
    charge = 2,
    size = 'medium',
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/standard.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/blue.jpg',
        hound1 =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/hound1.jpg',
        hound2 =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/hound2.jpg',
        munilist =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/munilist.jpg',
        nosecrumb =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/nosecrumb.jpg',
        nosenexu =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/nosenexu.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/red.jpg',
        stealth =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/stealth.jpg',
        warthog =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/warthog.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/Textures/1/black.jpg',
    },
    factions = { ['galacticrepublic'] = true },
    arcs = { turret = { main = { name = 'primary', type = { 'doubleturret' } } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/laatigunship/LAATv2.obj',
    move_set = { 'rs0', 'wbl1', 'bs1', 'wbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'rs4' }
}

masterShipDB['hmpdroidgunship'] = {
    name = 'HMP Droid Gunship',
    hull = 5,
    shield = 3,
    size = 'small',
    agility = 1,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hmpdroidgunship/Textures/standard.png',
    },
    factions = { ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'fullfront' } } },
    move_set = { 'rs0', 'rbl1', 'bs1', 'rbr1', 'btl2', 'wbl2', 'bs2', 'wbr2', 'btr2', 'wtl3', 'rbl3', 'ws3', 'rbr3', 'wtr3', 'rs4', 'rs5' },
    keywords = { 'Droid' },
    config = {
        States = {
            [1] = {
                Name = "Stabalizers (Inactive)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hmpdroidgunship/HMP_GunshipStable.obj",
                ZRot = 0,
                Message = " deactivated their stabilizers.",
            },
            [2] = {
                Name = "Stabalizers (Active)",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/hmpdroidgunship/HMP_GunshipSlipping.obj",
                ZRot = 180,
                Message = " activated their stabilizers.",
            }
        },
        ContextText = "Toggle Stabilizers",
        Token = "http://nnxwing.com/Content/TTS/Config/HMPGunship.png"
    }
}

masterShipDB['eta2actis'] = {
    name = 'Eta-2 Actis',
    hull = 3,
    shield = 0,
    size = 'small',
    agility = 3,
    textures = {
        jedi =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/Textures/JediGeneral.jpg',
        obi =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/Textures/ObiWanKenobi.jpg',
        anakin =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/Textures/AnakinSkywalker.jpg',
        aayla =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/Textures/AaylaSecura.jpg',
        shaak =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/Textures/ShaakTi.jpg',
        kit =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/Textures/kit.jpg',
        yoda =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/Textures/Yoda.jpg',
    },
    factions = { ['galacticrepublic'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/eta2actis/eta2actis.obj',
    move_set = { 'wtl1', 'wtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'ptl2t', 'ptr2t', 'wtl3', 'bbl3', 'bs3', 'bbr3', 'wtr3', 'bs4', 'rk4', 'ws5' },
    config = {
        States = {
            [1] = {
                Name = "Normal",
                Model = nil,
                ZRot = 0,
                Message = " removed hyperspace ring,",
            },
            [2] = {
                Name = "Hyperspace ring mounted",
                Model =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships/Small/GRP_Hyperspace_Ring/hyperspace_ring_attachment.obj",
                ZRot = 180,
                Message = " mounted an hyperspace ring.",
            }
        },
        ContextText = "Mount/unmount hyperspace ring",
    }
}

masterShipDB['droidtrifighter'] = {
    name = 'Droid Tri-Fighter',
    hull = 3,
    shield = 0,
    size = 'small',
    agility = 3,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/droidtrifighter/Textures/standard.png',
    },
    factions = { ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/droidtrifighter/CIS_Tri-Fighter.obj',
    move_set = { 'rtl1t', 'wtl1', 'wtr1', 'rtr1t', 'btl2', 'wbl2', 'bs2', 'wbr2', 'btr2', 'btl3', 'wbl3', 'bs3', 'wbr3', 'btr3', 'rk3', 'bs4', 'ws5', 'rk5' },
    keywords = { 'Droid' }
}

masterShipDB['tiewiwhispermodifiedinterceptor'] = {
    name = 'TIE/wi Whisper',
    hull = 3,
    shield = 2,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiewiwhispermodifiedinterceptor/Textures/1/standard.jpg',
    },
    factions = { ['firstorder'] = true },
    arcs = { fixed = { range = 3, type = { 'bullseye' } }, turret = { main = { name = 'primary', type = { 'front', 'back' } } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiewiwhispermodifiedinterceptor/TIE_Wiv2.obj',
    move_set = { 'wtl1', 'wtr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rbl3s', 'wtl3', 'bbl3', 'bs3', 'bbr3', 'wtr3', 'rbr3s', 'bs4', 'rk4', 'bs5', 'rk5' },
    keywords = { 'TIE' }
}

masterShipDB['tiesebomber'] = {
    name = 'TIE/se Bomber',
    hull = 4,
    shield = 2,
    size = 'small',
    agility = 2,
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiesebomber/Textures/1/standard.jpg',
    },
    factions = { ['firstorder'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/tiesebomber/tie_sev2.obj',
    move_set = { 'rtl1', 'wbl1', 'bs1', 'wbr1', 'rtr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rbl3s', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rbr3s', 'ws4' },
    keywords = { 'TIE' }
}

masterShipDB['btanr2ywing'] = {
    name = 'BTA-NR2 Y-Wing',
    hull = 4,
    shield = 3,
    size = 'small',
    agility = 1,
    textures = {
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/plain.png',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/red.png',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/blue.png',
        cai =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/caithrenalli.png',
        corus =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/coruskapellim.png',
        lega =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/legafossang.png',
        teza =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/tezanasz.png',
        wilsa =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/wilsateshlo.png',
    },
    factions = { ['resistance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/RIS_Y-Wing.obj',
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3', 'wbl3', 'bs3', 'wbr3', 'rtr3', 'rs4', 'rk5' },
    keywords = { 'Y-Wing' }
}

masterShipDB['btanr2ywing-wartime'] = {
    name = 'BTA-NR2-W Y-Wing',
    hull = 4,
    shield = 5,
    size = 'small',
    agility = 1,
    textures = {
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/plain.png',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/red.png',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/blue.png',
        cai =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/caithrenalli.png',
        corus =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/coruskapellim.png',
        lega =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/legafossang.png',
        teza =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/tezanasz.png',
        wilsa =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/Textures/wilsateshlo.png',
    },
    factions = { ['resistance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/btanr2ywing/RIS_Y-Wing.obj',
    move_set = { 'bbl1', 'bs1', 'bbr1', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtl3', 'wbl3', 'bs3', 'wbr3', 'rtr3', 'rs4', 'rk5' },
    keywords = { 'Y-Wing' }
}

masterShipDB['gauntletfighter'] = {
    name = 'Gauntlet Fighter',
    hull = 9,
    shield = 2,
    size = 'large',
    agility = 2,
    proximity_hider = true,
    factions = { ['rebelalliance'] = true, ['galacticempire'] = true, ['scumandvillainy'] = true, ['galacticrepublic'] = true, ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'frontback' } } },
    textures = {
        bokatan =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/BoKatan.jpg',
        bokatancis =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/BoKatanCIS.jpg',
        deathwatch =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/Deathwatch.jpg',
        default =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/Default.jpg',
        imperial =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/Imperial.jpg',
        maul =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/Maul.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/Plain.jpg',
        previzsla =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/PreVizla.jpg',
        scum =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/ScumColours.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/red.jpg',
        rebel =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/textures/rebel.jpg'
    },
    move_set = { 'bbl1', 'bbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtl3', 'wbl3', 'ws3', 'wbr3', 'rtr3', 'ws4', 'rs0' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/ship-base.obj',
    config = {
        States = {
            [1] = {
                Name = "Swivel Wing (Down)",
                Model =
                'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/wings-normal.obj',
                ZRot = 0,
                Message = " lowered their swivel wing.",
            },
            [2] = {
                Name = "Swivel Wing (Up)",
                Model =
                'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/large/gauntletfighter/wings-pivot.obj',
                ZRot = 0,
                Message = " raised their swivel wing.",
            }
        },
        ContextText = "Rise/lower swivel wing",
        Token = "http://nnxwing.com/Content/TTS/Config/GauntletFighter.png"
    }
}

masterShipDB['st70assaultship'] = {
    name = 'ST-70 Assault Ship',
    textures = {
        guildbountyhunter =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/st70assaultship/textures/guildbountyhunter.jpg',
        mandalorian =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/st70assaultship/textures/mandalorian.png',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/st70assaultship/textures/plain.jpg',
    },
    hull = 7,
    shield = 2,
    size = 'medium',
    agility = 2,
    factions = { ['scumandvillainy'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rtl1', 'wbl1', 'bs1', 'wbr1', 'rtr1', 'rtl2t', 'wtl2', 'wbl2', 'bs2', 'wbr2', 'wtr2', 'rtr2t', 'rtl3', 'wbl3', 'bs3', 'wbr3', 'rtr3', 'bs4', 'rk5', 'rs0' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/st70assaultship/razorcrest.obj',
}

masterShipDB['rogueclassstarfighter'] = {
    name = 'Rogue-Class Starfighter',
    textures = {
        grey =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rogueclassstarfighter/textures/Rogue-Class-Grey.jpg',
        green =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rogueclassstarfighter/textures/Rogue-Class-Green.jpg',
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rogueclassstarfighter/textures/plain.jpg',
        CIS =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rogueclassstarfighter/textures/CIS.jpg',
        white =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rogueclassstarfighter/textures/white.jpg',
        durge =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rogueclassstarfighter/textures/durge.jpg',
    },
    hull = 5,
    shield = 2,
    size = 'small',
    agility = 2,
    factions = { ['scumandvillainy'] = true, ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wtl1', 'bbl1', 'bbr1', 'wtr1', 'rtl2t', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'rtr2t', 'rtl3', 'wbl3', 'bs3', 'wbr3', 'rtr3', 'bs4', 'ws5', 'rk5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/rogueclassstarfighter/rogueclass2.obj',
}

masterShipDB['clonez95headhunter'] = {
    name = 'Clone Z-95 Headhunter',
    hull = 2,
    shield = 2,
    size = 'small',
    agility = 2,
    textures = {
        plain =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/clonez95headhunter/textures/plain.jpg',
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/clonez95headhunter/textures/standard.jpg',
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/clonez95headhunter/textures/blue.jpg',
        black =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/clonez95headhunter/textures/black.jpg',
    },
    factions = { ['galacticrepublic'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'wbl1', 'bs1', 'wbr1', 'wtl2', 'bbl2', 'bs2', 'bbr2', 'wtr2', 'wtl3', 'wbl3', 'bs3', 'wbr3', 'wtr3', 'rk3', 'ws4', 'rk4' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/small/clonez95headhunter/CloneZ95.obj'
}

-- Huge ships
masterShipDB['cr90corvette'] = {
    name = 'CR-90 Corvette',
    hull = 18,
    shield = 7,
    energy = 7,
    size = 'huge',
    agility = 0,
    mounting_points = { front = { 0, -2.63 }, rear = { 0, 2.63 } },
    factions = { ['rebelalliance'] = true, ['resistance'] = true, ['galacticrepublic'] = true },
    arcs = { fixed = { range = 4, type = { 'leftright' } } },
    move_set = { 'rbl0', 'rs0', 'rbr0', 'wbl1', 'ws1', 'wbr1', 'bbl2', 'bs2', 'bbr2', 'rbl3', 'bs3', 'rbr3', 'rs4', 'rs5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/cr90corelliancorvette/cr90.obj',
    textures = {
        blue =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/cr90corelliancorvette/Textures/blue.jpg',
        red =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/cr90corelliancorvette/Textures/red.jpg',
    },
    keywords = { 'Corvette' }
}

masterShipDB['croccruiser'] = {
    name = 'C-ROC Cruiser',
    hull = 12,
    shield = 4,
    energy = 4,
    size = 'huge',
    agility = 0,
    mounting_points = { front = { 0, -2.63 }, rear = { 0, 2.63 } },
    factions = { ['scumandvillainy'] = true, ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rbl0', 'rs0', 'rbr0', 'wbl1', 'bs1', 'wbr1', 'wbl2', 'bs2', 'wbr2', 'rbl3', 'ws3', 'rbr3', 'rs4', 'rs5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/croccruiser/croc.obj',
    textures = {
        standard =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/croccruiser/Textures/standard.jpg',
    },
    keywords = { 'Cruiser' }
}

masterShipDB['gozanticlasscruiser'] = {
    name = 'Gozanti-class Cruiser',
    hull = 11,
    shield = 5,
    energy = 3,
    size = 'huge',
    agility = 0,
    mounting_points = { front = { 0, -2.63 }, rear = { 0, 2.63 } },
    factions = { ['galacticempire'] = true, ['firstorder'] = true , ['galacticrepublic'] = true, ['separatistalliance'] = true},
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rbl0', 'rs0', 'rbr0', 'wbl1', 'bs1', 'wbr1', 'rbl2', 'bs2', 'rbr2', 'bs3', 'rs4' },
    mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/gozanticlasscruiser/gozanti.obj',
    textures = {
        standard = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/gozanticlasscruiser/Textures/standard.jpg',
    },
    keywords = { 'Cruiser' }
}

masterShipDB['gr75mediumtransport'] = {
    name = 'GR-75 Medium Transport',
    hull = 12,
    shield = 3,
    energy = 4,
    size = 'huge',
    agility = 0,
    mounting_points = { front = { 0, -2.05 }, rear = { 0, 2.05 } },
    factions = { ['rebelalliance'] = true, ['resistance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rbl0', 'rs0', 'rbr0', 'bbl1', 'bs1', 'bbr1', 'wbl2', 'ws2', 'wbr2', 'rs3', 'rs4' },
    mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/gr75mediumtransport/gr75.obj',
    textures = {
        standard = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/gr75mediumtransport/Textures/standard.jpg',
    },
    keywords = { 'Freighter' }
}

masterShipDB['raiderclasscorvette'] = {
    name = 'Raider-class Corvette',
    hull = 20,
    shield = 8,
    energy = 6,
    size = 'huge',
    agility = 0,
    mounting_points = { front = { 0, -2.63 }, rear = { 0, 2.63 } },
    factions = { ['galacticempire'] = true, ['firstorder'] = true },
    arcs = { fixed = { range = 3, type = { 'fullfront' } } },
    move_set = { 'rbl0', 'rs0', 'rbr0', 'bbl1', 'ws1', 'bbr1', 'wbl2', 'bs2', 'wbr2', 'rbl3', 'bs3', 'rbr3', 'ws4', 'rs5' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/raiderclasscorvette/raider.obj',
    textures = {
        standard = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/raiderclasscorvette/Textures/standard.jpg',
    },
    keywords = { 'Corvette' }
}

masterShipDB['tridentclassassaultship'] = {
    name = 'Trident-class Assault Ship',
    hull = 10,
    shield = 4,
    energy = 3,
    size = 'huge',
    agility = 0,
    mounting_points = { front = { 0, -2.63 }, rear = { 0, 2.63 } },
    factions = { ['scumandvillainy'] = true, ['separatistalliance'] = true },
    arcs = { fixed = { range = 3, type = { 'front' } } },
    move_set = { 'rs0', 'rbl0', 'rbr0', 'bbl2', 'bs2', 'bbr2', 'wbl3', 'bs3', 'wbr3', 'bs4', 'rk4', 'ws5', 'ws1r', 'rs2r' },
    mesh =
    'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/tridentclassassaultship/trident.obj',
    textures = {
        standard = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/huge/tridentclassassaultship/Textures/standard.jpg',
    },
    keywords = { 'Assault Ship' }
}

return masterShipDB
