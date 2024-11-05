// build with:
// g++ -o libThermostat.so -shared -fPIC thermostat.cpp

#ifndef THERMOSTAT_HPP
#define THERMOSTAT_HPP

#include <iostream>
#include <thread>
#include <atomic>
#include <functional>
#include <chrono>

enum Mode
{
    AUTO,
    HEAT,
    COOL,
    OFF
};

class Thermostat
{
public:
    using TemperatureCallback = void (*)(int);

    Thermostat()
        : m_temperature(0), m_setpoint(0), m_mode(AUTO), temperatureCallback(nullptr)
    {
    }

    ~Thermostat()
    {
        stopThread = true;
        if (temperatureThread.joinable())
        {
            temperatureThread.join();
        }
    }

    void registerCallback(TemperatureCallback callback)
    {
        temperatureCallback = callback;

        startTemperatureUpdateThread();
    }

    void startTemperatureUpdateThread()
    {
        temperatureThread = std::thread([this]()
                                        {
            while (!stopThread)
            {
                std::this_thread::sleep_for(std::chrono::seconds(1));
         
                if (m_temperature < m_setpoint)
                {
                    if (m_mode == AUTO || m_mode == HEAT)
                    {
                        m_temperature += 1.0;
                    }
                }
                else if (m_temperature > m_setpoint)
                {
                    if (m_mode == AUTO || m_mode == COOL)
                    {
                        m_temperature -= 1.0;
                    }
                }

                if (temperatureCallback)
                {
                    temperatureCallback(m_temperature);
                }
            } });
    }

    int getTemperature() const { return m_temperature; }
    int getSetpoint() const { return m_setpoint; }
    void setSetpoint(int setpoint) { m_setpoint = setpoint; }
    Mode getMode() const { return m_mode; }
    void setMode(Mode mode) { m_mode = mode; }

private:
    std::atomic<int> m_temperature;
    int m_setpoint;
    Mode m_mode;
    TemperatureCallback temperatureCallback;
    std::thread temperatureThread;
    std::atomic<bool> stopThread;
};

Thermostat thermostat;

extern "C"
{
    void registerCallback(void (*callback)(int))
    {
        thermostat.registerCallback(callback);
    }

    void startTemperatureThread()
    {
        thermostat.startTemperatureUpdateThread();
    }

    int getTemperature()
    {
        return thermostat.getTemperature();
    }

    void setSetpoint(int setpoint)
    {
        thermostat.setSetpoint(setpoint);
    }

    int getSetpoint()
    {
        return thermostat.getSetpoint();
    }

    void setMode(int mode)
    {
        thermostat.setMode(Mode(mode));
    }

    int getMode()
    {
        return thermostat.getMode();
    }
}

#endif // THERMOSTAT_HPP