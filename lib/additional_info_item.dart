import 'package:flutter/material.dart';
import 'bold_title_text_widget.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String forecastTitle;
  final String forecast;

  const AdditionalInfoItem({
    required this.icon,
    required this.forecastTitle,
    required this.forecast,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(height: 6),
          Text(forecastTitle),
          const SizedBox(height: 6),
          BoldTitleWidget(text: forecast)
        ],
      ),
    );
  }
}
