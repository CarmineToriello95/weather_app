import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/errors/weather_forecast/failure_messages.dart';
import 'package:weather_app/core/errors/weather_forecast/weather_forecast_failures.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc_state.dart';
import 'package:weather_app/features/weather/presentation/models/weather_view_model.dart';

import '../../../../core/helpers/entity_generators.dart';
import '../../../../core/mocks.mocks.dart';

void main() {
  late WeatherBloc bloc;
  late MockFetchWeatherForecastByCityUsecase
  mockFetchWeatherForecastByCityUsecase;

  setUp(() {
    mockFetchWeatherForecastByCityUsecase =
        MockFetchWeatherForecastByCityUsecase();
    bloc = WeatherBloc(mockFetchWeatherForecastByCityUsecase);
  });

  group('$WeatherBloc', () {
    const tCity = 'Berlin';
    const tFailure = FetchWeatherForecastCityNotFoundFailure(
      FailureMessages.cityNotFoundError,
    );

    final List<WeatherEntity> tDailyWeatherEntityList =
        createTestDailyWeatherList();

    blocTest(
      '''WHEN $WeatherBlocFetchWeatherByCityEvent is added and fetching the weather forecast is successful 
      THEN emit [$WeatherBlocLoadingState, $WeatherBlocPopulatedState]''',
      build: () {
        when(
          mockFetchWeatherForecastByCityUsecase.call(params: tCity),
        ).thenAnswer((_) async => Right(tDailyWeatherEntityList));

        return bloc;
      },
      act: (bloc) => bloc.add(WeatherBlocFetchWeatherByCityEvent(city: tCity)),
      verify: (bloc) {
        verify(
          mockFetchWeatherForecastByCityUsecase.call(params: tCity),
        ).called(1);
        verifyNoMoreInteractions(mockFetchWeatherForecastByCityUsecase);
      },
      expect:
          () => [
            isA<WeatherBlocLoadingState>(),
            isA<WeatherBlocPopulatedState>()
                .having((s) => s.cityName, 'cityName', tCity)
                .having(
                  (state) => state.selectedWeatherDay,
                  'selectedWeatherDay',
                  WeatherViewModel.fromEntry(tDailyWeatherEntityList.first),
                )
                .having(
                  (state) => state.selectedTemperatureUnit,
                  'selectedTemperatureUnit',
                  TemperatureUnit.celsius,
                ),
          ],
    );

    blocTest(
      '''WHEN $WeatherBlocFetchWeatherByCityEvent is added and fetching weather forecast is not successful 
      THEN emit [$WeatherBlocLoadingState, $WeatherBlocErrorState]''',
      build: () {
        when(
          mockFetchWeatherForecastByCityUsecase.call(params: tCity),
        ).thenAnswer((_) async => Left(tFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(WeatherBlocFetchWeatherByCityEvent(city: tCity)),
      verify: (bloc) {
        verify(
          mockFetchWeatherForecastByCityUsecase.call(params: tCity),
        ).called(1);
        verifyNoMoreInteractions(mockFetchWeatherForecastByCityUsecase);
      },
      expect:
          () => [
            isA<WeatherBlocLoadingState>(),
            isA<WeatherBlocErrorState>().having(
              (state) => state.failure,
              'failure',
              tFailure,
            ),
          ],
    );

    blocTest(
      'WHEN $WeatherBlocTemperatureUnitChangedEvent is added THEN emit a $WeatherBlocPopulatedState with the updated data',
      build: () => bloc,
      act:
          (bloc) => bloc.add(
            WeatherBlocTemperatureUnitChangedEvent(
              temperatureUnit: TemperatureUnit.fahrenheit,
            ),
          ),
      seed:
          () => WeatherBlocPopulatedState(
            cityName: tCity,
            selectedWeatherDay: WeatherViewModel.fromEntry(
              tDailyWeatherEntityList.first,
            ),
            dailyWeatherList: [
              WeatherViewModel.fromEntry(tDailyWeatherEntityList.first),
            ],
            selectedTemperatureUnit: TemperatureUnit.celsius,
          ),
      expect:
          () => [
            isA<WeatherBlocPopulatedState>().having(
              (state) => state.selectedTemperatureUnit,
              'selectedTemperatureUnit',
              TemperatureUnit.fahrenheit,
            ),
          ],
    );

    blocTest(
      'WHEN $WeatherBlocTemperatureUnitChangedEvent is added THEN emit a $WeatherBlocPopulatedState with the updated data',
      build: () => bloc,
      act:
          (bloc) => bloc.add(
            WeatherBlocTemperatureUnitChangedEvent(
              temperatureUnit: TemperatureUnit.fahrenheit,
            ),
          ),
      seed:
          () => WeatherBlocPopulatedState(
            cityName: tCity,
            selectedWeatherDay: WeatherViewModel.fromEntry(
              tDailyWeatherEntityList.first,
            ),
            dailyWeatherList: [
              WeatherViewModel.fromEntry(tDailyWeatherEntityList.first),
            ],
            selectedTemperatureUnit: TemperatureUnit.celsius,
          ),
      expect:
          () => [
            isA<WeatherBlocPopulatedState>().having(
              (state) => state.selectedTemperatureUnit,
              'selectedTemperatureUnit',
              TemperatureUnit.fahrenheit,
            ),
          ],
    );
  });
}
