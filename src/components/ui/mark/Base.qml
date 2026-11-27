import QtQuick
import theme
import components.behaviors

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

    Drawn {
        id: canvas
        visible: root.drawn
        anchors.fill: parent
        painter: root.draw
    }
}
