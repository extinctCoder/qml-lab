import QtQuick
import theme
import components.ui

Surface {
    id: root

    property bool open: false
    property alias header_items: header_area.data
    default property alias section_content: body.data
    signal toggled(bool open)

    function fold() {
        open = !open;
        toggled(open);
    }

    padding_x: 0
    padding_y: 0

    Column {
        width: parent.width

        Item {
            id: header_area
            width: parent.width
            implicitHeight: childrenRect.height
        }

        Rectangle {
            width: parent.width
            height: Shape.border
            color: Colors.outline_variant
            visible: body_box.height > 0
        }

        Item {
            id: body_box
            width: parent.width
            height: root.open ? body.implicitHeight + Spacing.tight * 2 : 0
            visible: height > 0
            clip: true

            Behavior on height {
                NumberAnimation {
                    duration: root.open ? Motion.open : Motion.close
                    easing.type: root.open ? Motion.ease_out : Motion.ease_in
                }
            }

            Column {
                id: body
                x: Spacing.tight
                y: Spacing.tight
                width: parent.width - Spacing.tight * 2
            }
        }
    }
}
