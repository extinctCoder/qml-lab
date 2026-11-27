import QtQuick
import QtQuick.Templates as T
import theme

T.ToolBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    horizontalPadding: Spacing.inner
    verticalPadding: Spacing.tight

    background: Rectangle {
        implicitHeight: 40
        color: Colors.surface_container

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: Shape.border
            color: Colors.outline_variant
        }
    }
}
