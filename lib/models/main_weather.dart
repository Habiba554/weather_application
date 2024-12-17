class MainWeather {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int? pressure;
  final int? humidity;

  MainWeather(
      { required this.temp,
       required this.feelsLike,
       required this.tempMin,
      required this.tempMax,
      this.pressure,
      this.humidity});

  factory MainWeather.fromJson(dynamic json) {
    if (json == null) {
      return MainWeather(temp: 0.0, feelsLike: 0.0, tempMin: 0.0, tempMax: 0.0);
    }

    return MainWeather(
      temp: (json['temp'] is num) ? (json['temp'] as num).toDouble() : 0.0,
      feelsLike: (json['feels_like'] is num) ? (json['feels_like'] as num).toDouble() : 0.0,
      tempMin: (json['temp_min'] is num) ? (json['temp_min'] as num).toDouble() : 0.0,
      tempMax: (json['temp_max'] is num) ? (json['temp_max'] as num).toDouble() : 0.0,
      pressure: json['pressure'] != null ? json['pressure'] as int : null,
      humidity: json['humidity'] != null ? json['humidity'] as int : null,
    );
  }
}