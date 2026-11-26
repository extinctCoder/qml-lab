import QtQuick
import theme

Rectangle {
    id: root

    property string kind: "radio"
    property bool on: false

    readonly property bool round: kind === "radio"

    implicitWidth: 14
    implicitHeight: 14
    radius: round ? width / 2 : Shape.radius
    color: "transparent"
    border.width: 2
    border.color: on ? Colors.primary : Colors.outline

    Behavior on border.color {
        ColorAnimation {
            duration: Motion.small
            easing.type: Motion.ease_out
        }
    }

    Rectangle {
        anchors.centerIn: parent
        readonly property int size: root.on ? (root.round ? 6 : 8) : 0
        width: size
        height: size
        radius: root.round ? size / 2 : Math.max(1, Shape.radius - 1)
        color: Colors.primary

        Behavior on width {
            NumberAnimation {
                duration: Motion.small
                easing.type: Motion.ease_out
            }
        }
        Behavior on height {
            NumberAnimation {
                duration: Motion.small
                easing.type: Motion.ease_out
            }
        }
    }
}
