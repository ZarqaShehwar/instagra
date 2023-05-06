 import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/connection/storage.dart';
import 'package:instagram/user/postusers.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadImage(String description,String uid,Uint8List file,String username,String profImage)async{
    String res= "Some error can be occur";

    try{
   String photoUrl =  await StorageMethod().uploadImage("posts", file, true);
   String postId=const Uuid().v1();
   Post post =Post(description: description, uid: uid, username: username, postId:postId ,
    datePublished: DateTime.now(), postUrl: photoUrl, profImage: profImage, likes: []);
    _firestore.collection("posts").doc(postId).set(post.ToJSON());
    res="Success";
  

  }
  catch(err){
    res= "${err.toString()}";
    return res;

  }
  return res;
 }
}