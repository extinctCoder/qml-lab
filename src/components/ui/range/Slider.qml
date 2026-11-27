import QtQuick
import theme
import components.behaviors

Linear {
    id: root

    property real step: 1
    signal moved(real value)

    bar.clip: false

    function snapped(v) {
        const s = step > 0 ? Math.round((v - from) / step) * step + from : v;
        return Math.max(from, Math.min(to, s));
    }
    function move_to(v) {
        const s = snapped(v);
        if (s !== value)
            moved(s);
    }
    function value_at(x) {
        return from + Math.max(0, Math.min(1, x / root.bar.width)) * (to - from);
    }

    Rectangle {
        parent: root.bar
        visible: root.enabled
        x: root.bar.width * root.ratio - width / 2
        anchors.verticalCenter: parent.verticalCenter
        width: 3
        height: parent.height + 4
        radius: 1
        color: Colors.on_surface

        Behavior on x {
            Glide {}
        }
    }

    Interactive {
        id: interactive
        parent: root.bar
        anchors.fill: parent
        anchors.margins: -Spacing.tight
        keys: []

        Keys.onLeftPressed: root.move_to(root.value - root.step)
        Keys.onDownPressed: root.move_to(root.value - root.step)
        Keys.onRightPressed: root.move_to(root.value + root.step)
        Keys.onUpPressed: root.move_to(root.value + root.step)
        Keys.onPressed: event => {
            if (event.key === Qt.Key_PageUp)
                root.move_to(root.value + root.step * 10);
            else if (event.key === Qt.Key_PageDown)
                root.move_to(root.value - root.step * 10);
            else if (event.key === Qt.Key_Home)
                root.move_to(root.from);
            else if (event.key === Qt.Key_End)
                root.move_to(root.to);
            else
                return;
            event.accepted = true;
        }
    }

    MouseArea {
        parent: root.bar
        anchors.fill: parent
        anchors.margins: -Spacing.tight
        z: 1
        enabled: root.enabled
        cursorShape: Qt.PointingHandCursor
        onPressed: mouse => {
            interactive.forceActiveFocus();
            root.move_to(root.value_at(mouse.x - Spacing.tight));
        }
        onPositionChanged: mouse => {
            if (pressed)
                root.move_to(root.value_at(mouse.x - Spacing.tight));
        }
    }
}
