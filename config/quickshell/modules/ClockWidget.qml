import QtQuick
import "../services/"

Text {
    id: clockWidget
    anchors.centerIn: parent
    text: Time.time
    color: "#d4be98"
    font {
        family: "JetBrainsMono Nerd Font Mono"
        pixelSize: 18
    }
}
