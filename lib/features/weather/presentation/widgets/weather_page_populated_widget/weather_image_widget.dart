import 'package:flutter/material.dart';

class WeatherImageWidget extends StatelessWidget {
  final String imagePath;
  const WeatherImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 200,
    child: Image.network(
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
    ),
  );
}
