import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/postcard.dart';
import 'package:instagram/Utilites/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: Image(
            image: AssetImage("images/insta.png"),
            // color: primaryColor,
            height: 32,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.message_outlined)),
          ]),
      body: StreamBuilder(
        stream:FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child:CircularProgressIndicator(color:primaryColor,));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) =>Postcard(
              snap:snapshot.data!.docs[index].data(),
            )));
          }
        )
      ),
        
    );
     }
    
  }

