import QtQuick
import theme
import components.ui.text as Text

Item {
    id: root

    property string icon: ""
    property string title: ""
    property int title_width: 0
    property string label: ""
    property real middle_width: 0
    default property alias middle: strip.middle

    implicitWidth: strip.implicitWidth
    implicitHeight: Math.max(strip.implicitHeight, one_line.implicitHeight, 10) + Spacing.tight * 2

    Text.Mono {
        id: one_line
        visible: false
        text: " "
    }

    Strip {
        id: strip
        anchors.fill: parent
        middle_width: root.middle_width

        leading: [
            Text.Mono {
                visible: root.icon !== ""
                anchors.verticalCenter: parent.verticalCenter
                text: root.icon
                tone: Colors.primary
            },
            Text.Mono {
                visible: root.title !== ""
                anchors.verticalCenter: parent.verticalCenter
                width: root.title_width > 0 ? root.title_width : implicitWidth
                text: root.title
                maximumLineCount: 1
                elide: Qt.ElideRight
            }
        ]

        trailing: [
            Text.Mono {
                visible: root.label !== ""
                anchors.verticalCenter: parent.verticalCenter
                text: root.label
                size: "label"
                muted: true
                horizontalAlignment: Qt.AlignRight
                width: Math.max(implicitWidth, 32)
            }
        ]
    }
}
