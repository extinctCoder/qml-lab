import QtQuick
import components.ui.button as Button

Base {
    id: root

    property bool shown: false

    icon: "⚿"
    secret: !shown

    Button.Basic {
        variant: "ghost"
        text: root.shown ? "◎ hide" : "◉ show"
        onClicked: root.shown = !root.shown
    }
}
