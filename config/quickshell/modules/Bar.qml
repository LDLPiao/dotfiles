pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property var modelData
            screen: modelData

            color: "#D8252423"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            ClockWidget {}

            RowLayout {
                anchors.fill: parent

                // Left widgets
                MainMenu {}

                Workspaces {
                    screen: bar.modelData
                }
                // Spacer
                Item {
                    Layout.fillWidth: true
                }

                // Right widgets
                SystemStats {}
            }
        }
    }
}
