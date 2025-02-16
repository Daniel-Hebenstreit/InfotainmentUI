#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>
#include "controllers/system.h"
#include "controllers/hvachandler.h"
#include "controllers/volumehandler.h"
#include "api/nominatimapiclient.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Create objects
    System mySystemHandler;

    HVACHandler mDriverHVAC;
    HVACHandler mPassengerHVAC;
    VolumeHandler mVolume;

    NominatimApiClient mNominatim;

    // Declare objects as context properties
    QQmlContext * contextProp(engine.rootContext());
    contextProp->setContextProperty("SystemHandler", &mySystemHandler);

    contextProp->setContextProperty("DriverHVAC", &mDriverHVAC);
    contextProp->setContextProperty("PassengerHVAC", &mPassengerHVAC);
    contextProp->setContextProperty("Volume", &mVolume);

    contextProp->setContextProperty("Nominatim", &mNominatim);

    //

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("TeslaInfotainment", "Main");

    return app.exec();
}
