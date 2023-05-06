import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

PickImage(ImageSource source) async {
  XFile? file = await ImagePicker().pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  } else {
    print("No image selected");
  }
}


