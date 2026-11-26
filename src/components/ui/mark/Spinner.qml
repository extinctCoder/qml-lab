import QtQuick
import theme

Base {
    id: root

    property int size: 14

    on: true
    on_color: Colors.on_surface_variant
    off_color: Colors.on_surface_variant

    implicitWidth: size
    implicitHeight: size

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.strokeStyle = root.tone;
            ctx.lineWidth = Math.max(2, root.size / 8);
            ctx.lineCap = "square";
            ctx.beginPath();
            const r = (Math.min(width, height) - ctx.lineWidth) / 2;
            ctx.arc(width / 2, height / 2, r, 0, Math.PI * 1.5);
            ctx.stroke();
        }
    }
    onToneChanged: canvas.requestPaint()
    onSizeChanged: canvas.requestPaint()

    RotationAnimator on rotation {
        from: 0
        to: 360
        duration: 1000
        loops: Animation.Infinite
        running: root.on && root.visible
    }
}
