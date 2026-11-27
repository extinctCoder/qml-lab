import QtQuick
import theme

// A thin indicator for a Flickable (or ListView). Point it at `target`; it
// shows only when the content overflows, and tracks the visible area. Sits at
// the right edge (or the bottom, when `horizontal`). It indicates, it doesn't
// grab — the list scrolls by wheel or drag, as a terminal's does.
Rectangle {
    id: root

    property Flickable target: null
    property bool horizontal: false

    readonly property bool needed: target
        && (horizontal ? target.contentWidth > target.width + 1 : target.contentHeight > target.height + 1)

    visible: needed
    color: Colors.outline_variant
    radius: Shape.radius

    width: horizontal ? (target ? target.visibleArea.widthRatio * target.width : 0) : 3
    height: horizontal ? 3 : (target ? target.visibleArea.heightRatio * target.height : 0)
    x: horizontal
        ? (target ? target.visibleArea.xPosition * target.width : 0)
        : (parent ? parent.width - width - 2 : 0)
    y: horizontal
        ? (parent ? parent.height - height - 2 : 0)
        : (target ? target.visibleArea.yPosition * target.height : 0)
}
