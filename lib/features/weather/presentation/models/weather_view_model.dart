import 'package:equatable/equatable.dart';
import 'package:weather_app/core/extensions/date_time_extension.dart';
import 'package:weather_app/core/extensions/double_extension.dart';
import 'package:weather_app/core/extensions/string_extension.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

/// Presentation layer representation of a daily weather forecast
/// It contains the information to display in the widgets.
class WeatherViewModel extends Equatable {
  final int id;
  final String weatherCondition;
  final String longDayFormat;
  final String shortDayFormat;
  final double temp;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int wind;
  final String smallIconPath;
  final String largeIconPath;

  const WeatherViewModel({
    required this.id,
    required this.weatherCondition,
    required this.longDayFormat,
    required this.shortDayFormat,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.wind,
    required this.smallIconPath,
    required this.largeIconPath,
  });

  @override
  List<Object> get props => [
    id,
    weatherCondition,
    longDayFormat,
    shortDayFormat,
    temp,
    tempMin,
    tempMax,
    pressure,
    humidity,
    wind,
    smallIconPath,
    largeIconPath,
  ];

  factory WeatherViewModel.fromEntry(WeatherEntity entity) {
    return WeatherViewModel(
      id: entity.id,
      weatherCondition: entity.weatherCondition.capitalizeFirstLetterOnly,
      longDayFormat: entity.date.longDay,
      shortDayFormat: entity.date.shortDay,
      temp: entity.temp,
      pressure: entity.pressure.round(),
      humidity: entity.humidity.round(),
      wind: entity.wind.round(),
      tempMin: entity.tempMin,
      tempMax: entity.tempMax,
      smallIconPath: entity.smallIconPath,
      largeIconPath: entity.largeIconPath,
    );
  }

  String formattedTemperature(TemperatureUnit temperatureUnit) {
    if (temperatureUnit == TemperatureUnit.fahrenheit) {
      return '${temp.celsiusToFahrenheit.round()}°';
    }
    return '${temp.round()}°';
  }

  String formattedTempRange(TemperatureUnit temperatureUnit) {
    if (temperatureUnit == TemperatureUnit.fahrenheit) {
      return '${tempMin.celsiusToFahrenheit.round()}°/ ${tempMax.celsiusToFahrenheit.round()}°';
    }
    return '${tempMin.round()}°/ ${tempMax.round()}°';
  }

  String get pressureWithUnit => '$pressure hPa';
  String get humidityWithPercentage => '$humidity%';
  String get windWithUnit => '$wind km/h';
}
