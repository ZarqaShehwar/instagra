import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Utilites/colors.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => Screen();
}

class Screen extends State<WebScreen> {
  int _page = 0;
  late PageController pageController;
  NavigationChange(int page) {
    pageController.jumpToPage(page);
  }

  OnPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: [
            Text("home"),
            Text("home"),
            Text("home"),
            Text("home"),
            Text("home"),
          ],
          controller: pageController,
          onPageChanged: OnPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? primaryColor : secondaryColor,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            )),
          ],
          onTap: NavigationChange,
        ));
  }
}
