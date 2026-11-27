import QtQuick
import theme
import components.ui
import components.ui.text as Text
import components.ui.mark as Mark

Strip {
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
    gap: Spacing.gap

    leading: [
        Mark.Choice {
            visible: root.mark !== ""
            anchors.verticalCenter: parent.verticalCenter
            kind: root.mark
            on: root.marked
        },
        Text.Header {
            anchors.verticalCenter: parent.verticalCenter
            icon: root.icon
            title: root.title
            description: root.description
            title_size: "body"
        }
    ]

    trailing: [
        Mark.Switch {
            visible: root.show_switch
            anchors.verticalCenter: parent.verticalCenter
            on: root.switch_on
        },
        Text.Mono {
            visible: root.meta !== "" && !root.show_switch
            anchors.verticalCenter: parent.verticalCenter
            text: root.meta
            size: "label"
            muted: true
        }
    ]
}
