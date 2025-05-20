import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/errors/failure.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_forecast_repository.dart';

@injectable
class FetchWeatherForecastByCityUsecase
    implements Usecase<List<WeatherEntity>, String> {
  final WeatherForecastRepository _repository;

  FetchWeatherForecastByCityUsecase(this._repository);
  @override
  Future<Either<Failure, List<WeatherEntity>>> call({required String params}) =>
      _repository.fetchWeatherForecastByCity(cityName: params);
}
