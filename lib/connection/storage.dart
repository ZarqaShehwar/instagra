import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImage(
      String childname, Uint8List file, bool post) async {
    Reference ref =
        _storage.ref().child(childname).child(_auth.currentUser!.uid);
    TaskSnapshot uploadTask = await ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String photoUrl = await snapshot.ref.getDownloadURL();
    return photoUrl;
  }
}
