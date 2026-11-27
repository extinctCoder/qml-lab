import QtQuick
import QtQuick.Templates as T
import theme

T.MenuSeparator {
    id: control

    implicitWidth: 100
    implicitHeight: Shape.border + Spacing.tight * 2
    padding: Spacing.tight
    horizontalPadding: Spacing.tight

    contentItem: Rectangle {
        implicitHeight: Shape.border
        color: Colors.outline_variant
    }
}
