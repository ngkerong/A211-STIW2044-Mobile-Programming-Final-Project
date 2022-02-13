import 'package:flutter/material.dart';
import 'package:annburger/model/user.dart';
import 'userordermenu.dart';
import 'adminpage.dart';
import 'productmenu.dart';

class MainPage2 extends StatefulWidget {
  final User user;

  const MainPage2({Key? key, required this.user}) : super(key: key);
  

  @override
  State<MainPage2> createState() => _MainPageState2();
}

class _MainPageState2 extends State<MainPage2> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Admin";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      const UserOrderMenu(),
      const ProductMenu(),
      AdminPage(user: widget.user),
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
              icon: Icon(Icons.menu),
              label: "Order"),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: "Menu"),
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
        maintitle = "Order";
      }
      if (_currentIndex == 1) {
        maintitle = "Menu";
      }
      if (_currentIndex == 2) {
        maintitle = "Profile";
      }
    });
  }
}