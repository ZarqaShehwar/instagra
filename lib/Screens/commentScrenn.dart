import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/commentCard.dart';
import 'package:instagram/Screens/homescreen.dart';
import 'package:instagram/Utilites/Textfield.dart';
import 'package:instagram/Utilites/colors.dart';
import 'package:instagram/connection/firestoremethods.dart';
import 'package:instagram/provider/userProvider.dart';
import 'package:instagram/user/usermodel.dart';
import 'package:provider/provider.dart';
class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key,required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late final TextEditingController commentcontroller = TextEditingController() ;
 
  @override
  void dispose() {
    // TODO: implement dispose
    
    commentcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final UserDetail user = Provider.of<Userprovider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.of(context).
          pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreen()

          ));
        },),
        title:  Text(' Comment',style: TextStyle(fontSize: 20),),
        centerTitle: false,
      ),
      body:StreamBuilder(
        stream:FirebaseFirestore.instance.collection("posts").
        doc(widget.snap['PostId']).collection('Comments').orderBy('datePublished',descending:true).snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:CircularProgressIndicator(color:primaryColor,));
          }
          return ListView.builder(
            itemCount: snapshot.data! .docs.length,
            itemBuilder: (context, index) =>CommentCard(
              snap:snapshot.data!.docs[index].data(),
            ),);
           
   } )),
          
      bottomNavigationBar: SafeArea(child: 
      Container(
        height: kToolbarHeight,
        margin:EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.only(left: 16,right: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(user.photoUrl),
            ),
            Expanded(child:Padding(padding: EdgeInsets.only(left: 16,right:8),child: 
            TextField(
              decoration:  InputDecoration(
                border: InputBorder.none,
                hintText: 'Comment as ${user.username}',
                
              ),
              controller: commentcontroller,
            ),),),
          //    TextField1(
              
          //     textedittingcontroller: controller,
          //    hinttext:'Write comment' , textinputtype:TextInputType.text,border),),
       InkWell(
       
        onTap: ()async{
         
         await  FirestoreMethods().
         postComment(widget.snap['PostId'], 
         commentcontroller.text, user.uid, user.username, user.photoUrl);
         commentcontroller.text='';
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8,horizontal:8),
          child:Text('Post',style:TextStyle(color: Colors.blueAccent))
        )
       ),
          ],
        ),

        ),
      ));
    
  }
}  