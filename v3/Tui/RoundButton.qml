import QtQuick
import QtQuick.Templates as T
import theme

// A circular icon button. Same outline look as Button, but fully round.
T.RoundButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: Spacing.inner
    font.family: Type.family
    font.pixelSize: Type.title

    radius: height / 2

    contentItem: Text {
        text: control.text
        font: control.font
        color: !control.enabled ? States.disabled_text : Colors.primary
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        implicitWidth: 36
        implicitHeight: 36
        radius: control.radius
        color: "transparent"
        border.width: Shape.border
        border.color: !control.enabled ? States.disabled_fill : Colors.outline

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: Colors.on_surface
            opacity: !control.enabled ? 0 : control.down ? States.pressed
                : (control.hovered || control.visualFocus) ? States.hover : 0

            Behavior on opacity { NumberAnimation { duration: Motion.small } }
        }
    }
}
