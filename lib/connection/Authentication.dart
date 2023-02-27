import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:instagram/user/user.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> SignUp({
    required String email,
    required String name,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error can be occur";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await _firestore.collection("User").doc(cred.user!.uid).set(UserDetail(
                name: name,
                bio: bio,
                email: email,
                password: password,
                file: file)
            .ToJSON());
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> LoginScreeen({
    required String email,
    required String password,
  }) async {
    String res = "Some error can be occur";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
