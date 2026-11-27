import QtQuick
import theme

// A container that opens and closes with the standard glide: its height
// animates between 0 and its content's natural height. The content is given
// the full width, so it only needs to know how tall it wants to be.
// Used wherever something shows and hides in place (a section's body, a
// quick-settings detail panel, an expandable sidebar row).
Item {
    id: root

    property bool open: false
    default property alias content: holder.data

    clip: true
    implicitWidth: holder.implicitWidth
    implicitHeight: open ? holder.implicitHeight : 0
    height: implicitHeight

    Behavior on implicitHeight {
        Swing {
            opened: root.open
        }
    }

    Item {
        id: holder
        width: root.width
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
    }
}
