import QtQuick
import theme

Base {
    id: root

    property string kind: "radio"
    readonly property bool round: kind === "radio"

    implicitWidth: 14
    implicitHeight: 14

    Rectangle {
        anchors.fill: parent
        radius: root.round ? width / 2 : Shape.radius
        color: "transparent"
        border.width: 2
        border.color: root.tone

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
            color: root.on_color

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
}
