import QtQuick
import theme
import components.ui
import components.ui.text
import components.behaviors

Surface {
    id: root

    required property string title
    property string description: ""
    property string icon: ""
    property string meta: ""
    property bool checkable: false
    property bool checked: false
    property string mark: "radio"
    signal clicked

    readonly property bool selected: checkable && checked

    width: parent ? parent.width : implicitWidth
    padding_x: Spacing.inner
    padding_y: Spacing.tight

    appearance: "ghost"
    color: enabled && selected ? Colors.secondary_container : "transparent"

    Item {
        width: parent.width
        implicitWidth: lead.implicitWidth + Spacing.gap + meta_text.implicitWidth
        implicitHeight: Math.max(lead.implicitHeight, meta_text.implicitHeight)
        opacity: root.enabled ? 1 : States.disabled

        Row {
            id: lead
            anchors.verticalCenter: parent.verticalCenter
            spacing: Spacing.inner

            Mono {
                visible: root.checkable
                anchors.verticalCenter: parent.verticalCenter
                text: root.mark === "check" ? (root.checked ? "■" : "□") : (root.checked ? "●" : "○")
                color: root.selected && root.enabled ? Colors.primary : Colors.on_surface_variant
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

    Interactive {
        parent: root
        anchors.fill: parent
        checkable: root.checkable
        checked: root.checked
        onActivated: root.clicked()
    }
}
