import QtQuick
import theme
import components.behaviors

Base {
    id: root

    implicitWidth: 30
    implicitHeight: 16

    Rectangle {
        id: track
        anchors.fill: parent
        radius: Shape.radius
        color: root.on ? root.tone : Colors.surface_container_highest
        border.width: Shape.border
        border.color: root.tone

        Behavior on color {
            ColorGlide {}
        }

        Rectangle {
            id: thumb
            readonly property int size: root.on ? 10 : 8
            width: size
            height: size
            radius: Math.max(1, Shape.radius - 1)
            anchors.verticalCenter: parent.verticalCenter
            x: root.on ? track.width - width - 3 : 3
            color: root.on ? Colors.on_primary : root.tone

            Behavior on x {
                Glide {}
            }
            Behavior on width {
                Glide {}
            }
            Behavior on height {
                Glide {}
            }
            Behavior on color {
                ColorGlide {}
            }
        }
    }
}
