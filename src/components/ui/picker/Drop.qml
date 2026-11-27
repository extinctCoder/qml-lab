import QtQuick
import theme
import components.ui
import components.behaviors

Popup {
    id: root

    property var options: []
    property bool searchable: false
    property int rows: 8
    property int box_width: 220
    readonly property alias list: options_list
    signal picked(var option)

    function show(from, title) {
        options_list.query = "";
        if (title)
            options_list.highlight_title(title);
        else
            options_list.highlight.reset();
        open(from);
    }

    Surface {
        width: root.box_width
        level: 5
        padding_x: Spacing.tight
        padding_y: Spacing.tight

        Base {
            id: options_list
            width: parent.width
            focus: true
            searchable: root.searchable
            esc_leaves: false
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
