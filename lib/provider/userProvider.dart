import 'package:flutter/material.dart';
import 'package:instagram/connection/Authentication.dart';
import 'package:instagram/user/usermodel.dart';

class Userprovider with ChangeNotifier{
  UserDetail? _user;
final AuthMethod _authmethod = AuthMethod();

  UserDetail get getUser => _user!;
Future<void>refreshUser() async{
  UserDetail user = await _authmethod.getUserDetails();
  _user = user;
  notifyListeners();
}


}