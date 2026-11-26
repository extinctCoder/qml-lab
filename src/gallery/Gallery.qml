import QtQuick
import theme
import components

// The storybook: every component, in its variants and states.
Rectangle {
    width: 560
    height: 520
    color: Colors.surface

    Column {
        anchors.fill: parent
        anchors.margins: Spacing.edge
        spacing: Spacing.gap

        // ---- Mono: text sizes and roles ----
        Mono {
            text: "mono · sizes and roles"
            size: "label"
            muted: true
        }

        Column {
            spacing: Spacing.tight

            Mono {
                text: "09:27"
                size: "display"
                color: Colors.primary
            }
            Mono {
                text: "title · quick settings"
                size: "title"
            }
            Mono {
                text: "body · wi-fi · home · 92%"
            }
            Mono {
                text: "body, muted · connected since 08:14"
                muted: true
            }
            Mono {
                text: "label, muted · small captions"
                size: "label"
                muted: true
            }
        }

        // ---- Button: the five variants ----
        Mono {
            text: "button · variants, loudest to quietest (click: see the terminal)"
            size: "label"
            muted: true
        }

        Row {
            spacing: Spacing.inner

            Button {
                text: "save"
                onClicked: console.log("save")
            }
            Button {
                text: "next"
                variant: "tonal"
                onClicked: console.log("next")
            }
            Button {
                text: "back"
                variant: "outline"
                onClicked: console.log("back")
            }
            Button {
                text: "cancel"
                variant: "ghost"
                onClicked: console.log("cancel")
            }
            Button {
                text: "delete"
                variant: "danger"
                onClicked: console.log("delete")
            }
        }

        // ---- Button: states ----
        Mono {
            text: "button · states"
            size: "label"
            muted: true
        }

        Column {
            spacing: Spacing.tight

            Mono {
                text: "hover: a light tint · press and hold: a bit stronger"
                size: "label"
            }
            Mono {
                text: "click the window, then Tab: a focus ring moves across the buttons"
                size: "label"
            }
            Mono {
                text: "Enter or Space: clicks the focused button"
                size: "label"
            }
        }

        Row {
            spacing: Spacing.inner

            Button {
                text: "save"
                enabled: false
                onClicked: console.log("disabled: should never print")
            }
            Button {
                text: "back"
                variant: "outline"
                enabled: false
            }
            Mono {
                text: "← disabled: faded, ignores clicks, skipped by Tab"
                size: "label"
                muted: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
