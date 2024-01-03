import 'package:flutter/material.dart';
import '../../additional_info_item.dart';
import '../../hourly_forecast_card_item.dart';
import '../../title_text_widget.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key, required  this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style:  TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions:  [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.refresh)
          )
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "300.67 F",
                        style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 8),
                      Icon(Icons.cloud, size: 60),
                      SizedBox(height: 8),
                      Text(
                          "Rain",
                          style: TextStyle(
                          fontSize: 32
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const TextTitleWidget(title: "Weather Forecast"),
            const SizedBox(height:  16),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecastCardItem(time: "09:00", temperature: "7.67", icon: Icons.cloud),
                  HourlyForecastCardItem(time: "10:00", temperature: "7.69", icon: Icons.cloud),
                  HourlyForecastCardItem(time: "11:00", temperature: "6.67", icon: Icons.cloud),
                  HourlyForecastCardItem(time: "12:00", temperature: "5.67", icon: Icons.cloud),
                  HourlyForecastCardItem(time: "01:00", temperature: "7.70", icon: Icons.cloud),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const TextTitleWidget(title: "Additional Information"),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(icon: Icons.water_drop, forecastTitle: "Humidity", forecast: "94",),
                AdditionalInfoItem(icon: Icons.air, forecastTitle: "Wind Speed", forecast: "7.67"),
                AdditionalInfoItem(icon: Icons.beach_access, forecastTitle: "Pressure", forecast: "1006"),
              ],
            )
          ]
        ),
      )
    );
  }

}
