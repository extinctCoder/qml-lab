pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import theme
import services

// The lockscreen as a composition, not a form: a hero clock bottom-right with the
// weather as a small caption at its side, the date beneath, and the login reduced
// to a whisper under it. Everything else is empty blurred wallpaper.
Item {
    id: lock

    property Item backdrop: null

    visible: opacity > 0
    opacity: Session.locked ? 1 : 0
    focus: Session.locked

    Behavior on opacity { NumberAnimation { duration: Motion.open; easing.type: Motion.ease_out } }

    MouseArea { anchors.fill: parent }

    MultiEffect {
        anchors.fill: parent
        source: lock.backdrop
        visible: lock.backdrop !== null
        blurEnabled: true
        blur: 1.0
        blurMax: 64
    }
    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0.01, 0.01, 0.03, 0.62)
    }

    // ── the bottom-right composition ────────────────────────────────────
    ColumnLayout {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: Spacing.edge * 3
        anchors.bottomMargin: Spacing.edge * 2.5
        spacing: Spacing.tight

        // clock · weather at its side
        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: Spacing.gap

            ColumnLayout {
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                Layout.bottomMargin: Spacing.inner
                spacing: 0
                Label {
                    Layout.alignment: Qt.AlignRight
                    text: Weather.condition
                    color: Colors.on_surface_variant
                    font.family: Type.family
                    font.pixelSize: Type.label
                }
                Label {
                    Layout.alignment: Qt.AlignRight
                    text: Weather.temp + "°"
                    color: Colors.on_surface
                    font.family: Type.family
                    font.pixelSize: Type.title
                }
                Label {
                    Layout.alignment: Qt.AlignRight
                    text: Weather.location
                    color: Colors.on_surface_variant
                    font.family: Type.family
                    font.pixelSize: Type.label
                }
            }

            Label {
                Layout.alignment: Qt.AlignBottom
                text: Time.clock
                color: Colors.on_surface
                font.family: Type.family
                font.pixelSize: Type.display * 2.0
                font.weight: Font.Medium
            }
        }

        Label {
            Layout.alignment: Qt.AlignRight
            text: Time.day
            color: Colors.on_surface_variant
            font.family: Type.family
            font.pixelSize: Type.title
        }

        Item { Layout.preferredHeight: Spacing.edge * 1.5 }

        // login — a whisper
        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: Spacing.inner
            Label {
                text: Session.user.name
                color: Colors.on_surface
                font.family: Type.family
                font.pixelSize: Type.body
            }
            Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                radius: 13
                color: Colors.surface_container_high
                border.width: Shape.border
                border.color: Colors.outline
                Text {
                    anchors.centerIn: parent
                    text: Session.user.avatar
                    color: Colors.primary
                    font.family: Type.family
                    font.pixelSize: Type.label
                }
            }
        }

        TextField {
            id: pw
            Layout.alignment: Qt.AlignRight
            implicitWidth: 240
            horizontalAlignment: Text.AlignRight
            echoMode: TextInput.Password
            placeholderText: "password"
            onAccepted: Session.unlock(pw.text)
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: Spacing.inner

            Repeater {
                model: Session.users.length > 1 ? Session.users : []
                Rectangle {
                    id: ua
                    required property var modelData
                    required property int index
                    readonly property bool cur: ua.index === Session.current
                    implicitWidth: 22
                    implicitHeight: 22
                    radius: 11
                    color: ua.cur ? Colors.primary : Colors.surface_container_high
                    border.width: Shape.border
                    border.color: ua.cur ? Colors.primary : Colors.outline_variant
                    Text {
                        anchors.centerIn: parent
                        text: ua.modelData.avatar
                        color: ua.cur ? Colors.on_primary : Colors.on_surface_variant
                        font.family: Type.family
                        font.pixelSize: Type.label
                    }
                    MouseArea { anchors.fill: parent; onClicked: Session.set_current(ua.index) }
                }
            }

            Label {
                text: Session.error !== "" ? Session.error : "press ⏎ to unlock"
                color: Session.error !== "" ? Colors.error : Colors.on_surface_variant
                font.family: Type.family
                font.pixelSize: Type.label
            }
        }
    }
}
