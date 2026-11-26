import QtQuick
import theme

// A surface: our look for any box (DESIGN.md · Layers). Everything visible sits on one,
// so the background, border, corners, padding, and the look of every state are decided
// here, once.
// level: its depth, 1 (deepest) to 5 (front); 3, the middle, is the default.
// appearance: "outlined" (fill + 1 px border), "filled" (fill only), "ghost" (neither),
//             "none" (no look and no padding: just the content).
// fill / line: its resting colors (default: the level's color, and the outline color);
//             a component sets these instead of its color, e.g. a primary button.
// selected:   the tonal fill, and an accent border if it has one (same everywhere).
// disabled (enabled: false): neutral gray, never a faded color (Material 3);
//             its content can use `disabled_content` for its text.
// It can hold anything; it sizes itself around its content (one item), plus the padding.
Rectangle {
    id: root

    property int level: 3
    property string appearance: "outlined"
    property color fill: level_color
    property color line: Colors.outline_variant
    property bool selected: false
    property int padding_x: Spacing.inner
    property int padding_y: Spacing.inner
    default property alias content: area.data

    readonly property color level_color: [
        Colors.surface_container_lowest,    // 1: deepest, recessed
        Colors.surface_container_low,       // 2
        Colors.surface_container,           // 3: the middle (default)
        Colors.surface_container_high,      // 4
        Colors.surface_container_highest    // 5: front, e.g. popups and menus
    ][Math.max(1, Math.min(5, level)) - 1]

    // disabled (Material 3): containers and outlines at 12 %, content at 38 % of on_surface
    readonly property color disabled_container: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, States.disabled_container)
    readonly property color disabled_content: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, States.disabled)

    // does it show a fill at rest? (outlined and filled do, unless the fill is transparent)
    readonly property bool shows_fill: (appearance === "outlined" || appearance === "filled") && fill.a > 0

    // the padding actually applied: none for appearance "none"
    readonly property int pad_x: appearance === "none" ? 0 : padding_x
    readonly property int pad_y: appearance === "none" ? 0 : padding_y

    color: !enabled ? (shows_fill || selected ? disabled_container : "transparent")
        : selected ? Colors.secondary_container
        : shows_fill ? fill : "transparent"
    border.width: appearance === "outlined" ? Shape.border : 0
    border.color: !enabled ? disabled_container : selected ? Colors.primary : line
    radius: Shape.radius

    // its size: what the content wants (its implicit size), plus the padding.
    // (Not where the content sits: a centered label would make that a loop.)
    implicitWidth: area.children.reduce((w, c) => c.visible ? Math.max(w, c.implicitWidth) : w, 0) + pad_x * 2
    implicitHeight: area.children.reduce((h, c) => c.visible ? Math.max(h, c.implicitHeight) : h, 0) + pad_y * 2

    // the content area: the surface minus its padding
    Item {
        id: area
        x: root.pad_x
        y: root.pad_y
        width: root.width - root.pad_x * 2
        height: root.height - root.pad_y * 2
    }
}
