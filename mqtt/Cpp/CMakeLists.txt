cmake_minimum_required(VERSION 3.14)
project(mqtt_project VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(PahoMqttCpp REQUIRED)

add_executable(temperature main.cpp)

target_link_libraries(temperature PahoMqttCpp::paho-mqttpp3)
