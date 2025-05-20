import 'package:flutter/material.dart';

class HorizontalLayoutWidget extends StatelessWidget {
  final Widget titleWidget;
  final Widget headerWidget;
  final Widget imageWidget;
  final Widget metricsWidget;
  const HorizontalLayoutWidget({
    super.key,
    required this.titleWidget,
    required this.headerWidget,
    required this.imageWidget,
    required this.metricsWidget,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Column(
      children: [
        Center(child: titleWidget),
        headerWidget,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [imageWidget, metricsWidget],
        ),
      ],
    ),
  );
}
