//
//  Generated code. Do not modify.
//  source: thermostat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use modeDescriptor instead')
const Mode$json = {
  '1': 'Mode',
  '2': [
    {'1': 'auto', '2': 0},
    {'1': 'heat', '2': 1},
    {'1': 'cool', '2': 2},
    {'1': 'off', '2': 3},
  ],
};

/// Descriptor for `Mode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List modeDescriptor = $convert.base64Decode(
    'CgRNb2RlEggKBGF1dG8QABIICgRoZWF0EAESCAoEY29vbBACEgcKA29mZhAD');

@$core.Deprecated('Use thermostatRequestDescriptor instead')
const ThermostatRequest$json = {
  '1': 'ThermostatRequest',
  '2': [
    {'1': 'mode', '3': 1, '4': 1, '5': 14, '6': '.thermostat.Mode', '10': 'mode'},
    {'1': 'setpoint', '3': 2, '4': 1, '5': 5, '10': 'setpoint'},
  ],
};

/// Descriptor for `ThermostatRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List thermostatRequestDescriptor = $convert.base64Decode(
    'ChFUaGVybW9zdGF0UmVxdWVzdBIkCgRtb2RlGAEgASgOMhAudGhlcm1vc3RhdC5Nb2RlUgRtb2'
    'RlEhoKCHNldHBvaW50GAIgASgFUghzZXRwb2ludA==');

@$core.Deprecated('Use temperatureResponseDescriptor instead')
const TemperatureResponse$json = {
  '1': 'TemperatureResponse',
  '2': [
    {'1': 'temperature', '3': 1, '4': 1, '5': 1, '10': 'temperature'},
  ],
};

/// Descriptor for `TemperatureResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List temperatureResponseDescriptor = $convert.base64Decode(
    'ChNUZW1wZXJhdHVyZVJlc3BvbnNlEiAKC3RlbXBlcmF0dXJlGAEgASgBUgt0ZW1wZXJhdHVyZQ'
    '==');

