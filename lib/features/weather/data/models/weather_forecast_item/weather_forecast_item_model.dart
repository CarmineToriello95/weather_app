import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/core/utils/api_utils.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_item/clouds_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_item/main_info_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_item/sys_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_item/weather_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_item/wind_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

part 'weather_forecast_item_model.g.dart';

@JsonSerializable()
class WeatherForecastItemModel extends Equatable {
  final int dt;
  final MainInfoModel main;
  final List<WeatherModel> weather;
  final CloudsModel? clouds;
  final WindModel wind;
  final int? visibility;
  final double? pop;
  final SysModel? sys;
  @JsonKey(name: 'dt_txt')
  final String dtTxt;

  const WeatherForecastItemModel({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory WeatherForecastItemModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastItemModelFromJson(json);

  @override
  List<Object?> get props => [dt];

  WeatherEntity toEntity({required String city}) => WeatherEntity(
    id: dt,
    date: DateTime.parse(dtTxt),
    weatherCondition: weather.first.description,
    smallIconPath:
        Uri.https(
          ApiUtils.iconApiAuthority,
          ApiUtils.weatherIconPath +
              weather.first.icon +
              ApiUtils.weatherIconExtension2x,
        ).toString(),
    largeIconPath:
        Uri.https(
          ApiUtils.iconApiAuthority,
          ApiUtils.weatherIconPath +
              weather.first.icon +
              ApiUtils.weatherIconExtension4x,
        ).toString(),
    temp: main.temp,
    tempMax: main.tempMax,
    tempMin: main.tempMin,
    humidity: main.humidity,
    pressure: main.pressure,
    wind: wind.speed,
    city: city,
  );
}
