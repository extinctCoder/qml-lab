import QtQuick
import theme

Rectangle {
    id: root

    property bool on: false

    implicitWidth: 30
    implicitHeight: 16
    radius: Shape.radius
    color: on ? Colors.primary : Colors.surface_container_highest
    border.width: Shape.border
    border.color: on ? Colors.primary : Colors.outline

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
        x: root.on ? root.width - width - 3 : 3
        color: root.on ? Colors.on_primary : Colors.outline

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
