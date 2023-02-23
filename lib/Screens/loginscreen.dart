import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instagram/Utilites/Textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Flexible(flex: 2, child: Container()),
        Container(
          height: 200,
          width: 200,
          child: const Image(
            image: NetworkImage(
                "https://images.unsplash.com/photo-1611262588024-d12430b98920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
            fit: BoxFit.fill,
          ),
        ),
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
          onTap: () {},
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
            child: const Text("Log in"),
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
