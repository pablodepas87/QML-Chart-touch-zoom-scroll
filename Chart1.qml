import QtQuick 2.3
import QtQuick.Controls 1.2
import QtCharts 2.1

Item {
     width:800
    height: 480
    Rectangle{
        
        anchors.fill: parent
       
        property variant temp: [1,2,3,4,5,6,7,8,9,10]
        property variant umid: [1,2,3,4,5,6,7,8,9,10]
        property int i:0
    
    
    
        function randomIntFromInterval(min,max)
        {
            return Math.floor(Math.random()*(max-min+1)+min);
        }
    
        ChartView {
            id:chart1
            title: "ciclo refrigerazione"
            anchors.fill: parent
           // legend.visible: false
            antialiasing: true
            //backgroundColor: "lightgrey"
            theme: ChartView.ChartThemeDark
            dropShadowEnabled:true
            localizeNumbers:true
    
            SplineSeries {
                id:tempCiclo
               /* axisX:CategoryAxis {
    
                    id: asseX
                    min: temp[0]
                    max: temp[(temp.length-1)]
    
    
                    color:"white"
                    CategoryRange {
                        label: temp[0].toString()
                        endValue: temp[0]
    
                    }
    
                    CategoryRange {
                        label: temp[1].toString()
                        endValue: temp[1]
    
                    }
                    CategoryRange {
                        label: temp[2].toString()
                        endValue: temp[2]
    
                    }
                    CategoryRange {
                        label: temp[3].toString()
                        endValue: temp[3]
    
                    }
                    CategoryRange {
                        label: temp[4].toString()
                        endValue: temp[4]
    
                    }
    
                    CategoryRange {
                        label: temp[5].toString()
                        endValue: temp[5]
    
                    }
                    CategoryRange {
                        label: temp[6].toString()
                        endValue: temp[6]
    
                    }
                    CategoryRange {
                        label: temp[7].toString()
                        endValue: temp[7]
    
                    }
                    CategoryRange {
                        label: temp[8].toString()
                        endValue: temp[8]
    
                    }
    
                    CategoryRange {
                        label: temp[9].toString()
                        endValue: temp[9]
    
                    }
    
    
                }*/
    
               axisX: ValueAxis {
                    id:asseX
                    //labelFormat: Qt.
    
                    labelsColor: "green"
                     min: temp[0]
                     max: temp[(temp.length-1)]
                     //minorTickCount:1                                      // VALORI TRA UN TICK E L'ALTRO
                     tickCount:10
                     gridVisible: false
                     color:"white"
                     lineVisible : true                                     //  visualizzo o no l'asseY
                     labelFormat: "%.0f"                                    //  visualizzo un valore senza virgola
                 }
               axisY:CategoryAxis {
    
                            id: asseY
                            min:-15
                            max:40
                            labelsPosition:Qt.AlignLeft
                            color:"white"
                            //alignment: Qt.AlignRight
    
                            CategoryRange {
                                label: "-10"
                                endValue: -10
    
                            }
                            CategoryRange {
                                label: "0"
                                endValue: 0
                            }
                            CategoryRange {
                                label: "10"
                                endValue: 10
                            }
                            CategoryRange {
                                label: "20"
                                endValue: 20
                            }
                            CategoryRange {
                                label: "30"
                                endValue: 30
                            }
    
                            CategoryRange {
                                label: "40"
                                endValue: 40
                            }
                        }
                /*  axisY:    ValueAxis {
                    id: asseY
                    min: -15
                    max: 40
                    tickCount : 11
                    gridVisible: false
                    color:"white"
                    lineVisible : true        //visualizzo o no l'asseY
    
               }*/
                width:3
                color: "seagreen"
                pointsVisible:true
                //capStyle: Qt.SquareCap
                style: Qt.DotLine
    
            }
            LineSeries {
                id:umidCiclo
                width:3
                color: "orange"
                pointsVisible:true
                axisX: asseX
                axisY: asseY
                //capStyle: Qt.SquareCap
                style: Qt.DashDotLine
    
            }
            LineSeries {
                id: lineaSetPoint
                width:2
                color: "seagreen"
    
                axisX: asseX
                axisY: asseY
                XYPoint {x:0; y: 32}
                XYPoint {x:temp[9]; y: 32}
                style: Qt.DotLine
    
    
            }
            LineSeries {
                id: lineaSetPoint2
                width:2
                color:"orange"
                axisX: asseX
                axisY: asseY
                XYPoint {x:0; y: 15}
                XYPoint {x:umid[9]; y: 15}
                style: Qt.DashDotLine
    
    
            }
    
    }
    
    
    
        Timer {
    
            id:addpoint
            interval:2000
            onTriggered: {
    
             // AGGIUNGO VALORI DI TEMP E umiditA
              tempCiclo.append(temp[9],randomIntFromInterval(-10,35))
              temp.push(temp[9]+1)
              temp.splice(0,1);
              umidCiclo.append(umid[9],randomIntFromInterval(-10,35))
              umid.push(umid[9]+1)
              umid.splice(0,1);
    
            // VADO A MODIFICARE I VALORI DELLA BARRA DELLE X
              asseX.min=temp[0]
              asseX.max=temp[(temp.length-1)]
              //asseX.remove(temp[9].toString())
              //asseX.append(temp[9].toString(),temp[9].toString())
    
             // disegno le linee degli eventuali SET POINT
              lineaSetPoint.append(temp[9],32)
              lineaSetPoint2.append(umid[9],15)
    
            }
            repeat: true
            running: true
    
        }
        

               
        
        
        
    }
    
    

}
