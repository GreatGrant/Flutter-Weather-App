import 'package:flutter/material.dart';

import 'bold_title_text_widget.dart';

class HourlyForecastCardItem extends StatelessWidget {
  const HourlyForecastCardItem({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
  });

  final String time;
  final String temperature;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child:  Column(
          children: [
            BoldTitleWidget(text: time),
            const SizedBox(height: 8),
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              temperature,
            ),
          ],
        ),
      ),

    );
  }
}
