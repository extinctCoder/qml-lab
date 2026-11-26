import QtQuick
import theme
import components.ui.text

Item {
    id: root

    property string mark: ""
    property bool marked: false
    property string icon: ""
    property string title: ""
    property string description: ""
    property string meta: ""

    width: parent ? parent.width : implicitWidth
    implicitWidth: lead.implicitWidth + Spacing.gap + meta_text.implicitWidth
    implicitHeight: Math.max(lead.implicitHeight, meta_text.implicitHeight)
    opacity: enabled ? 1 : States.disabled

    Row {
        id: lead
        anchors.verticalCenter: parent.verticalCenter
        spacing: Spacing.inner

        Mono {
            visible: root.mark !== ""
            anchors.verticalCenter: parent.verticalCenter
            text: root.mark
            color: root.marked && root.enabled ? Colors.primary : Colors.on_surface_variant
        }
        Header {
            anchors.verticalCenter: parent.verticalCenter
            icon: root.icon
            title: root.title
            description: root.description
            title_size: "body"
        }
    }

    Mono {
        id: meta_text
        visible: root.meta !== ""
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: root.meta
        size: "label"
        muted: true
    }
}
