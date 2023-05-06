import 'package:flutter/material.dart';
import 'package:instagram/Utilites/colors.dart';
import 'package:instagram/provider/userProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:instagram/user/usermodel.dart';



class Postcard extends StatelessWidget {
  final snap;
 const  Postcard({super.key,required this.snap});
 
  @override
  Widget build(BuildContext context) {
    
     final UserDetail user = Provider.of<Userprovider>(context,listen: false).getUser;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                CircleAvatar(

                  radius: 24,
                   backgroundImage:NetworkImage(snap["ProfileImage"],
                    
                    //user.photoUrl==null?user.photoUrl:
                   
//"https://images.unsplash.com/photo-1611262588024-d12430b98920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"

),),//NetworkImage(
                //       "https://images.unsplash.com/photo-1611262588024-d12430b98920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snap["Username"],
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
                                        onTap: () {},
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
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: Image(
                image: NetworkImage(
                  snap["PostUrl"]
                    //"https://images.unsplash.com/photo-1611262588024-d12430b98920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"
                    ),fit: BoxFit.cover,
              )),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )),
              IconButton(onPressed: () {}, icon: Icon(Icons.message_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.send)),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.bookmark_border)),
              ))
            ],
          ),
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
                    child: Text("${snap['Likes'].length} likes",
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
                          text: snap['Username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ${snap['Description']}',
                        ),
                      ],
                    )),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "View all 200 comments",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: secondaryColor),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd().format(snap['DatePublished'].toDate()),
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
