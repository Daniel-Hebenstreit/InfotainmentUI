#ifndef VOLUMEHANDLER_H
#define VOLUMEHANDLER_H

#include <QObject>

class VolumeHandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(unsigned int volume READ volume WRITE setVolume NOTIFY volumeChanged FINAL)

public:
    explicit VolumeHandler(QObject *parent = nullptr);

    unsigned int volume() const;
    void setVolume(unsigned int newVolume);

    Q_INVOKABLE void changeVolume(const unsigned int &val);

signals:
    void volumeChanged();
private:
    unsigned int m_volume;
};

#endif // VOLUMEHANDLER_H
