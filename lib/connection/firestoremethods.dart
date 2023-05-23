
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/Utilites/globalvariable.dart';
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
 Future<void> likePost(String postId,String uid,List likes)async{
  try{
    if(likes.contains(uid)){
     await _firestore.collection('posts').doc(postId).update({
        'Likes':FieldValue.arrayRemove([uid]),
      }
      );
    }
    else{
      await _firestore.collection('posts').doc(postId).update({
        'Likes':FieldValue.arrayUnion([uid]),
      });
    }

  }
  catch(err){
    print(err.toString());

  }
 }
 Future<void> postComment(String postId,String text,String uid,String username,String userProfile,)async{
try{

  if(text.isNotEmpty){
    String commentId=Uuid().v1();
    

    
    
    
    await _firestore.collection('posts').
    doc(postId).collection('Comments').doc(commentId).set({
      'ProfilePic':userProfile,
      'PostId':postId,
      'Comment':text,
      'uid':uid,
      'Username':username,
      'datePublished':DateTime.now(),
      
    
    });
    }
  
}
catch(err){
  print(err.toString());
}
 }
 Future<void> delete(String postId)async{
  try{
  await _firestore.collection('posts').doc(postId).delete();
  }
  catch(err){
    print(err.toString());
  }
 }
 Future<void> followUser(String uid,String followId )async{

  try{
    DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
    List following = (snap.data()! as dynamic)['Following'];
    if(following.contains(followId)){
      await _firestore.collection('users').doc(followId).update({
        'Follower':FieldValue.arrayRemove([uid])
      });
       await _firestore.collection('users').doc(uid).update({
        'Following':FieldValue.arrayRemove([followId])
      });

    }else{
       await _firestore.collection('users').doc(followId).update({
        'Follower':FieldValue.arrayUnion([uid])
      });
       await _firestore.collection('users').doc(uid).update({
        'Following':FieldValue.arrayUnion([followId])
      });

    }



  }
  catch(err){
   
  }
 }
}