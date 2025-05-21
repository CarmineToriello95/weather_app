import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:weather_app/core/errors/weather_forecast/failure_messages.dart';
import 'package:weather_app/core/errors/weather_forecast/weather_forecast_failures.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/di_config.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc_state.dart';
import 'package:weather_app/features/weather/presentation/models/weather_view_model.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_error_state_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_loading_state_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_page_populated_state_widget.dart';

import '../../../../core/helpers/model_generators.dart';
import '../../../../core/mocks.mocks.dart';

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUpAll(() {
    mockWeatherBloc = MockWeatherBloc();

    getIt.registerFactory<WeatherBloc>(() => mockWeatherBloc);
    provideDummy<WeatherBlocState>(const WeatherBlocInitialState());
  });

  group('$WeatherPage', () {
    const tCity = 'Berlin';

    final List<WeatherViewModel> tDailyWeatherViewModelList =
        createTestWeatherViewModelList();
    final tPopulatedState = WeatherBlocPopulatedState(
      selectedWeatherDay: tDailyWeatherViewModelList.first,
      dailyWeatherList: tDailyWeatherViewModelList,

      selectedTemperatureUnit: TemperatureUnit.celsius,
      cityName: tCity,
    );

    testWidgets(
      'WHEN $WeatherPage is visible THEN display a $FloatingActionButton',
      (tester) async {
        /// arrange
        when(mockWeatherBloc.state).thenReturn(tPopulatedState);
        when(
          mockWeatherBloc.stream,
        ).thenAnswer((_) => Stream.value(tPopulatedState));

        /// act
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(MaterialApp(home: WeatherPage()));
        });

        /// assert
        expect(find.byType(FloatingActionButton), findsOne);
      },
    );

    testWidgets(
      'WHEN bloc state is $WeatherBlocPopulatedState THEN display $WeatherPagePopulatedStateWidget',
      (tester) async {
        /// arrange
        when(mockWeatherBloc.state).thenReturn(tPopulatedState);
        when(
          mockWeatherBloc.stream,
        ).thenAnswer((_) => Stream.value(tPopulatedState));

        /// act
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(MaterialApp(home: WeatherPage()));
        });

        final widgetFinder = find.byType(WeatherPagePopulatedStateWidget);

        /// assert
        expect(widgetFinder, findsOne);
      },
    );

    final tErrorState = WeatherBlocErrorState(
      failure: FetchWeatherForecastCityNotFoundFailure(
        FailureMessages.cityNotFoundError,
      ),
      cityName: tCity,
    );

    testWidgets(
      'WHEN bloc state is $WeatherBlocErrorState THEN display $WeatherPageErrorStateWidget',
      (tester) async {
        /// arrange
        when(mockWeatherBloc.state).thenReturn(tErrorState);
        when(
          mockWeatherBloc.stream,
        ).thenAnswer((_) => Stream.value(tErrorState));

        /// act
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(MaterialApp(home: WeatherPage()));
        });

        /// assert
        expect(find.byType(WeatherPageErrorStateWidget), findsOne);
      },
    );

    const tLoadingState = WeatherBlocLoadingState();

    testWidgets(
      'WHEN bloc state is $WeatherBlocLoadingState THEN display $WeatherPageLoadingStateWidget',
      (tester) async {
        /// arrange
        when(mockWeatherBloc.state).thenReturn(tLoadingState);
        when(
          mockWeatherBloc.stream,
        ).thenAnswer((_) => Stream.value(tLoadingState));

        /// act
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(MaterialApp(home: WeatherPage()));
        });

        /// assert
        expect(find.byType(WeatherPageLoadingStateWidget), findsOne);
      },
    );
  });
}
