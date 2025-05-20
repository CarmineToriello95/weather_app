import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failure.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/features/weather/presentation/models/weather_view_model.dart';

sealed class WeatherBlocState extends Equatable {
  const WeatherBlocState();
}

class WeatherBlocInitialState extends WeatherBlocState {
  const WeatherBlocInitialState();
  @override
  List<Object?> get props => [];
}

class WeatherBlocLoadingState extends WeatherBlocState {
  const WeatherBlocLoadingState();

  @override
  List<Object?> get props => [];
}

class WeatherBlocErrorState extends WeatherBlocState {
  final Failure failure;
  final String cityName;
  const WeatherBlocErrorState({required this.failure, required this.cityName});

  @override
  List<Object?> get props => [failure, cityName];
}

class WeatherBlocPopulatedState extends WeatherBlocState {
  final WeatherViewModel selectedWeatherDay;
  final List<WeatherViewModel> dailyWeatherList;
  final TemperatureUnit selectedTemperatureUnit;
  final String cityName;

  const WeatherBlocPopulatedState({
    required this.selectedWeatherDay,
    required this.dailyWeatherList,
    required this.selectedTemperatureUnit,
    required this.cityName,
  });

  WeatherBlocPopulatedState copyWith({
    WeatherViewModel? selectedWeatherDay,
    List<WeatherViewModel>? dailyWeatherList,
    TemperatureUnit? selectedTemperatureUnit,
    String? cityName,
  }) => WeatherBlocPopulatedState(
    selectedWeatherDay: selectedWeatherDay ?? this.selectedWeatherDay,
    dailyWeatherList: dailyWeatherList ?? this.dailyWeatherList,
    selectedTemperatureUnit:
        selectedTemperatureUnit ?? this.selectedTemperatureUnit,
    cityName: cityName ?? this.cityName,
  );

  @override
  List<Object?> get props => [
    selectedWeatherDay,
    dailyWeatherList,
    selectedTemperatureUnit,
    cityName,
  ];
}
