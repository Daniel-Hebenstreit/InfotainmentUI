#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>
#include "controllers/system.h"
#include "controllers/hvachandler.h"
#include "controllers/volumehandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Objekte erstellen
    System mySystemHandler;

    HVACHandler mDriverHVAC;
    HVACHandler mPassengerHVAC;
    VolumeHandler mVolume;


    // Objekte als Context Property deklarieren
    QQmlContext * contextProp(engine.rootContext());
    contextProp->setContextProperty("SystemHandler", &mySystemHandler);

    contextProp->setContextProperty("DriverHVAC", &mDriverHVAC);
    contextProp->setContextProperty("PassengerHVAC", &mPassengerHVAC);
    contextProp->setContextProperty("Volume", &mVolume);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("TeslaInfotainment", "Main");

    return app.exec();
}
