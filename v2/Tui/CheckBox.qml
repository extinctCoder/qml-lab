import QtQuick
import QtQuick.Templates as T
import theme

// The mark (indicator) shows checked; the overlay behind it shows current/pressed.
// Different items, different channels — they cannot collide.
T.CheckBox {
    id: control

    spacing: Spacing.inner
    padding: Spacing.tight
    font.family: Type.family
    font.pixelSize: Type.body

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    indicator: Rectangle {
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding)
                        : control.leftPadding + (control.availableWidth - width) / 2
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

        Rectangle {
            anchors.fill: parent
            anchors.margins: -Spacing.tight
            radius: Shape.radius
            color: Colors.on_surface
            opacity: !control.enabled ? 0 : control.down ? States.pressed
                : (control.hovered || control.visualFocus) ? States.hover : 0

            Behavior on opacity {
                NumberAnimation { duration: Motion.small }
            }
        }
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        text: control.text
        font: control.font
        color: !control.enabled ? States.disabled_text : Colors.on_surface
        verticalAlignment: Text.AlignVCenter
    }
}
