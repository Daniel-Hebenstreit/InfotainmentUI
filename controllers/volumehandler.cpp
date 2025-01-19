#include "volumehandler.h"

VolumeHandler::VolumeHandler(QObject *parent)
    : QObject{parent}
    , m_volume(15)
{}

unsigned int VolumeHandler::volume() const
{
    return m_volume;
}

void VolumeHandler::setVolume(unsigned int newVolume)
{
    if (m_volume == newVolume)
        return;
    m_volume = newVolume;
    emit volumeChanged();
}

void VolumeHandler::changeVolume(const unsigned int &val)
{
    unsigned int newVolume = m_volume + val;

    if (newVolume >= 0 && newVolume <= 20)
        setVolume(newVolume);
}
