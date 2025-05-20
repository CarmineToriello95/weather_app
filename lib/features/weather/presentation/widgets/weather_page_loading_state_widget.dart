import 'package:flutter/material.dart';

class WeatherPageLoadingStateWidget extends StatelessWidget {
  const WeatherPageLoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      Center(child: CircularProgressIndicator());
}
