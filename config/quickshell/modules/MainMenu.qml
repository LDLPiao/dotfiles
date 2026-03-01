import Quickshell
import QtQuick

Rectangle {
    implicitWidth: 70
    implicitHeight: 30

    color: "transparent"

    border.color: "#ffffff"
    border.width: 1

    Text {
        anchors.centerIn: parent
        font.pixelSize: 18

        text: ""

        color: "#7daea3"
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked: {
            Quickshell.execDetached(["sh", "rofi-main-menu.sh"]);
        }
    }
}
