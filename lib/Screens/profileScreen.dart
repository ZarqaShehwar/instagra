import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/loginscreen.dart';
import 'package:instagram/Utilites/colors.dart';
import 'package:instagram/Utilites/followButton.dart';
import 'package:instagram/connection/Authentication.dart';
import 'package:instagram/connection/firestoremethods.dart';
class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key,required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   int postLength = 0 ;
  int follower = 0;
  int following= 0 ;
  bool isFollowing =  false;
  bool isLoading = false;
  var userData = {};
@override
void initState() {
  super.initState();
  getData();
  
}
getData()async{
  setState(() {
    isLoading= true;
  });
  try{
  var usersnap = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
  userData = usersnap.data()!;
  follower = usersnap.data()!['Follower'].length;
  following = usersnap.data()!['Following'].length;
  isFollowing = usersnap.data()!['Follower'].contains(FirebaseAuth.instance.currentUser!.uid);
  
  var postSnap = await FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
  postLength= postSnap.docs.length;
  
  print(postSnap.docs.length);
  setState(() {
   
    isLoading=false;
  });
  print(userData);
}
catch(err){

}

}
  @override
  Widget build(BuildContext context) {
    return isLoading?Center(child: CircularProgressIndicator(color: primaryColor)):Scaffold(
      appBar: AppBar(
       title: Text('${userData['Username']}',style: TextStyle(color: primaryColor),),
       centerTitle: false,
      ),
      body:ListView(children: [
        Padding(padding: EdgeInsets.all(16),child:
        Column(
        children: [
          
          Row(
            children: [
              CircleAvatar(
                backgroundColor:Colors.grey ,
                radius: 40,
                backgroundImage: NetworkImage(userData['Photo']
                //'https://plus.unsplash.com/premium_photo-1682075450326-0922b38e694a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1632&q=80'
                ),
 
              ),
              Expanded(flex:1,
              child: Column(
                children:[
                
              Row(
                mainAxisSize: MainAxisSize.max ,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                
                buildStateColumn(postLength, 'post'),
                buildStateColumn(follower, 'Follower'),
                buildStateColumn(following , 'Following'),

              ],),
            
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [FirebaseAuth.instance.currentUser!.uid == widget.uid?
                  FollowButton(textColor: primaryColor, text: 'SignOut',
                  
                   backgroundColor: mobileBackgroundColor, borderColor: Colors.grey,
                    function: ()async{
                      await AuthMethod().signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));

                    }):isFollowing?  FollowButton(textColor: Colors.black, text: 'Unfollow',
                  
                   backgroundColor: Colors.grey, borderColor: Colors.grey,
                    function: ()async{
                      await FirestoreMethods().followUser(FirebaseAuth.instance.currentUser!.uid, userData['uid']);
setState(() {
  isFollowing=false;
  if(following>0){
  following--;
  }
});
                    }):  FollowButton(textColor: Colors.white, text: 'Follow',
                  
                   backgroundColor: Colors.blue, borderColor: Colors.blue,
                    function: ()async{
                       await FirestoreMethods().followUser(FirebaseAuth.instance.currentUser!.uid, userData['uid']);
setState(() {
  isFollowing=true;
  follower++;
});
                    }),
                ],
              ),
              
                ]
                ),
          )],
          ),
          Container(
            alignment:Alignment.centerLeft,
            padding:const EdgeInsets.only(top:8),
            child: Text(userData['Username'],style:TextStyle(fontWeight: FontWeight.bold)),
          ),
           Container(
            alignment:Alignment.centerLeft,
            padding:const EdgeInsets.only(top:1),
            child:  Text(userData['Bio'],style:TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(),
          FutureBuilder(
            future:FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo: widget.uid).get(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(color: primaryColor),);

              }
              return GridView.builder(
                shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 1.5,
                childAspectRatio: 1),
               itemBuilder: (context,index){
                DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                return Container(
                  child:Image(image: NetworkImage(snap['PostUrl']),
                  fit: BoxFit.cover,)
                );
               });

            }
          ),
      ])),
      ],)
    );
  } 
  Column buildStateColumn(int num,String label){
    return //Padding(padding: EdgeInsets.only(left:10),
   Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(num.toString(),style:const  TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
       Container(margin:EdgeInsets.only(top:4),child:
        Text(label,style:const TextStyle(fontSize: 14,fontWeight:
         FontWeight.w400,color: Colors.grey)),
    ) ],
    );
  }
}