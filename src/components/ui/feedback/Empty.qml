import QtQuick

Base {
    id: root

    required title
    property string action: ""
    property string link: ""
    signal acted
    signal linked

    primary: action
    secondary: link
    onPrimary_pressed: acted()
    onSecondary_pressed: linked()
}
