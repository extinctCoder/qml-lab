pragma ComponentBehavior: Bound

import QtQuick
import theme
import components.ui
import components.behaviors
import components.ui.button as Button
import components.ui.field as Field
import components.ui.feedback as Feedback

FocusScope {
    id: root

    property var options: []
    property bool searchable: true
    property string placeholder: "search…"
    property string empty_text: "no matches"
    property int rows: 6
    property string query: ""
    property bool esc_leaves: true
    property string list_appearance: "outlined"
    readonly property var matches: Fuzzy.rank(query, options)
    readonly property alias highlight: cursor
    signal picked(var option)

    property string typed: ""

    function pick_current() {
        if (cursor.index >= 0 && cursor.index < matches.length)
            picked(matches[cursor.index].option);
    }

    function highlight_title(title) {
        for (let i = 0; i < matches.length; i++)
            if (matches[i].option.title === title) {
                cursor.index = i;
                return;
            }
        cursor.reset();
    }

    onMatchesChanged: cursor.reset()

    implicitWidth: 320
    implicitHeight: column.implicitHeight

    Highlight {
        id: cursor
        count: root.matches.length
        page: root.rows
    }

    Timer {
        id: typing
        interval: 700
        onTriggered: root.typed = ""
    }

    Keys.onPressed: event => {
        if (root.searchable)
            return;
        if (cursor.handle(event)) {
            event.accepted = true;
        } else if (event.key === Qt.Key_Home || event.key === Qt.Key_End) {
            cursor.index = event.key === Qt.Key_Home ? 0 : cursor.count - 1;
            event.accepted = true;
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
            root.pick_current();
            event.accepted = true;
        } else if (event.text.length === 1 && event.text.charCodeAt(0) > 32 && event.text.charCodeAt(0) !== 127) {
            root.typed += event.text;
            typing.restart();
            const best = Fuzzy.rank(root.typed, root.options);
            if (best.length > 0)
                cursor.index = best[0].order;
            event.accepted = true;
        }
    }

    Column {
        id: column
        width: root.width
        spacing: Spacing.tight

        Field.Search {
            id: search
            visible: root.searchable
            width: parent.width
            focus: root.searchable
            text: root.query
            placeholder: root.placeholder
            label: root.matches.length + (root.matches.length === 1 ? " result" : " results")
            highlight: cursor
            esc_leaves: root.esc_leaves
            onEdited: text => root.query = text
            onSubmitted: root.pick_current()
        }

        Surface {
            width: parent.width
            appearance: root.list_appearance
            padding_x: 0
            padding_y: Spacing.tight

            Item {
                width: parent.width
                implicitHeight: list.visible ? list.height : empty.implicitHeight

                ListView {
                    id: list
                    visible: root.matches.length > 0
                    width: parent.width
                    height: Math.min(contentHeight, root.rows * row_height)
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    model: root.matches
                    currentIndex: cursor.index
                    onCurrentIndexChanged: if (currentIndex >= 0)
                        positionViewAtIndex(currentIndex, ListView.Contain)

                    readonly property real row_height: count > 0 ? contentHeight / count : 0

                    delegate: Button.ListItem {
                        id: row
                        required property var modelData
                        required property int index
                        width: ListView.view.width
                        icon: row.modelData.option.icon ? row.modelData.option.icon : ""
                        title: Fuzzy.emphasize(row.modelData.option.title, row.modelData.positions, Colors.primary)
                        description: row.modelData.option.description ? row.modelData.option.description : ""
                        meta: row.modelData.option.meta ? row.modelData.option.meta : ""
                        focusable: false
                        highlighted: row.index === cursor.index
                        onHoveredChanged: if (hovered)
                            cursor.index = row.index
                        onClicked: root.picked(row.modelData.option)
                    }
                }

                Feedback.Empty {
                    id: empty
                    visible: root.matches.length === 0
                    compact: true
                    icon: "⌕"
                    title: root.empty_text
                }
            }
        }
    }
}
