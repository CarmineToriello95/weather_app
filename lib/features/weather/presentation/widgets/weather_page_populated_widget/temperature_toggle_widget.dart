import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';

class TemperatureToggleWidget extends StatelessWidget {
  final TemperatureUnit selectedTemperatureUnit;
  final Function(TemperatureUnit) onSelectedTemperatureUnit;
  const TemperatureToggleWidget({
    super.key,
    required this.selectedTemperatureUnit,
    required this.onSelectedTemperatureUnit,
  });

  @override
  Widget build(BuildContext context) => ToggleButtons(
    constraints: BoxConstraints(minHeight: 32.0),
    isSelected: [
      selectedTemperatureUnit == TemperatureUnit.celsius,
      selectedTemperatureUnit == TemperatureUnit.fahrenheit,
    ],
    onPressed:
        (index) => onSelectedTemperatureUnit(TemperatureUnit.values[index]),
    borderRadius: BorderRadius.circular(20),
    borderColor: Colors.blue.shade200,
    fillColor: Colors.blue.shade200,
    borderWidth: 2,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(TemperatureUnit.celsius.symbol),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(TemperatureUnit.fahrenheit.symbol),
      ),
    ],
  );
}
