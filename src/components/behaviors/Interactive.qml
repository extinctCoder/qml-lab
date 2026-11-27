import QtQuick

// The one input behaviour: it draws NOTHING. It handles pointer and keyboard
// (tap, Enter/Space, roving arrows, click-exclusion) and reports the state the
// view should show — `current` (hovered, highlighted or keyboard-focused: one
// state) and `pressed`. A StateLayer, owned by Surface or placed beside a
// non-Surface view, renders those. Looks live in one place; input lives here.
Item {
    id: root

    property bool checkable: false
    property bool checked: false
    property var keys: checkable ? ["space"] : ["enter", "space"]
    property Item exclude: null
    property Roving roving: null
    property bool highlighted: false
    property bool focusable: true
    readonly property bool hovered: hover.hovered
    readonly property bool pressed: tap.pressed && !tap.on_excluded
    readonly property bool current: hovered || highlighted || activeFocus

    signal activated

    activeFocusOnTab: roving ? roving.stop === root || activeFocus : focusable

    Component.onCompleted: if (roving)
        roving.join(root)
    Component.onDestruction: if (roving)
        roving.leave(root)

    Keys.onPressed: event => {
        if (roving && roving.handle(root, event.key))
            event.accepted = true;
    }

    Keys.onReturnPressed: if (keys.includes("enter"))
        activated()
    Keys.onEnterPressed: if (keys.includes("enter"))
        activated()
    Keys.onSpacePressed: if (keys.includes("space"))
        activated()

    HoverHandler {
        id: hover
        cursorShape: Qt.PointingHandCursor
    }
    TapHandler {
        id: tap
        readonly property bool on_excluded: root.exclude !== null && pressed && root.inside_exclude(point.position)
        onTapped: point => {
            if (!root.inside_exclude(point.position))
                root.activated();
        }
    }

    function inside_exclude(position) {
        if (!exclude || !exclude.visible)
            return false;
        const p = exclude.mapFromItem(root, position.x, position.y);
        return p.x >= 0 && p.y >= 0 && p.x <= exclude.width && p.y <= exclude.height;
    }
}
