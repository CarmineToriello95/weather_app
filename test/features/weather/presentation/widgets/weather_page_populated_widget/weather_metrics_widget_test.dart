import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_metrics_widget.dart';

void main() {
  testWidgets(
    'WHEN $WeatherMetricsWidget is visible THEN display the provided data ',
    (testers) async {
      /// arrange
      const tTemperature = '10°';
      const tPressure = '4 hPa';
      const tHumidity = '3%';
      const tWind = '7 km/h';
      const tCityName = 'Berlin';

      /// act
      await testers.pumpWidget(
        MaterialApp(
          home: WeatherMetricsWidget(
            temperature: tTemperature,
            pressure: tPressure,
            humidity: tHumidity,
            wind: tWind,
            cityName: tCityName,
          ),
        ),
      );

      /// assert
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text && (widget.data?.contains(tCityName) ?? false),
        ),
        findsOne,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text && (widget.data?.contains(tTemperature) ?? false),
        ),
        findsOne,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.data?.contains(tPressure.toString()) ?? false),
        ),
        findsOne,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.data?.contains(tHumidity.toString()) ?? false),
        ),
        findsOne,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.data?.contains(tWind.toString()) ?? false),
        ),
        findsOne,
      );
    },
  );
}
