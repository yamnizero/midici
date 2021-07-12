import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicine_2/widget/button_primery.dart';
import 'package:medicine_2/widget/general_logo_space.dart';
import 'package:medicine_2/widget/widget_ilustration.dart';

import 'regiater_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
        child: Column(
          children: [
            SizedBox(height: 45,),
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
                      builder: (context)=> RegisterPage()));
                },

              ) ,
            ),
          ],
        ),
      ),
    );
  }
}
