#include "drawing.h"
#include<QDebug>

Drawing::Drawing(QObject *parent):  QObject(parent)
{

}

QVariantList Drawing::imageData()
{
    return m_imageData;
}

void Drawing::setImageData(QVariantList listIn)
{
    if(listIn == m_imageData)
    {
        return;
    }
    m_imageData = listIn;
    qDebug() <<"Adding Image";
    emit imageDataChanged();
}

void Drawing::processData(QVariantList input){
    int listLen = input.length();
    int avgArr [64][3] = {{0}};
    for(int x=0;x<listLen;x++)
    {
        //pull the QVariantList out of the main list
        QVariantList cell = input.at(x).toList();
        int len = cell.length();
        int count =0;
        int i =0;
        int blockSize = 10; // only get every 10th pixel...
        while((i+=blockSize*4)<len)
        {
            ++count;
            for(int z=0;z<3;z++)
            {
                if(avgArr[x][z] !=0)
                {
                    avgArr[x][z] = (avgArr[x][z]+cell.at(i+z).toInt())/2;
                }else{
                    avgArr[x][z] +=cell.at(i+z).toInt();
                }
            }
        }
    }
}

