#include "MaryJane.h"

#include <QDebug>
#include <QtGlobal>
#include <QImage>
#include <QImageReader>
#include <QImageWriter>

#include <QPainter>
#include <QTransform>
#include <QUrl>

#ifdef Q_OS_ANDROID
    #include <AndroidUtils.h>
#endif


MaryJane::MaryJane(QObject *parent)
    : QObject(parent)
{
    QObject::connect(this, &MaryJane::cameraButtonPressed, this, &MaryJane::onCameraButtonPressed, Qt::QueuedConnection);
    QObject::connect(this, &MaryJane::loadButtonPressed, this, &MaryJane::onLoadButtonPressed, Qt::QueuedConnection);
    QObject::connect(this, &MaryJane::saveButtonPressed, this, &MaryJane::onSaveButtonPressed, Qt::QueuedConnection);
    QObject::connect(this, &MaryJane::shareButtonPressed, this, &MaryJane::onShareButtonPressed, Qt::QueuedConnection);

#ifdef Q_OS_ANDROID
    QObject::connect(&AndroidUtils::instance(), &AndroidUtils::imageLoaded, this, &MaryJane::imageLoaded, Qt::QueuedConnection);
#else
#endif

}

QString MaryJane::getImagePath()
{
#ifdef Q_OS_ANDROID
    QString path = AndroidUtils::instance().getTmagesLocation() + ".png";
#else
    QString path = "~/asdf.png";
#endif

    return path;
    //return AndroidUtils::instance().getImagePath();
}

void MaryJane::onCameraButtonPressed()
{
    qDebug() << "on camera button pressed";

#ifdef Q_OS_ANDROID
    AndroidUtils::instance().openCamera();
#else
#endif

}

void MaryJane::onLoadButtonPressed()
{
    qDebug() << "on load button pressed";

#ifdef Q_OS_ANDROID
    AndroidUtils::instance().openImage();
#else
    imageLoaded(QUrl::fromLocalFile("/Users/timur/test.jpg").toString());
#endif


}

void MaryJane::onSaveButtonPressed(const QString &imagePath, const QString &framePath, const float rotation, const float scale, const float imageX, const float imageY)
{
    qDebug() << "on save button pressed";
    qDebug() << "imageX = " << imageX;
    qDebug() << "imageY = " << imageY;

//    QImageReader photoReader(QUrl(imagePath).toLocalFile());
//    photoReader.setAutoTransform(true);
//    QImage photo = photoReader.read();

//    QImage frame(":/frames/3_clumba.png");

//    QPixmap background(frame.width(), frame.height());
//    background.fill();



    QImageReader photoReader(QUrl(imagePath).toLocalFile());
    photoReader.setAutoTransform(true);

    QImage img = photoReader.read();
    qDebug() << photoReader.errorString();
    QImage frame(framePath.mid(3));

    qDebug() << "isNUll = " << frame.isNull() << " framePath = " << framePath;
    qDebug() << "rect = " << img.rect();
    img = img.scaledToWidth(frame.width());

    qDebug() << "rect = " << img.rect();

    QTransform transform;
    transform.rotate(rotation);
    transform.scale(scale, scale);


    qDebug() << "rect = " << img.rect();
    img = img.transformed(transform);//.copy(QRect(rect));
    qDebug() << "rect = " << img.rect();


    QRect rect;
    // if you do set width after set x , it is moving .
    // set x before.
    rect.setX(img.width() * 0.5 - imageX * frame.width());
    rect.setY(img.height() * 0.5 - imageY * frame.height());
    rect.setWidth(frame.width());
    rect.setHeight(frame.height());
    qDebug() << "just rect = " << rect;

    img = img.copy(rect);

    QPainter painter;
    //painter.rotate(rotation);
    painter.begin(&img);
    //painter.rotate(-rotation);
    painter.drawImage(0,0, frame);
    painter.end();

    //img = img.copy(rect);

#ifdef Q_OS_ANDROID
    QString path = AndroidUtils::instance().getTmagesLocation() + ".png";
#else
    QString path = "/Users/timur/asdf.png";//QUrl::fromLocalFile("/Users/timur/asdf.jpeg").toString();
#endif

    QImageWriter writer(path);

    bool isSaved = writer.write(img);

    qDebug() << "saved = " << isSaved << " error = " << writer.errorString();

#ifdef Q_OS_ANDROID
    AndroidUtils::instance().updateGallery(path);
#else
#endif


    qDebug() << "path = " + path;
    qDebug() << "done";
    saved(path);
}

void MaryJane::onShareButtonPressed(const QString &path)
{
    qDebug() << "on share button pressed" << "path = " << path;

#ifdef Q_OS_ANDROID
    AndroidUtils::instance().shareImage(path);
#else
#endif

}
