import 'package:flutter/material.dart';

class WeatherPageErrorStateWidget extends StatelessWidget {
  final String errorMessage;
  final String buttonText;
  final VoidCallback onButtonPressed;
  const WeatherPageErrorStateWidget({
    super.key,
    required this.errorMessage,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 50),
        const SizedBox(height: 16.0),
        Text(
          errorMessage,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(onPressed: onButtonPressed, child: Text(buttonText)),
      ],
    ),
  );
}
