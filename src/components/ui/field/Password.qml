import QtQuick
import theme
import components.behaviors
import components.ui.mark as Mark

Base {
    id: root

    property bool shown: false

    icon: "⚿"
    secret: !shown

    Item {
        width: eye.implicitWidth + Spacing.inner * 2
        height: eye.implicitHeight + Spacing.tight * 2

        Mark.Eye {
            id: eye
            anchors.centerIn: parent
            on: root.shown
        }

        Interactive {
            anchors.fill: parent
            checkable: true
            checked: root.shown
            onActivated: root.shown = !root.shown
        }
    }
}
