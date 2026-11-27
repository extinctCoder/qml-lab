import QtQuick
import QtQuick.Templates as T
import theme

T.Label {
    color: enabled ? Colors.on_surface : States.disabled_text
    linkColor: Colors.primary
    font.family: Type.family
    font.pixelSize: Type.body
}
