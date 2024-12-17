import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/app_routes.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/five_days_data.dart';
import 'package:weather_app/services/location_file.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherProvider extends ChangeNotifier {
  CurrentWeatherData? currentWeatherData;
  Position? currentPosition;
  FiveDaysData? weatherData;
  Set<String> uniqueDates = {};
  String? selectedDate;
  List<CurrentWeatherData> filteredList = [];
  String deviceLanguage='en';

  
  //Splash screen
  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    deviceLanguage = WeatherServices().getDeviceLanguage(context);
    Navigator.pushNamed(context, Routes.loginRoute);
  }

  //Home screen
  Future<void> initializeDataToGetLocation() async {
    try {
      currentPosition = await LocationFile().determinePosition();
      currentWeatherData = await WeatherServices().getCurrentWeather(
        lat: currentPosition!.latitude,
        lon: currentPosition!.longitude, lang: deviceLanguage,
      );
      notifyListeners();
    } catch (e) {
      // throw ("Error fetching location or weather data: $e");
    }
  }
  
  //Search screen
  Future<void> fetchWeatherByCityName(String cityName) async {
    try {
      currentWeatherData = await WeatherServices()
          .getCurrentWeatherByCityName(cityName: cityName,lang: deviceLanguage,);
      notifyListeners();
    } catch (e) {
      currentWeatherData = null;
      notifyListeners();
    }
  }

  //filter screen
    Future<void> fetchWeatherForecast(String cityName) async {
    try {
      weatherData = await WeatherServices().getWeatherForecast(cityName: cityName,lang: deviceLanguage,);
      _extractUniqueDates();
      notifyListeners();
    } catch (e) {
      throw ('Error fetching weather data: $e');
    }
  }

  void _extractUniqueDates() {
    uniqueDates.clear();
    for (var item in weatherData!.list) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(item.dtTxt!));
      uniqueDates.add(formattedDate);
    }
  }

  void filterByDate(String date) {
    if (weatherData == null) return;

    filteredList = weatherData!.list
        .where((item) => item.dtTxt!.startsWith(date))
        .toList();
    selectedDate = date;
    notifyListeners();
  }


}
