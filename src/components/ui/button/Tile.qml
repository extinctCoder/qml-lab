import QtQuick
import theme

Base {
    id: root

    property string icon: ""
    required property string title
    property string description: ""
    property string meta: ""

    padding_x: Spacing.inner
    padding_y: Spacing.inner
    appearance: "outlined"

    ItemContent {
        show_switch: root.checkable
        switch_on: root.checked
        icon: root.icon
        title: root.title
        description: root.description
        meta: root.meta
    }
}
