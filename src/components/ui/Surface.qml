import QtQuick
import theme

Rectangle {
    id: root

    property string level: "card"
    property string appearance: "outlined"
    property int padding_x: Spacing.inner
    property int padding_y: Spacing.inner
    default property alias content: area.data

    readonly property color level_color: ({
            panel: Colors.surface_container,
            card: Colors.surface_container_high,
            popup: Colors.surface_container_highest
        })[level]

    color: appearance === "ghost" ? "transparent" : level_color
    border.width: appearance === "outlined" ? Shape.border : 0
    border.color: Colors.outline_variant
    radius: Shape.radius

    implicitWidth: area.children.reduce((w, c) => c.visible ? Math.max(w, c.implicitWidth) : w, 0) + padding_x * 2
    implicitHeight: area.children.reduce((h, c) => c.visible ? Math.max(h, c.implicitHeight) : h, 0) + padding_y * 2

    Item {
        id: area
        x: root.padding_x
        y: root.padding_y
        width: root.width - root.padding_x * 2
        height: root.height - root.padding_y * 2
    }
}
