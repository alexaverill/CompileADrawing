#ifndef DRAWING_H
#define DRAWING_H

#include <QObject>
#include<QVariant>
#include<vector>
#include<tuple>
#include "rgbvalue.h"

class Drawing : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList imageData READ imageData WRITE setImageData NOTIFY imageDataChanged)
public:
    explicit Drawing(QObject *parent = nullptr);
    QVariantList imageData();
    void setImageData(QVariantList);
public slots:
   void processData(QVariantList input);
signals:
    void imageDataChanged();
private:
    QVariantList m_imageData;
};

#endif // DRAWING_H
