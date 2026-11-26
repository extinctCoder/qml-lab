pragma ComponentBehavior: Bound

import QtQuick
import theme
import components.behaviors

Base {
    id: root

    property int count: 4
    readonly property int lit: ratio <= 0 ? 0 : Math.max(1, Math.round(ratio * count))

    implicitWidth: line.implicitWidth
    implicitHeight: line.implicitHeight

    Line {
        id: line
        anchors.fill: parent
        icon: root.icon
        title: root.title
        title_width: root.title_width
        label: root.label
        middle_width: bars.implicitWidth

        Row {
            id: bars
            height: 14
            spacing: 2

            Repeater {
                model: root.count

                Rectangle {
                    id: step_bar
                    required property int index
                    anchors.bottom: parent.bottom
                    width: 4
                    height: 4 + (bars.height - 4) * step_bar.index / Math.max(1, root.count - 1)
                    radius: Math.min(1, Shape.radius)
                    color: step_bar.index < root.lit ? root.shown_tone : Colors.surface_container_highest

                    Behavior on color {
                        ColorGlide {}
                    }
                }
            }
        }
    }
}
