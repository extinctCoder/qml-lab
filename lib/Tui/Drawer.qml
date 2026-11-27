import QtQuick
import QtQuick.Templates as T
import theme

T.Drawer {
    id: control

    parent: T.Overlay.overlay

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    enter: Transition { SmoothedAnimation { velocity: 5 } }
    exit: Transition { SmoothedAnimation { velocity: 5 } }

    background: Rectangle {
        color: Colors.surface_container
        readonly property bool horizontal: control.edge === Qt.LeftEdge || control.edge === Qt.RightEdge

        Rectangle {
            width: parent.horizontal ? Shape.border : parent.width
            height: parent.horizontal ? parent.height : Shape.border
            color: Colors.outline_variant
            x: control.edge === Qt.LeftEdge ? parent.width - width : 0
            y: control.edge === Qt.TopEdge ? parent.height - height : 0
        }
    }

    T.Overlay.modal: Rectangle { color: Qt.rgba(0.02, 0.02, 0.04, 0.6) }
    T.Overlay.modeless: Rectangle { color: Qt.rgba(0.02, 0.02, 0.04, 0.4) }
}
