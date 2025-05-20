import 'package:json_annotation/json_annotation.dart';

part 'sys_model.g.dart';

@JsonSerializable()
class SysModel {
  final String? pod;

  SysModel({required this.pod});

  factory SysModel.fromJson(Map<String, dynamic> json) =>
      _$SysModelFromJson(json);
}
