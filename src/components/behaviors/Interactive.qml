import QtQuick
import theme

// Behavior only (DESIGN.md · States): makes its parent hoverable, pressable,
// focusable with Tab, and activatable with a click, Enter or Space.
// checkable: it holds a value (on/off). It is told `checked` and only reports
// `activated`; whoever owns the value flips it. Checkable things react to Space only.
// exclude: an item inside its area that has its own job (e.g. a switch in a header):
// clicks there are left to that item, while the hover tint still covers the whole area.
// It has no look of its own; it only draws the state tint and the focus ring.
// Use: draw the component, then put `Interactive { anchors.fill: parent }` on top.
Item {
    id: root

    property color tint: Colors.on_surface
    property int radius: Shape.radius
    property bool checkable: false
    property bool checked: false
    property var keys: checkable ? ["space"] : ["enter", "space"]
    property Item exclude: null                     // a region whose clicks belong to someone else
    readonly property bool hovered: hover.hovered
    readonly property bool pressed: tap.pressed && !tap.on_excluded

    signal activated

    activeFocusOnTab: true

    Keys.onReturnPressed: if (keys.includes("enter"))
        activated()
    Keys.onEnterPressed: if (keys.includes("enter"))
        activated()   // the keypad's Enter
    Keys.onSpacePressed: if (keys.includes("space"))
        activated()

    Rectangle {
        anchors.fill: parent
        radius: root.radius
        color: root.tint
        opacity: root.pressed ? States.pressed : root.hovered ? States.hover : 0

        Behavior on opacity {
            NumberAnimation {
                duration: Motion.small
                easing.type: Motion.ease_out
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: -(Shape.focus + 1)
        radius: root.radius + Shape.focus
        color: "transparent"
        border.width: Shape.focus
        border.color: Colors.primary
        opacity: root.activeFocus ? 1 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: Motion.small
                easing.type: Motion.ease_out
            }
        }
    }

    HoverHandler {
        id: hover
        cursorShape: Qt.PointingHandCursor
    }
    TapHandler {
        id: tap
        // did this press land on the excluded item?
        readonly property bool on_excluded: root.exclude !== null && pressed && root.inside_exclude(point.position)
        onTapped: (point) => {
            if (!root.inside_exclude(point.position))
                root.activated()
        }
    }

    function inside_exclude(position) {
        if (!exclude || !exclude.visible)
            return false
        const p = exclude.mapFromItem(root, position.x, position.y)
        return p.x >= 0 && p.y >= 0 && p.x <= exclude.width && p.y <= exclude.height
    }
}
