import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/user_provider.dart';
import 'layout/mobile_screen_layout.dart';
import 'layout/responsive_screen_layout.dart';
import 'layout/web_screen_layout.dart';
import 'screens/login_screen.dart';
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

//* This widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        // Removing debug banner
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        // Kepping all dark colors in the Theme
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance
              .authStateChanges(), //* User signed in or out
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                // The user has been authenticated
                return const ResponsiveScreenLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error}', //Some error occured has an error
                  ),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            //* If it hasn't any data the user needs to login
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
