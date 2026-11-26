import QtQuick
import theme
import components.ui.text
import components.ui.mark
import components.ui.button as Button

Item {
    id: root

    property string icon: ""
    property bool busy: false
    property color tone: Colors.on_surface_variant
    property string title: ""
    property string description: ""
    property string details: ""
    property string primary: ""
    property string secondary: ""
    property bool compact: false
    signal primary_pressed
    signal secondary_pressed

    width: parent ? parent.width : implicitWidth
    implicitWidth: compact ? line.implicitWidth : Math.max(standard.implicitWidth, 240)
    implicitHeight: compact ? line.implicitHeight + Spacing.inner * 2 : standard.implicitHeight + Spacing.edge * 2

    Column {
        id: standard
        visible: !root.compact
        anchors.centerIn: parent
        width: Math.min(root.width - Spacing.edge * 2, 320)
        spacing: Spacing.tight

        Item {
            visible: root.busy || root.icon !== ""
            anchors.horizontalCenter: parent.horizontalCenter
            width: Type.title * 1.6
            height: Type.title * 1.6 + Spacing.tight

            Mono {
                visible: !root.busy
                anchors.horizontalCenter: parent.horizontalCenter
                text: root.icon
                font.pixelSize: Type.title * 1.6
                color: root.tone
            }
            SpinnerMark {
                visible: root.busy
                anchors.horizontalCenter: parent.horizontalCenter
                size: Type.title * 1.4
                color: root.tone
            }
        }
        Mono {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: root.title
        }
        Mono {
            visible: root.description !== ""
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: root.description
            size: "label"
            muted: true
        }
        Mono {
            visible: root.details !== ""
            width: parent.width
            text: root.details
            size: "label"
            muted: true
            surface: true
        }
        Item {
            visible: actions.visible
            width: 1
            height: Spacing.tight
        }
        Row {
            id: actions
            visible: root.primary !== "" || root.secondary !== ""
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: Spacing.inner

            Button.Basic {
                visible: root.primary !== ""
                variant: "outline"
                text: root.primary
                onClicked: root.primary_pressed()
            }
            Button.Basic {
                visible: root.secondary !== ""
                variant: "ghost"
                text: root.secondary + " ↗"
                onClicked: root.secondary_pressed()
            }
        }
    }

    Item {
        id: line
        visible: root.compact
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: Spacing.inner
        anchors.rightMargin: Spacing.tight
        implicitWidth: lead.implicitWidth + Spacing.gap + trailing.implicitWidth + Spacing.inner + Spacing.tight
        implicitHeight: Math.max(lead.implicitHeight, trailing.implicitHeight)

        Row {
            id: lead
            anchors.verticalCenter: parent.verticalCenter
            spacing: Spacing.inner

            Mono {
                visible: !root.busy && root.icon !== ""
                anchors.verticalCenter: parent.verticalCenter
                text: root.icon
                color: root.tone
            }
            SpinnerMark {
                visible: root.busy
                anchors.verticalCenter: parent.verticalCenter
                color: root.tone
            }
            Mono {
                anchors.verticalCenter: parent.verticalCenter
                text: root.title
                color: root.tone
            }
        }
        Row {
            id: trailing
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 0

            Button.Basic {
                visible: root.primary !== ""
                variant: "ghost"
                text: root.primary + " →"
                onClicked: root.primary_pressed()
            }
            Button.Basic {
                visible: root.secondary !== ""
                variant: "ghost"
                text: root.secondary + " ↗"
                onClicked: root.secondary_pressed()
            }
        }
    }
}
