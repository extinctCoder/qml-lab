import QtQuick
import theme

Item {
    id: root

    property string icon: ""
    property string title: ""
    property string description: ""
    property string title_size: "title"
    property string description_size: "label"

    readonly property bool has_icon: icon !== ""

    implicitWidth: (has_icon ? icon_box.width + Spacing.inner : 0) + text_block.implicitWidth
    implicitHeight: text_block.implicitHeight

    Item {
        id: icon_box
        visible: root.has_icon
        width: text_block.implicitHeight
        height: text_block.implicitHeight

        Mono {
            anchors.centerIn: parent
            text: root.icon
            font.pixelSize: parent.height * 0.8
            color: Colors.primary
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
