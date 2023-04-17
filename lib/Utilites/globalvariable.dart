import 'package:flutter/material.dart';
import 'package:instagram/Screens/addpostScreen.dart';
import 'package:instagram/Screens/homescreen.dart';

const homeScreen = [
  HomeScreen(),
  Text("Search"),
  AddPostScreen(),
  Text("like"),
  Text("account"),
];

ShowSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}
