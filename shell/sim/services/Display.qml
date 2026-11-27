pragma Singleton
import QtQuick

// `has_brightness` is absence-as-a-value again: many desktop monitors expose no
// software brightness, so the panel hides the slider.
QtObject {
    id: root

    property bool has_brightness: true
    property int brightness: 65        // 0–100
    property bool night_light: false

    function set_brightness(v) {
        root.brightness = Math.max(0, Math.min(100, Math.round(v)))
    }

    function set_night_light(on) {
        root.night_light = on
    }
}
