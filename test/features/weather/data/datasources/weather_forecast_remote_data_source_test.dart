import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/errors/weather_forecast/weather_forecast_exception.dart';
import 'package:weather_app/features/weather/data/datasources/weather_forecast_remote_data_source.dart';
import 'package:weather_app/features/weather/data/models/api_response_model.dart';

import '../../../../core/helpers/model_generators.dart';
import '../../../../core/mocks.mocks.dart';

void main() {
  late WeatherForecastRemoteDataSource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = WeatherForecastRemoteDataSourceImpl(mockClient);
  });

  group('$WeatherForecastRemoteDataSource', () {
    final http.Response tApiResponseSuccess = createTestApiResponseSuccess();
    final ApiResponseModel tApiReponseModel = createTestApiResponseModel();

    test(
      'WHEN fetching the weather forecast is successful THEN return a $ApiResponseModel',
      () async {
        /// arrange
        when(mockClient.get(any)).thenAnswer((_) async => tApiResponseSuccess);

        /// act
        final result = await dataSource.fetchWeatherForecastByCity(
          cityName: 'Berlin',
        );

        /// assert
        expect(result, tApiReponseModel);
        verify(mockClient.get(any)).called(1);
        verifyNoMoreInteractions(mockClient);
      },
    );

    final http.Response tApiResponseCityNotFoundError =
        createTestApiResponseCityNotFound();

    test(
      'WHEN the city searched for has not been found  THEN throw a $FetchWeatherForecastByCityException with status code 404',
      () async {
        /// arrange
        when(
          mockClient.get(any),
        ).thenAnswer((_) async => tApiResponseCityNotFoundError);

        /// act
        final result = dataSource.fetchWeatherForecastByCity(
          cityName: 'Berlin',
        );

        /// assert
        expect(
          result,
          throwsA(
            isA<FetchWeatherForecastByCityException>().having(
              (e) => e.statusCode,
              'statusCode',
              404,
            ),
          ),
        );
        verify(mockClient.get(any)).called(1);
        verifyNoMoreInteractions(mockClient);
      },
    );

    test(
      'WHEN an error occurred while fetching the weather forecast THEN throw a $FetchWeatherForecastByCityException',
      () async {
        /// arrange
        when(mockClient.get(any)).thenThrow((_) => Exception());

        /// act
        final result = dataSource.fetchWeatherForecastByCity(
          cityName: 'Berlin',
        );

        /// assert
        expect(result, throwsA(isA<FetchWeatherForecastByCityException>()));
        verify(mockClient.get(any)).called(1);
        verifyNoMoreInteractions(mockClient);
      },
    );
  });
}
