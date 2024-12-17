import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_assets.dart';
import 'package:weather_app/providers/weather_provider.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor , 
      body: FutureBuilder(
        future: weatherProvider.initializeApp(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset(
                AppAssets.weather,
                width: 150, 
                height: 150, 
              ),
            );
          }
          return Container(); 
        },
      ),
    );
  }
}
