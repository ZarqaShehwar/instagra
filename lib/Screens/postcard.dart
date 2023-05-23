import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/commentScrenn.dart';
import 'package:instagram/Utilites/colors.dart';
import 'package:instagram/Utilites/globalvariable.dart';
import 'package:instagram/Utilites/like_animation.dart';
import 'package:instagram/connection/firestoremethods.dart';
import 'package:instagram/provider/userProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:instagram/user/usermodel.dart';




class Postcard extends StatefulWidget {
  final snap;

  Postcard({Key? key,required this.snap}):super(key: key);
    @override
  State<Postcard> createState() => _Postcard();
}
class _Postcard extends State<Postcard>{
 int commentLength = 0; 
      bool isLikeAnimating = false;
      @override
      void initState() {
        super.initState();
        getComment();
        
      }
      void getComment()async{
        try{
        QuerySnapshot snap = await FirebaseFirestore.instance.
        collection('posts').doc(widget.snap['PostId']).collection('Comments').get();
        commentLength = snap.docs.length;
        }


catch(err){
  ShowSnackBar(err.toString(), context);
}   
setState(() {
  commentLength = commentLength;
});
   }
  
  
 
  @override
  Widget build(BuildContext context) {
    
    
     final UserDetail user = Provider.of<Userprovider>(context,listen: false).getUser;
    return Container(
      padding:const  EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding:const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
               CircleAvatar(

                 radius: 24,
                  backgroundImage:NetworkImage(widget.snap['ProfileImage']


                    
                    //user.photoUrl==null?user.photoUrl:
                   
//"https://images.unsplash.com/photo-1611262588024-d12430b98920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"

)),//NetworkImage(
                //       "https://images.unsplash.com/photo-1611262588024-d12430b98920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
Text(
                         widget.snap["Username"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: ["Delete"]
                                    .map(
                                      (e) => InkWell(
                                        onTap: ()async {
                                         await  FirestoreMethods().delete(widget.snap['PostId']);
                                         Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          });
                    },
                    icon: Icon(Icons.more_vert)),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap:()async{
              await FirestoreMethods().likePost(widget.snap['PostId'],user.uid,widget.snap['Likes']);
              setState(() {
                isLikeAnimating=true;
              });
            },
          child:Stack(
            alignment: Alignment.center,
            children:[
            
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: Image(
                image: NetworkImage(
                widget.snap["PostUrl"], 
                    ),fit: BoxFit.cover,
              )),
              AnimatedOpacity(
                opacity: isLikeAnimating? 1:0,
                 duration: const Duration(milliseconds: 100),child:
              LikeAnimation(
                 isAnimating:isLikeAnimating ,
                child: Icon(Icons.favorite,color: Colors.white,size:100) ,
              
               duration: const  Duration(milliseconds: 400),
                onEnd: (){
              setState(() {
                isLikeAnimating=false;
                
              }); 
                }),
      )]),),
          Row(
            children: [
              LikeAnimation( isAnimating: widget.snap['Likes'].contains(user.uid),
             smallLike: true,
             child:
              IconButton(
                  onPressed: ()async{
                 await FirestoreMethods().likePost(widget.snap['PostId'],user.uid,widget.snap['Likes']);


                  },
                  icon:widget.snap['Likes'].contains(user.uid)?const  Icon(
                   Icons.favorite,
                    color: Colors.red,
                  ):const Icon(Icons.favorite_border)),),
              IconButton(onPressed: () {

                Navigator.of(context).
                pushReplacement(MaterialPageRoute(builder: 
                (context)=>CommentScreen(snap:widget.snap)));
              }, icon:const  Icon(Icons.message_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.bookmark_border)),
              ))
            ]),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w800),
                    child:
 Text("${widget.snap['Likes'].length} likes",
                    
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 8),
                    child: RichText(
                        text: TextSpan(
                      style: TextStyle(color: primaryColor),
                      children: [
                       
TextSpan(
                          text:widget.snap['Username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                       TextSpan(
       text:' ${widget.snap['Description']}',
                        ),
                      ],
                    )),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Container(
                        padding:const  EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'View all $commentLength comments',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: secondaryColor),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
            child:
  Text(
  DateFormat.yMMMd().format((widget.snap['DatePublished']).toDate()),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: secondaryColor),
                    ),
                  ),
                ]),
          )
        ],
      ),
   );
  }
  
 
}
