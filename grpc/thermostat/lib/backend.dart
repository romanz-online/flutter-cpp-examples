import 'dart:async';

import 'generated/thermostat.pbgrpc.dart';
import 'client.dart';

class Backend {
  Function(double)? onTemperatureReceived;
  double _temperature = 0.0;
  int _setpoint = 0;
  Mode _mode = Mode.auto;

  final _client = ThermostatClient('localhost', 50051);

  Backend();

  Future<void> init() async {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      print('Requesting current temperature...');
      final temperature = await _client.sendThermostatRequest(_mode, _setpoint);
      _temperature = temperature;
      onTemperatureReceived!(temperature);
      print('Current Temperature: $temperature');
    });
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
