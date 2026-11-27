import QtQuick
import QtQuick.Templates as T
import theme

T.ProgressBar {
    id: control

    implicitWidth: 200
    implicitHeight: 10

    contentItem: Item {
        Rectangle {
            anchors.fill: parent
            radius: Shape.radius
            color: Colors.surface_container_highest
            clip: true

            Rectangle {
                visible: !control.indeterminate
                width: control.position * parent.width
                height: parent.height
                radius: Shape.radius
                color: !control.enabled ? States.disabled_text : Colors.primary
            }

            Rectangle {
                id: stripe
                visible: control.indeterminate
                width: parent.width * 0.3
                height: parent.height
                radius: Shape.radius
                color: Colors.primary

                NumberAnimation on x {
                    running: control.indeterminate && control.visible
                    from: -stripe.width
                    to: control.width
                    duration: 1400
                    loops: Animation.Infinite
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
