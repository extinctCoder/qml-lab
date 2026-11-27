import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme
import services

// Quick-settings content (tiles + sliders + actions). No container of its own —
// it lives in the 1/3 column of the control center.
ColumnLayout {
    id: qs
    spacing: Spacing.gap

    function cyclePower() {
        const i = Power.profiles.indexOf(Power.profile);
        Power.set_profile(Power.profiles[(i + 1) % Power.profiles.length]);
    }

    Label {
        text: "quick settings"
        color: Colors.primary
        font.family: Type.family
        font.pixelSize: Type.title
    }

    GridLayout {
        columns: 2
        rowSpacing: Spacing.inner
        columnSpacing: Spacing.inner
        Layout.fillWidth: true

        Tile {
            Layout.fillWidth: true
            title: "Wi-Fi"
            subtitle: Network.connected ? Network.ssid : (Network.enabled ? "on" : "off")
            active: Network.enabled
            onClicked: Network.set_enabled(!Network.enabled)
        }
        Tile {
            Layout.fillWidth: true
            visible: Bluetooth.available
            title: "Bluetooth"
            subtitle: Bluetooth.enabled ? "on" : "off"
            active: Bluetooth.enabled
            onClicked: Bluetooth.set_enabled(!Bluetooth.enabled)
        }
        Tile {
            Layout.fillWidth: true
            visible: Display.has_brightness
            title: "Night Light"
            subtitle: Display.night_light ? "on" : "off"
            active: Display.night_light
            onClicked: Display.set_night_light(!Display.night_light)
        }
        Tile {
            Layout.fillWidth: true
            title: "Power"
            subtitle: Power.profile
            active: Power.profile !== "balanced"
            onClicked: qs.cyclePower()
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Label { text: "vol"; color: Colors.on_surface_variant; Layout.preferredWidth: 34 }
        Slider {
            Layout.fillWidth: true
            value: Audio.volume / 100
            onMoved: Audio.set_volume(value * 100)
        }
    }
    RowLayout {
        Layout.fillWidth: true
        visible: Display.has_brightness
        Label { text: "sun"; color: Colors.on_surface_variant; Layout.preferredWidth: 34 }
        Slider {
            Layout.fillWidth: true
            value: Display.brightness / 100
            onMoved: Display.set_brightness(value * 100)
        }
    }

    Item { Layout.fillHeight: true }

    RowLayout {
        Layout.fillWidth: true
        Item { Layout.fillWidth: true }
        Button { text: "settings"; variant: "ghost" }
        Button { text: "lock"; variant: "ghost" }
        Button { text: "power"; variant: "danger" }
    }
}
