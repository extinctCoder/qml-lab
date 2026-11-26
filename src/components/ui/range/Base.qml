import QtQuick
import theme
import components.behaviors
import components.ui.text as Text

// The base of every range (internal to the range family): a value between `from` and
// `to`, drawn as a block bar: a track, and the filled part in the accent (gray when
// disabled). The filled part glides when the value changes.
// On the left, an optional `icon` and an optional `title` (what it controls: "output",
// "firefox"). In a list, give every row the same `title_width`, so the bars line up.
// On the right, an optional `label` (e.g. "51%"); the owner formats it.
Item {
    id: root

    property real value: 0
    property real from: 0
    property real to: 100
    property string icon: ""
    property string title: ""
    property int title_width: 0                             // 0: as wide as the title itself
    property string label: ""
    property color tone: Colors.primary                     // the filled part's role
    property alias track: track                             // for Slider: the bar itself

    // where the value sits on the bar, from 0 to 1
    readonly property real ratio: to > from ? Math.max(0, Math.min(1, (value - from) / (to - from))) : 0

    implicitWidth: 200
    implicitHeight: Math.max(icon_text.implicitHeight, title_text.implicitHeight, label_text.implicitHeight, 10) + Spacing.tight * 2

    Row {
        anchors.fill: parent
        spacing: Spacing.inner

        Text.Mono {
            id: icon_text
            visible: root.icon !== ""
            anchors.verticalCenter: parent.verticalCenter
            text: root.icon
            tone: Colors.primary
        }

        Text.Mono {
            id: title_text
            visible: root.title !== ""
            anchors.verticalCenter: parent.verticalCenter
            width: root.title_width > 0 ? root.title_width : implicitWidth
            text: root.title
            maximumLineCount: 1                             // a long title stays on one line…
            elide: Qt.ElideRight                            // …and ends in "…"
        }

        // the bar: a track, and the filled part over it
        Rectangle {
            id: track
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
                   - (icon_text.visible ? icon_text.width + parent.spacing : 0)
                   - (title_text.visible ? title_text.width + parent.spacing : 0)
                   - (label_text.visible ? label_text.width + parent.spacing : 0)
            height: 10
            radius: Shape.radius
            color: Colors.surface_container_highest

            Rectangle {
                id: filled
                width: track.width * root.ratio
                height: parent.height
                radius: Shape.radius
                color: root.enabled ? root.tone : States.disabled_text

                Behavior on width {
                    Glide {}
                }
            }
        }

        Text.Mono {
            id: label_text
            visible: root.label !== ""
            anchors.verticalCenter: parent.verticalCenter
            text: root.label
            size: "label"
            muted: true
            horizontalAlignment: Qt.AlignRight
            width: Math.max(implicitWidth, 32)                 // stable width, so the bar doesn't jump
        }
    }
}
