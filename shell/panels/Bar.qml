import QtQuick
import QtQuick.Layouts
import theme
import services

// The top bar. It only reads services and reports clicks; it never knows the
// values are simulated. Far-left dots open the overview; the status cluster
// opens quick settings.
Rectangle {
    id: bar

    signal quickSettings()
    signal overview()

    implicitHeight: 34
    color: Colors.surface_container

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: Shape.border
        color: Colors.outline_variant
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Spacing.tight
        anchors.rightMargin: Spacing.tight
        spacing: Spacing.gap

        // ── activities / overview (app-grid dots) ───────────────────────
        MouseArea {
            id: appsBtn
            Layout.preferredWidth: 28
            Layout.fillHeight: true
            hoverEnabled: true
            onClicked: bar.overview()

            Rectangle {
                anchors.fill: parent
                radius: Shape.radius
                color: Colors.on_surface
                opacity: appsBtn.pressed ? States.pressed : appsBtn.containsMouse ? States.hover : 0
                Behavior on opacity { NumberAnimation { duration: Motion.small } }
            }
            Grid {
                anchors.centerIn: parent
                columns: 2
                rowSpacing: 3
                columnSpacing: 3
                Repeater {
                    model: 4
                    Rectangle { width: 4; height: 4; radius: 1; color: Colors.on_surface_variant }
                }
            }
        }

        // ── workspaces ──────────────────────────────────────────────────
        Row {
            spacing: Spacing.tight
            Repeater {
                model: Workspaces.list
                Rectangle {
                    id: ws
                    required property var modelData
                    readonly property bool focused: modelData.id === Workspaces.focused_id
                    width: 22
                    height: 22
                    radius: Shape.radius
                    color: focused ? Colors.primary
                        : modelData.occupied ? Colors.surface_container_high : "transparent"
                    border.width: Shape.border
                    border.color: focused ? Colors.primary : Colors.outline_variant

                    Text {
                        anchors.centerIn: parent
                        text: ws.modelData.id
                        color: ws.focused ? Colors.on_primary : Colors.on_surface_variant
                        font.family: Type.family
                        font.pixelSize: Type.label
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Workspaces.focus(ws.modelData.id)
                    }
                }
            }
        }

        Item { Layout.fillWidth: true }

        // ── clock (centre) ──────────────────────────────────────────────
        Text {
            text: Time.clock
            color: Colors.on_surface
            font.family: Type.family
            font.pixelSize: Type.body
        }

        Item { Layout.fillWidth: true }

        // ── status (right) — opens quick settings ───────────────────────
        MouseArea {
            id: statusArea
            Layout.preferredWidth: statusRow.implicitWidth + Spacing.gap * 2
            Layout.fillHeight: true
            hoverEnabled: true
            onClicked: bar.quickSettings()

            Rectangle {
                anchors.fill: parent
                color: Colors.on_surface
                opacity: statusArea.pressed ? States.pressed : statusArea.containsMouse ? States.hover : 0
                Behavior on opacity { NumberAnimation { duration: Motion.small } }
            }

            Row {
                id: statusRow
                anchors.centerIn: parent
                spacing: Spacing.gap

                Text {
                    text: Network.connected ? Network.ssid : (Network.enabled ? "…" : "offline")
                    color: Colors.on_surface_variant
                    font.family: Type.family
                    font.pixelSize: Type.label
                }
                Text {
                    text: Audio.muted ? "muted" : "vol " + Audio.volume
                    color: Colors.on_surface_variant
                    font.family: Type.family
                    font.pixelSize: Type.label
                }
                Text {
                    visible: Power.has_battery
                    text: Power.battery + "%" + (Power.charging ? "+" : "")
                    color: Power.battery <= 15 ? Colors.warning : Colors.on_surface_variant
                    font.family: Type.family
                    font.pixelSize: Type.label
                }
            }
        }
    }
}
