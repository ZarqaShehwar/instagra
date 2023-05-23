import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/addpostScreen.dart';
import 'package:instagram/Screens/homescreen.dart';
import 'package:instagram/Screens/searchscreen.dart';
import 'package:instagram/Screens/profileScreen.dart';

var  homeScreen = [
  HomeScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("like"),
  ProfileScreen(uid:FirebaseAuth.instance.currentUser!.uid),
];

ShowSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}
