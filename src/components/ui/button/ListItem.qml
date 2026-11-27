import QtQuick
import theme

Rich {
    id: root

    property string mark: "radio"

    width: parent ? parent.width : implicitWidth
    padding_y: Spacing.tight
    appearance: "ghost"
    item_content.mark: checkable ? mark : ""
    item_content.marked: checked
}
