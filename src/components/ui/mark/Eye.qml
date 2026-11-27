import QtQuick
import theme

Base {
    id: root

    implicitWidth: 16
    implicitHeight: 12

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            const w = width, h = height;
            ctx.strokeStyle = root.tone;
            ctx.fillStyle = root.tone;
            ctx.lineWidth = 1.5;
            ctx.lineCap = "square";
            ctx.beginPath();
            ctx.moveTo(1, h / 2);
            ctx.quadraticCurveTo(w / 2, -h * 0.25, w - 1, h / 2);
            ctx.quadraticCurveTo(w / 2, h * 1.25, 1, h / 2);
            ctx.stroke();
            if (root.on) {
                ctx.beginPath();
                ctx.arc(w / 2, h / 2, 2.25, 0, Math.PI * 2);
                ctx.fill();
            } else {
                ctx.beginPath();
                ctx.moveTo(2, h - 0.5);
                ctx.lineTo(w - 2, 0.5);
                ctx.stroke();
            }
        }
    }
    onToneChanged: canvas.requestPaint()
    onOnChanged: canvas.requestPaint()
}
