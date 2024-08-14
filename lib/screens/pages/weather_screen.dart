import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../additional_info_item.dart';
import '../../hourly_forecast_card_item.dart';
import '../../title_text_widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<Map<String, dynamic>?> getCurrentWeather() async {
    try {
      const String cityName = "Abuja,ng";
      final String? key = dotenv.env['API_KEY']; // Fetch the API key

      if (key == null || key.isEmpty) {
        throw 'API key is missing';
      }

      final String urlEndPoint =
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$key";
      final http.Response res = await http.get(Uri.parse(urlEndPoint));

      if (res.statusCode != 200) {
        throw 'An unexpected error occurred. HTTP Status: ${res.statusCode}';
      }

      final Map<String, dynamic> data = jsonDecode(res.body);

      if (data['cod'] != "200") {
        throw 'An unexpected error occurred. API Response: ${data['cod']}';
      }

      return data;
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
      return null; // Return null or handle the error in another way
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  getCurrentWeather();
                });
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: getCurrentWeather(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                    child: Text("Error: ${snapshot.error.toString()}"));
              }

              if (snapshot.hasData) {
                final data = snapshot.data!;
                final currentTemperature = data["list"][0]["main"]["temp"];
                final weatherCondition = data["list"][0]["weather"][0]["main"];

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
                                    '$currentTemperature K', // Actual temperature
                                    style: const TextStyle(
                                        fontSize: 33,
                                        fontWeight: FontWeight.bold),
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
                        const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              HourlyForecastCardItem(
                                  time: "09:00",
                                  temperature: "7.67",
                                  icon: Icons.cloud),
                              HourlyForecastCardItem(
                                  time: "10:00",
                                  temperature: "7.69",
                                  icon: Icons.cloud),
                              HourlyForecastCardItem(
                                  time: "11:00",
                                  temperature: "20.67",
                                  icon: Icons.sunny),
                              HourlyForecastCardItem(
                                  time: "12:00",
                                  temperature: "5.67",
                                  icon: Icons.cloud),
                              HourlyForecastCardItem(
                                  time: "01:00",
                                  temperature: "7.70",
                                  icon: Icons.cloud),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const TextTitleWidget(title: "Additional Information"),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AdditionalInfoItem(
                              icon: Icons.water_drop,
                              forecastTitle: "Humidity",
                              forecast: "94",
                            ),
                            AdditionalInfoItem(
                                icon: Icons.air,
                                forecastTitle: "Wind Speed",
                                forecast: "7.67"),
                            AdditionalInfoItem(
                                icon: Icons.beach_access,
                                forecastTitle: "Pressure",
                                forecast: "1006"),
                          ],
                        )
                      ]),
                );
              }

              return const Center(child: Text("No data available"));
            },
          ),
        ));
  }
}
