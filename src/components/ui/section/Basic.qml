import QtQuick
import theme
import components.ui
import components.ui.text as Text
import components.ui.mark as Mark
import components.ui.button as Button
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

    readonly property bool active: checkable && checked
    line: active ? Colors.primary : Colors.outline_variant

    header_items: [
        Item {
            id: row
            width: parent.width
            implicitHeight: header.implicitHeight + Spacing.inner * 2

            Rectangle {
                anchors.fill: parent
                anchors.margins: Shape.border
                z: -2
                color: root.enabled && root.active ? Colors.secondary_container : "transparent"
                radius: Shape.radius

                Behavior on color {
                    ColorGlide {}
                }
            }

            StateLayer {
                anchors.fill: parent
                anchors.margins: Shape.border
                radius: Shape.radius
                current: header_input.current
                pressed: header_input.pressed
            }

            Strip {
                anchors.fill: parent
                anchors.leftMargin: Spacing.inner
                anchors.rightMargin: root.checkable ? Spacing.inner - Spacing.tight : Spacing.inner
                spacing: Spacing.inner - Spacing.tight

                leading: [
                    Text.Header {
                        id: header
                        anchors.verticalCenter: parent.verticalCenter
                        icon: root.icon
                        title: root.title
                        description: root.description
                    }
                ]

                trailing: [
                    Row {
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
                    },
                    Button.Mark {
                        id: switch_box
                        visible: root.checkable
                        anchors.verticalCenter: parent.verticalCenter
                        padding_x: Spacing.tight
                        padding_y: Spacing.tight
                        checkable: true
                        checked: root.checked
                        onClicked: root.switched()

                        Mark.Switch {
                            on: root.checked
                        }
                    }
                ]
            }

            Interactive {
                id: header_input
                anchors.fill: parent
                exclude: root.checkable ? switch_box : null
                z: -1
                onActivated: root.fold()
            }
        }
    ]
}
