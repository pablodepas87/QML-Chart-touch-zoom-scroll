import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtCharts 2.0

Window {
    id: window
    width: 640
    height: 480
    visible: true


    Flickable{
        id:flick
        width : parent.width
        height : 300
        contentHeight: chartview.height
        contentWidth:  chartview.width
        ChartView {
            id: chartview
            width: window.width * 2
            height: 300

            LineSeries {
                name: "LineSeries"
                axisX: ValueAxis {
                    min: 0
                    //max: 200
                    tickCount: 12
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

        ScrollBar.horizontal: ScrollBar {
            id: hbar
            hoverEnabled: true
            active: hovered || pressed
            orientation: Qt.Horizontal
        }
    }
}
