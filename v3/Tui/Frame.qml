import QtQuick
import QtQuick.Templates as T
import theme

T.Frame {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    padding: Spacing.inner

    background: Rectangle {
        color: Colors.surface_container
        radius: Shape.radius
        border.width: Shape.border
        border.color: Colors.outline_variant
    }
}
