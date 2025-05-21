import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_error_state_widget.dart';

void main() {
  testWidgets(
    'WHEN  $WeatherPageErrorStateWidget is visible THEN show a message and a button with the provided data',
    (tester) async {
      /// arrange
      const tErrorMessage = 'error message';
      const tButtonText = 'button';
      void onButtonPressed() {}

      /// act
      await tester.pumpWidget(
        MaterialApp(
          home: WeatherPageErrorStateWidget(
            errorMessage: tErrorMessage,
            buttonText: tButtonText,
            onButtonPressed: onButtonPressed,
          ),
        ),
      );

      /// arrange
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Text && widget.data == tErrorMessage,
        ),
        findsOne,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is ElevatedButton &&
              widget.onPressed != null &&
              widget.child is Text &&
              (widget.child as Text).data == tButtonText,
        ),
        findsOne,
      );
    },
  );
}
