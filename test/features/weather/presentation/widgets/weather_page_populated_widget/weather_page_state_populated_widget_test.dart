import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc_state.dart';
import 'package:weather_app/features/weather/presentation/models/weather_view_model.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_header_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_image_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_metrics_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_page_populated_state_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_tile_widget.dart';

import '../../../../../core/helpers/model_generators.dart';

void main() {
  testWidgets(
    'WHEN $WeatherPagePopulatedStateWidget is visible THEN display the expected widgets with the provided data',
    (tester) async {
      /// arrange
      const tCity = 'Berlin';
      final dailyWeatherList = createTestWeatherViewModelList();
      final tPopulatedState = WeatherBlocPopulatedState(
        selectedWeatherDay: dailyWeatherList.first,
        dailyWeatherList: dailyWeatherList,
        selectedTemperatureUnit: TemperatureUnit.celsius,
        cityName: tCity,
      );

      void onSelectedTemperatureUnit(TemperatureUnit selectedUnit) {}
      void onSelectedWeatherDay(WeatherViewModel selectedWeatherDay) {}
      Future<void> onRefresh() async {}

      /// act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherPagePopulatedStateWidget(
              state: tPopulatedState,
              onSelectedWeatherDay: onSelectedWeatherDay,
              onSelectedUnit: onSelectedTemperatureUnit,
              onRefresh: onRefresh,
            ),
          ),
        ),
      );

      /// assert
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is WeatherHeaderWidget &&
              widget.weatherCondition ==
                  tPopulatedState.selectedWeatherDay.weatherCondition &&
              widget.onSelectedTemperatureUnit == onSelectedTemperatureUnit &&
              widget.selectedTemperatureUnit ==
                  tPopulatedState.selectedTemperatureUnit,
        ),
        findsOne,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is WeatherImageWidget &&
              widget.imagePath ==
                  tPopulatedState.selectedWeatherDay.largeIconPath,
        ),
        findsOne,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is WeatherMetricsWidget &&
              widget.cityName == tPopulatedState.cityName &&
              widget.temperature ==
                  tPopulatedState.selectedWeatherDay.formattedTemperature(
                    TemperatureUnit.celsius,
                  ) &&
              widget.humidity ==
                  tPopulatedState.selectedWeatherDay.humidityWithPercentage &&
              widget.wind == tPopulatedState.selectedWeatherDay.windWithUnit &&
              widget.pressure ==
                  tPopulatedState.selectedWeatherDay.pressureWithUnit,
        ),
        findsOne,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is RefreshIndicator && widget.onRefresh == onRefresh,
        ),
        findsOne,
      );

      expect(find.byType(ListView), findsOne);
      expect(
        find.byType(WeatherTileWidget),
        findsNWidgets(tPopulatedState.dailyWeatherList.length),
      );
    },
  );
}
