import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failure.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

/// Contract that defines the operations to fetch the weather forecast.
abstract class WeatherForecastRepository {
  /// Fetches the weather forecast by city from the data source.
  ///
  /// Returns a list of [WeatherEntity] if successful.
  ///
  /// Returns a [Failure] object if not successful.
  Future<Either<Failure, List<WeatherEntity>>> fetchWeatherForecastByCity({
    required String cityName,
  });
}
