

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Utilites/colors.dart';
import 'package:instagram/Utilites/globalvariable.dart';
import 'package:instagram/connection/firestoremethods.dart';
import 'package:instagram/provider/userProvider.dart';
import 'package:instagram/user/user.dart';
import 'package:instagram/user/usermodel.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _image;
  bool _isloading = false;
  final TextEditingController _descriptioncontroller=TextEditingController();
  SelectImage() async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Create a post"),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text("Choose from gallery"),
              onPressed: () async {
                Navigator.of(context).pop();

                Uint8List file = await PickImage(ImageSource.gallery);
                setState(() {
                  _image = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a photo"),
              onPressed: () async {
                Navigator.of(context).pop();

                Uint8List file = await PickImage(ImageSource.camera);
                setState(() {
                  _image = file;
                });
              },
            ),
         
          ],
        );
      },
    );
  }
  postImage(
    String uid,
    String username,
    String userprofile,
    
  )

  async{
    setState(() {
      _isloading=true;
    });
    try{
      Uint8List file = _image!;
      
      
      String res = await FirestoreMethods().uploadImage(_descriptioncontroller.text, uid, file, username, userprofile);
if(res=="Success"){
  setState(() {
    _isloading=false;
  });
  clearImage();
ShowSnackBar('posted', context);
}
    }
    catch(e){
      ShowSnackBar(e.toString()
      , context);

    }
  }
   @override
  void initState() {
    super.initState();
    _descriptioncontroller;
    
  }
  @override
  void dispose() {
    
    super.dispose();
    _descriptioncontroller.dispose();
  }
  clearImage(){
    setState(() {
      _image=null;
    });
  }
 

  @override
  Widget build(BuildContext context) {
    final UserDetail user = Provider.of<Userprovider>(context).getUser;
    return _image == null
        ? Center(
            child: IconButton(
                onPressed: () => {
                      SelectImage(),
                    },
                icon: const Icon(Icons.upload)),
          )
        : Scaffold(
          
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  onPressed:()=>clearImage(),
                   icon: const Icon(Icons.arrow_back)),
              title: const Text("Post to"),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed:()=> postImage(user.uid,user.username,user.photoUrl),
                    child: const Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                SizedBox(
                  width: 100,
                )
              ],
            ),
            body: Column(children:[
               _isloading?const LinearProgressIndicator():Container(),
               const Divider(),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              

                CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.photoUrl==null?user.photoUrl:"https://images.unsplash.com/photo-1611262588024-d12430b98920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),),//NetworkImage(

                
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child:  TextField(
                   
                    decoration: InputDecoration(
                      hintText: "Write a caption.....",
                      border: InputBorder.none,
                      
                    ),
                     controller: _descriptioncontroller,
                    
                    maxLines: 8,
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(_image!),
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),],
            )
          );
  }
}
