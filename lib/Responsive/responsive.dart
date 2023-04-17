import 'package:flutter/material.dart';

class Responsive extends StatefulWidget {
  final Widget web;
  final Widget mobile;
  const Responsive({required this.web, required this.mobile});

  @override
  State<Responsive> createState() => _Responsive();
}

class _Responsive extends State<Responsive> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth > 600) {
        return widget.web;
      } else {
        return widget.mobile;
      }
    });
  }
}
