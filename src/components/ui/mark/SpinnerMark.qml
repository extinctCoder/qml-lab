import QtQuick
import theme

Item {
    id: root

    property color color: Colors.on_surface_variant
    property int size: 14

    implicitWidth: size
    implicitHeight: size

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.strokeStyle = root.color;
            ctx.lineWidth = Math.max(2, root.size / 8);
            ctx.lineCap = "square";
            ctx.beginPath();
            const r = (Math.min(width, height) - ctx.lineWidth) / 2;
            ctx.arc(width / 2, height / 2, r, 0, Math.PI * 1.5);
            ctx.stroke();
        }
    }
    onColorChanged: canvas.requestPaint()
    onSizeChanged: canvas.requestPaint()

    RotationAnimator on rotation {
        from: 0
        to: 360
        duration: 1000
        loops: Animation.Infinite
        running: root.visible
    }
}
