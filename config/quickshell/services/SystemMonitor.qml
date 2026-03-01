pragma Singleton

import QtQuick
import Quickshell.Io

Item {
    id: root

    property var lastCpuTotal
    property var lastCpuIdle
    property var cpuUsage
    property var memUsage

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true;
            memProc.running = true;
        }
    }

    Process {
        id: cpuProc
        command: ['sh', '-c', 'head -1 /proc/stat']
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var p = data.trim().split(/\s+/);
                var idle = parseInt(p[4]) + parseInt(p[5]);
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);
                if (root.lastCpuTotal > 0) {
                    root.cpuUsage = Math.round(100 * (1 - (idle - root.lastCpuIdle) / (total - root.lastCpuTotal)));
                }
                root.lastCpuTotal = total;
                root.lastCpuIdle = idle;
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: memProc
        command: ['sh', '-c', 'free | grep Mem']
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var p = data.trim().split(/\s+/);
                var total = parseInt(p[1]);
                var used = parseInt(p[2]);
                root.memUsage = Math.round(100 * used / total);
            }
        }
        Component.onCompleted: running = true
    }
}
