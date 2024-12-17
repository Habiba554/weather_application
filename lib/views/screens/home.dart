import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/views/screens/filter_screen.dart';
import 'package:weather_app/views/screens/home_screen.dart';
import 'package:weather_app/views/screens/search_screen.dart';
import 'package:weather_app/views/widgets/bottom_navigation_bar.dart';
import 'package:weather_app/views/widgets/custom_drawer.dart';
import 'package:weather_app/views/widgets/navigation_rail.dart';

import '../widgets/custom_appBar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> screens = [
    const HomeBody(),
    const SearchScreen(),
    const FilterScreen(cityName: 'Cairo',),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> appTitle = [
      context.translate(AppStrings.home),
      context.translate(AppStrings.search),
      context.translate(AppStrings.filter),
    ];
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: screenWidth < 1024 ? const CustomDrawer() : null,
      backgroundColor: theme.primaryColor,
      appBar: CustomAppBar(
        title: appTitle[_currentIndex],
        currentIndex: _currentIndex,
      ),
      body:  screenWidth<600?screens[_currentIndex]:(screenWidth>600 && screenWidth<1024)?Row(children: [
          CustomNavigationRail(onTap: _onTap, currentIndex: _currentIndex),
          Expanded(
            flex: 3,
            child: screens[_currentIndex])
      ],):Row(children: [
          CustomDrawer(currentIndex:_currentIndex,onTap: _onTap,),
          Expanded(
            flex: 3,
            child: screens[_currentIndex]),
      ],),
      bottomNavigationBar: screenWidth<600?CustomBottomNavBar(onTap: _onTap, currentIndex: _currentIndex):null,
    );
  }
}
