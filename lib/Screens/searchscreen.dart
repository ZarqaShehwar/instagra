import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram/Screens/profileScreen.dart';
import 'package:staggered_grid_view_flutter/staggered_grid_view_flutter.dart';
import 'package:instagram/Utilites/colors.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isShowUser = false;
  final TextEditingController searchcontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:mobileBackgroundColor,
        title:TextFormField(
          controller:searchcontroller,
          decoration:const  InputDecoration(
            labelText: 'Search for user'),
          
          onFieldSubmitted:(String _ ){
           setState(() {
             isShowUser=true;
           });
          }
        ),

      ),
      body: isShowUser?FutureBuilder(
        future:FirebaseFirestore.instance.collection('users').where('Username',isGreaterThanOrEqualTo:searchcontroller.text).get(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center (child:CircularProgressIndicator(color: primaryColor,));
          }
          return ListView.builder(itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context,index){
            return  InkWell(
              onTap:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen(uid:(snapshot.data! as dynamic).docs[index]['uid'])));
              },child:
              ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(""),

              ),
              title:Text('${ (snapshot.data! as dynamic).docs[index]['Username']}'),
            ));
          },
          );
        }
      ):FutureBuilder(
        
        future:FirebaseFirestore.instance.collection('posts').get(),
        builder:(context,snapshot){ 
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(color: primaryColor),);
          }
          return StaggeredGridView.countBuilder(crossAxisCount: 3,
          itemCount:(snapshot.data! as dynamic).docs.length,
          itemBuilder:(context,index)=> Image.network(
         (snapshot.data! as dynamic).docs[index]['PostUrl']),
          staggeredTileBuilder:(index)=>StaggeredTile.count((
            (index%7==0)?2:1),
           ( index%7==0)?2:1),
          mainAxisSpacing:8);
        }  
      ),);
  }
        
    
  }
