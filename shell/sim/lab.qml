import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme
import services
import "../panels" as Panels

// The lab: a device emulator. Two parts, deliberately separate —
//   left  · simulation control: picks the scenario and the screen resolution.
//           This is the dev harness, NOT the shell; the shell never sees it.
//   right · the actual shell, rendered in a framed screen at the chosen size
//           (default 1200×800), scaled to fit the preview area.
Theme {
    id: lab
    width: 1360
    height: 820

    readonly property var resNames: ["1200 × 800", "1366 × 768", "1920 × 1080", "1080 × 1920"]
    readonly property var resDims: [[1200, 800], [1366, 768], [1920, 1080], [1080, 1920]]
    property int screenW: 1200
    property int screenH: 800

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // ── simulation control (dev harness, not the shell) ─────────────
        Pane {
            Layout.preferredWidth: 248
            Layout.fillHeight: true

            ScrollView {
                anchors.fill: parent
                contentWidth: availableWidth

                ColumnLayout {
                    width: parent.width
                    spacing: Spacing.gap

                    Label { text: "simulation"; color: Colors.primary; font.pixelSize: Type.title }
                    Label {
                        text: "the dev harness that fakes the machine — not part of the shell."
                        color: Colors.on_surface_variant
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                        font.pixelSize: Type.label
                    }

                    Label { text: "device"; color: Colors.on_surface_variant }
                    ComboBox {
                        Layout.fillWidth: true
                        model: Scenario.names
                        currentIndex: Scenario.names.indexOf(Scenario.current)
                        onActivated: (index) => Scenario.apply(Scenario.names[index])
                    }

                    Label { text: "resolution"; color: Colors.on_surface_variant }
                    ComboBox {
                        Layout.fillWidth: true
                        model: lab.resNames
                        onActivated: (index) => { lab.screenW = lab.resDims[index][0]; lab.screenH = lab.resDims[index][1] }
                    }

                    MenuSeparator { Layout.fillWidth: true }

                    Label { text: "overrides"; color: Colors.on_surface_variant }
                    RowLayout {
                        Layout.fillWidth: true
                        Label { text: "vol"; color: Colors.on_surface_variant; Layout.preferredWidth: 32 }
                        Slider {
                            Layout.fillWidth: true
                            value: Audio.volume / 100
                            onMoved: Audio.set_volume(value * 100)
                        }
                    }
                    Switch {
                        text: "wi-fi"
                        checked: Network.enabled
                        onToggled: Network.set_enabled(checked)
                    }
                    Switch {
                        visible: Bluetooth.available
                        text: "bluetooth"
                        checked: Bluetooth.enabled
                        onToggled: Bluetooth.set_enabled(checked)
                    }
                    Switch {
                        text: "lock screen"
                        checked: Session.locked
                        onToggled: checked ? Session.lock() : Session.unlock("")
                    }
                    Button {
                        text: "spotlight"
                        onClicked: shellView.toggleSpotlight()
                    }

                    Item { Layout.fillHeight: true; Layout.preferredHeight: Spacing.gap }

                    Label {
                        text: Scenario.current + " · " + lab.screenW + "×" + lab.screenH
                        color: Colors.on_surface_variant
                        font.pixelSize: Type.label
                    }
                }
            }
        }

        // ── the actual shell, framed at the chosen resolution ───────────
        Item {
            id: stage
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            readonly property real s: Math.min(1,
                (width - 2 * Spacing.edge) / lab.screenW,
                (height - 2 * Spacing.edge) / lab.screenH)

            Rectangle {
                id: bezel
                anchors.centerIn: parent
                width: lab.screenW * stage.s
                height: lab.screenH * stage.s
                color: Colors.surface_container_lowest
                border.width: 1
                border.color: Colors.outline

                Item {
                    width: lab.screenW
                    height: lab.screenH
                    transformOrigin: Item.TopLeft
                    scale: stage.s

                    Panels.Shell { id: shellView; anchors.fill: parent }
                }
            }
        }
    }
}
