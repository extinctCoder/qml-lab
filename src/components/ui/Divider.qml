import QtQuick
import theme

// A 1 px rule between groups — a menu's sections, a bar's modules. Horizontal
// by default (fills its parent's width); `vertical` makes it a column rule.
Rectangle {
    id: root

    property bool vertical: false

    color: Colors.outline_variant
    implicitWidth: vertical ? Shape.border : (parent ? parent.width : 120)
    implicitHeight: vertical ? (parent ? parent.height : 24) : Shape.border
    width: implicitWidth
    height: implicitHeight
}
