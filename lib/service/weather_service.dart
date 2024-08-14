import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService{
  static Future<Map<String, dynamic>?> fetchCurrentWeather(String cityName) async {
    try {
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
}