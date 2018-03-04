import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtCharts 2.0

ApplicationWindow {
    id: window
    width: 1280
    height:800
    visible: true

    property real zoomPartenza: 1.0
    property real maxZoom: 1.4
    property int  countZoom: 1
    property int  numeroScroll :0 // mi indica quante volte ho scrollato mi serve x resettare la posizione

    ChartView {
        id: chart
        property var selectedPoint: undefined
        title: "Two Series, Common Axes"
        width:  800
        height: 800
        anchors.horizontalCenter: parent.horizontalcenter
        antialiasing: true
        property real toleranceX: 0.05
        property real toleranceY: 0.05

        ValueAxis {
            id: axisX
            min: 0
            max: 10
            tickCount: 6
        }

        ValueAxis {
            id: axisY
            min: -0.5
            max: 1.5
            tickCount: 5
        }


        LineSeries {
            id: series1
            visible: checkBox.checked
            axisX: axisX
            axisY: axisY
            pointsVisible: true
            color: "orange"
            width: 2
            onClicked: console.log("onClicked: " + point.x + ", " + point.y);


        }

        LineSeries {
            id: series2
            visible: checkBox1.checked
            axisX: axisX
            axisY: axisY
            pointsVisible: true
            color: "red"
            width: 2
        }

        LineSeries {
            id: series3
            visible: checkBox2.checked
            axisX: axisX
            axisY: axisY
            pointsVisible: true
            color: "green"
            width: 2
        }

        LineSeries {
            id: series4
            visible: checkBox3.checked
            axisX: axisX
            axisY: axisY
            pointsVisible: true
            color: "black"
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

    // mousearea ancorata all' area del grafico
    MouseArea{

        x:chart.plotArea.x
        y:chart.plotArea.y
        width: chart.plotArea.width
        height: chart.plotArea.height
        hoverEnabled: true
        property real precX: 0
        property real precY:0

        onPressed: {
            // Salvo coordinate del mouse
            precX=mouseX
            precY=mouseY

        }

        onMouseXChanged: {
          if(pressed==true){ // xchè  ho messo hoverEnabled==true
            if(precX != mouseX) {

                if(precX>(mouseX+chart.plotArea.width*0.05)) {                       //mouseX+20 x avere un po di margine e non scroll per ogni pixel serve anxhe x o scroll dello zoom sull'asse delle y
                    precX=mouseX
                    console.log("mi muovo verso sinistra")
                    chart.scrollRight(chart.plotArea.width*0.10)
                    numeroScroll++
                }
                else if(precX<(mouseX-chart.plotArea.width*0.05)) {
                    precX=mouseX
                    console.log("mi muovo verso destro")
                    chart.scrollLeft(chart.plotArea.width*0.10)
                    numeroScroll--

                }

            }
//            else {
//                console.log("premuto")
//            }
          }
        }

        onMouseYChanged: {

            if(pressed==true){ // xchè  ho messo hoverEnabled==true
              if(precY != mouseY) {

                  if(precY>(mouseY+(chart.plotArea.height/7))) {
                      precY=mouseY
                      console.log("SALGO")
                      if(countZoom<3){
                          countZoom++
                          chart.zoomIn()
                      }

                  }
                  else if(precY<(mouseY-(chart.plotArea.height/7))){
                      precY=mouseY
                      console.log("SCENDO")

                      if(countZoom>-3){
                          countZoom--
                          chart.zoomOut()
                      }

                  }

              }
  //            else {
  //                console.log("premuto")
  //            }
            }


        }


    }

    Button {
        id: btn_scrollRight
        x: 1157
        y: 33
        text: qsTr("scroll right --->")
        onClicked: {
            chart.scrollRight(chart.plotArea.width*0.10)
            numeroScroll++
        }
    }

    Button {
        id: btn_scrollLeft
        x: 1157
        y: 85
        text: qsTr("scroll left <---")
        onClicked: {
            chart.scrollLeft(chart.plotArea.width*0.10)
            numeroScroll--
        }
    }

    Button {
        id: btn_zoomIn
        x: 1157
        y: 190
        text: qsTr("zoom in")
        enabled: countZoom <3? true: false//zoomPartenza>=1.4? false : true

        onClicked: {
            if(countZoom<3){
                countZoom++
                chart.zoomIn()
            }

            //        if( zoomPartenza <1.4 ){
            //            zoomPartenza+=0.1
            //            chart.zoom(zoomPartenza)
            //        }
            //        else  if(zoomPartenza>1.4 ) {
            //           chart.zoom(1.4)

            //        }

        }
    }

    Button {
        id: btn_zoomOut
        x: 1157
        y: 131
        enabled: countZoom>-3? true : false //zoomPartenza<=0.5 ? false : true
        text: qsTr("zoom out")
        onClicked: {
            if(countZoom>-3){
                countZoom--
                chart.zoomOut()
            }


        }
    }

    Button {
        id: btn_resetZoom
        x: 1157
        y: 242
        text: qsTr("reset zoom")
        onClicked: {
          if(countZoom!=1){

            if(countZoom>1) {

                for(var i=countZoom; i>1;i--)
                  chart.zoomOut()
            }
            else {

                for(var i=countZoom; i<1;i++)
                  chart.zoomIn()

            }
            countZoom=1
           }
        }

    }

    Button {
        id: btn_resetScroll
        x: 1157
        y: 242+height+10
        text: qsTr("reset scroll")
        onClicked: {
           // var point = chart.mapToValue(series1.at(series1.count-1))
           // console.log(point.x.toString())
           // chart.scrollRight(point.x)
           console.log(numeroScroll.toString())
            if(numeroScroll>0)
                chart.scrollRight(-(chart.plotArea.width*0.10*numeroScroll))
            else
                chart.scrollRight(-(chart.plotArea.width*0.10*numeroScroll))
            numeroScroll=0                                                      // resetto la variabile
        }

    }

    CheckBox {
        id: checkBox
        x: 1157
        y: 364
        text: qsTr("Serie 1")
    }

    CheckBox {
        id: checkBox1
        x: 1157
        y: 434
        text: qsTr("Serie 2")
    }

    CheckBox {
        id: checkBox2
        x: 1157
        y: 503
        text: qsTr("Serie 3")
    }

    CheckBox {
        id: checkBox3
        x: 1157
        y: 585
        text: qsTr("Serie 4")
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
            series2.append(i, Math.random()) ;
            series3.append(i, Math.random()) ;
            series4.append(i, Math.random()) ;
            i++
            if(i>10){

               // do effetto di live chart lo scrool dipende dal livello di zoom
               switch(countZoom){
                 case -3:chart.scrollRight(chart.plotArea.width*0.00625); break;  // zoom con fattore 16
                 case -2:chart.scrollRight(chart.plotArea.width*0.0125); break;   // zoom con fattore 8
                 case -1:chart.scrollRight(chart.plotArea.width*0.025); break;    // zoom con fattore 4
                 case 0: chart.scrollRight(chart.plotArea.width*0.05); break;     // zoom con fattore 2
                 case 1: chart.scrollRight(chart.plotArea.width*0.10); break;     // zoom con fattore 1
                 case 2:  chart.scrollRight(chart.plotArea.width*0.20); break;    // zoom con fattore 0.5
                 case 3: chart.scrollRight(chart.plotArea.width*0.40); break;     // zoom con fattore 0.25
              }
            }

        }
    }


    // Aggiungo dati alla serie quando viene creato l'oggetto
    //Component.onCompleted: {
    //    for (var i = 0; i <= 80; i++) {
    //        series1.append(i, Math.random());
    //    }
    //}


}
