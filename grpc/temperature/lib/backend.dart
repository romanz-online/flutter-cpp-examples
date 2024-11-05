import 'dart:async';

import 'package:grpc/grpc.dart';
import 'generated/thermostat.pbgrpc.dart';
import 'server.dart';

class Backend {
  Function(double)? onCurrentTempUpdated;
  Function(Mode, int)? onSettingsUpdated;
  double currentTemp = 0.0;
  int setpoint = 0;
  Mode mode = Mode.auto;

  late Server _server;
  late ThermostatService _thermostatService;

  Backend();

  Future<void> init() async {
    _thermostatService = ThermostatService();
    _thermostatService.onMessageReceived = parseMessage;
    _thermostatService.getTemperature = getTemperature;
    _server = Server.create(services: [_thermostatService]);
    try {
      await _server.serve(port: 50051);
      print('Server listening on port ${_server.port}...');
    } catch (e) {
      print('Exception: $e');
      return;
    }

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      updateTemperature();
    });
  }

  double getTemperature() {
    return currentTemp;
  }

  void parseMessage(Mode newMode, int newSetpoint) {
    mode = newMode;
    setpoint = newSetpoint;
    onSettingsUpdated!(mode, setpoint);
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
