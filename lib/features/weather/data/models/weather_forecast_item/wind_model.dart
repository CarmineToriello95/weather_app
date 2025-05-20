import 'package:json_annotation/json_annotation.dart';

part 'wind_model.g.dart';

@JsonSerializable()
class WindModel {
  final double speed;
  final int? deg;
  final double? gust;

  WindModel({required this.speed, required this.deg, required this.gust});

  factory WindModel.fromJson(Map<String, dynamic> json) =>
      _$WindModelFromJson(json);
}
