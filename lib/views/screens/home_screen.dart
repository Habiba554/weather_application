import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/views/widgets/weather_card_info.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ChangeNotifierProvider(
          create: (_) => WeatherProvider()..initializeDataToGetLocation(),
          child: Center(
            child: Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.currentWeatherData != null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WeatherCardInformation(
                        weatherData: weatherProvider.currentWeatherData!),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          )),
    );
  }
}
