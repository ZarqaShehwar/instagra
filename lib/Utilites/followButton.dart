import 'package:flutter/material.dart';
class FollowButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Function()? function;
  final String text;
  final Color textColor;

  const FollowButton({super.key,required this.textColor,required this.text,required this.backgroundColor,required this.borderColor,required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(padding:const  EdgeInsets.only(top:20),
    child:Container(
      child:TextButton(onPressed: function,
      child:Container(
        decoration: BoxDecoration(
          color:backgroundColor,
          
          border:Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child:Text(text,style: TextStyle(color:textColor,fontWeight: FontWeight.bold,),),width:150,
        height:27,
      ))
    ));
  }
}