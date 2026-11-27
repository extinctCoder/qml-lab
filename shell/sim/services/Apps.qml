pragma Singleton
import QtQuick

// The installed apps the launcher searches. `launch` just records the id in sim.
QtObject {
    id: root

    property var entries: [
        { "id": "firefox",   "name": "Firefox",     "category": "web",       "icon": "F", "description": "Web browser" },
        { "id": "files",     "name": "Files",       "category": "system",    "icon": "F", "description": "File manager" },
        { "id": "kitty",     "name": "kitty",       "category": "terminal",  "icon": "k", "description": "Terminal emulator" },
        { "id": "nvim",      "name": "Neovim",      "category": "editor",    "icon": "N", "description": "Text editor" },
        { "id": "code",      "name": "VS Code",     "category": "editor",    "icon": "V", "description": "Code editor" },
        { "id": "spotify",   "name": "Spotify",     "category": "music",     "icon": "S", "description": "Music player" },
        { "id": "discord",   "name": "Discord",     "category": "chat",      "icon": "D", "description": "Voice & text chat" },
        { "id": "slack",     "name": "Slack",       "category": "chat",      "icon": "S", "description": "Team chat" },
        { "id": "steam",     "name": "Steam",       "category": "games",     "icon": "S", "description": "Game library" },
        { "id": "gimp",      "name": "GIMP",        "category": "graphics",  "icon": "G", "description": "Image editor" },
        { "id": "blender",   "name": "Blender",     "category": "3d",        "icon": "B", "description": "3D creation" },
        { "id": "obsidian",  "name": "Obsidian",    "category": "notes",     "icon": "O", "description": "Notes" },
        { "id": "thunderbird","name": "Thunderbird","category": "mail",      "icon": "T", "description": "Email client" },
        { "id": "calendar",  "name": "Calendar",    "category": "time",      "icon": "C", "description": "Calendar" },
        { "id": "calc",      "name": "Calculator",  "category": "utility",   "icon": "C", "description": "Calculator" },
        { "id": "settings",  "name": "Settings",    "category": "system",    "icon": "S", "description": "System settings" },
        { "id": "screenshot","name": "Screenshot",  "category": "utility",   "icon": "S", "description": "Capture the screen" },
        { "id": "telegram",  "name": "Telegram",    "category": "chat",      "icon": "T", "description": "Messenger" }
    ]
    property string launched: ""

    function launch(id) {
        root.launched = id
    }
}
