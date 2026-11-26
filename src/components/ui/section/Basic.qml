import QtQuick
import theme
import components.ui.text
import components.ui.mark
import components.behaviors

// A section (pattern A): its header opens and closes it (click, Enter or Space).
// The header shows an icon, a title, a description (best used to summarize the current
// state, e.g. "headphones · 51%"), optional meta, and a chevron that turns when open.
// checkable: true adds a switch at the header's right edge (wi-fi, bluetooth). The switch
// is its own control (click or Space); it is told `checked` and reports `switched`; the
// owner flips it. Clicking anywhere else on the header opens and closes the section.
// Only the header row is clickable, so list items inside keep working.
Base {
    id: root

    property string icon: ""
    required property string title
    property string description: ""
    property string meta: ""
    property bool checkable: false
    property bool checked: false
    signal switched

    header_items: [
        Item {
            id: row
            width: parent.width
            implicitHeight: header.implicitHeight + Spacing.inner * 2

            Header {
                id: header
                x: Spacing.inner
                anchors.verticalCenter: parent.verticalCenter
                icon: root.icon
                title: root.title
                description: root.description
            }

            // the switch: its own control at the right edge (where tiles have it too),
            // so it toggles without opening the section
            Item {
                id: switch_box
                visible: root.checkable
                anchors.right: parent.right
                anchors.rightMargin: Spacing.inner
                anchors.verticalCenter: parent.verticalCenter
                width: root.checkable ? switch_mark.implicitWidth : 0
                height: switch_mark.implicitHeight

                SwitchMark {
                    id: switch_mark
                    on: root.checked
                }
                Interactive {
                    anchors.fill: parent
                    anchors.margins: -Spacing.tight
                    checkable: true
                    checked: root.checked
                    onActivated: root.switched()
                }
            }

            // meta and the chevron, left of the switch (or at the edge without one)
            Row {
                id: trailing
                anchors.right: root.checkable ? switch_box.left : parent.right
                anchors.rightMargin: Spacing.inner
                anchors.verticalCenter: parent.verticalCenter
                spacing: Spacing.inner

                Mono {
                    visible: root.meta !== ""
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.meta
                    size: "label"
                    muted: true
                }
                ChevronMark {
                    anchors.verticalCenter: parent.verticalCenter
                    open: root.open
                }
            }

            // the header's click area: the whole row, so its hover tint is one clean band;
            // clicks on the switch are excluded, they belong to the switch
            Interactive {
                anchors.fill: parent
                exclude: root.checkable ? switch_box : null
                z: -1
                onActivated: root.fold()
            }
        }
    ]
}
