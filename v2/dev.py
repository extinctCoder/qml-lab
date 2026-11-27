"""Run the v2 gallery in the Tui style, reloading on any .qml/qmldir change in v2/.

    uv run v2/dev.py
    uv run v2/dev.py v2/gallery/Gallery.qml

The Tui style skins Qt Quick Controls; controls we haven't styled fall back to the
Basic style (set in Tui/qmldir). Ctrl+C stops it.
"""

import signal
import sys
import time
from pathlib import Path

from PySide6.QtCore import Qt, QTimer, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQuick import QQuickView
from PySide6.QtQuickControls2 import QQuickStyle

V2 = Path(__file__).parent


def snapshot():
    return {
        p: p.stat().st_mtime_ns
        for p in V2.rglob("*")
        if p.is_file() and (p.suffix == ".qml" or p.name == "qmldir")
    }


def load(view, target):
    view.setSource(QUrl())
    view.engine().clearComponentCache()
    view.setSource(QUrl.fromLocalFile(str(target.resolve())))
    return [e.toString() for e in view.errors()]


def log(message):
    print(f"[{time.strftime('%H:%M:%S')}] {message}", flush=True)


if __name__ == "__main__":
    target = Path(sys.argv[1]) if len(sys.argv) > 1 else V2 / "gallery" / "Gallery.qml"

    app = QGuiApplication(sys.argv)
    app.styleHints().setTabFocusBehavior(Qt.TabFocusBehavior.TabFocusAllControls)
    QQuickStyle.setStyle("Tui")  # our custom style; Basic is the fallback (Tui/qmldir)

    view = QQuickView()
    view.setFlag(Qt.WindowType.WindowStaysOnTopHint, True)
    view.setResizeMode(QQuickView.ResizeMode.SizeRootObjectToView)
    view.engine().addImportPath(str(V2))  # resolves `import theme` and the Tui style

    state = {"files": snapshot(), "reloads": 0}
    errors = load(view, target)
    log(
        f"loaded {target.relative_to(V2) if target.is_relative_to(V2) else target}"
        f" in the Tui style, watching {len(state['files'])} file(s)"
    )
    for e in errors:
        print("  " + e, flush=True)

    def check():
        now = snapshot()
        before = state["files"]
        if now == before:
            return
        changes = (
            [f"{p.relative_to(V2)} (added)" for p in now.keys() - before.keys()]
            + [f"{p.relative_to(V2)} (removed)" for p in before.keys() - now.keys()]
            + [
                f"{p.relative_to(V2)} (modified)"
                for p in now.keys() & before.keys()
                if now[p] != before[p]
            ]
        )
        state["files"] = now
        state["reloads"] += 1
        errors = load(view, target)
        log(
            f"reload #{state['reloads']}: {', '.join(sorted(changes))}"
            + (" · errors:" if errors else " · ok")
        )
        for e in errors:
            print("  " + e, flush=True)

    poll = QTimer(interval=300)
    poll.timeout.connect(check)
    poll.start()

    signal.signal(signal.SIGINT, lambda *_: (log("stopped"), app.quit()))

    view.setTitle("qml-lab v2 · Tui")
    view.show()
    sys.exit(app.exec())
