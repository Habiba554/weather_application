import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_strings.dart';

class CustomNavigationRail extends StatelessWidget {
  const CustomNavigationRail({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });
  final ValueChanged<int> onTap;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 105, 
      decoration: BoxDecoration(
        color: theme.primaryColor,
      ),
      child: Semantics(
                  label:"Main navigation bar to switch between home, search and watchlist screen",
        child: NavigationRail(
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          backgroundColor: theme.primaryColor,
          selectedIconTheme: IconThemeData(
            color: theme.bottomNavigationBarTheme.selectedItemColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: theme.bottomNavigationBarTheme.unselectedItemColor,
          ),
          selectedLabelTextStyle: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
          ),
          labelType: NavigationRailLabelType.selected,
          destinations:  [
            NavigationRailDestination(
              icon: const Icon(Icons.home_filled),
              label: Text(context.translate(AppStrings.home)),  
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.search),
              label: Text(context.translate(AppStrings.search)),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.bookmark_border),
              label: Text(context.translate(AppStrings.filter)),
            ),
          ],
        ),
      ),
    );
  }
}