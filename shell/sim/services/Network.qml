pragma Singleton
import QtQuick

// Wi-Fi. `connect` with the wrong password sets `error` (an error is a value,
// not a crash) — the `wrong password` scenario exercises it.
QtObject {
    id: root

    property bool enabled: true
    property bool connected: true
    property string ssid: "home-5G"
    property int strength: 72          // 0–100
    property string error: ""

    function set_enabled(on) {
        root.enabled = on
        if (!on)
            root.connected = false
    }

    function connect(ssid, password) {
        if (password === "" || password === "hunter2") {
            root.ssid = ssid
            root.connected = true
            root.error = ""
        } else {
            root.error = "wrong password"
        }
    }

    function disconnect() {
        root.connected = false
    }
}
