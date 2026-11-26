import QtQuick
import theme

Base {
    id: root

    property string icon: ""
    required property string title
    property string description: ""
    property string meta: ""
    property string mark: "check"            // checkable: "check" or "radio"

    padding_x: Spacing.inner
    padding_y: Spacing.inner
    appearance: "outlined"
    color: enabled && selected ? Colors.secondary_container : level_color
    border.color: enabled && selected ? Colors.primary : Colors.outline_variant

    ItemContent {
        mark: !root.checkable ? "" : root.mark === "check" ? (root.checked ? "■" : "□") : (root.checked ? "●" : "○")
        marked: root.selected
        icon: root.icon
        title: root.title
        description: root.description
        meta: root.meta
    }
}
