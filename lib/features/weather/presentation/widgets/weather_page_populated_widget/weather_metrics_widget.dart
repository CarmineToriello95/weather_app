import 'package:flutter/material.dart';

class WeatherMetricsWidget extends StatelessWidget {
  final String temperature;
  final String pressure;
  final String humidity;
  final String wind;
  final String cityName;

  const WeatherMetricsWidget({
    super.key,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.wind,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Text(
          cityName,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      Center(child: Text(temperature, style: TextStyle(fontSize: 64.0))),
      SizedBox(height: 16.0),
      Text(humidity, style: TextStyle(fontSize: 18.0)),
      Text(pressure, style: TextStyle(fontSize: 18.0)),
      Text(wind, style: TextStyle(fontSize: 18.0)),
    ],
  );
}
