import QtQuick

QtObject {
    id: root

    property int count: 0
    property int index: -1
    property int page: 8
    property bool wraps: true

    onCountChanged: index = count > 0 ? Math.min(Math.max(index, 0), count - 1) : -1

    function reset() {
        index = count > 0 ? 0 : -1;
    }

    function move(delta) {
        if (count === 0)
            return;
        if (index < 0)
            index = 0;
        else if (wraps && Math.abs(delta) === 1)
            index = (index + delta + count) % count;
        else
            index = Math.max(0, Math.min(count - 1, index + delta));
    }

    function handle(event) {
        const ctrl = event.modifiers & Qt.ControlModifier;
        if (event.key === Qt.Key_Down || (ctrl && (event.key === Qt.Key_N || event.key === Qt.Key_J)))
            move(1);
        else if (event.key === Qt.Key_Up || (ctrl && (event.key === Qt.Key_P || event.key === Qt.Key_K)))
            move(-1);
        else if (event.key === Qt.Key_PageDown)
            move(page);
        else if (event.key === Qt.Key_PageUp)
            move(-page);
        else
            return false;
        return true;
    }
}
