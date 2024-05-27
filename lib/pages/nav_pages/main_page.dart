import 'package:flutter/material.dart';
import 'package:master_class_travel_app/pages/nav_pages/bar_item_page.dart';
import 'package:master_class_travel_app/pages/home_page.dart';
import 'package:master_class_travel_app/pages/nav_pages/my_page.dart';
import 'package:master_class_travel_app/pages/nav_pages/search_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List page = [
    HomePage(),
    BusinessListPage(),
    SearchPage(),
    LoginRegisterPage(),
  ];

  int currentIndex = 0;

  void onTab(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: page[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        onTap: onTab,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_sharp),label: 'Bar'),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'My'),
        ],

      ),
    );
  }
}
