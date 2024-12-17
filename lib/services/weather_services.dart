import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/five_days_data.dart';

class WeatherServices {
  String baseurl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = 'c3bd07bb497d387193fbe4bcb06b5ce5';

  Future<CurrentWeatherData> getCurrentWeather(
      {required double lat, required double lon,required String lang}) async {
    final response = await http
        .get(Uri.parse('$baseurl/weather?lat=$lat&lon=$lon&lang=$lang&appid=$apiKey'));
    if (response.statusCode == 200) {
      return CurrentWeatherData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception(
          'There is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<CurrentWeatherData> getCurrentWeatherByCityName(
      {required String cityName,required String lang}) async {
    final response =
        await http.get(Uri.parse('$baseurl/weather?q=$cityName&lang=$lang&appid=$apiKey'));
    if (response.statusCode == 200) {
      return CurrentWeatherData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception(
          'There is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<FiveDaysData> getWeatherForecast({required String cityName,required String lang}) async {
    final url = Uri.parse("$baseurl/forecast?q=$cityName&lang=$lang&appid=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return FiveDaysData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception(
          "Failed to load weather data: ${response.statusCode}, ${response.reasonPhrase}");
    }
  }

  String getDeviceLanguage(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    return currentLocale.languageCode; 
}
}
