import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/temperature_toggle_widget.dart';

class WeatherHeaderWidget extends StatelessWidget {
  final String weatherCondition;
  final String iconPath;
  final TemperatureUnit selectedTemperatureUnit;
  final Function(TemperatureUnit) onSelectedTemperatureUnit;

  const WeatherHeaderWidget({
    super.key,
    required this.weatherCondition,
    required this.iconPath,
    required this.selectedTemperatureUnit,
    required this.onSelectedTemperatureUnit,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(weatherCondition, style: TextStyle(fontSize: 18.0)),
          ),
          TemperatureToggleWidget(
            selectedTemperatureUnit: selectedTemperatureUnit,
            onSelectedTemperatureUnit: onSelectedTemperatureUnit,
          ),
        ],
      ),
    ],
  );
}
