import QtQuick
import theme

Item {
    id: root

    property bool on: false
    property color on_color: Colors.primary
    property color off_color: Colors.outline
    property bool drawn: false
    readonly property color tone: !enabled ? States.disabled_text : on ? on_color : off_color

    function draw(ctx, w, h) {
    }

    function repaint() {
        canvas.requestPaint();
    }

    onToneChanged: repaint()
    onOnChanged: repaint()

    Canvas {
        id: canvas
        visible: root.drawn
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            root.draw(ctx, width, height);
        }
    }
}
