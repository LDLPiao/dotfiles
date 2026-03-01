pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

import "../services/"

Item {
    id: systemStats
    implicitWidth: labels.implicitWidth
    implicitHeight: labels.implicitHeight

    property var battery: UPower.displayDevice

    RowLayout {
        id: labels

        spacing: 16

        RowLayout {
            Text {
                id: cpuLabel

                color: "#ffffff"
                text: ' ' + SystemMonitor.cpuUsage + "%"
                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 18
                }
            }
            Text {
                id: memLabel

                color: "#ffffff"
                text: ' ' + SystemMonitor.memUsage + "%"
                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 18
                }
            }
        }

        Text {
            id: batteryLabel

            color: '#ffffff'
            text: ' ' + Math.round(systemStats.battery.percentage * 100) + '%'
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 18
            }
        }
    }
}
