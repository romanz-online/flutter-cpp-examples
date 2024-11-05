import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'generated/thermostat.pbgrpc.dart';
import 'backend.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Thermostat',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const AppPage(title: 'Thermostat'));
  }
}

class AppPage extends StatefulWidget {
  const AppPage({super.key, required this.title});

  final String title;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with SingleTickerProviderStateMixin {
  late AnimationController _gradientPulseController;
  late Animation _gradientPulse;
  final TextEditingController _setpointController = TextEditingController();
  final _backend = Backend();
  double _lastTemp = 0.0;
  String _modeText = 'AUTO';
  Color _gradientColor = Colors.black, _modeColor = Colors.white;

  @override
  void initState() {
    _backend.init();
    _backend.onTemperatureReceived = _onCurrentTempReceived;

    _modeText = _getModeText();
    _modeColor = _getModeColor();

    _setpointController.text = '${_backend.getSetpoint()}';

    _gradientPulseController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))
          ..repeat(reverse: true);
    _gradientPulse =
        Tween(begin: 0.0, end: 1.0).animate(_gradientPulseController)
          ..addListener(() {
            setState(() {});
          });

    super.initState();
  }

  void _incrementSetpoint() {
    try {
      _backend.setSetpoint(_backend.getSetpoint() + 1);
      setState(() {
        _setpointController.text = '${_backend.getSetpoint()}';
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _decrementSetpoint() {
    try {
      _backend.setSetpoint(_backend.getSetpoint() - 1);
      setState(() {
        _setpointController.text = '${_backend.getSetpoint()}';
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _handleSetpointChange(String newSetpoint) {
    try {
      int v = 0;
      if (newSetpoint.isNotEmpty && newSetpoint != '-') {
        v = int.parse(newSetpoint);
      }
      _backend.setSetpoint(v);
    } catch (e) {
      print('Error: $e');
    }
  }

  void _cycleMode() {
    final currentIndex = Mode.values.indexOf(_backend.getMode());
    final nextIndex = (currentIndex + 1) % Mode.values.length;
    _backend.setMode(Mode.values[nextIndex]);
    setState(() {
      _modeText = _getModeText();
      _modeColor = _getModeColor();
    });
  }

  void _onCurrentTempReceived(double newCurrentTemp) {
    setState(() {
      // when the temperature is changing
      if (_lastTemp < newCurrentTemp) {
        _gradientColor = Colors.red;
        if (!_gradientPulseController.isAnimating) {
          _gradientPulseController.repeat(reverse: true);
        }
      } else if (_lastTemp > newCurrentTemp) {
        _gradientColor = Colors.blue;
        if (!_gradientPulseController.isAnimating) {
          _gradientPulseController.repeat(reverse: true);
        }
      } else {
        _gradientColor = Colors.black;
        _gradientPulseController.stop();
      }

      _lastTemp = newCurrentTemp;
    });
  }

  String _getModeText() {
    switch (_backend.getMode()) {
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

  Color _getModeColor() {
    switch (_backend.getMode()) {
      case Mode.cool:
        return Colors.blue;
      case Mode.heat:
        return Colors.red;
      case Mode.off:
      case Mode.auto:
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Stack(children: [
      // Gradient Background
      AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [_gradientColor, Colors.black],
            radius: 0.2 + (0.02 * _gradientPulse.value),
            center: Alignment.center,
          ),
        ),
      ),

      // Current Temperature
      Center(
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3.0),
                  color: Colors.black),
              padding: const EdgeInsets.all(48.0),
              child: Text('${_backend.getTemperature()}°',
                  style: const TextStyle(color: Colors.white, fontSize: 42)))),

      // Controls
      Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                width: 46,
                child: TextField(
                    controller: _setpointController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d{0,3}')),
                    ],
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    onSubmitted: _handleSetpointChange,
                    onChanged: _handleSetpointChange)),
            const SizedBox(width: 4), // Padding
            const Text('°', style: TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(width: 16), // Padding
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  icon: const Icon(Icons.arrow_downward),
                  style: IconButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: _decrementSetpoint),
              const SizedBox(width: 8), // Padding
              IconButton(
                  icon: const Icon(Icons.arrow_upward),
                  style: IconButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: _incrementSetpoint),
            ]),
            const SizedBox(width: 8), // Padding
            ElevatedButton(
                onPressed: _cycleMode,
                style: ElevatedButton.styleFrom(backgroundColor: _modeColor),
                child: SizedBox(
                    width: 48,
                    height: 40,
                    child: Center(
                        child: Text(_modeText,
                            style: const TextStyle(color: Colors.black)))))
          ]))
    ])));
  }
}
