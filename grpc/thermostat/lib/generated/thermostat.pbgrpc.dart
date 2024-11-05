//
//  Generated code. Do not modify.
//  source: thermostat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'thermostat.pb.dart' as $0;

export 'thermostat.pb.dart';

// @$pb.GrpcServiceName('thermostat.ThermostatService')
class ThermostatServiceClient extends $grpc.Client {
  static final _$sendMessage = $grpc.ClientMethod<$0.ThermostatRequest, $0.TemperatureResponse>(
      '/thermostat.ThermostatService/SendMessage',
      ($0.ThermostatRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TemperatureResponse.fromBuffer(value));

  ThermostatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.TemperatureResponse> sendMessage($0.ThermostatRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }
}

// @$pb.GrpcServiceName('thermostat.ThermostatService')
abstract class ThermostatServiceBase extends $grpc.Service {
  $core.String get $name => 'thermostat.ThermostatService';

  ThermostatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ThermostatRequest, $0.TemperatureResponse>(
        'SendMessage',
        sendMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ThermostatRequest.fromBuffer(value),
        ($0.TemperatureResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.TemperatureResponse> sendMessage_Pre($grpc.ServiceCall call, $async.Future<$0.ThermostatRequest> request) async {
    return sendMessage(call, await request);
  }

  $async.Future<$0.TemperatureResponse> sendMessage($grpc.ServiceCall call, $0.ThermostatRequest request);
}
