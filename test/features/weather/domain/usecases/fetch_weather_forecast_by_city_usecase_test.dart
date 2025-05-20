import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/errors/failure.dart';
import 'package:weather_app/core/errors/weather_forecast/weather_forecast_failures.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/usecases/fetch_weather_forecast_by_city_usecase.dart';

import '../../../../core/helpers/entity_generators.dart';
import '../../../../core/mocks.mocks.dart';

void main() {
  late FetchWeatherForecastByCityUsecase usecase;
  late MockWeatherForecastRepository mockWeatherForecastRepository;

  setUp(() {
    mockWeatherForecastRepository = MockWeatherForecastRepository();
    usecase = FetchWeatherForecastByCityUsecase(mockWeatherForecastRepository);
  });

  group('$FetchWeatherForecastByCityUsecase', () {
    const tCity = 'Berlin';
    final List<WeatherEntity> tWeatherEntityList = createTestDailyWeatherList();

    const FetchWeatherForecastGenericFailure tFailure =
        FetchWeatherForecastGenericFailure('error');
    test('WHEN successful THEN return a list of $WeatherEntity', () async {
      /// arrange
      when(
        mockWeatherForecastRepository.fetchWeatherForecastByCity(
          cityName: tCity,
        ),
      ).thenAnswer((_) async => Right(tWeatherEntityList));

      // act
      final result = await usecase.call(params: tCity);

      // assert
      expect(result, Right(tWeatherEntityList));
      verify(
        mockWeatherForecastRepository.fetchWeatherForecastByCity(
          cityName: tCity,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockWeatherForecastRepository);
    });

    test('WHEN not successful THEN return a $Failure object', () async {
      /// arrange
      when(
        mockWeatherForecastRepository.fetchWeatherForecastByCity(
          cityName: tCity,
        ),
      ).thenAnswer((_) async => Left(tFailure));

      // act
      final result = await usecase.call(params: tCity);

      // assert
      expect(result, Left(tFailure));
      verify(
        mockWeatherForecastRepository.fetchWeatherForecastByCity(
          cityName: tCity,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockWeatherForecastRepository);
    });
  });
}
