pragma Singleton
import QtQuick

// The session: lock state, the users to pick from, stay-awake. The sim password
// is "hunter2" (empty also unlocks, for quick demoing); anything else errors.
QtObject {
    id: root

    property bool locked: false
    property bool stay_awake: false
    property var users: [
        { "name": "seraph", "avatar": "S" },
        { "name": "guest", "avatar": "G" }
    ]
    property int current: 0
    property string error: ""

    readonly property var user: users[current]

    function lock() {
        root.locked = true
        root.error = ""
    }
    function unlock(password) {
        if (password === "" || password === "hunter2") {
            root.locked = false
            root.error = ""
        } else {
            root.error = "wrong password"
        }
    }
    function set_current(i) {
        root.current = i
        root.error = ""
    }
    function set_stay_awake(on) {
        root.stay_awake = on
    }
}
