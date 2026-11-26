import QtQuick
import theme

Item {
    id: root

    property color tint: Colors.on_surface
    property int radius: Shape.radius
    property bool checkable: false
    property bool checked: false
    property var keys: checkable ? ["space"] : ["enter", "space"]
    readonly property bool hovered: hover.hovered
    readonly property bool pressed: tap.pressed

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
        onTapped: root.activated()
    }
}
