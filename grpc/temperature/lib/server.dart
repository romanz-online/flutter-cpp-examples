import 'dart:async';
import 'package:grpc/grpc.dart';
import 'generated/thermostat.pbgrpc.dart';

class ThermostatService extends ThermostatServiceBase {
  Function(Mode, int)? onMessageReceived;
  Function()? getTemperature;

  @override
  Future<TemperatureResponse> sendMessage(
      ServiceCall call, ThermostatRequest request) async {
    print('Mode: ${request.mode}, Setpoint: ${request.setpoint}');

    onMessageReceived!(request.mode, request.setpoint);

    double currentTemperature = getTemperature?.call() ?? 0.0;

    final response = TemperatureResponse()..temperature = currentTemperature;

    return response;
  }
}
