import 'package:flutter/material.dart';
import 'package:medicine_2/pages/main_page.dart';
import 'package:medicine_2/pages/splash_screen.dart';
import 'package:medicine_2/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(primaryColor: greenColor) ,
      home: MainPages(),
    );
  }
}
