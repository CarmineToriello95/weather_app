import 'package:flutter/material.dart';

class WeatherImageWidget extends StatelessWidget {
  final String imagePath;
  const WeatherImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) => Image.network(
    imagePath,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;

      return Center(
        child: CircularProgressIndicator(
          value:
              loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return Center(child: Icon(Icons.broken_image_outlined, size: 64));
    },
  );
}
