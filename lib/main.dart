import 'package:flutter/material.dart';
import 'package:instagram/Responsive/mobilescreen.dart';
import 'package:instagram/Responsive/responsive.dart';
import 'package:instagram/Responsive/webscreen.dart';
import 'package:instagram/Screens/Signupscreen.dart';
import 'package:instagram/Screens/loginscreen.dart';
import 'package:instagram/Utilites/colors.dart';

void main() {
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

      home: SignUpScreen(),

      //Responsive(web: WebScreen(), mobile: MobileScreen()),
    );
  }
}
