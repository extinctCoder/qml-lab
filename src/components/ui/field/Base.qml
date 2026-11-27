pragma ComponentBehavior: Bound

import QtQuick
import theme
import components.ui
import components.behaviors
import components.ui.text as Text

FocusScope {
    id: root

    property string text: ""
    property string placeholder: ""
    property string icon: ""
    property string label: ""
    property string error: ""
    property bool secret: false
    property Roving list: null
    property Highlight highlight: null
    property bool esc_leaves: true
    default property alias trailing: trailing_row.data
    readonly property alias input: editor
    signal edited(string text)
    signal submitted(string text)

    onTextChanged: if (editor.text !== text)
        editor.text = text

    implicitWidth: 240
    implicitHeight: box.height + (message.visible ? Spacing.tight + message.implicitHeight : 0)

    Surface {
        id: box
        width: root.width
        height: editor.implicitHeight + Spacing.inner * 2
        padding_x: 0
        padding_y: 0
        line: Colors.outline_variant
        invalid: root.error !== ""

        Behavior on border.color {
            ColorGlide {}
        }

        StateLayer {
            anchors.fill: parent
            radius: box.radius
            current: editor.activeFocus || hover.hovered
        }

        HoverHandler {
            id: hover
            cursorShape: Qt.IBeamCursor
        }

        TapHandler {
            onTapped: editor.forceActiveFocus()
        }

        Strip {
            id: row
            parent: box
            anchors.fill: parent
            anchors.leftMargin: Spacing.inner + 2
            anchors.rightMargin: Spacing.tight

            leading: [
                Text.Mono {
                    id: icon_text
                    visible: root.icon !== ""
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.icon
                    tone: Colors.primary
                }
            ]

            Item {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                height: editor.implicitHeight
                clip: true

                TextInput {
                    id: editor
                    anchors.fill: parent
                    focus: true
                    text: root.text
                    font.family: Type.family
                    font.pixelSize: Type.body
                    color: root.enabled ? Colors.on_surface : States.disabled_text
                    selectionColor: Colors.secondary_container
                    selectedTextColor: Colors.on_secondary_container
                    selectByMouse: true
                    echoMode: root.secret ? TextInput.Password : TextInput.Normal
                    passwordCharacter: "•"
                    verticalAlignment: TextInput.AlignVCenter
                    activeFocusOnTab: true

                    cursorDelegate: Rectangle {
                        width: metrics.averageCharacterWidth
                        height: metrics.height
                        color: Colors.primary
                        opacity: editor.cursorVisible ? 0.6 : 0

                        SequentialAnimation on opacity {
                            running: editor.activeFocus
                            loops: Animation.Infinite
                            NumberAnimation { to: 0.6; duration: 0 }
                            PauseAnimation { duration: 530 }
                            NumberAnimation { to: 0; duration: 0 }
                            PauseAnimation { duration: 530 }
                        }
                    }

                    onTextEdited: root.edited(text)
                    Keys.onReturnPressed: root.submitted(text)
                    Keys.onEnterPressed: root.submitted(text)
                    Keys.onEscapePressed: event => {
                        if (text !== "") {
                            text = "";
                            root.edited("");
                        } else if (root.esc_leaves) {
                            focus = false;
                        } else {
                            event.accepted = false;
                        }
                    }
                    Keys.onPressed: event => {
                        if (root.highlight && root.highlight.handle(event))
                            event.accepted = true;
                    }
                    Keys.onDownPressed: event => {
                        if (!root.list || !root.list.enter())
                            event.accepted = false;
                    }
                }

                FontMetrics {
                    id: metrics
                    font: editor.font
                }

                Text.Mono {
                    visible: editor.text === "" && root.placeholder !== ""
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.placeholder
                    muted: true
                }
            }

            trailing: [
                Row {
                    id: trailing_row
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 0
                },
                Text.Mono {
                    id: label_text
                    visible: root.label !== ""
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.label
                    size: "label"
                    muted: true
                    rightPadding: Spacing.tight
                }
            ]
        }
    }

    Text.Mono {
        id: message
        visible: root.error !== ""
        anchors.top: box.bottom
        anchors.topMargin: Spacing.tight
        text: root.error
        size: "label"
        tone: Colors.error
    }
}
