import QtQuick
import QtQuick.Templates as T
import theme

// The whole thesis in one file: a Button, flat and square, in our look. Qt's
// T.Button owns every behaviour — hover, press, keyboard activation, checkable,
// focus, accessibility. We only read its state and paint it.
//
//   background overlay  ← control.down / hovered / visualFocus   (the "current" channel)
//   border + fill       ← control.checked                        (the selected channel)
//   content tone        ← control.enabled                        (disabled)
T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    horizontalPadding: Spacing.gap
    verticalPadding: Spacing.tight
    spacing: Spacing.tight

    font.family: Type.family
    font.pixelSize: Type.label

    // The one style-level option. Works because the style file IS the Button type
    // when the Tui style is active, so `Button { variant: "primary" }` just works.
    property string variant: "outline"

    readonly property bool selected: control.checkable && control.checked
    readonly property var look: ({
            primary: { fill: Colors.primary, label: Colors.on_primary, line: "none" },
            tonal: { fill: Colors.secondary_container, label: Colors.on_secondary_container, line: "none" },
            outline: { fill: "transparent", label: Colors.primary, line: Colors.outline },
            ghost: { fill: "transparent", label: Colors.primary, line: "none" },
            danger: { fill: "transparent", label: Colors.error, line: Colors.error }
        })[variant]
    readonly property bool lined: look.line !== "none"

    readonly property color tone: !control.enabled ? States.disabled_text
        : selected ? Colors.on_secondary_container
        : look.label

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.tone
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 64
        implicitHeight: 28
        radius: Shape.radius
        color: !control.enabled ? ((control.selected || control.look.fill !== "transparent") ? States.disabled_fill : "transparent")
            : control.selected ? Colors.secondary_container
            : control.look.fill
        border.width: (control.selected || control.lined) ? Shape.border : 0
        border.color: !control.enabled ? States.disabled_fill
            : control.selected ? Colors.primary
            : control.lined ? control.look.line
            : "transparent"

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: Colors.on_surface
            opacity: !control.enabled ? 0
                : control.down ? States.pressed
                : (control.hovered || control.visualFocus) ? States.hover
                : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: Motion.small
                    easing.type: Motion.ease_out
                }
            }
        }
    }
}
