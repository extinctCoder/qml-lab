import QtQuick
import theme
import components.ui.button as Button
import components.ui.mark as Mark

Base {
    id: root

    property bool shown: false

    icon: "⚿"
    secret: !shown

    Button.Mark {
        checkable: true
        checked: root.shown
        onClicked: root.shown = !root.shown

        Mark.Eye {
            on: root.shown
        }
    }
}
