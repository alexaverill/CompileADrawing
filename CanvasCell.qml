import QtQuick 2.0
import QtQuick 2.7
import QtQuick.Window 2.7
import QtQuick.Controls 2.3

Canvas{
    width:100
    height:width
    property real lastX
    property real lastY
    property color color: "red"
    onPaint:{

        var ctx = getContext("2d");
        /*ctx.fillStyle="red"
        ctx.fillRect(0,0,width,height)*/
        ctx.lineWidth = 10;
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
        onPressed: {
            canvas.lastX = mouseX
            canvas.lastY = mouseY
        }
        onPositionChanged: {
            canvas.requestPaint()
        }
    }
}
