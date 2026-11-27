"""Run the qml-lab gallery with live reload.

The Tui style (QQuickStyle "Tui") paints every control from the M3 tokens in
theme/, so the whole tree is themed with no palette. Edit any .qml under the
repo and the window reloads.

    uv run dev.py
    uv run dev.py gallery/Catalogue.qml
"""

import signal
import sys
import time
from pathlib import Path

from PySide6.QtCore import Qt, QTimer, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQuick import QQuickView
from PySide6.QtQuickControls2 import QQuickStyle

ROOT = Path(__file__).parent


def load(view, target):
    view.setSource(QUrl())
    view.engine().clearComponentCache()
    view.setSource(QUrl.fromLocalFile(str(target.resolve())))
    return [e.toString() for e in view.errors()]


def snapshot():
    return {
        p: p.stat().st_mtime_ns
        for p in ROOT.rglob("*")
        if p.is_file() and (p.suffix == ".qml" or p.name == "qmldir")
    }


def log(message):
    print(f"[{time.strftime('%H:%M:%S')}] {message}", flush=True)


if __name__ == "__main__":
    target = Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT / "gallery" / "Gallery.qml"

    app = QGuiApplication(sys.argv)
    app.styleHints().setTabFocusBehavior(Qt.TabFocusBehavior.TabFocusAllControls)
    QQuickStyle.setStyle("Tui")

    view = QQuickView()
    view.setFlag(Qt.WindowType.WindowStaysOnTopHint, True)
    view.setResizeMode(QQuickView.ResizeMode.SizeRootObjectToView)
    view.engine().addImportPath(str(ROOT))

    state = {"files": snapshot(), "reloads": 0}
    errors = load(view, target)
    log(f"loaded {target.name} · Tui style, watching {len(state['files'])} file(s)")
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
    view.setTitle("qml-lab")
    view.show()
    sys.exit(app.exec())
