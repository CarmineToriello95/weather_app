import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/data/models/coord_model.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel extends Equatable {
  final int id;
  final String name;
  final CoordModel? coord;
  final String? country;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  const CityModel({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
