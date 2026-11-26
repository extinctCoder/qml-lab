import QtQuick
import theme

Base {
    id: root

    required title
    property bool retry: true
    property string link: ""
    signal retried
    signal linked

    tone: Colors.error
    primary: retry ? "try again" : ""
    secondary: link
    onPrimary_pressed: retried()
    onSecondary_pressed: linked()
}
