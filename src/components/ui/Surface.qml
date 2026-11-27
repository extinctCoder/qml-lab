import QtQuick
import theme

Rectangle {
    id: root

    property int level: 3
    property string appearance: "outlined"
    property color fill: level_color
    property color line: Colors.outline_variant
    property bool selected: false
    property string emphasis: "none"
    property int padding_x: Spacing.inner
    property int padding_y: Spacing.inner
    default property alias content: area.data

    readonly property color level_color: [Colors.surface_container_lowest, Colors.surface_container_low, Colors.surface_container, Colors.surface_container_high, Colors.surface_container_highest][Math.max(1, Math.min(5, level)) - 1]

    readonly property bool shows_fill: (appearance === "outlined" || appearance === "filled") && fill.a > 0

    readonly property int pad_x: appearance === "none" ? 0 : padding_x
    readonly property int pad_y: appearance === "none" ? 0 : padding_y

    color: !enabled ? (shows_fill || selected ? States.disabled_fill : "transparent") : selected ? Colors.secondary_container : shows_fill ? fill : "transparent"
    border.width: emphasis !== "none" ? Shape.focus : appearance === "outlined" ? Shape.border : 0
    border.color: !enabled ? States.disabled_fill : emphasis === "error" ? Colors.error : emphasis === "focus" || selected ? Colors.primary : line
    radius: Shape.radius

    implicitWidth: area.children.reduce((w, c) => c.visible ? Math.max(w, c.implicitWidth) : w, 0) + pad_x * 2
    implicitHeight: area.children.reduce((h, c) => c.visible ? Math.max(h, c.implicitHeight) : h, 0) + pad_y * 2

    Item {
        id: area
        x: root.pad_x
        y: root.pad_y
        width: root.width - root.pad_x * 2
        height: root.height - root.pad_y * 2
    }
}
