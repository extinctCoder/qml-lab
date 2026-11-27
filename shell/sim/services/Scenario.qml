pragma Singleton
import QtQuick

// The device simulator. Each named scenario sets every service at once, so one
// dropdown flips the whole machine between a laptop and a desktop (and a couple
// of edge states) — no VM, no real hardware. This is what replaces an emulator.
QtObject {
    id: root

    readonly property var names: ["laptop", "desktop", "low battery", "offline"]
    property string current: "laptop"

    function apply(name) {
        root.current = name

        if (name === "laptop") {
            Power.has_battery = true; Power.battery = 80; Power.charging = false
            Power.on_battery = true; Power.profile = "balanced"
            Bluetooth.available = true; Bluetooth.enabled = true
            Display.has_brightness = true; Display.brightness = 65; Display.night_light = false
            Network.enabled = true; Network.connected = true; Network.ssid = "home-5G"; Network.strength = 72; Network.error = ""
            Audio.volume = 45; Audio.muted = false
        } else if (name === "desktop") {
            Power.has_battery = false; Power.charging = false
            Power.on_battery = false; Power.profile = "performance"
            Bluetooth.available = false; Bluetooth.enabled = false
            Display.has_brightness = false
            Network.enabled = true; Network.connected = true; Network.ssid = "ethernet"; Network.strength = 100; Network.error = ""
            Audio.volume = 60; Audio.muted = false
        } else if (name === "low battery") {
            Power.has_battery = true; Power.battery = 7; Power.charging = false
            Power.on_battery = true; Power.profile = "eco"
            Bluetooth.available = true; Bluetooth.enabled = true
            Display.has_brightness = true; Display.brightness = 40; Display.night_light = true
            Network.enabled = true; Network.connected = true; Network.ssid = "home-5G"; Network.strength = 55; Network.error = ""
            Audio.volume = 30; Audio.muted = false
        } else if (name === "offline") {
            Power.has_battery = true; Power.battery = 64; Power.charging = false
            Power.on_battery = true; Power.profile = "balanced"
            Bluetooth.available = true; Bluetooth.enabled = false
            Display.has_brightness = true; Display.brightness = 65; Display.night_light = false
            Network.enabled = false; Network.connected = false; Network.ssid = ""; Network.strength = 0; Network.error = ""
            Audio.volume = 45; Audio.muted = false
        }
    }

    Component.onCompleted: root.apply(root.current)
}
