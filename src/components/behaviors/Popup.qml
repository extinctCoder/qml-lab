import QtQuick
import theme

FocusScope {
    id: root

    property Item anchor: null
    property bool opened: false
    property Item opener: null
    default property alias content: holder.data
    signal closed

    readonly property Item overlay: anchor ? anchor.Window.contentItem : null

    function open(from) {
        const source = from ? from : anchor;
        opener = source && source.focus_target ? source.focus_target : source;
        opened = true;
        place();
        holder.forceActiveFocus();
    }

    function close() {
        if (!opened)
            return;
        opened = false;
        if (opener)
            opener.forceActiveFocus();
        closed();
    }

    property Item last_inside: null

    function contains_item(item) {
        for (let it = item; it; it = it.parent)
            if (it === holder)
                return true;
        return false;
    }

    function focus_moved(item) {
        if (!opened || !item)
            return;
        if (contains_item(item)) {
            last_inside = item;
            return;
        }
        const forward = !last_inside || last_inside.nextItemInFocusChain(true) === item;
        const from = opener;
        close();
        if (from) {
            const next = from.nextItemInFocusChain(forward);
            if (next)
                next.forceActiveFocus(forward ? Qt.TabFocusReason : Qt.BacktabFocusReason);
        }
    }

    Connections {
        target: root.overlay ? root.overlay.Window.window : null
        function onActiveFocusItemChanged() {
            root.focus_moved(root.overlay.Window.activeFocusItem);
        }
    }

    function inside(x, y) {
        return x >= holder.x && x <= holder.x + holder.width && y >= holder.y && y <= holder.y + holder.height;
    }

    function place() {
        if (!anchor || !overlay)
            return;
        const p = anchor.mapToItem(overlay, 0, 0);
        const below = p.y + anchor.height + Spacing.tight;
        const fits_below = below + holder.implicitHeight <= overlay.height - Spacing.tight;
        holder.y = fits_below ? below : Math.max(Spacing.tight, p.y - holder.implicitHeight - Spacing.tight);
        holder.x = Math.max(Spacing.tight, Math.min(p.x, overlay.width - holder.implicitWidth - Spacing.tight));
    }

    parent: overlay
    anchors.fill: parent
    visible: opened || fade.running
    z: 1000

    MouseArea {
        anchors.fill: parent
        enabled: root.opened
        acceptedButtons: Qt.AllButtons
        onPressed: mouse => {
            if (!root.inside(mouse.x, mouse.y))
                root.close();
        }
        onWheel: wheel => {
            if (root.inside(wheel.x, wheel.y))
                return;
            root.close();
            wheel.accepted = false;
        }
    }

    FocusScope {
        id: holder
        width: childrenRect.width
        height: childrenRect.height
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
        focus: true
        opacity: root.opened ? 1 : 0
        scale: root.opened ? 1 : 0.97
        transformOrigin: Item.Top

        onHeightChanged: if (root.opened)
            root.place()
        onWidthChanged: if (root.opened)
            root.place()

        Behavior on opacity {
            NumberAnimation {
                id: fade
                duration: root.opened ? Motion.open : Motion.close
                easing.type: root.opened ? Motion.ease_out : Motion.ease_in
            }
        }
        Behavior on scale {
            Glide {
                duration: root.opened ? Motion.open : Motion.close
            }
        }

        Keys.onEscapePressed: root.close()
    }
}
