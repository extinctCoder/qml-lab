import QtQuick
import QtQuick.Layouts
import theme
import services

// The top bar — the first real shell panel. It only reads services and reports
// clicks; it never knows the values are simulated.
Rectangle {
    id: bar

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
        anchors.leftMargin: Spacing.gap
        anchors.rightMargin: Spacing.gap
        spacing: Spacing.gap

        // ── workspaces (left) ───────────────────────────────────────────
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

        // ── status (right) ──────────────────────────────────────────────
        Row {
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
