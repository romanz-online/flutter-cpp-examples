#include <iostream>
#include <functional>

#include "mqttmanager.hpp"

enum Mode
{
    AUTO,
    HEAT,
    COOL,
    OFF
};

int main()
{
    double currentTemp = 0.0;
    int setpoint = 0;
    Mode mode = AUTO;

    MqttManager server;
    std::atomic<bool> responseFlag(false);

    auto parseMessage = [&responseFlag, &currentTemp, &setpoint, &mode](const std::string &payload)
    {
        std::cout << "Received message " << payload << std::endl;

        size_t firstDelimPos = payload.find('&');
        size_t secondDelimPos = payload.find('&', firstDelimPos + 1);

        std::string firstPart = payload.substr(0, firstDelimPos);
        std::string secondPart = payload.substr(firstDelimPos + 1, secondDelimPos - firstDelimPos - 1);
        std::string thirdPart = payload.substr(secondDelimPos + 1);

        int newMode = 0;
        int newSetpoint = 0;

        try
        {
            newMode = std::stoi(secondPart);
            newSetpoint = std::stoi(thirdPart);
        }
        catch (const std::invalid_argument &e)
        {
            std::cerr << "Error: Invalid argument for conversion to int" << std::endl;
        }
        catch (const std::out_of_range &e)
        {
            std::cerr << "Error: Value out of range for int" << std::endl;
        }

        setpoint = newSetpoint;
        mode = static_cast<Mode>(newMode);
        std::cout << "Setpoint is now " << setpoint << std::endl;
        std::cout << "Mode is now " << mode << std::endl;

        responseFlag.store(true);
    };

    try
    {
        server.init(parseMessage);

        while (true)
        {
            if (currentTemp < setpoint)
            {
                if (mode == AUTO || mode == HEAT)
                {
                    currentTemp += 1.0;
                }
            }
            else if (currentTemp > setpoint)
            {
                if (mode == AUTO || COOL)
                {
                    currentTemp -= 1.0;
                }
            }

            if (responseFlag.load())
            {
                server.sendMessage(std::to_string(currentTemp));
                responseFlag.store(false);
            }
            std::this_thread::sleep_for(std::chrono::seconds(1));
        }

        server.exit();
    }
    catch (const mqtt::exception &exc)
    {
        std::cerr << "Error: " << exc.what() << std::endl;
        return 1;
    }

    return 0;
}
