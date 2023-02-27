import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Responsive/mobilescreen.dart';
import 'package:instagram/Responsive/responsive.dart';
import 'package:instagram/Responsive/webscreen.dart';
import 'package:instagram/Screens/Signupscreen.dart';
import 'package:instagram/Screens/loginscreen.dart';
import 'package:instagram/Utilites/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        //options: FirebaseOptions(apiKey: apiKey, appId: appId, messagingSenderId: messagingSenderId, projectId: projectId)
        );
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

      home: const LoginScreen(),

      //Responsive(web: WebScreen(), mobile: MobileScreen()),
    );
  }
}
