import QtQuick
import theme

// The shell surface — what renders on the screen: a wallpaper with the bar on
// top. Sized to the screen it's placed in. Panels (quick settings, launcher,
// notifications) will be added over this.
Item {
    id: shell

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: Colors.surface_container_low }
            GradientStop { position: 1.0; color: Colors.surface_container_lowest }
        }
    }

    Bar {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }
}
