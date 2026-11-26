import QtQuick

Base {
    id: root

    required title
    property bool cancellable: false
    signal cancelled

    busy: true
    primary: cancellable ? "cancel" : ""
    onPrimary_pressed: cancelled()
}
