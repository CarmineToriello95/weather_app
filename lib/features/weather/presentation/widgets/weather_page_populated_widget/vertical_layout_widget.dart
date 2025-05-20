import 'package:flutter/material.dart';

class VerticalLayoutWidget extends StatelessWidget {
  final Widget titleWidget;
  final Widget headerWidget;
  final Widget imageWidget;
  final Widget metricsWidget;
  const VerticalLayoutWidget({
    super.key,
    required this.titleWidget,
    required this.headerWidget,
    required this.imageWidget,
    required this.metricsWidget,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        Center(child: titleWidget),
        headerWidget,
        Center(child: imageWidget),
        metricsWidget,
      ],
    ),
  );
}
