import QtQuick

QtObject {
    id: root

    property string orientation: "row"
    property bool selects: true
    property var members: []
    property Item entry: null

    readonly property Item stop: {
        for (const m of members)
            if (m.activeFocus)
                return m;
        let first = null;
        for (const m of ordered()) {
            if (!m.enabled)
                continue;
            if (m.checked)
                return m;
            if (!first)
                first = m;
        }
        return first;
    }

    function join(member) {
        if (members.indexOf(member) < 0)
            members = members.concat([member]);
    }

    function enter() {
        if (stop)
            stop.forceActiveFocus();
        return stop !== null;
    }

    function leave(member) {
        members = members.filter(m => m !== member);
    }

    function ordered() {
        return members.slice().sort((a, b) => {
            const pa = a.mapToItem(null, 0, 0), pb = b.mapToItem(null, 0, 0);
            return orientation === "row" ? (pa.x - pb.x) || (pa.y - pb.y) : (pa.y - pb.y) || (pa.x - pb.x);
        });
    }

    function step(from, delta) {
        const list = ordered();
        const count = list.length;
        let i = list.indexOf(from);
        for (let n = 0; n < count; n++) {
            i = (i + delta + count) % count;
            if (list[i].enabled)
                return list[i];
        }
        return from;
    }

    function edge(last) {
        const list = last ? ordered().reverse() : ordered();
        for (const m of list)
            if (m.enabled)
                return m;
        return null;
    }

    function handle(from, key) {
        const back = orientation === "row" ? Qt.Key_Left : Qt.Key_Up;
        const next = orientation === "row" ? Qt.Key_Right : Qt.Key_Down;
        let target = null;
        if (key === next)
            target = step(from, 1);
        else if (key === back && entry && edge(false) === from)
            target = entry;
        else if (key === back)
            target = step(from, -1);
        else if (key === Qt.Key_Home)
            target = edge(false);
        else if (key === Qt.Key_End)
            target = edge(true);
        else
            return false;
        if (target && target === entry) {
            entry.forceActiveFocus();
        } else if (target && target !== from) {
            target.forceActiveFocus();
            if (selects)
                target.activated();
        }
        return true;
    }
}
