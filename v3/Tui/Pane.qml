import QtQuick
import QtQuick.Templates as T
import theme

T.Pane {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    padding: Spacing.inner

    background: Rectangle {
        color: Colors.surface_container
        radius: Shape.radius
    }
}
