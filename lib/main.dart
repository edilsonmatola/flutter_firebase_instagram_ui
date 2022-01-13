import 'package:flutter/material.dart';
import 'layout/mobile_screen_layout.dart';
import 'layout/responsive_screen_layout.dart';
import 'layout/web_screen_layout.dart';
import 'utils/colors_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Removing debug banner
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      // Kepping all dark colors in the Theme
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: const ResponsiveScreenLayout(
        webScreenLayout: WebScreenLayout(),
        mobileScreenLayout: MobileScreenLayout(),
      ),
    );
  }
}
