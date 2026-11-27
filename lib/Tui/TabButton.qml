import QtQuick
import QtQuick.Templates as T
import theme

T.TabButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    horizontalPadding: Spacing.gap
    verticalPadding: Spacing.inner
    spacing: Spacing.tight
    font.family: Type.family
    font.pixelSize: Type.label

    contentItem: Text {
        text: control.text
        font: control.font
        color: !control.enabled ? States.disabled_text : control.checked ? Colors.on_surface : Colors.on_surface_variant
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight

        Behavior on color {
            ColorAnimation { duration: Motion.small }
        }
    }

    background: Rectangle {
        color: "transparent"

        Rectangle {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - Spacing.gap
            height: Shape.focus
            color: control.checked ? (control.enabled ? Colors.primary : States.disabled_text) : "transparent"
        }

        Rectangle {
            anchors.fill: parent
            color: Colors.on_surface
            opacity: !control.enabled ? 0 : control.down ? States.pressed
                : (control.hovered || control.visualFocus) ? States.hover : 0

            Behavior on opacity {
                NumberAnimation { duration: Motion.small }
            }
        }
    }
}
