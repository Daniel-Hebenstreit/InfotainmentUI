#ifndef NOMINATIMAPICLIENT_H
#define NOMINATIMAPICLIENT_H

#include <QObject>
#include <QNetworkAccessManager>


class NominatimApiClient : public QObject
{
    Q_OBJECT
public:
    explicit NominatimApiClient(QObject *parent = nullptr);

    Q_INVOKABLE void searchLocation(const QString &query);

signals:
    void searchCompleted(double lat, double lon);

private slots:
    void handleNetworkReply(QNetworkReply *reply);

private:
    QNetworkAccessManager networkManager;
};

#endif // NOMINATIMAPICLIENT_H
