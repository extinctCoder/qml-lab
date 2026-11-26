import QtQuick
import theme

Base {
    id: root

    property string icon: ""
    required property string title
    property string description: ""
    property string meta: ""
    property string mark: "radio"

    width: parent ? parent.width : implicitWidth
    padding_x: Spacing.inner
    padding_y: Spacing.tight
    appearance: "ghost"
    color: enabled && selected ? Colors.secondary_container : "transparent"

    ItemContent {
        mark: !root.checkable ? "" : root.mark === "check" ? (root.checked ? "■" : "□") : (root.checked ? "●" : "○")
        marked: root.selected
        icon: root.icon
        title: root.title
        description: root.description
        meta: root.meta
    }
}
