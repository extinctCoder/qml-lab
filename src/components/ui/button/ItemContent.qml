import QtQuick
import theme
import components.ui.text as Text
import components.ui.mark as Mark

Item {
    id: root

    property string mark: ""
    property bool marked: false
    property string icon: ""
    property string title: ""
    property string description: ""
    property string meta: ""
    property bool show_switch: false
    property bool switch_on: false

    width: parent ? parent.width : implicitWidth
    implicitWidth: lead.implicitWidth + Spacing.gap + (show_switch ? switch_mark.implicitWidth : meta_text.implicitWidth)
    implicitHeight: Math.max(lead.implicitHeight, meta_text.implicitHeight)

    Row {
        id: lead
        anchors.verticalCenter: parent.verticalCenter
        spacing: Spacing.inner

        Mark.Choice {
            visible: root.mark !== ""
            anchors.verticalCenter: parent.verticalCenter
            kind: root.mark
            on: root.marked
        }
        Text.Header {
            anchors.verticalCenter: parent.verticalCenter
            icon: root.icon
            title: root.title
            description: root.description
            title_size: "body"
        }
    }

    Mark.Switch {
        id: switch_mark
        visible: root.show_switch
        on: root.switch_on
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    Text.Mono {
        id: meta_text
        visible: root.meta !== "" && !root.show_switch
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: root.meta
        size: "label"
        muted: true
    }
}
