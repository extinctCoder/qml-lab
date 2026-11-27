import QtQuick
import theme
import components.ui

Surface {
    id: root

    property string icon: ""
    required property string title
    property string description: ""
    property string title_size: "title"
    property string description_size: "label"
    property bool surface: false
    property bool icon_outline: false

    readonly property bool has_icon: icon !== ""

    appearance: surface ? "outlined" : "none"

    Item {
        implicitWidth: (root.has_icon ? icon_box.width + Spacing.inner : 0) + text_block.implicitWidth
        implicitHeight: text_block.implicitHeight

        Surface {
            id: icon_box
            visible: root.has_icon
            width: text_block.implicitHeight
            height: text_block.implicitHeight
            appearance: root.icon_outline ? "outlined" : "none"
            level: 4

            Mono {
                anchors.centerIn: parent
                text: root.icon
                font.pixelSize: icon_box.height * (root.icon_outline ? 0.6 : 0.8)
                tone: Colors.primary
            }
        }

        Column {
            id: text_block
            x: root.has_icon ? icon_box.width + Spacing.inner : 0

            Mono {
                text: root.title
                size: root.title_size
            }
            Mono {
                visible: root.description !== ""
                text: root.description
                size: root.description_size
                muted: true
            }
        }
    }
}
