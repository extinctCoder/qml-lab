import QtQuick
import components.ui.button as Button

Base {
    id: root

    icon: "⌕"

    Button.Basic {
        visible: root.input.text !== ""
        variant: "ghost"
        text: "×"
        onClicked: {
            root.input.text = "";
            root.edited("");
            root.input.forceActiveFocus();
        }
    }
}
