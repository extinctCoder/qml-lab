pragma Singleton
import QtQuick

// Battery and power profile. `has_battery` is the absence-is-a-value flag: a
// desktop reports false and panels hide the battery instead of breaking.
QtObject {
    id: root

    property bool has_battery: true
    property int battery: 80          // 0–100, meaningful only when has_battery
    property bool charging: false
    property bool on_battery: true
    property string profile: "balanced"
    readonly property var profiles: ["eco", "balanced", "performance"]

    function set_profile(name) {
        root.profile = name
    }
}
