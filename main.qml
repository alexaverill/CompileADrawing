import QtQuick 2.7
import QtQuick.Window 2.7
import QtQuick.Controls 2.3
import draw.drawing 1.0
import "compile.js" as Compile


Window {
    Drawing{
        id:drawer
    }

    title: qsTr("CompileDrawing")
    width: 800
    height: 800
    visible: true
    Row{
        id:colors

        property color paint: "red"
        anchors{
            top:parent.top
            horizontalCenter: parent.horizontalCenter
        }

        spacing:4
        Repeater{

            model:["red","green","blue","orange","yellow","steelblue"]
            Rectangle{
                id:red
                width:100
                height:100
                color:modelData
                MouseArea{
                    anchors.fill:parent
                    onClicked:{
                        console.log(parent.color)
                        colors.paint = parent.color
                    }
                }
            }
        }
        Rectangle{
            width:100
            height:100
        }

        Button{
            text:"Make"


            width:100
            height:100
            onClicked: {drawer.processData(Compile.returnImageData(),80);}
            //onClicked: {drawer.processListRGB(Compile.returnImageData(),400);}
            //onClicked:{drawer.processList(Compile.returnImageData(),canvas.width,canvas.height);}
        }

    }


    Grid{
        columns:8
        rows:8
        spacing:2
        anchors{
            horizontalCenter: parent.horizontalCenter
            top:colors.bottom
        }


        Repeater{
            model:64
            id:root
            property bool enabledPaint: false
            Canvas{
                width:80
                height:width
                property real lastX
                property real lastY
                property color color: "red"
                onPaint:{

                    var ctx = getContext("2d");
                    /*ctx.fillStyle="red"
                    ctx.fillRect(0,0,width,height)*/
                    ctx.lineWidth =5;
                    ctx.strokeStyle = colors.paint;
                    ctx.beginPath();
                    ctx.moveTo(lastX,lastY);
                    lastX = area.mouseX;
                    lastY = area.mouseY;
                    ctx.lineTo(lastX,lastY);
                    ctx.stroke();
                }
                MouseArea{
                    id: area
                    anchors.fill:parent;
                    hoverEnabled: true
                   /*onPressed: {
                        parent.lastX = mouseX
                        parent.lastY = mouseY
                    }*/

                    onEntered:{
                        parent.lastX = mouseX
                        parent.lastY = mouseY
                    }
                    onClicked:{
                        root.enabledPaint = root.enabledPaint? false:true;
                        parent.lastX = mouseX
                        parent.lastY = mouseY
                    }


                    onPositionChanged: {
                        if(root.enabledPaint){
                            parent.requestPaint()
                        }
                    }
                }
            }

            }
        }
    Rectangle{
        visible: root.enabledPaint ? false:true
        anchors{
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter

        }
        color:"#939393"
        width:300
        height:50
        Text{
            anchors{
                horizontalCenter: parent.horizontalCenter
                verticalCenter:  parent.verticalCenter
            }
            text:"Touch/Click to start drawing!"
        }
    }
}




