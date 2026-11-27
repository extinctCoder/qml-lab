pragma Singleton
import QtQuick

QtObject {
    id: root

    property var list: [
        { "id": 1, "occupied": true, "windows": [
            { "title": "kitty", "app": "terminal" },
            { "title": "nvim — lab.qml", "app": "editor" }
        ] },
        { "id": 2, "occupied": true, "windows": [
            { "title": "qml-lab — Firefox", "app": "browser" }
        ] },
        { "id": 3, "occupied": true, "windows": [
            { "title": "Spotify", "app": "music" }
        ] },
        { "id": 4, "occupied": false, "windows": [] }
    ]
    property int focused_id: 1

    function focus(id) {
        root.focused_id = id
    }
}
