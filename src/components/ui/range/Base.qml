import QtQuick
import theme

Item {
    id: root

    property real value: 0
    property real from: 0
    property real to: 100
    property real buffered: from
    property string icon: ""
    property string title: ""
    property int title_width: 0
    property string label: ""
    property color tone: Colors.primary

    readonly property real ratio: fraction(value)
    readonly property real buffered_ratio: fraction(buffered)
    readonly property color shown_tone: enabled ? tone : States.disabled_text

    function fraction(v) {
        return to > from ? Math.max(0, Math.min(1, (v - from) / (to - from))) : 0;
    }

    implicitWidth: 200
}
