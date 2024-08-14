import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../service/weather_service.dart';
import '../../widgets/weather_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>?> _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = WeatherService.fetchCurrentWeather("Abuja,ng");
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
                _weatherData = WeatherService.fetchCurrentWeather("Abuja,ng");
              });
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _weatherData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error.toString()}"));
            }

            if (snapshot.hasData) {
              final data = snapshot.data!;
              if (kDebugMode) {
                print(data);
              }
              return WeatherDisplay(data: data);
            }

            return const Center(child: Text("No data available"));
          },
        ),
      ),
    );
  }
}

