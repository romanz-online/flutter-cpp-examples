import 'package:flutter/material.dart';

import 'generated/thermostat.pbgrpc.dart';
import 'backend.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Probe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const AppPage(title: 'Temperature Probe'),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({super.key, required this.title});

  final String title;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final _backend = Backend();
  double _currentTemp = 0.0;
  int _setpoint = 0;
  String _modeText = 'AUTO';

  @override
  void initState() {
    _backend.init();
    _backend.onCurrentTempUpdated = _onCurrentTempUpdated;
    _backend.onSettingsUpdated = _onSettingsUpdated;

    _modeText = _getModeText();

    super.initState();
  }

  void _onCurrentTempUpdated(double newCurrentTemp) {
    setState(() {
      _currentTemp = newCurrentTemp;
    });
  }

  void _onSettingsUpdated(Mode newMode, int newSetpoint) {
    setState(() {
      _setpoint = newSetpoint;
      _modeText = _getModeText();
    });
  }

  String _getModeText() {
    switch (_backend.mode) {
      case Mode.auto:
        return 'AUTO';
      case Mode.cool:
        return 'COOL';
      case Mode.heat:
        return 'HEAT';
      case Mode.off:
        return 'OFF';
      default:
        return '???';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title)),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text('Current Temperature: $_currentTemp',
                  style: Theme.of(context).textTheme.bodyMedium),
              Text('Temperature Setpoint: $_setpoint',
                  style: Theme.of(context).textTheme.bodyMedium),
              Text('[ Mode: $_modeText ]',
                  style: Theme.of(context).textTheme.bodyMedium)
            ])));
  }
}
