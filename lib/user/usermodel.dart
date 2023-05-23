import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetail  {
  final String username;
  final String uid;
  final String bio;
  final String password;
  final String email;
  final String photoUrl;
  final List follower;
  final List following;
  UserDetail(
      {required this.username,
      required this.uid,
      required this.bio,
      required this.email,
      required this.password,
      required this.photoUrl,
      required this.follower,
      required this. following});
  Map<String, dynamic> ToJSON() => {
        "Username": username,
        "uid":uid,
        "Email": email,
        "Password": password,
        "Bio": bio,
        "Photo": photoUrl,
        "Follower":follower,
        "Following":following,
      };

      static UserDetail fromSnap(DocumentSnapshot snap){
        var snapshot = snap.data()as Map<String,dynamic>;
        return UserDetail(username: snapshot
        ['Username'], uid: snapshot['uid'], bio: snapshot['Bio'], 
        email: snapshot['Email'], password: snapshot['Password'],
         photoUrl: snapshot['Photo'], follower: snapshot['Follower'],
          following: snapshot['Following']);


      }
}