import QtQuick
import theme

Base {
    id: root

    implicitWidth: 30
    implicitHeight: 16

    Rectangle {
        id: track
        anchors.fill: parent
        radius: Shape.radius
        color: root.on ? root.on_color : Colors.surface_container_highest
        border.width: Shape.border
        border.color: root.tone

        Behavior on color {
            ColorAnimation {
                duration: Motion.small
                easing.type: Motion.ease_out
            }
        }

        Rectangle {
            id: thumb
            readonly property int size: root.on ? 10 : 8
            width: size
            height: size
            radius: Math.max(1, Shape.radius - 1)
            anchors.verticalCenter: parent.verticalCenter
            x: root.on ? track.width - width - 3 : 3
            color: root.on ? Colors.on_primary : root.off_color

            Behavior on x {
                NumberAnimation {
                    duration: Motion.small
                    easing.type: Motion.ease_out
                }
            }
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
            Behavior on color {
                ColorAnimation {
                    duration: Motion.small
                    easing.type: Motion.ease_out
                }
            }
        }
    }
}
