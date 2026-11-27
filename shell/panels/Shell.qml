import QtQuick
import theme

// The shell surface — wallpaper, the bar, and the panels that drop from it.
Item {
    id: shell

    // the wallpaper (given soft shapes so the overview blur reads)
    Item {
        id: wallpaper
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: Colors.surface_container_low }
                GradientStop { position: 1.0; color: Colors.surface_container_lowest }
            }
        }
        Rectangle {
            x: -parent.width * 0.1; y: parent.height * 0.2
            width: parent.width * 0.5; height: width; radius: width / 2
            color: Qt.rgba(Colors.primary.r, Colors.primary.g, Colors.primary.b, 0.06)
        }
        Rectangle {
            x: parent.width * 0.62; y: -parent.height * 0.2
            width: parent.width * 0.6; height: width; radius: width / 2
            color: Qt.rgba(0.40, 0.52, 0.82, 0.06)
        }
        Rectangle {
            x: parent.width * 0.5; y: parent.height * 0.55
            width: parent.width * 0.5; height: width; radius: width / 2
            color: Qt.rgba(Colors.primary.r, Colors.primary.g, Colors.primary.b, 0.04)
        }
    }

    // quick-settings dismiss catcher
    MouseArea {
        anchors.fill: parent
        enabled: quick.open && !activities.open
        onClicked: quick.open = false
    }

    // full-screen overlay (below the bar, so the bar stays visible)
    Overview {
        id: activities
        anchors.fill: parent
        backdrop: wallpaper
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
}
