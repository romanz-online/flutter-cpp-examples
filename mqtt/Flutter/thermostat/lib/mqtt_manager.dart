import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTManager {
  Function(String)? onMessageReceived;
  final _client = MqttServerClient('localhost', 'Thermostat');
  final String _topic = 'temp';

  MQTTManager();

  Future<void> init() async {
    _client.port = 1883;
    _client.logging(on: false);
    _client.setProtocolV311();
    _client.keepAlivePeriod = 20;
    _client.connectTimeoutPeriod = 2 * 1000;
    _client.onDisconnected = onDisconnected;
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;

    try {
      await _client.connect();
    } catch (e) {
      print('Exception: $e');
      _client.disconnect();
      return;
    }

    if (_client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Client connected');
    } else {
      print('Client connection failed - status ${_client.connectionStatus}');
      _client.disconnect();
      return;
    }

    _client.subscribe(_topic, MqttQos.atMostOnce);

    _client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final m = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(m.payload.message);
      print('Topic <${c[0].topic}>; Payload <-- $pt -->');
      if (c[0].topic == _topic && pt.split('&')[0] != _client.clientIdentifier) {
        onMessageReceived!(pt);
      }
    });
  }

  void sendMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString('${_client.clientIdentifier}&$message');
    _client.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
  }

  void onSubscribed(String t) {
    print('Subscribed to $t');
  }

  void onConnected() {
    print('Client connected');
  }

  void onDisconnected() {
    print('Client disconnected');
  }
}
