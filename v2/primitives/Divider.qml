import QtQuick
import theme

// A 1px rule between groups. Horizontal by default; `vertical` makes it a column
// rule. Not a control — a plain Item.
Rectangle {
    property bool vertical: false

    color: Colors.outline_variant
    implicitWidth: vertical ? Shape.border : (parent ? parent.width : 120)
    implicitHeight: vertical ? (parent ? parent.height : 24) : Shape.border
    width: implicitWidth
    height: implicitHeight
}
