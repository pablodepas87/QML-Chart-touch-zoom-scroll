import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtCharts 2.0

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true

    ChartView {
        id: chartview
        width: parent.width
        height: 300

        LineSeries {
            name: "LineSeries"
            axisX: ValueAxis {
                property real minValue: 0
                property real maxValue: 200
                property real range: 100
                min: minValue + sb.position * (maxValue - minValue - range)
                max: minValue + sb.position * (maxValue - minValue - range) + range
                tickCount: 12
                labelFormat: "%.0f"
            }

            axisY: ValueAxis {
                min: 0
                max: 70
                tickCount: 5
                labelFormat: "%.0f"
            }
            XYPoint { x: 0; y: 0.0 }
            XYPoint { x: 1.1; y: 3.2 }
            XYPoint { x: 1.9; y: 2.4 }
            XYPoint { x: 2.1; y: 2.1 }
            XYPoint { x: 2.9; y: 2.6 }
            XYPoint { x: 3.4; y: 2.3 }
            XYPoint { x: 200.1; y: 3.1 }
        }


    }

    Slider {
        id: sb
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: 30
    }
}
