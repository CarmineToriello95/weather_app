import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/presentation/widgets/city_search_dialog.dart';

void main() {
  testWidgets(
    'WHEN $CitySearchDialog is visible THEN show a textfield and a button ',
    (tester) async {
      /// act
      await tester.pumpWidget(MaterialApp(home: CitySearchDialog()));

      /// assert
      expect(find.byType(TextField), findsOne);
      expect(find.byType(ElevatedButton), findsOne);
    },
  );
}
