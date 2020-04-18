# Tabletop Simulator - X-Wing 2.0
Updated Dec 6, 2019 by infinityLoop


## Setting Up Your Environment

1.  Download [ATOM IDE](https://atom.io/) as it has a TTS LUA integration
2.  Install [TTS-Lua](https://atom.io/packages/tabletopsimulator-lua) package through the package manager in Settings->Packages
3.  Move `TTS_Lib` and `TTS_xwing` from the repository into your tabletop simulator mod directory
    * (Default Windows directory) C:\Users\ {User}\Documents\My Games\Tabletop Simulator\
    It is also possible to create a symbolic link from the Simulator mod directory to `TTS_Lib` and `TTS_xwing` in your repository.


## Previewing Changes
Changes to the mod won't be compile until mod deployment

You will have to compile the changes to an existing save game
* Open Tabletop Simulator and load the X-wing 2.0 Unified Mod
    * Save the game under Games -> Save & Load
* While TTS is still opened, switch over to Atom and under `Packages -> Tabletop Simulator`, select `Get LUA Scripts (Ctrl-Shift-L)`
    * This will load the running game scripts into Atom
* To save and see changes, under `Packages -> Tabletop Simulator`, select `Save and Play (Ctrl-Shift-S)`

## Troubleshooting

Error - `Could not catalog #include - file not found:`
* Check to make sure you have moved `TTS_Lib` and `TTS_xwing` to the Tabletop Simulator Directory in step 3 of setup

* If they exist, check to make sure the path from the package to the directory is correct.
    * The default path seems to exclude the `My Games` directory so you may have to manually set it
    * You can set this in `Settings -> Packages -> Settings -> Base path for files you want to #include`
