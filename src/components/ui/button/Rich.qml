import QtQuick
import theme

Base {
    id: root

    property string icon: ""
    required property string title
    property string description: ""
    property string meta: ""
    readonly property alias item_content: item_content

    padding_x: Spacing.inner

    ItemContent {
        id: item_content
        icon: root.icon
        title: root.title
        description: root.description
        meta: root.meta
    }
}
