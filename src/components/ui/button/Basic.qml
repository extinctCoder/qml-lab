import QtQuick
import theme
import components.ui.text as Text

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
    readonly property bool has_line: look.line !== "none"

    padding_x: Spacing.gap
    padding_y: Spacing.tight
    appearance: variant === "ghost" ? "ghost" : has_line ? "outlined" : "filled"
    fill: look.fill
    line: has_line ? look.line : Colors.outline_variant
    tint: label.color

    Text.Mono {
        id: label
        anchors.centerIn: parent
        text: root.text
        size: "label"
        tone: root.selected ? Colors.on_secondary_container : root.look.label
    }
}
