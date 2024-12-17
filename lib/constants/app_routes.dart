import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app/views/screens/home.dart';
import 'package:weather_app/views/screens/login_screen.dart';
import 'package:weather_app/views/screens/report_screen.dart';
import 'package:weather_app/views/screens/search_screen.dart';
import 'package:weather_app/views/screens/signup_screen.dart';
import 'package:weather_app/views/screens/splash_screen.dart';


class Routes {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String signUpRoute = '/signUp';
  static const String searchRoute = '/search';
  static const String reportRoute='/report';

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_){
              SemanticsService.announce(
              "Splash Screen Loaded Please wait",
              TextDirection.ltr,
              );
            });
        return const SplashScreen();
          },
        );
      case loginRoute:
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SemanticsService.announce(
                "Login Screen. Enter your credentials to log in.",
                TextDirection.ltr,
              );
            });
            return  LoginScreen();
          },
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SemanticsService.announce(
                "Home Screen loaded. Navigate through the app using the bottom navigation bar.",
                TextDirection.ltr,
              );
            });
            return const HomeScreen();
          },
        );

      case signUpRoute:
        return MaterialPageRoute(
          builder: (context) =>  SignupScreen(),
        );
      case searchRoute:
        return MaterialPageRoute(builder: (context) => const SearchScreen());
      case reportRoute:
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SemanticsService.announce(
                "Report Screen loaded.",
                TextDirection.ltr,
              );
            });
            return  ReportScreen();
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SemanticsService.announce(
                "Home Screen loaded. Default navigation.",
                TextDirection.ltr,
              );
            });
            return  HomeScreen();
          },
        );
    }
  }
  }