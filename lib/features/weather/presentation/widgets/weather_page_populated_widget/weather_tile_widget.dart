import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_image_widget.dart';

class WeatherTileWidget extends StatelessWidget {
  final String day;
  final String imagePath;
  final String temperatureRange;
  final bool isSelected;
  final VoidCallback onTap;

  const WeatherTileWidget({
    super.key,
    required this.day,
    required this.imagePath,
    required this.temperatureRange,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.blue.shade200, width: 2),
      color: isSelected ? Colors.blue.shade200 : Colors.transparent,
    ),
    width: 140,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(day),
            WeatherImageWidget(imagePath: imagePath),
            Text(temperatureRange),
          ],
        ),
      ),
    ),
  );
}
