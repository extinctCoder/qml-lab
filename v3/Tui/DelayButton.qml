import QtQuick
import QtQuick.Templates as T
import theme

// Hold to confirm: the green fill sweeps across as `progress` grows; the label
// flips to on_primary once the fill is under it.
T.DelayButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    horizontalPadding: Spacing.gap
    verticalPadding: Spacing.tight
    font.family: Type.family
    font.pixelSize: Type.label

    transition: Transition {
        NumberAnimation {
            duration: control.delay * (control.pressed ? 1.0 - control.progress : 0.3 * control.progress)
        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.progress > 0.5 ? Colors.on_primary : Colors.on_surface
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 80
        implicitHeight: 28
        radius: Shape.radius
        color: "transparent"
        border.width: Shape.border
        border.color: !control.enabled ? States.disabled_fill : Colors.outline
        clip: true

        Rectangle {
            width: control.progress * parent.width
            height: parent.height
            radius: parent.radius
            color: Colors.primary
        }
    }
}
