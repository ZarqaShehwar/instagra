import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:instagram/Responsive/mobilescreen.dart';
import 'package:instagram/Responsive/responsive.dart';
import 'package:instagram/Responsive/webscreen.dart';
import 'package:instagram/Screens/Signupscreen.dart';
import 'package:instagram/Screens/addpostScreen.dart';
import 'package:instagram/Screens/homescreen.dart';
import 'package:instagram/Screens/loginscreen.dart';
import 'package:instagram/Utilites/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyAgTEJQgIap_SS9fmFrZiqQYQi6fOTVBnw",
      projectId: "instaa-7de2c",
      storageBucket: "instaa-7de2c.appspot.com",
      messagingSenderId: "608300252800",
      appId: "1:608300252800:web:60bed43769a42d79f67065",
    ));
  }
  runApp(const MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),

      home: const SignUpScreen(),

      //Responsive(web: WebScreen(), mobile: MobileScreen()),
    );
  }
}
