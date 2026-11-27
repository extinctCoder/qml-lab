import QtQuick
import QtQuick.Templates as T
import theme

T.MenuBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    delegate: MenuBarItem { }

    contentItem: Row {
        spacing: control.spacing
        Repeater { model: control.contentModel }
    }

    background: Rectangle {
        implicitHeight: 28
        color: Colors.surface_container

        Rectangle {
            y: parent.height - height
            width: parent.width
            height: Shape.border
            color: Colors.outline_variant
        }
    }
}
