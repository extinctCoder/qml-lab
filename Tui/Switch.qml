import QtQuick
import QtQuick.Templates as T
import theme

T.Switch {
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
        implicitWidth: 30
        implicitHeight: 16
        radius: Shape.radius
        color: control.checked ? (control.enabled ? Colors.primary : States.disabled_text) : Colors.surface_container_highest
        border.width: Shape.border
        border.color: !control.enabled ? States.disabled_text : control.checked ? Colors.primary : Colors.outline

        Behavior on color {
            ColorAnimation { duration: Motion.small }
        }

        Rectangle {
            readonly property int size: control.checked ? 10 : 8
            x: control.checked ? parent.width - width - 3 : 3
            anchors.verticalCenter: parent.verticalCenter
            width: size
            height: size
            radius: Math.max(1, Shape.radius - 1)
            color: !control.enabled ? States.disabled_fill : control.checked ? Colors.on_primary : Colors.outline

            Behavior on x {
                NumberAnimation { duration: Motion.small; easing.type: Motion.ease_out }
            }
            Behavior on width {
                NumberAnimation { duration: Motion.small }
            }
            Behavior on height {
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
