import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_strings.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
    required this.currentIndex,
    required this.theme,
    required this.onTap,
  });

  final int? currentIndex;
  final ThemeData theme;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.home_filled,
           color:currentIndex==0? theme.bottomNavigationBarTheme.selectedItemColor:theme.bottomNavigationBarTheme.unselectedItemColor),
          title: Text(
            context.translate(AppStrings.home),
            style: TextStyle(color: currentIndex==0? theme.bottomNavigationBarTheme.selectedItemColor:theme.bottomNavigationBarTheme.unselectedItemColor),
          ),
          onTap: () =>onTap?.call(0),
        ),
        ListTile(
          leading: Icon(Icons.search, color: currentIndex==1? theme.bottomNavigationBarTheme.selectedItemColor:theme.bottomNavigationBarTheme.unselectedItemColor),
          title: Text(
            context.translate(AppStrings.search),
            style: TextStyle(color: currentIndex==1? theme.bottomNavigationBarTheme.selectedItemColor:theme.bottomNavigationBarTheme.unselectedItemColor),
          ),
          onTap: () =>onTap?.call(1),
        ),
        ListTile(
          leading:
              Icon(Icons.bookmark_border, color: currentIndex==2? theme.bottomNavigationBarTheme.selectedItemColor:theme.bottomNavigationBarTheme.unselectedItemColor),
          title: Text(
            context.translate(AppStrings.filter),
            style: TextStyle(color: currentIndex==2? theme.bottomNavigationBarTheme.selectedItemColor:theme.bottomNavigationBarTheme.unselectedItemColor),
          ),
          onTap: () =>onTap?.call(2),
        ),
      ],
    );
  }
}