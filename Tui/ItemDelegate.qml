import QtQuick
import QtQuick.Templates as T
import theme

// A plain list row (an action, or a choice with no mark). Selection has no mark
// to live on, so it takes the background fill; current/pressed is the overlay.
T.ItemDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    horizontalPadding: Spacing.gap
    verticalPadding: Spacing.inner
    spacing: Spacing.inner
    font.family: Type.family
    font.pixelSize: Type.body

    readonly property bool chosen: control.highlighted || control.checked

    contentItem: Text {
        text: control.text
        font: control.font
        color: !control.enabled ? States.disabled_text : control.chosen ? Colors.on_secondary_container : Colors.on_surface
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitHeight: 34
        radius: Shape.radius
        color: control.chosen ? Colors.secondary_container : "transparent"

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
