#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "imagetable.h"

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
    qmlRegisterType<imagetable>("myImage",1,0,"ImageTable");
    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/gallery/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
