import QtQuick
import QtQuick.Layouts
import Quickshell.Networking

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    // Pega o primeiro device conectado (wifi ou ethernet)
    property var activeDevice: {
        for (var i = 0; i < Networking.devices.length; i++) {
            var d = Networking.devices[i];
            if (d.connectionState === DeviceConnectionState.Connected)
                return d;
        }
        return null;
    }

    property bool isWifi: activeDevice !== null && activeDevice.type === DeviceType.Wifi

    property bool isEthernet: activeDevice !== null && activeDevice.type === DeviceType.None

    // Ícone baseado no tipo de conexão
    property string icon: {
        if (activeDevice === null)
            return "󰤭"; // desconectado
        if (isWifi) {
            // Ícone de wifi baseado no sinal
            var wifi = activeDevice as WifiDevice;
            if (wifi && wifi.activeNetwork) {
                var strength = wifi.activeNetwork.strength;
                if (strength >= 75)
                    return "󰤨";
                if (strength >= 50)
                    return "󰤥";
                if (strength >= 25)
                    return "󰤢";
                return "󰤟";
            }
            return "󰤨";
        }
        if (isEthernet)
            return "󰈀"; // ethernet
        return "󰤭";
    }

    property string label: {
        if (activeDevice === null)
            return "Desconectado";
        if (isWifi) {
            var wifi = activeDevice as WifiDevice;
            if (wifi && wifi.activeNetwork)
                return wifi.activeNetwork.ssid;
            return "Wi-Fi";
        }
        if (isEthernet)
            return "Ethernet";
        return "Desconectado";
    }

    RowLayout {
        id: row
        spacing: 4

        Text {
            color: "#ffffff"
            text: root.icon
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 18
            }
        }

        Text {
            color: "#ffffff"
            text: root.label
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 14
            }
        }
    }
}
