import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instagram/Responsive/webscreen.dart';
import 'package:instagram/Screens/Signupscreen.dart';
import 'package:instagram/Screens/homescreen.dart';
import 'package:instagram/Utilites/Textfield.dart';
import 'package:instagram/Utilites/colors.dart';
import 'package:instagram/connection/Authentication.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isloading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  loginscreen() async {
    String email = emailController.text;
    String password = passwordController.text;
    setState(() {
      _isloading = true;
    });
    String res =
        await AuthMethod().LoginScreeen(email: email, password: password);
    if (res == "Success") {
    setState(() {
      _isloading = false;
    });
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>WebScreen()));
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child:Container(
      padding:MediaQuery.of(context).size.width>600?  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/3):
      const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Flexible(flex: 2, child: Container()),
//         Container(
//           height: 200,
//           width: 200,
//           child: Image(
//             image: 
// //"https://images.unsplash.com/photo-1611262588024-d12430b98920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"
// ), fit: BoxFit.fill,
//           ),
        SvgPicture.asset('assets/images/ic_instagram.svg'),
        const SizedBox(height: 24),
        TextField1(
          textedittingcontroller: emailController,
          hinttext: "Enter your Email",
          textinputtype: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 24,
        ),
        TextField1(
          textedittingcontroller: passwordController,
          hinttext: "Enter your Password",
          textinputtype: TextInputType.text,
          ispass: true,
        ),
        const SizedBox(
          height: 24,
        ),
        InkWell(
          onTap: () {
            loginscreen();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              color: Colors.blue,
            ),
            child: _isloading != false
                ? const Center(
                    child: CircularProgressIndicator(color: primaryColor))
                : const Text("Log In"),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: const Text("Do you have an account?"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignUpScreen())
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: const Text(
                  "Sign in ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ]),
    )));
  }
}

 
