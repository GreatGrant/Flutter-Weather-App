import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../additional_info_item.dart';
import '../../hourly_forecast_card_item.dart';
import '../../title_text_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key, required  this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State<HomePage>{
  double temperature = 0;

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async{

    try{

      const String cityName = "Abuja,ng";
      const String urlEndPoint = "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=905be606ab1e153bf7a8bbe63b590b3d";

      final res = await http.get(
          Uri.parse(urlEndPoint)
      );

      final data = jsonDecode(res.body);

        if(res.statusCode == 200){
          setState(() {
            temperature = data['list'][0]['main']['temp'];
          });

        }else{
          throw http.ClientException("Error: ${res.statusCode}");
        }

    } catch (e){
        if (kDebugMode) {
          print("an error occurred: $e");
        }
    }
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style:  const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions:  [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.refresh)
          )
        ],
      ),
      body:  SafeArea(
        child: Padding(
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          '$temperature K',
                          style: const TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Icon(Icons.cloud, size: 60),
                        const SizedBox(height: 8),
                        const Text(
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
                    HourlyForecastCardItem(time: "11:00", temperature: "20.67", icon: Icons.sunny),
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
        ),
      )
    );
  }

}
