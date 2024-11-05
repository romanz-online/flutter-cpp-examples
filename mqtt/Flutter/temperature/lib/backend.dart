import 'dart:async';

import 'mqtt_manager.dart';

enum Mode { auto, heat, cool, off }

class Backend {
  Function(double)? onCurrentTempUpdated;
  Function(Mode, int)? onSettingsUpdated;
  double currentTemp = 0.0;
  int setpoint = 0;
  Mode mode = Mode.auto;

  final _server = MQTTManager();

  Backend();

  Future<void> init() async {
    _server.onMessageReceived = parseMessage;
    try {
      await _server.init();
    } catch (e) {
      print('Exception: $e');
      return;
    }

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      updateTemperature();
    });
  }

  void parseMessage(String m) {
    List<String> data = m.split('&');

    mode = Mode.values[int.tryParse(data[1]) ?? 0];
    setpoint = int.tryParse(data[2]) ?? 0;
    onSettingsUpdated!(mode, setpoint);

    _server.sendMessage('$currentTemp');
  }

  void updateTemperature() {
    if (currentTemp < setpoint) {
      if (mode == Mode.auto || mode == Mode.heat) {
        currentTemp += 1.0;
        onCurrentTempUpdated!(currentTemp);
      }
    } else if (currentTemp > setpoint) {
      if (mode == Mode.auto || mode == Mode.cool) {
        currentTemp -= 1.0;
        onCurrentTempUpdated!(currentTemp);
      }
    }
  }
}
