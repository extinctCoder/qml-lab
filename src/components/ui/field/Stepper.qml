import QtQuick
import theme
import components.ui.text as Text
import components.ui.button as Button

// A field that holds one number, with − and + at its right edge. Type it, or
// step it (the buttons, or ↑ ↓ once focused). Clamped to [from, to]. The owner
// holds the value and reacts to `changed`, like every other control.
Base {
    id: root

    property real value: 0
    property real from: 0
    property real to: 100
    property real step: 1
    property int decimals: 0
    signal changed(real value)

    function set(v) {
        const c = Math.max(root.from, Math.min(root.to, v));
        if (c !== root.value)
            root.changed(c);
    }

    implicitWidth: 160
    text: root.value.toFixed(root.decimals)

    onEdited: t => {
        const n = parseFloat(t);
        if (!isNaN(n))
            root.set(n);
    }
    onSubmitted: root.input.focus = false

    Keys.onUpPressed: root.set(root.value + root.step)
    Keys.onDownPressed: root.set(root.value - root.step)

    trailing: [
        Button.Mark {
            anchors.verticalCenter: parent.verticalCenter
            padding_x: Spacing.tight
            padding_y: Spacing.tight
            enabled: root.enabled && root.value > root.from
            onClicked: root.set(root.value - root.step)

            Text.Mono {
                text: "−"
                size: "title"
                tone: Colors.primary
            }
        },
        Button.Mark {
            anchors.verticalCenter: parent.verticalCenter
            padding_x: Spacing.tight
            padding_y: Spacing.tight
            enabled: root.enabled && root.value < root.to
            onClicked: root.set(root.value + root.step)

            Text.Mono {
                text: "+"
                size: "title"
                tone: Colors.primary
            }
        }
    ]
}
