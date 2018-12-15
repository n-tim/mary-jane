#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QtGlobal>

#include <MaryJane.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    MaryJane* maryJane = new(std::nothrow) MaryJane();
    if (!maryJane) {
        return -1;
    }

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("maryJane", maryJane);

#ifdef Q_OS_ANDROID
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
#else
    engine.load(QUrl("main.qml"));
#endif
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    int retCode = app.exec();

    if (maryJane) {
        delete maryJane;
        maryJane = nullptr;
    }

    return retCode;
}
