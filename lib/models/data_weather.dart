class DataWeather {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  DataWeather({this.id, this.main, this.description, this.icon});

  factory DataWeather.fromJson(dynamic json) {
    if (json == null) {
      return DataWeather();
    }

    return DataWeather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']);
  }
}