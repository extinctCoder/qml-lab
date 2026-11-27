import QtQuick
import theme
import components.ui
import components.behaviors

Item {
    id: root

    property var values: []
    property var second: []
    property real from: 0
    property real to: 100
    property string icon: ""
    property string title: ""
    property int title_width: 0
    property string label: ""
    property color tone: Colors.primary
    property color second_tone: Colors.outline
    property int plot_height: 18

    readonly property color shown_tone: enabled ? tone : States.disabled_text
    readonly property color shown_second_tone: enabled ? second_tone : States.disabled_text
    readonly property real peak: to > from ? to : Math.max(1, ...values, ...second)

    function draw(ctx, w, h) {
    }

    function ratio(v) {
        return Math.max(0, Math.min(1, (v - from) / (peak - from)));
    }

    function path(ctx, data, w, h) {
        const step = data.length > 1 ? (w - 1) / (data.length - 1) : 0;
        ctx.beginPath();
        for (let i = 0; i < data.length; i++) {
            const x = 0.5 + i * step;
            const y = h - 1 - ratio(data[i]) * (h - 2);
            if (i === 0)
                ctx.moveTo(x, y);
            else
                ctx.lineTo(x, y);
        }
    }

    function repaint() {
        canvas.requestPaint();
    }

    onValuesChanged: repaint()
    onSecondChanged: repaint()
    onShown_toneChanged: repaint()
    onShown_second_toneChanged: repaint()

    implicitWidth: 200
    implicitHeight: row.implicitHeight

    Labeled {
        id: row
        anchors.fill: parent
        icon: root.icon
        title: root.title
        title_width: root.title_width
        label: root.label

        Drawn {
            id: canvas
            width: parent.width
            height: root.plot_height
            painter: root.draw
            onWidthChanged: requestPaint()
        }
    }
}
