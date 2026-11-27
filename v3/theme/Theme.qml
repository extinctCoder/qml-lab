import QtQuick
import QtQuick.Controls
import theme

// The root wrapper. The Tui style paints every control from the Colors tokens
// directly — nothing depends on palette inheritance, popups included — so there
// is no palette here at all. It only sets the app background and the default
// mono font that everything inherits. One source of truth: theme/Colors.qml.
// Wrap a window's content in `Theme { }`.
Pane {
    id: root

    padding: 0
    font.family: Type.family
    font.pixelSize: Type.body

    background: Rectangle { color: Colors.surface }
}
