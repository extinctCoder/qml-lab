pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme
import services

// Workspace overview (GNOME Activities): every workspace as a screen with its
// windows laid out inside. Click a workspace to go there. Dim backdrop; click
// outside or Esc to dismiss.
Item {
    id: ov

    property bool open: false

    visible: opacity > 0
    opacity: open ? 1 : 0
    focus: open

    Behavior on opacity { NumberAnimation { duration: Motion.open; easing.type: Motion.ease_out } }

    Keys.onEscapePressed: ov.open = false

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0.02, 0.02, 0.04, 0.72)
        MouseArea { anchors.fill: parent; onClicked: ov.open = false }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: Spacing.edge

        Label {
            text: "workspaces"
            color: Colors.on_surface
            font.pixelSize: Type.title
            Layout.alignment: Qt.AlignHCenter
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: Spacing.gap

            Repeater {
                model: Workspaces.list

                Rectangle {
                    id: screen
                    required property var modelData
                    readonly property bool focused: modelData.id === Workspaces.focused_id

                    width: 248
                    height: 155
                    radius: Shape.radius
                    color: Colors.surface_container_low
                    border.width: screen.focused ? Shape.focus : Shape.border
                    border.color: screen.focused ? Colors.primary : Colors.outline_variant

                    Text {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.margins: Spacing.tight
                        text: screen.modelData.id
                        color: screen.focused ? Colors.primary : Colors.on_surface_variant
                        font.family: Type.family
                        font.pixelSize: Type.label
                    }

                    Flow {
                        anchors.fill: parent
                        anchors.margins: Spacing.inner
                        anchors.topMargin: Spacing.gap + Spacing.inner
                        spacing: Spacing.tight

                        Repeater {
                            model: screen.modelData.windows
                            Rectangle {
                                id: win
                                required property var modelData
                                width: (screen.width - Spacing.inner * 2 - Spacing.tight) / 2
                                height: 44
                                radius: Shape.radius
                                color: Colors.surface_container_high
                                border.width: Shape.border
                                border.color: Colors.outline_variant
                                Text {
                                    anchors.fill: parent
                                    anchors.margins: Spacing.tight
                                    text: win.modelData.title
                                    color: Colors.on_surface
                                    font.family: Type.family
                                    font.pixelSize: Type.label
                                    wrapMode: Text.Wrap
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        visible: screen.modelData.windows.length === 0
                        text: "empty"
                        color: Colors.on_surface_variant
                        font.family: Type.family
                        font.pixelSize: Type.label
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Workspaces.focus(screen.modelData.id)
                            ov.open = false
                        }
                    }
                }
            }
        }
    }
}
