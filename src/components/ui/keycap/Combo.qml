pragma ComponentBehavior: Bound

import QtQuick
import theme
import components.ui.text as Text

// A key combination: several keys joined by a muted "+" (super + shift + q).
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

            Text.Mono {
                visible: cell.index > 0
                anchors.verticalCenter: parent.verticalCenter
                text: "+"
                size: "label"
                muted: true
            }
            Basic {
                anchors.verticalCenter: parent.verticalCenter
                text: cell.modelData
            }
        }
    }
}
