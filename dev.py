"""Run src/main.qml and reload it whenever a .qml file (or qmldir) in src/ changes.

    uv run dev.py                   # src/main.qml
    uv run dev.py src/gallery/Gallery.qml

Every 0.3 s it compares each file's modification time with the last check:
the same on every OS and with every editor, and cheap for a project this size.
The window stays open (and on top); QML errors print here and the last good
view stays until the file is fixed. src/ is also where QML modules (theme,
components) are imported from. Ctrl+C stops it.
"""

import signal
import sys
import time
from pathlib import Path

from PySide6.QtCore import Qt, QTimer, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQuick import QQuickView

SRC = Path(__file__).parent / "src"


def snapshot():
    """Every watched file and its modification time."""
    return {
        p: p.stat().st_mtime_ns
        for p in SRC.rglob("*")
        if p.is_file() and (p.suffix == ".qml" or p.name == "qmldir")
    }


def load(view, target):
    view.setSource(QUrl())
    view.engine().clearSingletons()
    view.engine().clearComponentCache()
    view.setSource(QUrl.fromLocalFile(str(target.resolve())))
    return [e.toString() for e in view.errors()]


def log(message):
    print(f"[{time.strftime('%H:%M:%S')}] {message}", flush=True)


if __name__ == "__main__":
    target = Path(sys.argv[1]) if len(sys.argv) > 1 else SRC / "main.qml"

    app = QGuiApplication(sys.argv)
    app.styleHints().setTabFocusBehavior(Qt.TabFocusBehavior.TabFocusAllControls)
    view = QQuickView()
    view.setFlag(Qt.WindowType.WindowStaysOnTopHint, True)  # stay above the editor
    view.setResizeMode(QQuickView.ResizeMode.SizeRootObjectToView)
    view.engine().addImportPath(str(SRC))  # `import theme`, `import components`

    state = {"files": snapshot(), "reloads": 0}
    errors = load(view, target)
    log(
        f"loaded {target.relative_to(SRC.parent) if target.is_relative_to(SRC.parent) else target}"
        f", watching {len(state['files'])} file(s) in src/"
    )
    for e in errors:
        print("  " + e, flush=True)

    def check():
        now = snapshot()
        before = state["files"]
        if now == before:
            return
        changes = (
            [f"{p.relative_to(SRC.parent)} (added)" for p in now.keys() - before.keys()]
            + [
                f"{p.relative_to(SRC.parent)} (removed)"
                for p in before.keys() - now.keys()
            ]
            + [
                f"{p.relative_to(SRC.parent)} (modified)"
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

    # Ctrl+C: Python only sees it while Python code runs (the poll above runs every
    # 0.3 s), and inside a Qt callback it would be swallowed: quit the app instead.
    signal.signal(signal.SIGINT, lambda *_: (log("stopped"), app.quit()))

    view.setTitle("qml-lab")
    view.show()
    sys.exit(app.exec())
