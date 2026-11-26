import QtQuick
import theme
import components.ui.text

Base {
    id: root

    property string text: ""
    property string variant: "primary"

    readonly property var look: ({
            primary: {
                fill: Colors.primary,
                label: Colors.on_primary,
                line: "none"
            },
            tonal: {
                fill: Colors.secondary_container,
                label: Colors.on_secondary_container,
                line: "none"
            },
            outline: {
                fill: "transparent",
                label: Colors.primary,
                line: Colors.outline
            },
            ghost: {
                fill: "transparent",
                label: Colors.primary,
                line: "none"
            },
            danger: {
                fill: "transparent",
                label: Colors.error,
                line: Colors.error
            }
        })[variant]
    readonly property bool has_fill: look.fill !== "transparent"
    readonly property bool has_line: look.line !== "none"

    padding_x: Spacing.gap
    padding_y: Spacing.tight

    color: !enabled ? (has_fill || selected ? disabled_container : "transparent") : selected ? Colors.secondary_container : look.fill
    border.width: selected || has_line ? Shape.border : 0
    border.color: !enabled ? disabled_container : selected ? Colors.primary : has_line ? look.line : "transparent"
    tint: label.color

    Mono {
        id: label
        anchors.centerIn: parent
        text: root.text
        size: "label"
        color: !root.enabled ? root.disabled_content : root.selected ? Colors.on_secondary_container : root.look.label
    }
}
