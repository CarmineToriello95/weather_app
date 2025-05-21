import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/temperature_toggle_widget.dart';

void main() {
  testWidgets(
    'WHEN $TemperatureToggleWidget is visible THEN display expected widgets with provided data',
    (tester) async {
      /// act
      await tester.pumpWidget(
        MaterialApp(
          home: TemperatureToggleWidget(
            selectedTemperatureUnit: TemperatureUnit.celsius,
            onSelectedTemperatureUnit: (selectedTemperatureUnit) {},
          ),
        ),
      );

      /// assert
      expect(
        find.byWidgetPredicate(
          (widget) => widget is ToggleButtons && widget.onPressed != null,
        ),
        findsOne,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text && widget.data == TemperatureUnit.celsius.symbol,
        ),
        findsOne,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data == TemperatureUnit.fahrenheit.symbol,
        ),
        findsOne,
      );
    },
  );
}
