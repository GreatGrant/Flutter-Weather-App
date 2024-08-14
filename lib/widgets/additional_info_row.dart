import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'additional_info_item.dart';

class AdditionalInfoRow extends StatelessWidget {
  final String currentPressure;
  final String currentWindSpeed;
  final String currentHumidity;

  const AdditionalInfoRow({
    super.key,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AdditionalInfoItem(
          icon: Icons.water_drop,
          forecastTitle: "Humidity",
          forecast: currentHumidity,
        ),
        AdditionalInfoItem(
            icon: Icons.air, forecastTitle: "Wind Speed", forecast: currentWindSpeed),
        AdditionalInfoItem(
            icon: Icons.beach_access, forecastTitle: "Pressure", forecast: currentPressure),
      ],
    );
  }
}