import QtQuick
import theme
import components.ui.text as Text

Item {
    id: root

    property string icon: ""
    property string title: ""
    property int title_width: 0
    property string label: ""
    property real middle_width: 0
    default property alias middle: slot.data

    implicitWidth: (icon_text.visible ? icon_text.implicitWidth + row.spacing : 0)
                   + (title_text.visible ? title_text.width + row.spacing : 0)
                   + middle_width
                   + (label_text.visible ? label_text.width + row.spacing : 0)
    implicitHeight: Math.max(icon_text.implicitHeight, title_text.implicitHeight, label_text.implicitHeight, slot.childrenRect.height, 10) + Spacing.tight * 2

    Row {
        id: row
        anchors.fill: parent
        spacing: Spacing.inner

        Text.Mono {
            id: icon_text
            visible: root.icon !== ""
            anchors.verticalCenter: parent.verticalCenter
            text: root.icon
            tone: Colors.primary
        }

        Text.Mono {
            id: title_text
            visible: root.title !== ""
            anchors.verticalCenter: parent.verticalCenter
            width: root.title_width > 0 ? root.title_width : implicitWidth
            text: root.title
            maximumLineCount: 1
            elide: Qt.ElideRight
        }

        Item {
            id: slot
            anchors.verticalCenter: parent.verticalCenter
            width: root.middle_width > 0 ? root.middle_width
                   : parent.width
                     - (icon_text.visible ? icon_text.width + parent.spacing : 0)
                     - (title_text.visible ? title_text.width + parent.spacing : 0)
                     - (label_text.visible ? label_text.width + parent.spacing : 0)
            height: childrenRect.height
        }

        Text.Mono {
            id: label_text
            visible: root.label !== ""
            anchors.verticalCenter: parent.verticalCenter
            text: root.label
            size: "label"
            muted: true
            horizontalAlignment: Qt.AlignRight
            width: Math.max(implicitWidth, 32)
        }
    }
}
