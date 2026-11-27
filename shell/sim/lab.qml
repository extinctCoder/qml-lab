import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme
import services

// The lab: the shell's gallery. Every service shown with Tui controls, fed by the
// mock spine. The scenario dropdown flips the whole machine — pick `desktop` and
// the battery, Bluetooth and brightness vanish; pick `laptop` and they return.
// Controls drive the services back (drag volume → Audio.set_volume), proving the
// contract both ways. Pure QtQuick: no Quickshell here.
Theme {
    id: root
    width: 520
    height: 720

    component Section: ColumnLayout {
        property string title
        default property alias body: inner.data
        Layout.fillWidth: true
        spacing: Spacing.inner
        Label {
            text: parent.title
            color: Colors.primary
            font.pixelSize: Type.title
            font.family: Type.family
        }
        ColumnLayout { id: inner; Layout.fillWidth: true; spacing: Spacing.inner }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            width: root.width
            spacing: Spacing.edge

            Item { implicitHeight: Spacing.tight }

            // ── header: device picker + clock ───────────────────────────────
            RowLayout {
                Layout.leftMargin: Spacing.edge
                Layout.rightMargin: Spacing.edge
                Layout.fillWidth: true
                spacing: Spacing.gap

                ColumnLayout {
                    spacing: 0
                    Label { text: "lab · " + Scenario.current; color: Colors.primary; font.pixelSize: Type.title }
                    Label { text: Time.clock + " · " + Time.day; color: Colors.on_surface_variant; font.pixelSize: Type.label }
                }
                Item { Layout.fillWidth: true }
                ComboBox {
                    model: Scenario.names
                    currentIndex: Scenario.names.indexOf(Scenario.current)
                    onActivated: Scenario.apply(Scenario.names[index])
                }
            }

            ColumnLayout {
                Layout.leftMargin: Spacing.edge
                Layout.rightMargin: Spacing.edge
                Layout.fillWidth: true
                spacing: Spacing.edge

                // ── power ───────────────────────────────────────────────────
                Section {
                    title: "Power"
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: Spacing.gap
                        visible: Power.has_battery
                        Label {
                            text: Power.battery + "%" + (Power.charging ? " · charging" : Power.on_battery ? " · on battery" : "")
                            color: Power.battery <= 15 ? Colors.warning : Colors.on_surface
                        }
                        ProgressBar { Layout.fillWidth: true; value: Power.battery / 100 }
                    }
                    Label {
                        visible: !Power.has_battery
                        text: "no battery · desktop"
                        color: Colors.on_surface_variant
                    }
                    RowLayout {
                        spacing: Spacing.inner
                        Label { text: "profile"; color: Colors.on_surface_variant }
                        ComboBox {
                            model: Power.profiles
                            currentIndex: Power.profiles.indexOf(Power.profile)
                            onActivated: Power.set_profile(Power.profiles[index])
                        }
                    }
                }

                // ── audio ───────────────────────────────────────────────────
                Section {
                    title: "Audio"
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: Spacing.gap
                        Label { text: "vol " + Audio.volume; color: Colors.on_surface; Layout.preferredWidth: 60 }
                        Slider {
                            Layout.fillWidth: true
                            value: Audio.volume / 100
                            onMoved: Audio.set_volume(value * 100)
                        }
                        Switch {
                            text: "mute"
                            checked: Audio.muted
                            onToggled: Audio.toggle_mute()
                        }
                    }
                }

                // ── network ─────────────────────────────────────────────────
                Section {
                    title: "Network"
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: Spacing.gap
                        Switch {
                            text: "wi-fi"
                            checked: Network.enabled
                            onToggled: Network.set_enabled(checked)
                        }
                        Label {
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignRight
                            text: !Network.enabled ? "off"
                                : Network.connected ? (Network.ssid + " · " + Network.strength + "%")
                                : "disconnected"
                            color: Network.connected ? Colors.on_surface : Colors.on_surface_variant
                        }
                    }
                }

                // ── bluetooth ───────────────────────────────────────────────
                Section {
                    title: "Bluetooth"
                    Switch {
                        visible: Bluetooth.available
                        text: Bluetooth.enabled ? "on" : "off"
                        checked: Bluetooth.enabled
                        onToggled: Bluetooth.set_enabled(checked)
                    }
                    Label {
                        visible: !Bluetooth.available
                        text: "no adapter · desktop"
                        color: Colors.on_surface_variant
                    }
                }

                // ── display ─────────────────────────────────────────────────
                Section {
                    title: "Display"
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: Spacing.gap
                        visible: Display.has_brightness
                        Label { text: "sun " + Display.brightness; color: Colors.on_surface; Layout.preferredWidth: 60 }
                        Slider {
                            Layout.fillWidth: true
                            value: Display.brightness / 100
                            onMoved: Display.set_brightness(value * 100)
                        }
                    }
                    Label {
                        visible: !Display.has_brightness
                        text: "no brightness control · desktop"
                        color: Colors.on_surface_variant
                    }
                    Switch {
                        text: "night light"
                        checked: Display.night_light
                        onToggled: Display.set_night_light(checked)
                    }
                }

                // ── workspaces ──────────────────────────────────────────────
                Section {
                    title: "Workspaces"
                    RowLayout {
                        spacing: Spacing.inner
                        Repeater {
                            model: Workspaces.list
                            Button {
                                required property var modelData
                                text: modelData.id
                                variant: modelData.id === Workspaces.focused_id ? "primary" : "outline"
                                onClicked: Workspaces.focus(modelData.id)
                            }
                        }
                    }
                }
            }

            Item { implicitHeight: Spacing.edge }
        }
    }
}
