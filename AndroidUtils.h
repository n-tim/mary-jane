#ifndef ANDROIDUTILS_H
#define ANDROIDUTILS_H

#include <QObject>

class AndroidUtils : public QObject
{
    Q_OBJECT
public:
    explicit AndroidUtils(QObject *parent = nullptr);

    static AndroidUtils& instance() {
        static AndroidUtils androidUtils;

        return androidUtils;
    }

signals:
    void imageLoaded(const QString& path);

public slots:
    void openCamera();
    void openImage();
    void shareImage(const QString& path);

    QString getImagePath();
};

#endif // ANDROIDUTILS_H
