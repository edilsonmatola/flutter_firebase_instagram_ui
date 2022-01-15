import 'package:flutter/material.dart';
import '../utils/dimensions_util.dart';

class ResponsiveScreenLayout extends StatelessWidget {
  const ResponsiveScreenLayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  }) : super(key: key);

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override
  Widget build(BuildContext context) {
    // Responsive Layout
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // Web Screen
          return webScreenLayout;
        }
        // Mobile Screen
        return mobileScreenLayout;
      },
    );
  }
}
