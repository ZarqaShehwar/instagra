import 'package:flutter/material.dart';
import 'package:instagram/Utilites/colors.dart';
import 'package:instagram/provider/userProvider.dart';
import 'package:instagram/user/usermodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key,required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
 
  @override
  Widget build(BuildContext context) {
     final UserDetail user = Provider.of<Userprovider>(context).getUser;
    return  Container(
      padding:const  EdgeInsets.symmetric(vertical:16,horizontal: 12),
      child: Row(
        children: [
         const  CircleAvatar(
            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1611262588024-d12430b98920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
            radius: 18,

          ),
          Expanded(child: 
          Padding(
            padding:const  EdgeInsets.only(left:16 ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(text:  TextSpan(
                children: [
                  TextSpan(
                  text:'${widget.snap['Username']}',
                    style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor)
                  ),
                  TextSpan(
                    text: ' ${widget.snap['Comment']}',
                    style: TextStyle(color: primaryColor)
                    
                  ),

              


                ]
              )),
               Padding(padding: EdgeInsets.only(top: 4),
              child:Text(DateFormat.yMMMd().format((widget.snap['datePublished']).toDate()),
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),)),

          ],)),),
          // Container(
          //   padding:const  EdgeInsets.all(8),
          //   child: widget.snap['Likes'].contains(widget.snap['uid'])?
          //   Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border,),
          // )
        ],
      ),
    );
  }
}