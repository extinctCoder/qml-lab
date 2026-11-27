import QtQuick
import theme
import components.ui
import components.behaviors
import components.ui.button as Button
import components.ui.text as Text
import components.ui.mark as Mark

Item {
    id: root

    property var options: []
    property string current: ""
    property string placeholder: "choose…"
    property bool searchable: false
    property int rows: 8
    signal picked(var option)

    implicitWidth: 200
    implicitHeight: button.implicitHeight

    Button.Basic {
        id: button
        anchors.fill: parent
        variant: "outline"
        onClicked: {
            list.query = "";
            list.highlight_title(root.current);
            popup.open(button);
        }
    }

    Text.Mono {
        anchors.left: parent.left
        anchors.leftMargin: Spacing.gap
        anchors.right: chevron.left
        anchors.rightMargin: Spacing.inner
        anchors.verticalCenter: parent.verticalCenter
        text: root.current !== "" ? root.current : root.placeholder
        size: "label"
        muted: root.current === ""
        tone: root.current !== "" ? Colors.primary : Colors.on_surface_variant
        maximumLineCount: 1
        elide: Qt.ElideRight
    }

    Mark.Chevron {
        id: chevron
        anchors.right: parent.right
        anchors.rightMargin: Spacing.inner
        anchors.verticalCenter: parent.verticalCenter
        on: true
        rotation: popup.opened ? -90 : 90
    }

    Popup {
        id: popup
        anchor: button

        Surface {
            width: Math.max(root.width, 220)
            level: 5
            padding_x: Spacing.tight
            padding_y: Spacing.tight

            Base {
                id: list
                width: parent.width
                focus: true
                searchable: root.searchable
                esc_leaves: false
                list_appearance: "none"
                rows: root.rows
                options: root.options
                onPicked: option => {
                    popup.close();
                    root.picked(option);
                }
            }
        }
    }
}
