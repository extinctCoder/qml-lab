import QtQuick
import theme
import components.ui
import components.behaviors

Popup {
    id: root

    property var options: []
    property int width_hint: 220
    property int rows: 8
    signal picked(var option)

    function show(from) {
        list.query = "";
        list.highlight.reset();
        open(from);
    }

    Surface {
        level: 5
        padding_x: Spacing.tight
        padding_y: Spacing.tight

        Base {
            id: list
            width: root.width_hint
            focus: true
            searchable: false
            list_appearance: "none"
            rows: root.rows
            options: root.options
            onPicked: option => {
                root.close();
                root.picked(option);
            }
        }
    }
}
