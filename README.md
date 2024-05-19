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


<hr>

# Setting up Visual Studio Code (VSCode) for Tabletop Simulator (TTS)

This guide details the setup of Visual Studio Code (VSCode) for developing scripts for Tabletop Simulator. The plugins listed are not necessarily required but are currently in use and recommended. If you have suggestions for better plugins, please share!

## Prerequisites
Visual Studio Code is a handy free editor that has cross-platform support. It's free and has a thriving marketplace for plugins.
https://code.visualstudio.com/

Note: The command-line name for VSCode is `code`.

## Recommended Plugins

### JSON Tools
Provides JSON syntax highlighting and formatting tools.
- [JSON by ZainChen](https://marketplace.visualstudio.com/items?itemName=ZainChen.json)

### Tabletop Simulator Lua
Support for Tabletop Simulator Lua scripting.
- [Tabletop Simulator Lua v1.1.3 by Rolandostar](https://marketplace.visualstudio.com/items?itemName=rolandostar.tabletopsimulator-lua)
    - Alternatively, install the pre-release version 2.0 from GitHub:
      ```bash
      git clone git@github.com:rolandostar/tabletopsimulator-lua-vscode.git
      cd tabletopsimulator-lua-vscode/
      npm install -g @vscode/vsce
      vsce package
      code --install-extension tabletopsimulator-lua-2.0.0-rc1.vsix
      ```

### EmmyLua
Provides advanced Lua editing features.
- [EmmyLua by Tangzx](https://marketplace.visualstudio.com/items?itemName=tangzx.emmylua)

### EmmyLua Code Style
Adds code formatting for Lua.
- [EmmyLuaCodeStyle by CppCXY](https://marketplace.visualstudio.com/items?itemName=CppCXY.emmylua-codestyle)

## VSCode Workspace Configuration

It's recommended not to check the workspace file into version control as it contains user-specific paths.

Here's an example of a typical VSCode workspace configuration:

```json
{
    "folders": [
        {
            "path": "."
        },
        {
            "name": "In-Game Scripts",
            "path": "C:/Users/<your-username>/AppData/Local/Temp/TabletopSimulatorLua"
        }
    ],
    "settings": {},
    "files.associations": {
        "*.ttslua": "lua"
    },
    "Lua.runtime.fileExtension": ".ttslua",
}
```

## Workflow Commands

- **Get Scripts**: `Ctrl+Alt+L` - Retrieve scripts from TTS to VSCode. This is different from Atom's `Ctrl+Shift+L`.
- **Send Scripts**: `Ctrl+Alt+S` - Upload scripts from VSCode to TTS. This is different from Atom's `Ctrl+Shift+S`.
- **Console++**: `Ctrl+Alt+\`` - Enhanced console access.

## Additional Setup

Note: VSCode's plugin directory is: `TabletopSimulatorLua/`
<br/>Atom's plugin directory is: `Tabletop Simulator Lua/`

When you retrieve the scripts they will be placed in VSCode's File
Explorer under the name `In-Game Scripts`, but they will actually be located
under `%TEMP%\TabletopSimulatorLua`.

If you find it useful to use an IDE without TTS integration,
or command line tools in the repo working tree,
a symbolic link to where the files get deposited can be quite handy:
```sh
mklink /D vscode %TEMP%\TabletopSimulatorLua
```
<hr>

# Setting up the Debugger

A little Background Info: 
* Tabletop Simulator (TTS) 13.0 is written in Unity.
* It uses a Lua (v5.2) Interpreter from MoonSharp (v2.0.0.0). [https://www.moonsharp.org/]
* MoonSharp is written in C#.

To get the Debugger working with TTS you'll need to defeat the sandbox
which TTS has MoonSharp running in. This is actually a security safety net, but
if you want to be able to debug the Lua scripts you'll have to break out of the sandbox.

Note: The easiest way to test if you have successfully gotten out of the sandbox, is you can now ask for a stacktrace from the Lua Interpreter.
In TTS using Chat, you can type the following:
```lua
/execute print(debug.traceback())
```

This is the "official" MoonSharp Extension for VSCode:
https://marketplace.visualstudio.com/items?itemName=xanathar.moonsharp-debug

This fork apparently uses an older version of this extension but was for use with TTS:
Note to self: Now that you've got this version working, see if the marco extension works without this fork.

Download the `.vsix` and `.dll.zip` from here:
https://github.com/tts-community/moonsharp-tts-debug/releases

Follow this `README.md` on where to drop the `.dll` and how to install the extension.

https://github.com/tts-community/moonsharp-tts-debug


You will need a `launch.json` configuration file.
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "MoonSharp Attach",
            "type": "moonsharp-debug",
            "debugServer": 41912,
            "request": "attach"
        }
    ]
}
```
Note: this is a "corrected one."
For more info: https://github.com/tts-community/moonsharp-tts-debug/issues/4

This may be useful to learn about Debuggers in VSCode.
https://code.visualstudio.com/docs/editor/debugging




