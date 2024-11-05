import 'dart:async';

import 'mqtt_manager.dart';

enum Mode { auto, heat, cool, off }

class Backend {
  Function(double)? onTemperatureReceived;
  double _temperature = 0.0;
  int _setpoint = 0;
  Mode _mode = Mode.auto;

  final _client = MQTTManager();

  Backend();

  Future<void> init() async {
    _client.onMessageReceived = parseMessage;
    try {
      await _client.init();
    } catch (e) {
      print('Exception: $e');
      return;
    }

    Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      print('Requesting current temperature...');
      _client.sendMessage('${Mode.values.indexOf(_mode)}&$_setpoint');
    });
  }

  void parseMessage(String m) {
    _temperature = double.tryParse(m.split('&')[1]) ?? 0.0;
    onTemperatureReceived!(_temperature);
    print('Current Temperature: $_temperature');
  }

  double getTemperature() {
    return _temperature;
  }

  void setSetpoint(int newSetpoint) {
    _setpoint = newSetpoint;
  }

  int getSetpoint() {
    return _setpoint;
  }

  void setMode(Mode newMode) {
    _mode = newMode;
  }

  Mode getMode() {
    return _mode;
  }
}
