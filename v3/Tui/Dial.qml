import QtQuick
import QtQuick.Templates as T
import theme

// A ring with a green handle dot — no gradients, no stray colour. The dot is
// placed around the ring by control.angle (0° = top).
T.Dial {
    id: control

    implicitWidth: 56
    implicitHeight: 56

    background: Rectangle {
        x: control.width / 2 - width / 2
        y: control.height / 2 - height / 2
        width: Math.min(control.width, control.height)
        height: width
        radius: width / 2
        color: "transparent"
        border.width: 2
        border.color: !control.enabled ? States.disabled_text : Colors.outline
    }

    handle: Rectangle {
        readonly property real radius_: Math.min(control.width, control.height) / 2 - 7
        readonly property real a: (control.angle - 90) * Math.PI / 180
        width: 9
        height: 9
        radius: width / 2
        color: !control.enabled ? States.disabled_text : Colors.primary
        x: control.width / 2 + radius_ * Math.cos(a) - width / 2
        y: control.height / 2 + radius_ * Math.sin(a) - height / 2
    }
}
