import QtQuick
import QtQuick.Templates as T
import theme

// A thin indicator — it tracks, it doesn't grab, like a terminal's.
T.ScrollBar {
    id: control

    implicitWidth: 6
    implicitHeight: 6
    padding: 1
    minimumSize: 0.1

    contentItem: Rectangle {
        implicitWidth: 4
        implicitHeight: 4
        radius: width / 2
        color: control.pressed ? Colors.outline : Colors.outline_variant
        opacity: (control.policy === T.ScrollBar.AlwaysOn
                  || (control.active && control.size < 1.0)) ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation { duration: Motion.close }
        }
    }
}
