import QtQuick
import theme
import components.ui.text as Text
import components.ui.button as Button

// The everyday dialog: a title, a line of explanation, and two buttons. The
// confirm button is `danger` for destructive choices. `confirmed` fires, then
// it closes; cancel just closes.
Base {
    id: root

    property string title: ""
    property string message: ""
    property string confirm: "confirm"
    property string cancel: "cancel"
    property bool danger: false
    signal confirmed

    Column {
        width: 280
        spacing: Spacing.gap

        Text.Header {
            width: parent.width
            title: root.title
        }

        Text.Mono {
            visible: root.message !== ""
            width: parent.width
            text: root.message
            muted: true
        }

        Row {
            anchors.right: parent.right
            spacing: Spacing.inner

            Button.Basic {
                text: root.cancel
                variant: "ghost"
                onClicked: root.close()
            }
            Button.Basic {
                text: root.confirm
                variant: root.danger ? "danger" : "primary"
                onClicked: {
                    root.confirmed();
                    root.close();
                }
            }
        }
    }
}
