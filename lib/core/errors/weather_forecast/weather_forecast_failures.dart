import 'package:weather_app/core/errors/failure.dart';

/// Class representing a failure occurred while fetching the weather forecast
/// when the city searched for has not been found.
class FetchWeatherForecastCityNotFoundFailure extends Failure {
  const FetchWeatherForecastCityNotFoundFailure(super.message);

  @override
  List<Object?> get props => [message];
}

/// Class representing a generic failure occurred when fetching the weather forecast.
class FetchWeatherForecastGenericFailure extends Failure {
  const FetchWeatherForecastGenericFailure(super.message);

  @override
  List<Object?> get props => [message];
}
