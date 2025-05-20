import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/data/models/city_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_item/weather_forecast_item_model.dart';

part 'api_response_model.g.dart';

@JsonSerializable()
class ApiResponseModel extends Equatable {
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherForecastItemModel> list;
  final CityModel city;

  const ApiResponseModel({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseModelFromJson(json);

  @override
  List<Object?> get props => [cod, message, cnt, list, city];
}
