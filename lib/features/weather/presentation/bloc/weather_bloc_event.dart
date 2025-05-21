import 'package:equatable/equatable.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/features/weather/presentation/models/weather_view_model.dart';

sealed class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();
}

class WeatherBlocFetchWeatherByCityEvent extends WeatherBlocEvent {
  final String city;

  const WeatherBlocFetchWeatherByCityEvent({required this.city});

  @override
  List<Object?> get props => [city];
}

class WeatherBlocWeatherDaySelectedEvent extends WeatherBlocEvent {
  final WeatherViewModel weatherViewModel;

  const WeatherBlocWeatherDaySelectedEvent({required this.weatherViewModel});

  @override
  List<Object?> get props => [weatherViewModel];
}

class WeatherBlocTemperatureUnitChangedEvent extends WeatherBlocEvent {
  final TemperatureUnit temperatureUnit;

  const WeatherBlocTemperatureUnitChangedEvent({required this.temperatureUnit});

  @override
  List<Object?> get props => [temperatureUnit];
}
