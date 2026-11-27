import QtQuick
import QtQuick.Templates as T
import theme

T.RangeSlider {
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
            x: control.first.position * parent.width
            width: (control.second.position - control.first.position) * parent.width
            height: parent.height
            radius: Shape.radius
            color: !control.enabled ? States.disabled_text : Colors.primary
        }
    }

    first.handle: Rectangle {
        x: control.leftPadding + control.first.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 3
        implicitHeight: 14
        radius: 1
        visible: control.enabled
        color: Colors.on_surface
    }

    second.handle: Rectangle {
        x: control.leftPadding + control.second.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 3
        implicitHeight: 14
        radius: 1
        visible: control.enabled
        color: Colors.on_surface
    }
}
