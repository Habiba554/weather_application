import 'package:weather_app/models/clouds.dart';
import 'package:weather_app/models/coord.dart';
import 'package:weather_app/models/data_weather.dart';
import 'package:weather_app/models/main_weather.dart';
import 'package:weather_app/models/sys.dart';
import 'package:weather_app/models/wind.dart';


class CurrentWeatherData {
  final String? dtTxt;
  final Coord? coord;
  final List<DataWeather>? weather;
  final String? base;
  final MainWeather? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  CurrentWeatherData(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod,this.dtTxt, });

  factory CurrentWeatherData.fromJson(dynamic json) {
    if (json == null) {
      return CurrentWeatherData();
    }

    return CurrentWeatherData(
      dtTxt: json['dt_txt'],
      coord: Coord.fromJson(json['coord']),
      weather: (json['weather'] as List)
              .map((w) => DataWeather.fromJson(w))
              .toList() ,
      base: json['base'],
      main: MainWeather.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}