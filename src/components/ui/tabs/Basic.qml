pragma ComponentBehavior: Bound

import QtQuick
import theme
import components.behaviors

Item {
    id: root

    property var tabs: []
    property int current: 0
    signal selected(int index)

    readonly property Base active_tab: repeater.count > current ? repeater.itemAt(current) as Base : null

    implicitWidth: row.implicitWidth + Spacing.tight * 2
    implicitHeight: row.implicitHeight + Shape.border

    Roving {
        id: group
        orientation: "row"
        selects: true
    }

    Row {
        id: row
        x: Spacing.tight
        spacing: 2

        Repeater {
            id: repeater
            model: root.tabs

            Base {
                required property int index
                required property string modelData
                text: modelData
                active: index === root.current
                roving: group
                onClicked: if (index !== root.current)
                    root.selected(index)
            }
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: Shape.border
        color: Colors.outline_variant
    }

    Rectangle {
        visible: root.active_tab !== null
        anchors.bottom: parent.bottom
        x: root.active_tab ? row.x + root.active_tab.x + root.active_tab.word.x : 0
        width: root.active_tab ? root.active_tab.word.width : 0
        height: Shape.focus
        color: root.enabled ? Colors.primary : States.disabled_text

        Behavior on x {
            Glide {}
        }
        Behavior on width {
            Glide {}
        }
    }
}
