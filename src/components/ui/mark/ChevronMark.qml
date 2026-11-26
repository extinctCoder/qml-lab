import QtQuick
import theme

Item {
    id: root

    property bool open: false
    property color color: Colors.on_surface_variant

    implicitWidth: 12
    implicitHeight: 12
    rotation: open ? 90 : 0

    Behavior on rotation {
        NumberAnimation {
            duration: Motion.small
            easing.type: Motion.ease_out
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.strokeStyle = root.color;
            ctx.lineWidth = 2;
            ctx.lineCap = "square";
            ctx.beginPath();
            ctx.moveTo(width * 0.35, height * 0.2);
            ctx.lineTo(width * 0.7, height * 0.5);
            ctx.lineTo(width * 0.35, height * 0.8);
            ctx.stroke();
        }
    }
    onColorChanged: canvas.requestPaint()
}
