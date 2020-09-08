import 'package:flutter/material.dart';
import 'package:transisi/ui/Akun.dart';
import 'package:transisi/ui/Home.dart';
import 'package:transisi/ui/Login.dart';
import 'package:transisi/ui/PageWidget.dart';
import 'package:transisi/ui/Search.dart';

class PageHomeBottomMenu extends StatefulWidget {
  @override
  _PageHomeBottomMenuState createState() => _PageHomeBottomMenuState();
}
class _PageHomeBottomMenuState extends State<PageHomeBottomMenu> {
  int currentIndex = 0;
  final List<Widget> _listmenu = [
    HomeScreen(),
    SearchScreen(),
    AkunScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _listmenu[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Akun')
          )
        ],
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
