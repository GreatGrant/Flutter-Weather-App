import 'package:flutter/material.dart';

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
            const Text(
              "Weather Forecast",
              style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            ),
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
            Placeholder(fallbackHeight: 150),
            SizedBox(height: 20),
            Placeholder(fallbackHeight: 150)
          ]
        ),
      )
    );
  }

}

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
              Text(
                time,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
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