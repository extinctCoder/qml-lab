import QtQuick
import QtQuick.Templates as T
import theme

// You type inside a field, so focus shows on the field's own border (accent),
// not a ring around it. An error turns the border error-coloured.
T.TextField {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    padding: Spacing.inner
    leftPadding: Spacing.inner + 2

    color: enabled ? Colors.on_surface : States.disabled_text
    placeholderTextColor: Colors.on_surface_variant
    selectionColor: Colors.secondary_container
    selectedTextColor: Colors.on_secondary_container
    font.family: Type.family
    font.pixelSize: Type.body

    background: Rectangle {
        implicitWidth: 240
        implicitHeight: control.font.pixelSize + Spacing.inner * 2 + 2
        radius: Shape.radius
        color: "transparent"
        border.width: control.activeFocus ? Shape.focus : Shape.border
        border.color: !control.enabled ? States.disabled_fill
            : control.activeFocus ? Colors.primary
            : Colors.outline_variant

        Behavior on border.color {
            ColorAnimation { duration: Motion.small }
        }
    }
}
