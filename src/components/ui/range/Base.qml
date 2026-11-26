import QtQuick
import theme
import components.behaviors
import components.ui.text as Text

Item {
    id: root

    property real value: 0
    property real from: 0
    property real to: 100
    property string icon: ""
    property string title: ""
    property int title_width: 0
    property string label: ""
    property color tone: Colors.primary
    property alias track: track

    readonly property real ratio: to > from ? Math.max(0, Math.min(1, (value - from) / (to - from))) : 0

    implicitWidth: 200
    implicitHeight: Math.max(icon_text.implicitHeight, title_text.implicitHeight, label_text.implicitHeight, 10) + Spacing.tight * 2

    Row {
        anchors.fill: parent
        spacing: Spacing.inner

        Text.Mono {
            id: icon_text
            visible: root.icon !== ""
            anchors.verticalCenter: parent.verticalCenter
            text: root.icon
            tone: Colors.primary
        }

        Text.Mono {
            id: title_text
            visible: root.title !== ""
            anchors.verticalCenter: parent.verticalCenter
            width: root.title_width > 0 ? root.title_width : implicitWidth
            text: root.title
            maximumLineCount: 1
            elide: Qt.ElideRight
        }

        Rectangle {
            id: track
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - (icon_text.visible ? icon_text.width + parent.spacing : 0) - (title_text.visible ? title_text.width + parent.spacing : 0) - (label_text.visible ? label_text.width + parent.spacing : 0)
            height: 10
            radius: Shape.radius
            color: Colors.surface_container_highest

            Rectangle {
                id: filled
                width: track.width * root.ratio
                height: parent.height
                radius: Shape.radius
                color: root.enabled ? root.tone : States.disabled_text

                Behavior on width {
                    Glide {}
                }
            }
        }

        Text.Mono {
            id: label_text
            visible: root.label !== ""
            anchors.verticalCenter: parent.verticalCenter
            text: root.label
            size: "label"
            muted: true
            horizontalAlignment: Qt.AlignRight
            width: Math.max(implicitWidth, 32)
        }
    }
}
