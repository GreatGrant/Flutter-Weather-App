import 'package:flutter/material.dart';
import 'hourly_forecast_card_item.dart';

class HourlyForecastList extends StatelessWidget {
  final List<Map<String, dynamic>?> forecastData;

  const HourlyForecastList({super.key, required this.forecastData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: forecastData.map((entry) {
          final time = entry?['dt_txt']; // or format this as needed
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
        }).toList(),
      ),
    );
  }
}
