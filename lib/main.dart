import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/signup_screen.dart';

import 'layout/mobile_screen_layout.dart';
import 'layout/responsive_screen_layout.dart';
import 'layout/web_screen_layout.dart';
import 'utils/colors_util.dart';

Future<void> main() async {
// !Making sure to initialize the Flutter widgets before anything
  WidgetsFlutterBinding.ensureInitialized();
  // kIsWeb is a constant that is true if the application was compiled to run on the web.
  if (kIsWeb) {
    // *Initializing Firebase for web
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCBpXigsnj9wN2PHqa7pq50mJ8mQnR3JD0',
          appId: '1:443107625071:web:ee34a0ad55d1bafda3e59a',
          messagingSenderId: '443107625071',
          projectId: 'instagram-1f034',
          storageBucket: 'instagram-1f034.appspot.com'),
    );
  } else {
    // *Initializing Firebase for mobile
    await Firebase.initializeApp();
  }

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
      /* home: const ResponsiveScreenLayout(
        webScreenLayout: WebScreenLayout(),
        mobileScreenLayout: MobileScreenLayout(),
      ), */
      home: SignUpScreen(),
    );
  }
}
