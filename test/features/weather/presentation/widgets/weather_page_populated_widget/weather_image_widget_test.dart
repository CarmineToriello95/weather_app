import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_image_widget.dart';

void main() {
  testWidgets(
    'WHEN $WeatherImageWidget is visible THEN display expected widget with provided data',
    (tester) async {
      /// arrange
      const tIconPath = 'iconPath';

      /// act
      await mockNetworkImagesFor(
        () async => await tester.pumpWidget(
          MaterialApp(home: WeatherImageWidget(imagePath: tIconPath)),
        ),
      );

      /// assert
      expect(
        find.byWidgetPredicate((widget) {
          if (widget is Image && widget.image is NetworkImage) {
            final networkImage = widget.image as NetworkImage;
            return networkImage.url == tIconPath &&
                widget.loadingBuilder != null &&
                widget.errorBuilder != null;
          }
          return false;
        }),
        findsOne,
      );
    },
  );
}
