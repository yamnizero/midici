import 'package:flutter/material.dart';
import 'package:medicine_2/pages/profile_page.dart';
import '../constants/theme.dart';

import 'history_page.dart';
import 'home_page.dart';

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _selectIndex = 0;
  final _pageList =[
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  onTappedItem(int index){
    setState(() {
      _selectIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(_selectIndex),
       bottomNavigationBar: BottomNavigationBar(

         items: [
           BottomNavigationBarItem(
                  icon: Icon(Icons.home),
             label: "Home",
           ),
           BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
             label: "History",
           ),
           BottomNavigationBarItem(
                  icon: Icon(Icons.account_box_rounded),
             label: "Profiled",
           ),
         ],
         currentIndex: _selectIndex,
         onTap: onTappedItem,
         selectedItemColor: greenColor,
         unselectedItemColor: grey35Color,
       ),
    );
  }
}
