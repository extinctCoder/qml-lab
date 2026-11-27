pragma ComponentBehavior: Bound

import QtQuick
import theme

// A key combination: several keys joined by a muted "+".
Row {
    id: root

    property var keys: []

    spacing: Spacing.tight

    Repeater {
        model: root.keys

        delegate: Row {
            id: cell
            required property int index
            required property string modelData
            spacing: Spacing.tight

            Text {
                visible: cell.index > 0
                anchors.verticalCenter: parent.verticalCenter
                text: "+"
                color: Colors.on_surface_variant
                font.family: Type.family
                font.pixelSize: Type.label
            }
            Keycap {
                anchors.verticalCenter: parent.verticalCenter
                text: cell.modelData
            }
        }
    }
}
