import QtQuick
import theme
import components.ui
import components.ui.text as Text

// Raster content (album art, an app thumbnail, a face) — the one thing the
// library draws that isn't a glyph. It loads the source and clips it to a
// rounded square (or a circle, `round`). Until it's ready — or when there's no
// source — it shows a fallback: a muted glyph or letter on a framed surface.
// Drawn on a Canvas, like every other drawn Base, so it needs no extra modules.
Item {
    id: root

    property url source: ""
    property string fallback: ""
    property real radius: Shape.radius
    property bool round: false

    implicitWidth: 40
    implicitHeight: 40

    readonly property bool ready: canvas.loaded

    Surface {
        anchors.fill: parent
        visible: !root.ready
        appearance: "filled"
        level: 4
        radius: root.round ? Math.min(width, height) / 2 : root.radius

        Text.Mono {
            anchors.centerIn: parent
            visible: root.fallback !== ""
            text: root.fallback
            tone: Colors.on_surface_variant
            font.pixelSize: Math.min(root.width, root.height) * 0.5
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        property bool loaded: false

        function reload() {
            loaded = false;
            requestPaint();
            if (root.source == "")
                return;
            if (isImageLoaded(root.source)) {
                loaded = true;
                requestPaint();
            } else if (!isImageLoading(root.source)) {
                loadImage(root.source);
            }
        }

        onImageLoaded: {
            loaded = true;
            requestPaint();
        }

        Component.onCompleted: reload()

        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            if (!loaded)
                return;
            const r = root.round ? Math.min(width, height) / 2 : root.radius;
            ctx.beginPath();
            if (root.round) {
                ctx.arc(width / 2, height / 2, r, 0, Math.PI * 2);
            } else {
                ctx.moveTo(r, 0);
                ctx.arcTo(width, 0, width, height, r);
                ctx.arcTo(width, height, 0, height, r);
                ctx.arcTo(0, height, 0, 0, r);
                ctx.arcTo(0, 0, width, 0, r);
            }
            ctx.closePath();
            ctx.clip();
            ctx.drawImage(root.source, 0, 0, width, height);
        }
    }

    onSourceChanged: canvas.reload()
    onVisibleChanged: if (visible)
        canvas.requestPaint()
}
