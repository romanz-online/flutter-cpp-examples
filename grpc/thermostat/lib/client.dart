import 'package:grpc/grpc.dart';
import 'generated/thermostat.pbgrpc.dart';

class ThermostatClient {
  late ClientChannel channel;
  late ThermostatServiceClient stub;

  ThermostatClient(String host, int port) {
    channel = ClientChannel(host,
        port: port,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
    stub = ThermostatServiceClient(channel);
  }

  Future<double> sendThermostatRequest(Mode mode, int setpoint) async {
    final request = ThermostatRequest()
      ..mode = mode
      ..setpoint = setpoint;

    try {
      final response = await stub.sendMessage(request);
      return response.temperature;
    } catch (e) {
      print('Caught error: $e');
      return 0.0;
    }
  }
}
