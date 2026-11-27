import QtQuick
import QtQuick.Templates as T
import theme

T.ToolSeparator {
    id: control

    leftPadding: Spacing.tight
    rightPadding: Spacing.tight
    topPadding: Spacing.tight
    bottomPadding: Spacing.tight

    implicitWidth: Math.max(implicitContentWidth + leftPadding + rightPadding, 1)
    implicitHeight: Math.max(implicitContentHeight + topPadding + bottomPadding, 1)

    contentItem: Rectangle {
        implicitWidth: control.vertical ? Shape.border : 16
        implicitHeight: control.vertical ? 16 : Shape.border
        color: Colors.outline_variant
    }
}
