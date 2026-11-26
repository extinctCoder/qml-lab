import QtQuick
import theme
import components.ui.text
import components.ui.mark
import components.behaviors

Base {
    id: root

    property string icon: ""
    required property string title
    property string description: ""
    property string meta: ""
    property bool checkable: false
    property bool checked: false
    signal switched

    header_items: [
        Item {
            id: row
            width: parent.width
            implicitHeight: header.implicitHeight + Spacing.inner * 2

            Header {
                id: header
                x: Spacing.inner
                anchors.verticalCenter: parent.verticalCenter
                icon: root.icon
                title: root.title
                description: root.description
            }

            Item {
                id: switch_box
                visible: root.checkable
                anchors.right: parent.right
                anchors.rightMargin: Spacing.inner
                anchors.verticalCenter: parent.verticalCenter
                width: root.checkable ? switch_mark.implicitWidth : 0
                height: switch_mark.implicitHeight

                SwitchMark {
                    id: switch_mark
                    on: root.checked
                }
                Interactive {
                    anchors.fill: parent
                    anchors.margins: -Spacing.tight
                    checkable: true
                    checked: root.checked
                    onActivated: root.switched()
                }
            }

            Row {
                id: trailing
                anchors.right: root.checkable ? switch_box.left : parent.right
                anchors.rightMargin: Spacing.inner
                anchors.verticalCenter: parent.verticalCenter
                spacing: Spacing.inner

                Mono {
                    visible: root.meta !== ""
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.meta
                    size: "label"
                    muted: true
                }
                ChevronMark {
                    anchors.verticalCenter: parent.verticalCenter
                    open: root.open
                }
            }

            Interactive {
                anchors.fill: parent
                exclude: root.checkable ? switch_box : null
                z: -1
                onActivated: root.fold()
            }
        }
    ]
}
