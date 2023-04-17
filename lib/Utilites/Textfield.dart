import 'package:flutter/material.dart';

class TextField1 extends StatelessWidget {
  final TextEditingController textedittingcontroller;
  final String hinttext;
  final bool ispass;
  final TextInputType textinputtype;
  const TextField1({
    Key? key,
    required this.textedittingcontroller,
    required this.hinttext,
    this.ispass = false,
    required this.textinputtype,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputborder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: textedittingcontroller,
      decoration: InputDecoration(
        hintText: hinttext,
        border: inputborder,
        focusedBorder: inputborder,
        enabledBorder: inputborder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textinputtype,
      obscureText: ispass,
    );
  }
}
