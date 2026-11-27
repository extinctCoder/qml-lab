import QtQuick
import theme

// The shell surface — wallpaper, the bar, and the panels that drop from it.
Item {
    id: shell

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: Colors.surface_container_low }
            GradientStop { position: 1.0; color: Colors.surface_container_lowest }
        }
    }

    // click anywhere outside an open panel to dismiss it
    MouseArea {
        anchors.fill: parent
        enabled: quick.open
        onClicked: quick.open = false
    }

    Bar {
        id: bar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        onQuickSettings: quick.open = !quick.open
        onOverview: { quick.open = false; activities.open = true }
    }

    QuickSettings {
        id: quick
        anchors.top: bar.bottom
        anchors.right: parent.right
        anchors.topMargin: Spacing.inner
        anchors.rightMargin: Spacing.inner
    }

    // full-screen overlay — above everything
    Overview {
        id: activities
        anchors.fill: parent
    }
}
