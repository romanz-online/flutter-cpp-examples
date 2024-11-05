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

class Mode extends $pb.ProtobufEnum {
  static const Mode auto = Mode._(0, _omitEnumNames ? '' : 'auto');
  static const Mode heat = Mode._(1, _omitEnumNames ? '' : 'heat');
  static const Mode cool = Mode._(2, _omitEnumNames ? '' : 'cool');
  static const Mode off = Mode._(3, _omitEnumNames ? '' : 'off');

  static const $core.List<Mode> values = <Mode> [
    auto,
    heat,
    cool,
    off,
  ];

  static final $core.Map<$core.int, Mode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Mode? valueOf($core.int value) => _byValue[value];

  const Mode._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
