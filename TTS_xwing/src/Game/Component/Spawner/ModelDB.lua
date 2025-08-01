ModelDB = {}

-- Get an SSL-invariant version of a link
ModelDB.RectifyLink = function(link)
    return link:gsub('https', 'http')
end

-- Save model data on the object itself
ModelDB.SaveData = function(data, obj)
    obj.setTable('__ModelDB_data', data)
end

-- Load data from an object
ModelDB.LoadData = function(obj)
    return obj.getTable('__ModelDB_data')
end

-- List of ships we warned about being unrecognized in the script
ModelDB.warnList = {}
-- Warn user that this model is outsourced or unrecognized for some other reason
ModelDB.UnrecognizedWarn = function(model)
    if not ModelDB.warnList[model] then
        broadcastToAll( model.getName() .. '\'s model not recognized - use LGS in name if large base and contact author about the issue', { 1, 0.1, 0.1 })
        ModelDB.warnList[model] = true
    end
end

-- Get the data about on object (ship model)
-- Return:  {
--      arcType     <- 'P' (primary only) / 'T' (primary turret) / 'R' (aux rear) / 'S' (aux side) / 'M' (mobile)
--      type        <- ship type name (e.g. 'TIE Phantom'), for faction-variant ships faction name is added (e.g. 'Y-Wing Scum')
--      faction     <- 'Rebel' / 'Scum' / 'Imperial'
--      baseSize    <- 'large' / 'small'
--          }
-- Return empty table when ship unrecognized
-- After finding the data once it is saved on the object to speed up future calls
ModelDB.GetData = function(model)
    local saved = ModelDB.LoadData(model)
    if saved then
        return saved
    end
    local modelMesh = ModelDB.RectifyLink(model.getCustomObject().mesh)
    for faction, l1 in pairs(ModelDB.data) do
        for baseSize, l2 in pairs(l1) do
            for type, entry in pairs(l2) do
                for _, mesh in pairs(entry.meshes) do
                    if ModelDB.RectifyLink(mesh) == modelMesh then
                        local out = table.shallowcopy(entry)
                        out.meshes = nil
                        out.type = type
                        out.faction = faction
                        out.baseSize = baseSize
                        local collData = ModelDB.colliders[baseSize]
                        local collLink = ModelDB.RectifyLink(model.getCustomObject().collider)
                        for collType, collSet in pairs(collData) do
                            if table.find(collSet, collLink) then
                                out.collider = collType
                                break
                            end
                        end
                        out.collider = out.collider or 'unknown'
                        ModelDB.SaveData(out, model)
                        return out
                    end
                end
            end
        end
    end
    ModelDB.UnrecognizedWarn(model)
    return {}
end
-- Callable version of the ModelDB.GetData()
function API_ModelDB_GetData(arg)
    local model = arg
    if type(arg) == 'table' then
        model = arg[1] or arg.obj or arg.model
    end
    return ModelDB.GetData(model)
end

ModelDB.SetCollider = function(model, type)
    local data = ModelDB.GetData(model)
    if not data.baseSize or (data.collider == type) then
        return
    end

    local custom = model.getCustomObject()
    custom.collider = ModelDB.colliders[data.baseSize][type][1]
    model.setCustomObject(custom)
    return model.reload()
end
function API_ModelDB_SetCollider(args)
    return ModelDB.SetCollider(table.unpack(args))
end

ModelDB.colliders = {
    ['small'] = {
        ['full'] = { '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Small_base_Collider.obj' }
    },
    ['medium'] = {
        ['full'] = { '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Medium_base_Collider.obj' }
    },

    ['large'] = {
        ['full'] = { '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Large_base_Collider.obj' }
    }
}

-- Ship data
-- First level: tables keyed by faction name
-- Second level: tables keyed by ship size
-- Third level: entries keyed by ship type
-- Entry:   {
--      arcType: 'P' (primary only) / 'T' (turret) / 'R' (rear aux) / 'S' (side aux) / 'M' (mobile)
--          }
ModelDB.data = {
    ['Generic'] = {
        ['small'] = {
            ['Generic'] = {
                meshes = { '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Small_base_Collider.obj' }
            }
        },
        ['medium'] = {
            ['Generic'] = {
                meshes = { '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Medium_base_Collider.obj' }
            }
        },
        ['large'] = {
            ['Generic'] = {
                meshes = { '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Large_base_Collider.obj' }
            }
        }
    },
    ['Rebel'] = {
        ['small'] = {
            ['X-Wing'] = {
                arcType = 'B',
                meshes = { 'https://paste.ee/r/54FLC', 'http://cloud-3.steamusercontent.com/ugc/918052948360433857/8A34F442252CAB28DA35B0AC1A71727619EE0160/' }
            },
            ['Y-Wing Rebel'] = {
                arcType = 'B',
                meshes = { 'https://paste.ee/r/8CtXr', 'http://cloud-3.steamusercontent.com/ugc/916925021436403067/6A63EB9F88F19CD9FBF054819F8CF48B3EDA7F8D/' }
            },
            ['A-Wing'] = {
                arcType = 'B',
                meshes = { 'https://paste.ee/r/8CtXr', 'http://cloud-3.steamusercontent.com/ugc/916924876572358861/60ED8B33063D8B2B5839F73349BA90B86FEEDE5C/' }
            },
            ['B-Wing'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/978856023916887206/16AB44F32DE8A59B210D7E0A3A4F8381A2464DF4/', 'http://cloud-3.steamusercontent.com/ugc/918052678140240779/168ECD873CB31974AEBD28FDDED1EDAEA536BE07/' }
            },
            ['HWK-290 Rebel'] = {
                arcType = 'B',
                meshes = { 'https://paste.ee/r/MySkn', 'http://cloud-3.steamusercontent.com/ugc/918052832513487328/69315DA5CA41137CD71B3C6F0A099D6E882D1B53/' }
            },
            ['Attack Shuttle'] = {
                arcType = 'B',
                meshes = { 'https://paste.ee/r/jrwRJ', 'http://cloud-3.steamusercontent.com/ugc/82591194029086137/2D8471654F7BA70A5B65BB3A5DC4EB6CBE8F7C1C/', 'http://cloud-3.steamusercontent.com/ugc/918053792681986677/133D8AE4C7EAF5D88014D285672613872D3A10F8/' }
            },
            ['E-Wing'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/919177944211462889/6EC124B3D284A43AFBC0E771882BC11FC72CBD19/' }
            },
            ['Z-95 Headhunter Rebel'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/978856023915005872/A968209160A2C8834E8E90B8CB2F2AF9FEDA00BC/' }
            },
            ['TIE Fighter Rebel'] = {
                arcType = 'B',
                meshes = { 'https://paste.ee/r/aCJSv', 'http://cloud-3.steamusercontent.com/ugc/918052678139052173/90520D87399448E9DA44D309C0051C7E094F693B/' }
            },
            ['Auzituck Gunship'] = {
                arcType = 'S',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/830199836523150434/792F09608618B0AC2FF114BAA88567BA214B4A62/' }
            },
            ['Sheathipede-Class Shuttle'] = {
                arcType = 'R',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/916924876572073358/FAADE8A66298BCF220B626A3F62CFE01DB809B18/' }
            },
        },
        ['medium'] = {
            ['K-Wing'] = {
                arcType = 'T',
                meshes = { 'https://paste.ee/r/D4Jjb', 'http://cloud-3.steamusercontent.com/ugc/919178312437267295/45363CE54ED569EB3B090A18F7138D23625FC14C/' }
            },

            ['ARC-170 Rebel'] = {
                arcType = 'R',
                meshes = { 'https://paste.ee/r/D4Jjb', 'http://cloud-3.steamusercontent.com/ugc/919178208543342246/E875A639EB7B28F5E8179A063A397FE370F60139/' }
            },
            ['U-Wing'] = {
                arcType = 'P',
                meshes = { 'https://paste.ee/r/D4Jjb', 'http://cloud-3.steamusercontent.com/ugc/919175824807778899/A6E3966F632ED4EA23D35D72756194B753F571B2/' }
            },

        },
        ['large'] = {
            ['VCX-100'] = {
                arcType = 'R',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/960842902741036050/16A54202685EF407B73CE0FF2233F1608B41CD2E/' }
            },
            ['YT-1300'] = {
                arcType = 'T',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/916924876571350894/150719F1E1213672B0CC0AC3C62930040CBE83CA/' }
            },
            ['YT-2400'] = {
                arcType = 'T',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/919178449002926330/E55B4CDFA422474079D58ED44BA8917911CD77AC/' }
            },
        }
    },

    ['Scum'] = {
        ['small'] = {
            ['Z-95 Headhunter Scum'] = {
                arcType = 'P',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/960842582370212024/3A03B4797B567B8DB9887BBF912F23014CE9D54F/' }
            },
            ['Y-Wing Scum'] = {
                arcType = 'P',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/960842582370227297/72D7DD398EA3CCD217D4282E7FF8268744B57AEA/' }
            },
            ['HWK-290 Scum'] = {
                arcType = 'P',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/960842582370235209/45F49CFE7AB8B96EBAF71E8E14E0687484645E1C/' }
            },
            ['M3-A Interceptor'] = {
                arcType = 'P',
                meshes = { 'https://paste.ee/r/mUFjk', 'http://cloud-3.steamusercontent.com/ugc/82591194029096648/6773CD675FA734358137849555B2868AC513801B/', 'http://cloud-3.steamusercontent.com/ugc/786353138697577321/6773CD675FA734358137849555B2868AC513801B/' }
            },
            ['StarViper'] = {
                arcType = 'P',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946202455626561944/844DAE416555DB99E5DF9814F402189069F7C126/', 'http://cloud-3.steamusercontent.com/ugc/82591194029085780/6B4B13CE7C78700EF474D06F44CEB27A14731011/' }
            },
            ['Kihraxz Fighter'] = {
                arcType = 'P',
                meshes = { 'https://paste.ee/r/E8ZT0', 'http://cloud-3.steamusercontent.com/ugc/82591194029077425/6C88D57B03EF8B0CD7E4D91FED266EC15C614FA9/', 'http://cloud-3.steamusercontent.com/ugc/786353138697577067/6C88D57B03EF8B0CD7E4D91FED266EC15C614FA9/' }
            },
            ['Quadjumper'] = {
                arcType = 'P',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946202455626449918/D2930E1A7AFE3B73360F4CABEA338453BCB14087/aasa', 'http://cloud-3.steamusercontent.com/ugc/946202455626449918/D2930E1A7AFE3B73360F4CABEA338453BCB14087/', 'http://cloud-3.steamusercontent.com/ugc/82591194029099470/6F4716CB145832CC47231B4A30F26153C90916AE/', 'http://cloud-3.steamusercontent.com/ugc/89352927637054865/CA43D9DEC1EF65DA30EC657EC6A9101E15905C78/' }
            },
            ['Protectorate Starfighter'] = {
                arcType = 'P',
                meshes = { 'https://paste.ee/r/GmKW8', 'http://cloud-3.steamusercontent.com/ugc/918052832515237211/A3AB57E935DF5095933AA99A09D9B6525451DDF1/' }
            },
            ['Escape Craft'] = {
                arcType = 'P',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/978856023916782865/18254DDDD8D5862B3753A69AD6346BD714CA9FEA/' }
            },
            ['TIE/ln Guild'] = {
                arcType = 'P',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/957464573866599100/3740D7E15F892658BB8928E3797F33BA2AE1FB83/' }
            },

        },

        ['medium'] = {
            ['Scurrg H-6 Bomber Scum'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/978855856920317535/7DB53713F88CA3666E7CFD650678BA904E3CF1C6/' }
            },
            ['Aggressor'] = {
                arcType = 'P',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/930441690612990671/6559EDB1F3F0FB1A6C1B9F6434CD5A1B18D43873/', 'http://cloud-3.steamusercontent.com/ugc/82591194029067417/A6D736A64063BC3BC26C10E5EED6848C1FCBADB7/' }
            },
            ['G-1A StarFighter'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/978856173220650210/1EC5676EAC69E8607F83D1A513E6CB156173D902/' }
            },
            ['M12-L Kimogila Fighter'] = {
                arcType = 'P',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/978855856920243568/83B447E4E9DE560880BCADFF6D815972C0463DC5/' }
            },
            ['FireSpray-31'] = {
                arcType = 'R',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946202563785001593/BC527222487B99421D94F3E626D364DC98A99F02/', 'http://cloud-3.steamusercontent.com/ugc/946202563785001593/BC527222487B99421D94F3E626D364DC98A99F02/' }
            }

        },

        ['large'] = {
            ['JumpMaster 5000'] = {
                arcType = 'T',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/82591194029067863/A8F7079195681ECD24028AE766C8216E6C27EE21/', 'http://cloud-3.steamusercontent.com/ugc/786353138697576736/A8F7079195681ECD24028AE766C8216E6C27EE21/' }
            },
            ['YV-666'] = {
                arcType = 'S',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/82591194029090900/DD6BFD31E1C7254018CF6B03ABA1DA40C9BD0D2D/', 'http://cloud-3.steamusercontent.com/ugc/786353138697578975/DD6BFD31E1C7254018CF6B03ABA1DA40C9BD0D2D/' }
            },
            ['Lancer-Class Pursuit Craft'] = {
                arcType = 'M',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/89352769134140020/49113B3BA0A5C67FD7D40A3F61B6AFAFF02E0D1F/' }
            },
            ['YT-1300 Scum'] = {
                arcType = 'T',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/918053186550884079/F5B923DC454650F390E8DE99F660D662D0BD749F/' }
            },
        },

    },

    ['Imperial'] = {
        ['small'] = {
            ['TIE Fighter'] = {
                arcType = 'B',
                meshes = { 'https://paste.ee/r/Yz0kt', 'http://cloud-3.steamusercontent.com/ugc/916925021432074935/70592DBBF3C74A03755DD17E7563FED14147BE69/' }
            },
            ['TIE Interceptor'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946201442188779524/19B9FFEB5CAEBA9AA16FFEC05E1ED6AAFA5C6BBB/', 'https://paste.ee/r/JxWNX', 'http://cloud-3.steamusercontent.com/ugc/82591194029074075/3AAF855C4A136C58E933F7409D0DB2C73E1958A9/', 'http://cloud-3.steamusercontent.com/ugc/82591194029086817/BD640718BFFAC3E4B5DF6C1B0220FB5A87E5B13C/' }
            },
            ['TIE Bomber'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946202228019356307/18EEEDD6E9ED0C53A51E4A35AEA9E10971B84C2A/', 'http://cloud-3.steamusercontent.com/ugc/82591194029070985/D0AF97C6FB819220CF0E0E93137371E52B77E2DC/' }
            },
            ['TIE Phantom'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946202455626338103/BD166815A586706AB93821AD29ACC25D9029439D/', 'http://cloud-3.steamusercontent.com/ugc/82591194029085339/CD9FEC659CF2EB67EE15B525007F784FB13D62B7/' }
            },
            ['TIE Advanced'] = {
                arcType = 'B',
                meshes = { 'https://paste.ee/r/NeptF', 'http://cloud-3.steamusercontent.com/ugc/916924876572407779/C25A78012DC787FA81B6F188E2F8E8A9308812B4/' }
            },
            ['TIE Defender'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946201592704466163/FE94FDFD903A9899F5B534F94048EEA6EF0C8B79/', 'http://cloud-3.steamusercontent.com/ugc/82591194029067091/F2165ABE4580BD5CCECF258CCE790CD9A942606F/' }
            },
            ['TIE Adv. Prototype'] = {
                arcType = 'B',
                meshes = { 'https://paste.ee/r/l7cuZ', 'http://cloud-3.steamusercontent.com/ugc/82591194029089434/A4DA1AD96E4A6D65CC6AE4F745EDA966BA4EF85A/', 'http://cloud-3.steamusercontent.com/ugc/786353138697578650/A4DA1AD96E4A6D65CC6AE4F745EDA966BA4EF85A/' }
            },
            ['TIE Striker'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946202126804926550/065A4FF9D2CB86710ECFDC973B7200EBB6111406/' }
            },
            ['TIE Aggressor'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946202030215779718/4826ED39807478C70B11DFC498006AF1BD73D9DC/' }
            },
            ['Alpha-Class Star Wing'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946201442190443315/1D51DACFC18FD5BFE7AFF3B07C60A77D57D3969D/' }
            },
        },
        ['medium'] = {
            ['TIE Punisher'] = {
                arcType = 'P',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946202334135716947/252FA9025598944D4B5F7397BAC5981E977BE126/', 'http://cloud-3.steamusercontent.com/ugc/82591194029073355/7A1507E4D88098D19C8EAFE4A763CC33A5EC35CB/' }
            },
            ['TIE Reaper'] = {
                arcType = 'P',
                meshes = { 'https://paste.ee/r/D4Jjb', 'http://cloud-3.steamusercontent.com/ugc/919176129629776982/3B648119BDA2E7A8694C81F5F8D385BDFED7C60C/' }
            },
        },
        ['large'] = {
            ['VT-49 Decimator'] = {
                arcType = 'T',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/960842902741075419/4C089B9BFCFF2373074DBB1C7BF4C3D6E549F9C5/' }
            },
            ['Lambda-Class Shuttle'] = {
                arcType = 'R',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/946201924931049080/CD9A879D641D91A42968EE6B68E6D0E81576D15C/' }
            },
        }
    },
    ['First Order'] = {
        ['small'] = {
            ['TIE/sf'] = {
                arcType = 'R',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/960842582370330742/45412D7C595D0A59E67FA0B68F12CDF34DB4A850/' }
            },
            ['TIE/ba'] = {
                arcType = 'R',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/1005935781612113099/1537396A193FB0F1E281C5A40F72407E51FAF4A9/' }
            },
            ['TIE/fo'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/957464720567202663/EBDEDD67FF7BD89EE015A0F56653CD7EE7B369F7/' }
            },
            ['TIE Silencer'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/960842902746031058/E49CB245DD4C0DAB13D727214C25F0B1CF947D35/' }
            }
        },
        ['medium'] = {},
        ['large'] = {
            ['Upsilon Class Shuttle'] = {
                arcType = 'P',
                meshes = { 'http://pastebin.com/nsHXF9XV' }
            },
        },
    },
    ['Resistance'] = {
        ['small'] = {
            ['T-70 X-Wing'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/957464573866846107/A29F7BFB9FE4942EDF822F7FA6552A07F8BE2DF2/' }
            },
            ['A-Wing RZ2'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/957464412124368928/176B45D52F1EFBC9C19FF32890B3BF359F795916/' }
            },
            ['Fireball'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/769477558847227779/A2415656F3E0AB863FC65B87BE3B99A16B041232/' }
            },
            ['Resistance Transport'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/959738243815490417/32A2F51AF355C42F9A30E2FBB6A4962D86655B5A/' }
            },
            ['Transport Pod'] = {
                arcType = 'B',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/959738243815492444/403A7B37C2F22FBE6A72AC3FBE5B0B0571B77D0A/' }
            },
        },
        ['medium'] = {},
        ['large'] = {
            ['B/SF-17 Bomber'] = {
                arcType = 'T',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/957464720571290011/F9E82239A431322A1639FD30A92A870F3914E7E9/' }
            },
            ['Salvaged YT-1300'] = {
                arcType = 'T',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/916924876571984935/BB012385651C04D21CB41B44F11C4288A87A616B/' }
            },

        }
    },
    ['Republic'] = {
        ['small'] = {
            ['V-19'] = {
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/947346690647402101/D0199140EB5D8B6A2931CA5A4F16D15CF2F9944B/' } },
            ['Delta-7'] = {
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/960842902741967042/314CB73974C7868C1B6E445F08D594BCAD5E33CD/' } },
            ['Naboo Starfighter'] = {
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/943970729014570907/DC6C4AA277A2B084827736B3DB8818CCC04266C9/' } },
            ['BTL-B Y-Wing'] = {
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/958613321556922860/FAAF973F0962EB4A537FC268313AF11F5CA16762/' } }
        },
        ['medium'] = {
            ['ARC-170 Republic'] = {
                arcType = 'R',
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/943970486583164606/3333C3E276C23D6ED4137A44EB0C07291730E3B4/', 'http://cloud-3.steamusercontent.com/ugc/943970486583146133/E875A639EB7B28F5E8179A063A397FE370F60139/' }
            }
        },
        ['large'] = {}
    },
    ['Separatist'] = {
        ['small'] = {
            ['Belbullab'] = {
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/947346371439640117/D3E9814390E9000A3D9B90FF564B9FA1E0F12C7C/' } },
            ['Hyena Bomber'] = {
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/943970922559272193/BC3FE066411B715C5D1336CFB28ABD14605F400C/' } },
            ['Vulture'] = {
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/947346371433468720/9AC0EE35865B9D1813A26E31BA7C1FF777A168D6/' } },
            ['Nantek'] = {
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/958613321557215803/79F85B59398FF398CC321BDB58445EDE1E99646F/' } }
        },
        ['medium'] = {},
        ['large'] = {
            ['Infiltrator'] = {
                meshes = { 'http://cloud-3.steamusercontent.com/ugc/947346087270486434/BC2C598ABFE31DDB0475DCC85E5FD4C1120B2E76/' } }
        }
    }

}
