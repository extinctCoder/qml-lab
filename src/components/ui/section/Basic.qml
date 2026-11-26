import QtQuick
import theme
import components.ui.text as Text
import components.ui.mark as Mark
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

    readonly property bool selected: checkable && checked
    border.color: enabled && selected ? Colors.primary : Colors.outline_variant

    header_items: [
        Item {
            id: row
            width: parent.width
            implicitHeight: header.implicitHeight + Spacing.inner * 2

            Rectangle {
                anchors.fill: parent
                anchors.margins: Shape.border
                z: -2                                   // behind the click area, so its hover tint shows
                color: root.enabled && root.selected ? Colors.secondary_container : "transparent"
                radius: Shape.radius

                Behavior on color {
                    ColorAnimation {
                        duration: Motion.small
                        easing.type: Motion.ease_out
                    }
                }
            }

            Text.Header {
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

                Mark.Switch {
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

                Text.Mono {
                    visible: root.meta !== ""
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.meta
                    size: "label"
                    muted: true
                }
                Mark.Chevron {
                    anchors.verticalCenter: parent.verticalCenter
                    on: root.open
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
