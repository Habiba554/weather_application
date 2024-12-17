import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class FilterScreen extends StatelessWidget {
  final String cityName;
  const FilterScreen({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchWeatherForecast(cityName);
    final theme = Theme.of(context);
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) {
        if (provider.weatherData == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Text(
              cityName,
              style: AppStyle.poppins400style14
                  .copyWith(color: theme.textTheme.bodyLarge?.color),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButton<String>(
                dropdownColor: theme.indicatorColor,
                value: provider.selectedDate,
                hint: Text(
                  context.translate(AppStrings.chooseDate),
                  style: AppStyle.poppins400style14
                      .copyWith(color: theme.secondaryHeaderColor),
                ),
                isExpanded: true,
                items: provider.uniqueDates.map((date) {
                  return DropdownMenuItem(
                    value: date,
                    child: Text(
                      date,
                      style: AppStyle.poppins400style14
                          .copyWith(color: theme.secondaryHeaderColor),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    provider.filterByDate(value);
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.filteredList.length,
                itemBuilder: (context, index) {
                  final item = provider.filteredList[index];
                  final formattedDate = DateFormat('yyyy-MM-dd HH:mm')
                      .format(DateTime.parse(item.dtTxt!));
                  return ListTile(
                    title: Text(
                      '${(item.main!.temp! - 273.15).round().toString()}\u2103',
                      style: AppStyle.poppins400style16
                          .copyWith(color: theme.secondaryHeaderColor),
                    ),
                    subtitle: Text(formattedDate,
                        style: AppStyle.poppins400style14
                            .copyWith(color: theme.secondaryHeaderColor)),
                    trailing: Text(item.weather![0].description!),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
