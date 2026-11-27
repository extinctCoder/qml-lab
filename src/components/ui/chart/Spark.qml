import QtQuick

Base {
    id: root

    function draw(ctx, w, h) {
        if (values.length < 2)
            return;
        path(ctx, values, w, h);
        ctx.lineTo(w - 0.5, h);
        ctx.lineTo(0.5, h);
        ctx.closePath();
        ctx.globalAlpha = 0.18;
        ctx.fillStyle = shown_tone;
        ctx.fill();
        ctx.globalAlpha = 1;
        path(ctx, values, w, h);
        ctx.strokeStyle = shown_tone;
        ctx.lineWidth = 1.5;
        ctx.stroke();
    }
}
