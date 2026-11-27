import QtQuick
import QtQuick.Layouts
import theme

// The control center: one wide drop-down holding the Dashboard (2/3, tabbed) and
// Quick Settings (1/3), split by a hairline. Opens from the bar's status cluster.
Item {
    id: cc

    property bool open: false

    width: Math.min(920, parent ? parent.width - Spacing.edge * 2 : 920)
    implicitHeight: panel.implicitHeight
    height: implicitHeight
    visible: opacity > 0
    opacity: open ? 1 : 0
    transformOrigin: Item.Top
    scale: open ? 1 : 0.98

    Behavior on opacity { NumberAnimation { duration: Motion.open; easing.type: Motion.ease_out } }
    Behavior on scale { NumberAnimation { duration: Motion.open; easing.type: Motion.ease_out } }

    Rectangle {
        id: panel
        anchors.fill: parent
        implicitHeight: Math.max(row.implicitHeight + Spacing.gap * 2, 360)
        color: Colors.surface_container_high
        radius: Shape.radius
        border.width: Shape.border
        border.color: Colors.outline_variant

        RowLayout {
            id: row
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: Spacing.gap
            spacing: Spacing.gap

            Dashboard {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.horizontalStretchFactor: 2
            }
            Rectangle {
                Layout.preferredWidth: Shape.border
                Layout.fillHeight: true
                color: Colors.outline_variant
            }
            QuickSettings {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.horizontalStretchFactor: 1
            }
        }
    }
}
