//Set some values here to make life a bit easier
var Image;



/**** Helper Functions to get color value for individual x and y locations ***/
//the image data is pulled into an object that has a height, width and then an array that has the RGBA values stored linearly.
// To get the indiidual pixel value the formula is:
// ((row * (imageWidth * 4)) + (column * 4))+2
//the 4 comes from the array being height, widht *4 bytes.
//more info can be found here: https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API/Tutorial/Pixel_manipulation_with_canvas

function getColor(x,y,width){
    //THis function will return the coordinates for the pixel we want.
    var start = y*(width*4) +x*4;
    //      R       G       B       A
    return [start,start+1,start+2,start+3]
}
function floor(input)
{
return Math.floor(input)
}

//functions to create a grid to emulate the 8x8 pixels on the Raspberry Pi
function drawGrid(){
    var height = gridCanvas.height;
    var width = gridCanvas.width;
    var grid = gridCanvas.getContext("2d");
    grid.lineWidth = 5;
    grid.strokeStyle = "black";
    grid.beginPath();
    for(x=width/8; x<width;x+= width/8){
        grid.moveTo(x,0);
        grid.lineTo(x, height);
        grid.stroke()
    }
    for(y=height/8; y<height;y+= height/8){
        grid.moveTo(0,y);
        grid.lineTo(width, y);
        grid.stroke()
    }

}


//function to convert the canvas colors into the average of the pixels in each 1/8 of the canvas.
//We want to ignore the entirely black and white pixels as they are either the background or part of the grid.
function returnImageData(){
    var canvasCount = root.model;
    var DataArr = [];
    for(x=0;x<canvasCount;x++)
    {
        var canvas = root.itemAt(x).getContext("2d").getImageData(0,0,80,80);
        var tempArr = [];
        for(var y=0;y<canvas.data.length;y++){
            tempArr[y] =canvas.data[y];
        }
        DataArr[x] = tempArr;

    }
    return DataArr;
    /*Image = canvas.getContext("2d").getImageData(0,0,canvas.width,canvas.height);

    var intArr = [];
    for(var x=0;x<Image.data.length;x++){
        intArr[x] =Image.data[x];
    }

    return intArr;*/
}


