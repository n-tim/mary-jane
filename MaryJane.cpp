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

    QImageReader photoReader(QUrl(imagePath).toLocalFile());
    photoReader.setAutoTransform(true);

    QImage img = photoReader.read();
    qDebug() << photoReader.errorString();
    QImage frame(":/frames/3_clumba.png");

    qDebug() << "isNUll = " << frame.isNull() << " framePath = " << framePath;

    img = img.scaledToWidth(frame.width());

    qDebug() << "rect = " << img.rect();

    QTransform transform;
    transform.rotate(rotation);
    transform.scale(scale, scale);
    QRect rect;
    // if you do set width after set x , it is moving .
    // set x before.
    rect.setX(imageX * frame.width());
    rect.setY(imageY * frame.height());
    rect.setWidth(frame.width());
    rect.setHeight(frame.height());
    qDebug() << "rect = " << img.rect();
    img = img.transformed(transform);//.copy(QRect(rect));
    qDebug() << "rect = " << img.rect();
    QPainter painter;
    painter.begin(&img);
    painter.drawImage(rect, frame);
    painter.end();

    img = img.copy(QRect(rect));

#ifdef Q_OS_ANDROID
    QString path = AndroidUtils::instance().getTmagesLocation() + ".png";
#else
    QString path = "/Users/timur/asdf.png";//QUrl::fromLocalFile("/Users/timur/asdf.jpeg").toString();
#endif

    QImageWriter writer(path);

    bool saved = writer.write(frame);

    qDebug() << "saved = " << saved << " error = " << writer.errorString();

#ifdef Q_OS_ANDROID
    AndroidUtils::instance().updateGallery(path);
#else
#endif


    qDebug() << "path = " + path;
    qDebug() << "done";
}

void MaryJane::onShareButtonPressed()
{
    qDebug() << "on share button pressed";

#ifdef Q_OS_ANDROID
    AndroidUtils::instance().shareImage("asdfasdf");
#else
#endif

}
