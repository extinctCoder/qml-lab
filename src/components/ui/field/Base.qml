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
        line: hover.hovered ? Colors.outline : Colors.outline_variant
        emphasis: root.error !== "" ? "error" : editor.activeFocus ? "focus" : "none"

        Behavior on border.color {
            ColorGlide {}
        }

        HoverHandler {
            id: hover
            cursorShape: Qt.IBeamCursor
        }

        TapHandler {
            onTapped: editor.forceActiveFocus()
        }

        Row {
            id: row
            parent: box
            anchors.fill: parent
            anchors.leftMargin: Spacing.inner + 2
            anchors.rightMargin: Spacing.tight
            spacing: Spacing.inner

            Text.Mono {
                id: icon_text
                visible: root.icon !== ""
                anchors.verticalCenter: parent.verticalCenter
                text: root.icon
                tone: Colors.primary
            }

            Item {
                anchors.verticalCenter: parent.verticalCenter
                width: row.width - (icon_text.visible ? icon_text.width + row.spacing : 0)
                       - (trailing_row.width > 0 ? trailing_row.width + row.spacing : 0)
                       - (label_text.visible ? label_text.width + row.spacing : 0)
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
                        } else {
                            focus = false;
                        }
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

            Row {
                id: trailing_row
                anchors.verticalCenter: parent.verticalCenter
                spacing: 0
            }

            Text.Mono {
                id: label_text
                visible: root.label !== ""
                anchors.verticalCenter: parent.verticalCenter
                text: root.label
                size: "label"
                muted: true
                rightPadding: Spacing.tight
            }
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
