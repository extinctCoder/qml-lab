import QtQuick
import theme
import components.ui
import components.behaviors

// A modal over the whole window: a dimming scrim and a centered box that holds
// the keyboard until it's answered. Unlike Popup (a dropdown beside its
// opener), a Dialog blocks — for a decision that shouldn't be missed (power
// off, delete). Esc or a click on the scrim cancels; focus returns to the
// opener. Give it an `anchor` in the scene so it can find the window overlay.
Overlay {
    id: root

    z_order: 2000
    default property alias content: holder.content

    onOpenedChanged: if (opened)
        holder.forceActiveFocus()

    visible: opened || scrim.opacity > 0

    Rectangle {
        id: scrim
        anchors.fill: parent
        color: "#000000"
        opacity: root.opened ? 0.5 : 0

        Behavior on opacity {
            Swing {
                opened: root.opened
            }
        }

        MouseArea {
            anchors.fill: parent
            enabled: root.opened
            onClicked: root.close()
        }
    }

    Surface {
        id: holder
        anchors.centerIn: parent
        level: 5
        focus: true
        opacity: root.opened ? 1 : 0
        scale: root.opened ? 1 : 0.97
        transformOrigin: Item.Center

        Behavior on opacity {
            Swing {
                opened: root.opened
            }
        }
        Behavior on scale {
            Swing {
                opened: root.opened
            }
        }

        Keys.onEscapePressed: root.close()
    }
}
