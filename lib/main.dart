import 'package:flutter/material.dart';
import 'package:medicine_2/pages/splash_screen.dart';

import 'constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(primaryColor: greenColor) ,
      home: SplashScreen(),
    );
  }
}
