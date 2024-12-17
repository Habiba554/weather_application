import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_strings.dart';


class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar(
      {super.key, required this.onTap, required this.currentIndex});
  final ValueChanged<int> onTap;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomNavBarTheme = theme.bottomNavigationBarTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth >= 600 ? 100 : 80,
      decoration: const BoxDecoration(
        color: AppColors.blueColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 0.7),
        child: Semantics(
          label:
              "Main navigation bar to switch between home, search and watchlist screen",
          child: BottomNavigationBar(
            backgroundColor: bottomNavBarTheme.backgroundColor,
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            selectedItemColor:
                bottomNavBarTheme.selectedItemColor ?? theme.primaryColor,
            unselectedItemColor:
                bottomNavBarTheme.unselectedItemColor ?? theme.iconTheme.color,
            items: [
              BottomNavigationBarItem(
                  icon: const SizedBox(
                      width: 40, height: 40, child: Icon(Icons.home_filled)),
                  label: context.translate(AppStrings.home),
                  tooltip: "Home Navigation bar , tap to go to home "),
              BottomNavigationBarItem(
                  icon: const SizedBox(
                      width: 40, height: 40, child: Icon(Icons.search)),
                  label: context.translate(AppStrings.search),
                  tooltip:
                      "Search bottom navigation bar , tap to go to search "),
              BottomNavigationBarItem(
                  icon: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.bookmark_border)),
                  label: context.translate(AppStrings.filter),
                  tooltip:
                      "Filter bottom navigation bar , tap to go to watch list "),
            ],
          ),
        ),
      ),
    );
  }
}
