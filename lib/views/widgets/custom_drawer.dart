import 'package:flutter/material.dart';
import 'package:weather_app/services/other_services.dart';
import 'package:weather_app/views/widgets/sidebar.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, this.onTap, this.currentIndex});
  final ValueChanged<int>? onTap;
  final int? currentIndex;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    OtherServices services = OtherServices();
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
        ),
      ),
      backgroundColor: theme.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: mediaQuery.size.height * 0.08),
          const Divider(
            thickness: 1,
            color: Color.fromARGB(255, 199, 198, 198),
            height: 0,
            indent: 15,
            endIndent: 15,
          ),
          SizedBox(height: mediaQuery.size.height * 0.03),
          MediaQuery.sizeOf(context).width>1024?SideBar(currentIndex: currentIndex, theme: theme, onTap: onTap):const SizedBox.shrink(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/facebook.png',
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () =>
                      services.openUrl("https://www.facebook.com/cookdooreg/"),
                  tooltip: "Open Facebook page",
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/images/gmail.png',
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () =>
                      services.openUrl("mailto:habibayasser55@gmail.com"),
                  tooltip: "Open Email Page",
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/images/twitter.png',
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () =>
                      services.openUrl("https://x.com/cookdooralex?lang=bn"),
                  tooltip: "Open Twitter Page",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


