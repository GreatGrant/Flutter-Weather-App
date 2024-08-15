import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/widgets/title_text_widget.dart';

import 'additional_info_row.dart';
import 'hourly_foroecast_list.dart';

class WeatherDisplay extends StatelessWidget {
  final Map<String, dynamic> data;

  const WeatherDisplay({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final currentTemperature = data["list"][0]["main"]["temp"];
    final weatherCondition = data["list"][0]["weather"][0]["main"];
    final currentPressure = data["list"][0]["main"]["pressure"].toString();
    final currentWindSpeed = data["list"][0]["wind"]["speed"].toString();
    final currentHumidity = data["list"][0]["main"]["humidity"].toString();
    final forecastList = data['list'] as List<dynamic>;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '$currentTemperature K'zz, // Actual temperature
                        style: const TextStyle(
                            fontSize: 33, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Icon(Icons.cloud, size: 60), // Static icon
                      const SizedBox(height: 8),
                      Text(
                          "$weatherCondition", // Actual weather condition
                          style: const TextStyle(fontSize: 32))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const TextTitleWidget(title: "Weather Forecast"),
            const SizedBox(height: 16),
            HourlyForecastList(forecastData: forecastList.map((e) => e as Map<String, dynamic>).toList(),
            ),
            const SizedBox(height: 20),
            const TextTitleWidget(title: "Additional Information"),
            const SizedBox(height: 20),
            AdditionalInfoRow(
              currentPressure: currentPressure,
              currentWindSpeed: currentWindSpeed,
              currentHumidity: currentHumidity
            ),
          ]),
    );
  }
}
