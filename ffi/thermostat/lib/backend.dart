import 'dart:async';
import 'dart:ffi';
import 'dart:io';

enum Mode { auto, heat, cool, off }

class Backend {
  Function(int)? onTemperatureReceived;

  Future<void> init() async {
    final temperatureCallbackFP =
        NativeCallable<NativeTemperatureCallback>.listener(
            _temperatureCallback);

    registerCallback(temperatureCallbackFP.nativeFunction);
  }

  void _temperatureCallback(int temperature) {
    print('Current Temperature: $temperature');
    onTemperatureReceived!(temperature);
  }

  int getTemperature() => retrieveTemperature();

  void setSetpoint(int newSetpoint) {
    updateSetpoint(newSetpoint);
  }

  int getSetpoint() => retrieveSetpoint();

  void setMode(Mode newMode) {
    updateMode(Mode.values.indexOf(newMode));
  }

  Mode getMode() => Mode.values[retrieveMode()];
}

final DynamicLibrary lib = Platform.isWindows
    ? DynamicLibrary.open("lib/build/thermostat.dll")
    : DynamicLibrary.open("lib/build/libThermostat.so");

final int Function() retrieveTemperature =
    lib.lookupFunction<Int64 Function(), int Function()>('getTemperature');

final void Function(int setpoint) updateSetpoint = lib.lookupFunction<
    Void Function(Int64 setpoint), void Function(int setpoint)>('setSetpoint');

final int Function() retrieveSetpoint =
    lib.lookupFunction<Int64 Function(), int Function()>('getSetpoint');

final void Function(int mode) updateMode =
    lib.lookupFunction<Void Function(Int64 mode), void Function(int mode)>(
        'setMode');

final int Function() retrieveMode =
    lib.lookupFunction<Int64 Function(), int Function()>('getMode');

typedef NativeTemperatureCallback = Void Function(Int64);
typedef TemperatureGetFunction = void Function(
    Pointer<NativeFunction<NativeTemperatureCallback>>);
typedef TemperatureGetNativeFunction = Void Function(
    Pointer<NativeFunction<NativeTemperatureCallback>>);

final registerCallback =
    lib.lookupFunction<TemperatureGetNativeFunction, TemperatureGetFunction>(
        'registerCallback');
