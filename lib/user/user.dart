import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

PickImage(ImageSource source) async {
  XFile? file = await ImagePicker().pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  } else {
    print("No image selected");
  }
}

class UserDetail {
  final String name;
  final String bio;
  final String password;
  final String email;
  final Uint8List? file;
  UserDetail(
      {required this.name,
      required this.bio,
      required this.email,
      required this.password,
      required this.file});
  Map<String, dynamic> ToJSON() => {
        "Username": name,
        "Email": email,
        "Password": password,
        "Bio": bio,
        "Photo": file,
      };
}
