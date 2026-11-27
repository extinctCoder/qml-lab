import QtQuick

Base {
    id: root

    plot_height: 48

    function draw(ctx, w, h) {
        ctx.lineWidth = 1.5;
        if (second.length > 1) {
            path(ctx, second, w, h);
            ctx.strokeStyle = shown_second_tone;
            ctx.stroke();
        }
        if (values.length > 1) {
            path(ctx, values, w, h);
            ctx.strokeStyle = shown_tone;
            ctx.stroke();
        }
    }
}
