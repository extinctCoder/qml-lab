import QtQuick
import theme

Base {
    id: root

    property int size: 14

    drawn: true
    on: true
    implicitWidth: size
    implicitHeight: size

    onSizeChanged: repaint()

    function draw(ctx, w, h) {
        ctx.strokeStyle = root.tone;
        ctx.lineWidth = Math.max(2, root.size / 8);
        ctx.lineCap = "square";
        ctx.beginPath();
        const r = (Math.min(w, h) - ctx.lineWidth) / 2;
        ctx.arc(w / 2, h / 2, r, 0, Math.PI * 1.5);
        ctx.stroke();
    }

    RotationAnimator on rotation {
        from: 0
        to: 360
        duration: 1000
        loops: Animation.Infinite
        running: root.on && root.visible
    }
}
