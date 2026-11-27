pragma Singleton
import QtQuick

// Local weather (placeholder values — set your location/source when the real
// service lands). Feeds the lockscreen and the dashboard.
QtObject {
    property string location: "home"
    property int temp: 18            // °C
    property string condition: "partly cloudy"
    property int high: 21
    property int low: 12
}
