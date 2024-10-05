# Tabletop Simulator - X-Wing 2.0
Updated 2024 by BeardedGamer

## Setting up Visual Studio Code (VSCode) for Tabletop Simulator (TTS)

This guide details the setup of Visual Studio Code (VSCode) for developing scripts for Tabletop Simulator. The plugins listed are not necessarily required but are currently in use and recommended. If you have suggestions for better plugins, please share!

### Prerequisites
Visual Studio Code is a handy free editor that has cross-platform support. It's free and has a thriving marketplace for plugins.
https://code.visualstudio.com/

Note: The command-line name for VSCode is `code`.

## Recommended Plugins

### JSON Tools
Provides JSON syntax highlighting and formatting tools.
- [JSON by ZainChen](https://marketplace.visualstudio.com/items?itemName=ZainChen.json)

### Tabletop Simulator Lua
Support for Tabletop Simulator Lua scripting.
- [Tabletop Simulator Lua v2-rc1 by Rolandostar from GitHub](https://github.com/rolandostar/tabletopsimulator-lua-vscode)
    ```bash
    git clone git@github.com:rolandostar/tabletopsimulator-lua-vscode.git
    cd tabletopsimulator-lua-vscode/
    npm install -g @vscode/vsce
    vsce package
    code --install-extension tabletopsimulator-lua-2.0.0-rc1.vsix
    ```
- Alternatively, install the released version 1.1.3 
- [Tabletop Simulator Lua v1.1.3 by Rolandostar](https://marketplace.visualstudio.com/items?itemName=rolandostar.tabletopsimulator-lua)

### Lua by Sumenko
Provides advanced Lua editing features. Millions of downloads. Probably the best if you're using only Visual Studio Code
- [Lua by Sumneko](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)

### EmmyLua
Provides advanced Lua editing features. Also available for JetBrains IDEs.
- [EmmyLua by Tangzx](https://marketplace.visualstudio.com/items?itemName=tangzx.emmylua)

### EmmyLua Code Style
Adds code formatting for EmmyLua.
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
    "Lua.runtime.fileExtension": ".ttslua"
}
```

## Workflow Commands

- **Get Scripts**: `Ctrl+Alt+L` - Retrieve scripts from TTS to VSCode. 
- **Send Scripts**: `Ctrl+Alt+S` - Upload scripts from VSCode to TTS. 
- **Debug Bundling**: `Ctrl+Alt+I` - Points to possible problems when bundling and sending to TTS doesn't work.
- **Console++**: `Ctrl+Alt+\`` - Enhanced console access.

## Additional Setup

Rolando's TTS Lua VSCode's plugin directory is: `TabletopSimulatorLua/`

When you retrieve the scripts they will be placed in VSCode's File
Explorer under the name `In-Game Scripts`, but they will actually be located
under `%TEMP%\TabletopSimulatorLua`.

If you find it useful to use an IDE without TTS integration,
or command line tools in the repo working tree,
a symbolic link to where the files get deposited can be quite handy:
```bash
mklink /D vscode-tts %TEMP%\TabletopSimulatorLua
```
<hr>

# Setting up the Debugger

A little Background Info which may be useful: 
* Tabletop Simulator (TTS) 13.0 is written in Unity.
* TTS uses a Lua (v5.2) Interpreter from MoonSharp (v2.0.0.0).
    https://www.moonsharp.org/
* MoonSharp and Unity are written in C#.

To get the Debugger working with TTS you'll need to defeat the sandbox
which TTS has MoonSharp running in. This is actually a security safety net, but
if you want to be able to debug the Lua scripts you'll have to break out of the sandbox.

The easiest way to test if you have successfully gotten out of the sandbox, is you can now ask for a stacktrace from the Lua Interpreter.
In TTS using Chat, you can type the following:
```javascript
/execute print(debug.traceback())
```

There is an ["official" MoonSharp Extension for VSCode 1.8.3:](https://marketplace.visualstudio.com/items?itemName=xanathar.moonsharp-debug)
But it will not work without Benjamin Dobell's modifications. 

To work with Tabletop Simulator you'll need the fork by Benjamin Dobell based an older (1.8.2) version of the MoonSharp Debugger extension that he made to work with TTS.

https://github.com/tts-community/moonsharp-tts-debug

Download the `.vsix` and `.dll.zip` from here:

https://github.com/tts-community/moonsharp-tts-debug/releases

Important: Before installing Dobell's debugger, disable auto-update for all VS Code extensions.
If you don't, immediately after you install the extension from the fork that works (1.8.2), it will auto-update and install the "offical" MoonSharp version (1.8.3) which doesn't.

You can turn them on later, just not for this Debugger.

To disable auto-update in VSCode:
* `Ctrl+Shift+P` - to enter command mode
* type: `Extensions: Disable Auto Update for All Extensions`

Follow Benjamin Dobell's `README.md` on where to drop the `.dll` and how to install the extension.

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
Note: this has the corrections found here:<br/>
https://github.com/tts-community/moonsharp-tts-debug/issues/4

To learn about using Debuggers in VSCode:<br/>
https://code.visualstudio.com/docs/editor/debugging




