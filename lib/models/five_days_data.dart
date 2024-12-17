import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/current_weather.dart';

class FiveDaysData {
  final String cod;
  final int message;
  final int cnt;
  final List<CurrentWeatherData> list;
  final City city;

  FiveDaysData({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory FiveDaysData.fromJson(Map<String, dynamic> json) {
    return FiveDaysData(
      cod: json['cod'] as String,
      message: json['message'] as int,
      cnt: json['cnt'] as int,
      list: (json['list'] as List)
          .map((item) => CurrentWeatherData.fromJson(item))
          .toList(),
      city: City.fromJson(json['city']),
    );
  }
}