"""Run the v3 gallery. The theme is injected once, in QML, by wrapping content in
`Theme { }` (theme/Theme.qml) — Qt Quick Controls read their palette from the QML
tree, so it propagates down to every control. (The C++ app palette and the
qtquickcontrols2.conf palette are both ignored by Qt Quick — only the QML tree
palette works.)

    uv run v3/dev.py
"""

import signal
import sys
import time
from pathlib import Path

from PySide6.QtCore import Qt, QTimer, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQuick import QQuickView
from PySide6.QtQuickControls2 import QQuickStyle

V3 = Path(__file__).parent


def load(view, target):
    view.setSource(QUrl())
    view.engine().clearComponentCache()
    view.setSource(QUrl.fromLocalFile(str(target.resolve())))
    return [e.toString() for e in view.errors()]


def snapshot():
    return {
        p: p.stat().st_mtime_ns
        for p in V3.rglob("*")
        if p.is_file() and (p.suffix == ".qml" or p.name == "qmldir")
    }


def log(message):
    print(f"[{time.strftime('%H:%M:%S')}] {message}", flush=True)


if __name__ == "__main__":
    target = Path(sys.argv[1]) if len(sys.argv) > 1 else V3 / "gallery" / "Gallery.qml"

    app = QGuiApplication(sys.argv)
    app.styleHints().setTabFocusBehavior(Qt.TabFocusBehavior.TabFocusAllControls)
    QQuickStyle.setStyle("Fusion")

    view = QQuickView()
    view.setFlag(Qt.WindowType.WindowStaysOnTopHint, True)
    view.setResizeMode(QQuickView.ResizeMode.SizeRootObjectToView)
    view.engine().addImportPath(str(V3))

    state = {"files": snapshot(), "reloads": 0}
    errors = load(view, target)
    log(f"loaded {target.name} (theme via Theme root), watching {len(state['files'])} file(s)")
    for e in errors:
        print("  " + e, flush=True)

    def check():
        now = snapshot()
        if now == state["files"]:
            return
        state["files"] = now
        state["reloads"] += 1
        errors = load(view, target)
        log(f"reload #{state['reloads']}" + (" · errors:" if errors else " · ok"))
        for e in errors:
            print("  " + e, flush=True)

    poll = QTimer(interval=300)
    poll.timeout.connect(check)
    poll.start()
    signal.signal(signal.SIGINT, lambda *_: (log("stopped"), app.quit()))
    view.setTitle("qml-lab v3")
    view.show()
    sys.exit(app.exec())
