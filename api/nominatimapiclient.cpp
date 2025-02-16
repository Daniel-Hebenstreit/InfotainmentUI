#include "nominatimapiclient.h"
#include <QUrlQuery>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

NominatimApiClient::NominatimApiClient(QObject *parent)
    : QObject{parent}
{
    // Signal-Slot connection
    connect(&networkManager,&QNetworkAccessManager::finished, this, &NominatimApiClient::handleNetworkReply);
}

void NominatimApiClient::searchLocation(const QString &query)
{
    if (query.trimmed().isEmpty())
    {
        qDebug() << "Query is empty";
        return;
    }

    qDebug() << "Search: " << query;

    // Create URL for API request
    QUrl url("https://nominatim.openstreetmap.org/search");
    QUrlQuery urlQuery;
    urlQuery.addQueryItem("q", query);
    urlQuery.addQueryItem("format", "json");
    url.setQuery(urlQuery);

    // GET request
    QNetworkRequest request(url);
    networkManager.get(request);
}

void NominatimApiClient::handleNetworkReply(QNetworkReply *reply)
{
    if (reply->error() != QNetworkReply::NoError)
    {
        qDebug() << "API requeest failed: " << reply->errorString();
        reply->deleteLater();
        return;
    }

    // Parse JSON response
    QByteArray responseData = reply->readAll();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(responseData);

    if (!jsonResponse.isArray())
    {
        qDebug() << "Invalid JSON format received";
        reply->deleteLater();
        return;
    }

    QJsonArray results = jsonResponse.array();
    if (results.isEmpty())
    {
        qDebug() << "No results found";
        return;
    }

    // Get the first result
    QJsonObject firstResult = results.first().toObject();
    double lat = firstResult["lat"].toString().toDouble();
    double lon = firstResult["lon"].toString().toDouble();

    qDebug() << "Found Location - " << "Latitude: " << lat << " Longitude: " << lon;

    qDebug() << "Emitting searchCompleted() with:" << lat << lon;
    emit searchCompleted(lat, lon);

    reply->deleteLater();
}
