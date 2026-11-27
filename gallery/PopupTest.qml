import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme

// Popups under Tui — the category I missed before. Menu, ComboBox dropdown and
// ToolTip are Tui-styled (read Colors directly), so they must be dark+green, not
// Fusion/Basic blue. Opened on load so a static grab captures them.
Theme {
    id: root
    width: 720
    height: 520

    ColumnLayout {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: Spacing.edge
        spacing: Spacing.gap

        Label { text: "popups · Tui"; color: Colors.primary; font.pixelSize: Type.title }
        ComboBox { id: cb; model: ["eco", "balanced", "performance"]; implicitWidth: 200 }
        Button { id: mb; text: "menu"; variant: "primary" }
        Label {
            text: "tooltip ↓"
            color: Colors.on_surface
            ToolTip.visible: true
            ToolTip.text: "hover tooltip"
        }
    }

    Menu {
        id: menu
        x: 320
        y: 120
        MenuItem { text: "open"; highlighted: true }
        MenuItem { text: "rename" }
        MenuSeparator {}
        MenuItem { text: "delete" }
    }

    Component.onCompleted: {
        cb.popup.open()
        menu.open()
    }
}
