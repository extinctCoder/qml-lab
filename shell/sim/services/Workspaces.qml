pragma Singleton
import QtQuick

QtObject {
    id: root

    property var list: [
        { "id": 1, "occupied": true },
        { "id": 2, "occupied": true },
        { "id": 3, "occupied": false },
        { "id": 4, "occupied": false }
    ]
    property int focused_id: 1

    function focus(id) {
        root.focused_id = id
    }
}
