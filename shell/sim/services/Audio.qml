pragma Singleton
import QtQuick

QtObject {
    id: root

    property int volume: 45           // 0–100
    property bool muted: false

    function set_volume(v) {
        root.volume = Math.max(0, Math.min(100, Math.round(v)))
    }

    function toggle_mute() {
        root.muted = !root.muted
    }
}
