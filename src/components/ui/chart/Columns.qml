import QtQuick
import theme

Base {
    id: root

    plot_height: 28

    function draw(ctx, w, h) {
        const n = values.length;
        if (n === 0)
            return;
        const gap = n > 30 ? 1 : 2;
        const column = Math.max(1, (w - gap * (n - 1)) / n);
        for (let i = 0; i < n; i++) {
            const x = i * (column + gap);
            const filled = Math.max(1, ratio(values[i]) * h);
            ctx.fillStyle = Colors.surface_container_highest;
            ctx.fillRect(x, 0, column, h);
            ctx.fillStyle = shown_tone;
            ctx.fillRect(x, h - filled, column, filled);
        }
    }
}
