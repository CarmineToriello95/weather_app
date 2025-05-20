import 'package:json_annotation/json_annotation.dart';

part 'coord_model.g.dart';

@JsonSerializable()
class CoordModel {
  final double? lat;
  final double? lon;

  const CoordModel({required this.lat, required this.lon});

  factory CoordModel.fromJson(Map<String, dynamic> json) =>
      _$CoordModelFromJson(json);
}
