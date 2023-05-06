import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Screens/homescreen.dart';
import 'package:instagram/Utilites/Textfield.dart';
import 'package:instagram/Utilites/colors.dart';
import 'package:instagram/Utilites/globalvariable.dart';
import 'package:instagram/connection/Authentication.dart';
import 'package:instagram/user/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usercontroller = TextEditingController();
  final TextEditingController biocontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  Uint8List? image;
  bool _isloading1 = false;
  @override
  void dispose() {
    super.dispose();
    usercontroller.dispose();
    biocontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  SelectedImage() async {
    Uint8List? file = await PickImage(ImageSource.gallery);
    setState(() {
      image = file;
    });
  }

  signUp1() async {
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    String name = usercontroller.text;
    String bio = biocontroller.text;
    Uint8List? file = image!;
    setState(() {
      _isloading1 = true;
    });

    String res = await AuthMethod().SignUp(
        email: email, name: name, password: password, bio: bio, file: file);
    setState(() {
      _isloading1 = false;
    });

    if (res == "Success") {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
    else {
      ShowSnackBar(res, context);
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Flexible(flex: 2, child: Container()),
        Stack(children: [
          image != null
              ? CircleAvatar(
                  radius: 64,
                  backgroundImage: MemoryImage(image!),
                )
              : const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                    "https://media.istockphoto.com/id/1335234186/photo/social-media-profile-page-in-smartphone-screen-at-work-woman-looking-at-feed-status-update-or.jpg?b=1&s=170667a&w=0&k=20&c=lyb5R1OJ53p22m-by_ECCKJOoB_akfdk64nu8A1kdPw=",
                  ),
                ),
          Positioned(
              bottom: -10,
              child: IconButton(
                  onPressed: () async {
                    SelectedImage();
                  },
                  icon: Icon(Icons.add_a_photo))),
        ]),
        const SizedBox(height: 24),
        TextField1(
          textedittingcontroller: usercontroller,
          hinttext: "Enter your Name",
          textinputtype: TextInputType.text,
        ),
        const SizedBox(
          height: 24,
        ),
        TextField1(
          textedittingcontroller: biocontroller,
          hinttext: "Enter your Bio",
          textinputtype: TextInputType.text,
        ),
        const SizedBox(
          height: 24,
        ),
        TextField1(
          textedittingcontroller: emailcontroller,
          hinttext: "Enter your Email",
          textinputtype: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 24,
        ),
        TextField1(
          textedittingcontroller: passwordcontroller,
          hinttext: "Enter your Password",
          textinputtype: TextInputType.text,
          ispass: true,
        ),
        const SizedBox(
          height: 24,
        ),
        InkWell(
          onTap: () {
            signUp1();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              color: Colors.blue,
            ),
            child: _isloading1 != false
                ? const Center(
                    child: CircularProgressIndicator(color: primaryColor))
                : const Text("Sign in "),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ]),
    )));
  }
}
