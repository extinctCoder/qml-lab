import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme
import services

// GNOME-style quick settings: a tile grid + sliders + an action row, dropping
// from the bar's status cluster. Reads the service contract only — it never
// knows the values are simulated.
Item {
    id: qs

    property bool open: false

    width: 340
    implicitHeight: panel.implicitHeight
    height: implicitHeight
    visible: opacity > 0
    opacity: open ? 1 : 0
    transformOrigin: Item.Top
    scale: open ? 1 : 0.98

    Behavior on opacity {
        NumberAnimation {
            duration: Motion.open
            easing.type: Motion.ease_out
        }
    }
    Behavior on scale {
        NumberAnimation {
            duration: Motion.open
            easing.type: Motion.ease_out
        }
    }

    function cyclePower() {
        const i = Power.profiles.indexOf(Power.profile);
        Power.set_profile(Power.profiles[(i + 1) % Power.profiles.length]);
    }

    Rectangle {
        id: panel
        anchors.fill: parent
        implicitHeight: col.implicitHeight + Spacing.gap * 2
        color: Colors.surface_container_high
        radius: Shape.radius
        border.width: Shape.border
        border.color: Colors.outline_variant

        ColumnLayout {
            id: col
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: Spacing.gap
            spacing: Spacing.gap

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
                Label {
                    text: "vol"
                    color: Colors.on_surface_variant
                    Layout.preferredWidth: 34
                }
                Slider {
                    Layout.fillWidth: true
                    value: Audio.volume / 100
                    onMoved: Audio.set_volume(value * 100)
                }
            }
            RowLayout {
                Layout.fillWidth: true
                visible: Display.has_brightness
                Label {
                    text: "sun"
                    color: Colors.on_surface_variant
                    Layout.preferredWidth: 34
                }
                Slider {
                    Layout.fillWidth: true
                    value: Display.brightness / 100
                    onMoved: Display.set_brightness(value * 100)
                }
            }

            MenuSeparator {
                Layout.fillWidth: true
            }

            RowLayout {
                Layout.fillWidth: true
                Item {
                    Layout.fillWidth: true
                }
                Button {
                    text: "settings"
                    variant: "ghost"
                }
                Button {
                    text: "lock"
                    variant: "ghost"
                }
                Button {
                    text: "power"
                    variant: "danger"
                }
            }
        }
    }
}
