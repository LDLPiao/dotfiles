pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    required property var screen

    Repeater {
        model: Hyprland.workspaces.values.filter(w => w.monitor?.name === screen?.name)

        Rectangle {
            id: button

            required property var modelData
            property bool isSpecial: button.modelData.id < 0
            property bool isActive: Hyprland.focusedWorkspace?.id === button.modelData.id
            property bool isOccupied: Hyprland.toplevels.values.some(w => w.workspace?.id === button.modelData.id)

            implicitWidth: mouseArea.containsMouse ? 30 : 20
            implicitHeight: 30

            color: "transparent"

            border.color: "#ffffff"
            border.width: 1

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            Text {
                anchors.centerIn: parent

                font.pixelSize: 16

                text: button.isSpecial ? "s" : button.modelData.id
                color: button.isActive ? "#d65d0e" : (button.isOccupied ? "#d4be98" : "#928374")
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onClicked: {
                    Hyprland.dispatch("workspace " + button.modelData.id);
                }
            }
        }
    }
}
