import QtQuick
import QtQuick.Templates as T
import theme

// A flat, chromeless button for toolbars. No resting fill — only the state
// overlay (current/pressed) and a green bar when checked.
T.ToolButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    horizontalPadding: Spacing.inner
    verticalPadding: Spacing.tight
    spacing: Spacing.tight
    font.family: Type.family
    font.pixelSize: Type.label

    readonly property bool selected: control.checkable && control.checked

    contentItem: Text {
        text: control.text
        font: control.font
        color: !control.enabled ? States.disabled_text
            : control.selected ? Colors.on_secondary_container : Colors.on_surface
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 36
        implicitHeight: 28
        radius: Shape.radius
        color: control.selected ? Colors.secondary_container : "transparent"

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
