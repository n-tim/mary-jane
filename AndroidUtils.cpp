#include "AndroidUtils.h"

#include <QtAndroidExtras>
#include <QDebug>
#include <QUrl>

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT void JNICALL
Java_org_maryJane_AndroidUtils_fileSelected(JNIEnv */*env*/,
                                                             jobject /*obj*/,
                                                             jstring fileName)
{
    QString selectedFileName = QAndroidJniObject(fileName).toString();

    qDebug() << "filename = " << selectedFileName;

    AndroidUtils::instance().imageLoaded(QUrl::fromLocalFile(selectedFileName).toString());
}

JNIEXPORT void JNICALL
Java_org_maryJane_AndroidUtils_photoTaken(JNIEnv */*env*/,
                                                             jobject /*obj*/,
                                                             jstring fileName)
{
    QString photoFileName = QAndroidJniObject(fileName).toString();

    qDebug() << "photoFileName = " << photoFileName;

    AndroidUtils::instance().imageLoaded(QUrl::fromLocalFile(photoFileName).toString());
}

#ifdef __cplusplus
}
#endif


AndroidUtils::AndroidUtils(QObject *parent) : QObject(parent)
{

}

void AndroidUtils::openCamera()
{
    QAndroidJniObject::callStaticMethod<void>("org/maryJane/AndroidUtils",
                                              "openCamera",
                                              "()V");
}

void AndroidUtils::openImage()
{
    QAndroidJniObject::callStaticMethod<void>("org/maryJane/AndroidUtils",
                                              "openAnImage",
                                              "()V");
//    while(selectedFileName == "#")
//        qApp->processEvents();

//    if(QFile(selectedFileName).exists())
//    {
//        QImage img(selectedFileName);
//        ui->label->setPixmap(QPixmap::fromImage(img));
    //    }
}

void AndroidUtils::shareImage(const QString& path)
{

    QAndroidJniObject filePathStringObject = QAndroidJniObject::fromString(path);
    QAndroidJniObject::callStaticMethod<void>("org/maryJane/AndroidUtils",
                                              "shareImage",
                                              "(Ljava/lang/String;)V",filePathStringObject.object<jstring>());
}

QString AndroidUtils::getImagePath()
{
//    qDebug() << "photo name = " << photoFileName;
//    return photoFileName;
    return "";
}
