import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_routes.dart';
import 'package:weather_app/constants/app_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.currentIndex});

  final int? currentIndex;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      actions: [IconButton(onPressed: ()=>Navigator.pushNamed(context,Routes.reportRoute), icon: Icon(Icons.info_outline,color: theme.iconTheme.color,))],
      leading: MediaQuery.of(context).size.width < 1024
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Semantics(
                  label: "OPen drawer",
                  tooltip: "Open app drawer",
                  child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(Icons.menu, color: theme.iconTheme.color))))
          : null,
      backgroundColor: theme.primaryColor,
      title: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              maxLines: 3,
              title,
              style: AppStyle.poppins400style16
                  .copyWith(color: theme.textTheme.bodyLarge?.color)),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
