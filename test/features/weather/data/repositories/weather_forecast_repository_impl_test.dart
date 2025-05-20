import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/errors/weather_forecast/weather_forecast_exception.dart';
import 'package:weather_app/core/errors/weather_forecast/weather_forecast_failures.dart';
import 'package:weather_app/core/extensions/etiher_extension.dart';
import 'package:weather_app/features/weather/data/models/api_response_model.dart';
import 'package:weather_app/features/weather/data/repositories/weather_forecast_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_forecast_repository.dart';

import '../../../../core/helpers/entity_generators.dart';
import '../../../../core/helpers/model_generators.dart';
import '../../../../core/mocks.mocks.dart';

void main() {
  late WeatherForecastRepository repository;
  late MockWeatherForecastRemoteDataSource mockWeatherForecastRemoteDataSource;

  setUp(() {
    mockWeatherForecastRemoteDataSource = MockWeatherForecastRemoteDataSource();
    repository = WeatherForecastRepositoryImpl(
      mockWeatherForecastRemoteDataSource,
    );
  });

  group('$WeatherForecastRepository', () {
    const tCity = 'Berlin';

    final ApiResponseModel tApiResponseModel = createTestApiResponseModel();

    final List<WeatherEntity> tDailyWeatherEntityList =
        createTestDailyWeatherListFromApiResponseModel(tApiResponseModel);

    test(
      'WHEN an $ApiResponseModel is returned when fetching the weather forecast THEN return a list of $WeatherEntity',
      () async {
        /// arrange
        when(
          mockWeatherForecastRemoteDataSource.fetchWeatherForecastByCity(
            cityName: tCity,
          ),
        ).thenAnswer((_) async => tApiResponseModel);

        /// act
        final result = await repository.fetchWeatherForecastByCity(
          cityName: tCity,
        );

        /// arrange
        for (int i = 0; i < result.asRight().length; i++) {
          expect(tDailyWeatherEntityList[i], result.asRight()[i]);
        }
        verify(
          mockWeatherForecastRemoteDataSource.fetchWeatherForecastByCity(
            cityName: tCity,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockWeatherForecastRemoteDataSource);
      },
    );

    test(
      'WHEN fetching the weather fails because city has not been found THEN return a $FetchWeatherForecastCityNotFoundFailure',
      () async {
        /// arrange
        when(
          mockWeatherForecastRemoteDataSource.fetchWeatherForecastByCity(
            cityName: tCity,
          ),
        ).thenThrow(
          FetchWeatherForecastByCityException(
            message: 'error',
            statusCode: 404,
          ),
        );

        /// act
        final result = await repository.fetchWeatherForecastByCity(
          cityName: tCity,
        );

        /// assert
        result.fold(
          (failure) =>
              expect(failure, isA<FetchWeatherForecastCityNotFoundFailure>()),
          (success) => fail('Expected a failure, but got a success'),
        );
        verify(
          mockWeatherForecastRemoteDataSource.fetchWeatherForecastByCity(
            cityName: tCity,
          ),
        );
        verifyNoMoreInteractions(mockWeatherForecastRemoteDataSource);
      },
    );

    test(
      'WHEN an exception occurs while fetching the weather forecast THEN return a $FetchWeatherForecastGenericFailure',
      () async {
        /// arrange
        when(
          mockWeatherForecastRemoteDataSource.fetchWeatherForecastByCity(
            cityName: tCity,
          ),
        ).thenThrow(Exception());

        /// act
        final result = await repository.fetchWeatherForecastByCity(
          cityName: tCity,
        );

        /// assert
        result.fold(
          (failure) =>
              expect(failure, isA<FetchWeatherForecastGenericFailure>()),
          (success) => fail('Expected a failure, but got a success'),
        );
        verify(
          mockWeatherForecastRemoteDataSource.fetchWeatherForecastByCity(
            cityName: tCity,
          ),
        );
        verifyNoMoreInteractions(mockWeatherForecastRemoteDataSource);
      },
    );
  });
}
