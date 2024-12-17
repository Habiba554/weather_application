import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_routes.dart';
import 'package:weather_app/constants/app_theme.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:weather_app/providers/user_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/user_authentication.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await UserAuthentication().initNotifications();
  runApp(
    MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (_) => WeatherProvider(),),
          ChangeNotifierProvider(create: (_) => UserProvider(),
          ),
      ],
      child: const MyApp()
    ));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: Routes.getRoute,
      initialRoute: Routes.splashRoute,
      debugShowCheckedModeBanner: false,
      theme: MyAppThemes.lightTheme,
      darkTheme: MyAppThemes.darkTheme,
      themeMode: ThemeMode.system,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates:  [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocal, supportedLocales) {
        for (var local in supportedLocales) {
          if (deviceLocal != null &&
              local.languageCode == deviceLocal.languageCode) {
            return deviceLocal;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
