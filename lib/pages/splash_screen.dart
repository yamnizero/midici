import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicine_2/network/model/pref_profile.dart';
import 'package:medicine_2/pages/login_page.dart';
import 'package:medicine_2/pages/main_page.dart';
import 'package:medicine_2/widget/button_primery.dart';
import 'package:medicine_2/widget/general_logo_space.dart';
import 'package:medicine_2/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'regiater_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 String? userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser);
      userID == null ? sessionLogout() : sessionLogin();
    });
  }

 sessionLogout(){}
 sessionLogin(){
    Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => MainPages()));
 }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
        child: Column(
          children: [
            WidgetIlustraion(
              image: "assets/splash_ilustration.png",
              title: "Find your medical\n solution",
              subtitle1: "Consult with a doctor",
              subtitle2: "Wherever and wherever you want",
              child:ButtonPrimary(
                text:
                "GET STARTED",
                onTap: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(
                      builder: (context)=> LoginPages()));
                },

              ) ,
            ),
          ],
        ),
      ),
    );
  }
}
