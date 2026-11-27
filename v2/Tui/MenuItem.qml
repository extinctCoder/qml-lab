import QtQuick
import QtQuick.Templates as T
import theme

T.MenuItem {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding
                                + (control.checkable ? implicitIndicatorWidth + spacing : 0))
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    horizontalPadding: Spacing.gap
    verticalPadding: Spacing.inner - Spacing.tight
    spacing: Spacing.inner
    font.family: Type.family
    font.pixelSize: Type.body

    contentItem: Text {
        leftPadding: !control.mirrored && control.checkable ? control.indicator.width + control.spacing : 0
        rightPadding: control.mirrored && control.checkable ? control.indicator.width + control.spacing : 0
        text: control.text
        font: control.font
        color: !control.enabled ? States.disabled_text : Colors.on_surface
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    indicator: Rectangle {
        visible: control.checkable
        x: control.mirrored ? control.width - width - control.rightPadding : control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        implicitWidth: 14
        implicitHeight: 14
        radius: Shape.radius
        color: "transparent"
        border.width: 2
        border.color: !control.enabled ? States.disabled_text : control.checked ? Colors.primary : Colors.outline

        Rectangle {
            anchors.centerIn: parent
            width: control.checked ? 6 : 0
            height: width
            radius: Math.max(1, Shape.radius - 1)
            color: Colors.primary
        }
    }

    background: Rectangle {
        implicitWidth: 180
        implicitHeight: 32
        radius: Shape.radius
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: Colors.on_surface
            opacity: !control.enabled ? 0 : control.down ? States.pressed
                : (control.highlighted || control.hovered) ? States.hover : 0

            Behavior on opacity {
                NumberAnimation { duration: Motion.small }
            }
        }
    }
}
