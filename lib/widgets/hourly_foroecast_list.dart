import 'package:flutter/material.dart';

import 'hourly_forecast_card_item.dart';

class HourlyForecastList extends StatelessWidget {
  final List<Map<String, dynamic>?> forecastData;

  const HourlyForecastList({super.key, required this.forecastData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecastData.length,
        itemBuilder: (context, index) {
          final entry = forecastData[index];
          final time = entry?['dt_txt'];
          final temperature = (entry?['main']['temp'] - 273.15).toStringAsFixed(1); // Convert Kelvin to Celsius
          final weatherCondition = entry?['weather'][0]['main'];

          IconData icon;
          switch (weatherCondition) {
            case 'Rain':
              icon = Icons.cloud;
              break;
            case 'Clear':
              icon = Icons.wb_sunny;
              break;
            case 'Clouds':
              icon = Icons.cloud;
              break;
            default:
              icon = Icons.help;
          }

          return HourlyForecastCardItem(
            time: time,
            temperature: '$temperature°C',
            icon: icon,
          );
        },
      ),
    );
  }
}
