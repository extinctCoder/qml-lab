import QtQuick
import QtQuick.Templates as T
import theme

T.Slider {
    id: control

    implicitWidth: 200
    implicitHeight: 20
    padding: 0

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        width: control.availableWidth
        height: 10
        radius: Shape.radius
        color: Colors.surface_container_highest

        Rectangle {
            width: control.position * parent.width
            height: parent.height
            radius: Shape.radius
            color: !control.enabled ? States.disabled_text : Colors.primary
        }

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: Colors.on_surface
            opacity: !control.enabled ? 0 : control.pressed ? States.pressed
                : (control.hovered || control.visualFocus) ? States.hover : 0

            Behavior on opacity {
                NumberAnimation { duration: Motion.small }
            }
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 3
        implicitHeight: 14
        radius: 1
        visible: control.enabled
        color: Colors.on_surface
    }
}
