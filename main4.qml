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
    id: chart
    property var selectedPoint: undefined
    title: "Two Series, Common Axes"
    width:  500
    height: 500
    anchors.horizontalCenter: parent.horizontalcenter
    antialiasing: true
    property real toleranceX: 0.05
    property real toleranceY: 0.05

    ValueAxis {
        id: axisX
        min: 0
        max: 10
        tickCount: 5
    }

    ValueAxis {
        id: axisY
        min: -0.5
        max: 1.5
    }

    LineSeries {
        id: series1
        axisX: axisX
        axisY: axisY
        pointsVisible: true
        color: "orange"
        width: 2
    }


//    MouseArea {
//        anchors.fill: parent
//        onPressed:
//        {
//            var cp = chart.mapToValue(Qt.point(mouse.x,mouse.y));
//            for(var i = 0;i < series1.count;i ++)
//            {
//                var p = series1.at(i);
//                if(Math.abs(cp.x - p.x) <= chart.toleranceX && Math.abs(cp.y - p.y) <= chart.toleranceY)
//                {
//                    chart.selectedPoint = p;
//                    break;
//                }
//            }
//        }
//        onPositionChanged: {
//            if(chart.selectedPoint != undefined) {
//                var p = Qt.point(mouse.x, mouse.y);
//                var cp = chart.mapToValue(p);
//                if(cp.x >= axisX.min && cp.x <= axisX.max && cp.y >= axisY.min && cp.y <= axisY.max) {
//                    series1.replace(chart.selectedPoint.x, chart.selectedPoint.y, cp.x, cp.y);
//                    chart.selectedPoint = cp;
//                }
//            }
//        }

//        onReleased: {
//            chart.selectedPoint = undefined;
//        }
//    }

}

Button {
    id: button
    x: 528
    y: 148
    text: qsTr("scroll right --->")
    onClicked: { chart.scrollRight(chart.plotArea.width/10) }
}

Button {
    id: button1
    x: 528
    y: 200
    text: qsTr("scroll left <---")
    onClicked: {chart.scrollLeft(chart.plotArea.width/10)}
}

Button {
    id: button2
    x: 528
    y: 305
    text: qsTr("zoom in")
    onClicked: {chart.zoomIn()}
}

Button {
    id: button3
    x: 528
    y: 246
    text: qsTr("zoom out")
     onClicked: {chart.zoomOut()}
}


// Aggiungo dati alla serie quando viene creato l'oggetto
//Component.onCompleted: {
//    for (var i = 0; i <= 80; i++) {
//        series1.append(i, Math.random());
//    }
//}

MouseArea{
   x:chart.plotArea.x
   y:chart.plotArea.y
   width: chart.plotArea.width
   height: chart.plotArea.height
   property real precX: 0
   property real precY:0

   onPressed: {
     // Salvo coordinate del mouse
     precX=mouseX
     precY=mouseY

   }
   onMouseXChanged: {
      if(precX != mouseX) {

         if(precX>mouseX) {
          precX=mouseX
          console.log("mi muovo verso destra")
          chart.scrollRight(10)
         }
         else {
          precX=mouseX
          console.log("mi muovo verso sinistra")
          chart.scrollLeft(10)

         }

      }
      else {
         console.log("premuto")
      }
   }

   onMouseYChanged: {

       if(precY != mouseY) {

          if(precY>mouseY) {
           precY=mouseY
           console.log("mi muovo verso destra")
           chart.zoomIn()
          }
          else {
           precY=mouseY
           console.log("mi muovo verso sinistra")
           chart.zoomOut()

          }

       }
       else {
          console.log("premuto")
       }



   }

   onDoubleClicked: {
       chart.zoomReset()  // resetto lo zoom
   }


}

Button {
    id: button4
    x: 528
    y: 357
    text: qsTr("reset zoom")
    onClicked: { chart.zoomReset()

    }

}


// il timer fa saltare l'editor visuale se si usa l'editor va commentato
Timer {

    id: tmrToAddPoint
    property int i: 1
    running: true
    repeat: true
    interval: 1000
    onTriggered:{
        series1.append(i, Math.random()) ;
        i++
        if(i>10)
            chart.scrollRight(chart.plotArea.width/10)

    }
}

}
