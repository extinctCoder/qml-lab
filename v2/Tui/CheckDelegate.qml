import QtQuick
import QtQuick.Templates as T
import theme

// A list row with a check. Selection lives on the mark (right), so the
// background stays free for current/pressed — the two never collide.
T.CheckDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding
                                + (implicitIndicatorWidth > 0 ? implicitIndicatorWidth + spacing : 0))
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    horizontalPadding: Spacing.gap
    verticalPadding: Spacing.inner
    spacing: Spacing.inner
    font.family: Type.family
    font.pixelSize: Type.body

    contentItem: Text {
        rightPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        leftPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        text: control.text
        font: control.font
        color: !control.enabled ? States.disabled_text : Colors.on_surface
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    indicator: Rectangle {
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        implicitWidth: 16
        implicitHeight: 16
        radius: Shape.radius
        color: "transparent"
        border.width: 2
        border.color: !control.enabled ? States.disabled_text : control.checked ? Colors.primary : Colors.outline

        Rectangle {
            anchors.centerIn: parent
            width: control.checked ? 8 : 0
            height: width
            radius: Math.max(1, Shape.radius - 1)
            color: !control.enabled ? States.disabled_text : Colors.primary

            Behavior on width {
                NumberAnimation { duration: Motion.small; easing.type: Motion.ease_out }
            }
            Behavior on height {
                NumberAnimation { duration: Motion.small; easing.type: Motion.ease_out }
            }
        }
    }

    background: Rectangle {
        implicitHeight: 34
        radius: Shape.radius
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: Colors.on_surface
            opacity: !control.enabled ? 0 : control.down ? States.pressed
                : (control.hovered || control.visualFocus) ? States.hover : 0

            Behavior on opacity {
                NumberAnimation { duration: Motion.small }
            }
        }
    }
}
