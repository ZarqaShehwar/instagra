import 'package:flutter/material.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreen();
}

class _MobileScreen extends State<MobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("MOBILE"),
    );
  }
}
