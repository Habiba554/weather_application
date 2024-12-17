import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget webLayout;

  const ResponsiveLayout({
    required this.mobileLayout,
    required this.tabletLayout,
    required this.webLayout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Semantics(label:"mobile layout", liveRegion: true,  hint: "You are viewing the mobile version of the application", child: mobileLayout);
        } else if (constraints.maxWidth < 1024) {
          return Semantics(label:"Tablet layout",liveRegion:true,  hint: "You are viewing the Tablet version of the application", child: tabletLayout);
        } else {
          return Semantics(label:"Web Layout",  hint: "You are viewing the Web version of the application", liveRegion: true,child: webLayout);
        }
      },
    );
  }
}
