import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/services/permissions.dart';
import 'package:weather_app/views/widgets/custom_button.dart';
import 'package:weather_app/views/widgets/weather_card_info.dart';
import 'package:weather_app/providers/weather_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController? cityNameController = TextEditingController();
    final theme = Theme.of(context);
    ModularPermissionManager permissionManager = ModularPermissionManager();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: cityNameController,
              onChanged: (cityName) {
                cityNameController.text = cityName;
              },
              onSubmitted: (cityName) {
                if (cityName.isNotEmpty) {
                  Provider.of<WeatherProvider>(context, listen: false)
                      .fetchWeatherByCityName(cityName);
                }
              },
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    String cityName = cityNameController.text;
                    if (cityName.isNotEmpty) {
                      Provider.of<WeatherProvider>(context, listen: false)
                          .fetchWeatherByCityName(cityName);
                    }
                  },
                  child: Icon(
                    Icons.search,
                    color: theme.iconTheme.color,
                  ),
                ),
                label: Text(context.translate(AppStrings.search)),
                hintText: context.translate(AppStrings.cityName),
                hintStyle: TextStyle(color: theme.secondaryHeaderColor),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.secondaryHeaderColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.secondaryHeaderColor)),
              ),
              style: AppStyle.poppins400style14
                  .copyWith(color: theme.textTheme.bodyLarge?.color),
              cursorColor: theme.secondaryHeaderColor,
            ),
            const SizedBox(height: 20),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.currentWeatherData != null) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        WeatherCardInformation(
                            weatherData: weatherProvider.currentWeatherData!),
                        Semantics(
                          button: true,
                          label:
                              "Download button for the movie ${weatherProvider.currentWeatherData?.name}",
                          child: CustomElevatedButton(
                            text: context.translate(AppStrings.download),
                            onPressed: () => permissionManager.downloadMovie(
                                context: context,
                                name: weatherProvider.currentWeatherData!.name!),
                            backgroundColor: theme.secondaryHeaderColor,
                            textColor: theme.primaryColor,
                          ),
                        )
                      ],
                    ),
                  );
                }
                if (cityNameController.text.isNotEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
        
                return const Center(child: Text(""));
              },
            ),
          ],
        ),
      ),
    );
  }
}
