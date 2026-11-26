import QtQuick
import theme
import components.ui.text

// The content shared by ListItem and Tile (internal to the button family):
// on the left a mark and a Header (icon, title, description), on the right the meta,
// or a switch (checkable tiles).
Item {
    id: root

    property string mark: ""                 // the glyph to show (● ○ ■ □), or "" for none
    property bool marked: false              // highlight the mark (selected)
    property string icon: ""
    property string title: ""
    property string description: ""
    property string meta: ""
    property bool show_switch: false         // a switch on the right (checkable tiles)
    property bool switch_on: false

    width: parent ? parent.width : implicitWidth
    implicitWidth: lead.implicitWidth + Spacing.gap + (show_switch ? switch_mark.implicitWidth : meta_text.implicitWidth)
    implicitHeight: Math.max(lead.implicitHeight, meta_text.implicitHeight)
    opacity: enabled ? 1 : States.disabled               // disabled: the content fades to gray

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

    SwitchMark {
        id: switch_mark
        visible: root.show_switch
        on: root.switch_on
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    Mono {
        id: meta_text
        visible: root.meta !== "" && !root.show_switch
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: root.meta
        size: "label"
        muted: true
    }
}
