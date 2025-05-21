import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/temperature_toggle_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_header_widget.dart';

void main() {
  testWidgets(
    'WHEN $WeatherHeaderWidget is visible THEN display expected widgets with provided data ',
    (tester) async {
      /// arrange
      const tWeatherCondition = 'Clouds';
      void onSelectedTemperature(TemperatureUnit temperatureUnit) {}

      /// act
      await tester.pumpWidget(
        MaterialApp(
          home: WeatherHeaderWidget(
            weatherCondition: tWeatherCondition,
            selectedTemperatureUnit: TemperatureUnit.celsius,
            onSelectedTemperatureUnit: onSelectedTemperature,
          ),
        ),
      );

      /// assert
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Text && widget.data == tWeatherCondition,
        ),
        findsOne,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TemperatureToggleWidget &&
              widget.selectedTemperatureUnit == TemperatureUnit.celsius &&
              widget.onSelectedTemperatureUnit == onSelectedTemperature,
        ),
        findsOne,
      );
    },
  );
}
