//
//  Generated code. Do not modify.
//  source: thermostat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'thermostat.pbenum.dart';

export 'thermostat.pbenum.dart';

class ThermostatRequest extends $pb.GeneratedMessage {
  factory ThermostatRequest({
    Mode? mode,
    $core.int? setpoint,
  }) {
    final $result = create();
    if (mode != null) {
      $result.mode = mode;
    }
    if (setpoint != null) {
      $result.setpoint = setpoint;
    }
    return $result;
  }
  ThermostatRequest._() : super();
  factory ThermostatRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ThermostatRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ThermostatRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'thermostat'), createEmptyInstance: create)
    ..e<Mode>(1, _omitFieldNames ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: Mode.auto, valueOf: Mode.valueOf, enumValues: Mode.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'setpoint', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ThermostatRequest clone() => ThermostatRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ThermostatRequest copyWith(void Function(ThermostatRequest) updates) => super.copyWith((message) => updates(message as ThermostatRequest)) as ThermostatRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ThermostatRequest create() => ThermostatRequest._();
  ThermostatRequest createEmptyInstance() => create();
  static $pb.PbList<ThermostatRequest> createRepeated() => $pb.PbList<ThermostatRequest>();
  @$core.pragma('dart2js:noInline')
  static ThermostatRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ThermostatRequest>(create);
  static ThermostatRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Mode get mode => $_getN(0);
  @$pb.TagNumber(1)
  set mode(Mode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMode() => $_has(0);
  @$pb.TagNumber(1)
  void clearMode() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get setpoint => $_getIZ(1);
  @$pb.TagNumber(2)
  set setpoint($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSetpoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearSetpoint() => clearField(2);
}

class TemperatureResponse extends $pb.GeneratedMessage {
  factory TemperatureResponse({
    $core.double? temperature,
  }) {
    final $result = create();
    if (temperature != null) {
      $result.temperature = temperature;
    }
    return $result;
  }
  TemperatureResponse._() : super();
  factory TemperatureResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TemperatureResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TemperatureResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'thermostat'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'temperature', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TemperatureResponse clone() => TemperatureResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TemperatureResponse copyWith(void Function(TemperatureResponse) updates) => super.copyWith((message) => updates(message as TemperatureResponse)) as TemperatureResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TemperatureResponse create() => TemperatureResponse._();
  TemperatureResponse createEmptyInstance() => create();
  static $pb.PbList<TemperatureResponse> createRepeated() => $pb.PbList<TemperatureResponse>();
  @$core.pragma('dart2js:noInline')
  static TemperatureResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TemperatureResponse>(create);
  static TemperatureResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get temperature => $_getN(0);
  @$pb.TagNumber(1)
  set temperature($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTemperature() => $_has(0);
  @$pb.TagNumber(1)
  void clearTemperature() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
