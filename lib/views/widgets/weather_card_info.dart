import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/current_weather.dart';

class WeatherCardInformation extends StatelessWidget {
  const WeatherCardInformation({
    super.key, required this.weatherData,
  });

   final CurrentWeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      height: mediaQuery.size.height * 0.4,
      child: Card(
        color: theme.indicatorColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    label: "City Name",
                    child: Center(
                      child: Text(
                        '${weatherData.name}'.toUpperCase(),
                        style: AppStyle.poppins400style16
                            .copyWith(color: theme.textTheme.bodyLarge?.color),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      DateFormat()
                          .add_MMMMEEEEd()
                          .format(DateTime.now()),
                      style: AppStyle.poppins400style14
                          .copyWith(color: theme.textTheme.bodyLarge?.color),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: theme.textTheme.bodyLarge?.color,
              height: 0,
              indent: 15,
              endIndent: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text(
                        '${weatherData.weather![0].description}',
                        style: AppStyle.poppins400style14
                            .copyWith(color: theme.textTheme.bodyLarge?.color),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '${(weatherData.main!.temp! - 273.15).round().toString()}\u2103',
                        style: AppStyle.poppins400style14
                            .copyWith(color: theme.textTheme.bodyLarge?.color),
                      ),
                      Text(
                        'min: ${(weatherData.main!.tempMin! - 273.15).round().toString()}\u2103 / max: ${(weatherData.main!.tempMax! - 273.15).round().toString()}\u2103',
                        style: AppStyle.poppins400style14
                            .copyWith(color: theme.textTheme.bodyLarge?.color),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'wind ${weatherData.wind!.speed} m/s',
                        style: AppStyle.poppins400style12
                            .copyWith(color: theme.textTheme.bodyLarge?.color),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}