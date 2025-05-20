import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final int id;
  final DateTime date;
  final String weatherCondition;
  final String smallIconPath;
  final String largeIconPath;
  final double temp;
  final double tempMax;
  final double tempMin;
  final int humidity;
  final int pressure;
  final double wind;
  final String city;

  const WeatherEntity({
    required this.id,
    required this.date,
    required this.weatherCondition,
    required this.smallIconPath,
    required this.largeIconPath,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.humidity,
    required this.pressure,
    required this.wind,
    required this.city,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    weatherCondition,
    smallIconPath,
    largeIconPath,
    temp,
    tempMax,
    tempMin,
    humidity,
    pressure,
    wind,
    city,
  ];
}
