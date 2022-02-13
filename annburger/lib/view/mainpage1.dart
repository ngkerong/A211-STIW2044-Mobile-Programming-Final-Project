import 'package:flutter/material.dart';
import 'package:annburger/model/user.dart';
import 'ordermenu.dart';
import 'progressorder.dart';
import 'userpage.dart';

class MainPage1 extends StatefulWidget {
  final User user;

  const MainPage1({Key? key, required this.user}) : super(key: key);
  

  @override
  State<MainPage1> createState() => _MainPageState1();
}

class _MainPageState1 extends State<MainPage1> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "User";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      OrderMenu(user: widget.user),
      ProgressOrderPage(user: widget.user),
      UserPage(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: "Menu"),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "Progress Order"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile")
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "Menu";
      }
      if (_currentIndex == 1) {
        maintitle = "Progress Order";
      }
      if (_currentIndex == 2) {
        maintitle = "Profile";
      }
    });
  }
}