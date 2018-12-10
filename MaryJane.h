#ifndef MARYJANE_H
#define MARYJANE_H

#include <QObject>

class MaryJane : public QObject
{
    Q_OBJECT
public:
    explicit MaryJane(QObject *parent = nullptr);

signals:
    void cameraButtonPressed();
    void loadButtonPressed();
    void saveButtonPressed(const QString& imagePath, const QString& framePath, const float rotation, const float scale, const float imageX, const float imageY);
    void shareButtonPressed();

signals:
    void imageLoaded(const QString& path);

public slots:
    Q_INVOKABLE QString getImagePath();

private slots:
    void onCameraButtonPressed();
    void onLoadButtonPressed();
    void onSaveButtonPressed(const QString& imagePath, const QString& framePath, const float rotation, const float scale, const float imageX, const float imageY);
    void onShareButtonPressed();
};

#endif // MARYJANE_H
