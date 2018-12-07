#include "MaryJane.h"

#include <QDebug>
#include <QtGlobal>

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

    QObject::connect(&AndroidUtils::instance(), &AndroidUtils::imageLoaded, this, &MaryJane::imageLoaded, Qt::QueuedConnection);
}

QString MaryJane::getImagePath()
{
    return AndroidUtils::instance().getImagePath();
}

void MaryJane::onCameraButtonPressed()
{
    qDebug() << "on camera button pressed";

    AndroidUtils::instance().openCamera();
}

void MaryJane::onLoadButtonPressed()
{
    qDebug() << "on load button pressed";

    AndroidUtils::instance().openImage();
}

void MaryJane::onSaveButtonPressed()
{
    qDebug() << "on save button pressed";
}

void MaryJane::onShareButtonPressed()
{
    qDebug() << "on share button pressed";

    AndroidUtils::instance().shareImage("asdfasdf");
}
