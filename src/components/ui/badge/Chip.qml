import QtQuick
import theme
import components.ui
import components.ui.text as Text
import components.ui.button as Button
import components.behaviors

// A tag you can act on: a filter you toggle, or a token you remove. Same box
// language as the other badges, but interactive — `checkable` gives it the
// selected look, `removable` adds an × that fires `removed` on its own (a click
// on the × never counts as a click on the chip). Contains Base's look rather
// than inheriting it, since Base centers a single label.
Surface {
    id: root

    property string text: ""
    property string icon: ""
    property bool checkable: false
    property bool checked: false
    property bool removable: false
    signal clicked
    signal removed

    appearance: "outlined"
    selected: checkable && checked
    padding_x: Spacing.tight + 2
    padding_y: 1

    readonly property color label_tone: selected ? Colors.on_secondary_container : Colors.on_surface_variant

    Strip {
        anchors.fill: parent
        spacing: Spacing.tight

        leading: [
            Text.Mono {
                visible: root.icon !== ""
                anchors.verticalCenter: parent.verticalCenter
                text: root.icon
                size: "label"
                tone: root.selected ? Colors.on_secondary_container : Colors.primary
            }
        ]

        Text.Mono {
            anchors.verticalCenter: parent.verticalCenter
            text: root.text
            size: "label"
            tone: root.label_tone
        }

        trailing: [
            Button.Mark {
                id: remove_btn
                visible: root.removable
                anchors.verticalCenter: parent.verticalCenter
                padding_x: 1
                padding_y: 1
                onClicked: root.removed()

                Text.Mono {
                    text: "×"
                    size: "label"
                    tone: root.label_tone
                }
            }
        ]
    }

    StateLayer {
        anchors.fill: parent
        radius: root.radius
        current: chip_input.current
        pressed: chip_input.pressed
    }

    Interactive {
        id: chip_input
        anchors.fill: parent
        exclude: root.removable ? remove_btn : null
        onActivated: root.clicked()
    }
}
