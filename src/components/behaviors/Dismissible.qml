import QtQuick
import theme

// Wraps content that can be thrown away with a horizontal drag. Drag past the
// threshold and it reports `dismissed`; let go before and it springs back. The
// content fades as it slides. Pairs with Transient (auto) — this is the manual
// one, for notifications. Mouse-welcome; the keyboard dismisses another way.
Item {
    id: root

    property real threshold: 0.4
    default property alias content: holder.data
    signal dismissed

    function reset() {
        holder.x = 0;
    }

    implicitWidth: holder.implicitWidth
    implicitHeight: holder.implicitHeight

    Item {
        id: holder
        width: root.width
        height: root.height
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
        opacity: 1 - Math.min(1, Math.abs(x) / (root.width > 0 ? root.width : 1))

        DragHandler {
            id: drag
            target: holder
            yAxis.enabled: false
            cursorShape: Qt.ClosedHandCursor
            onActiveChanged: if (!active) {
                if (root.width > 0 && Math.abs(holder.x) > root.width * root.threshold)
                    root.dismissed();
                else
                    holder.x = 0;
            }
        }

        Behavior on x {
            enabled: !drag.active
            Glide {}
        }
    }
}
