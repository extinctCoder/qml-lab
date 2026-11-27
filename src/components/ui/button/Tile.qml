import QtQuick
import theme

Rich {
    id: root

    padding_y: Spacing.inner
    appearance: "outlined"
    item_content.show_switch: checkable
    item_content.switch_on: checked
}
