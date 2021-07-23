import 'package:flutter/material.dart';
import 'package:medicine_2/pages/main_page.dart';
import 'package:medicine_2/widget/button_primery.dart';
import 'package:medicine_2/widget/general_logo_space.dart';
import 'package:medicine_2/widget/widget_ilustration.dart';

class SuccessCheckout extends StatelessWidget {
  const SuccessCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GeneralLogoSpace(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(24),
            children: [
              SizedBox(height: 80.0),
              WidgetIlustraion(
                image: "assets/order_success_ilustration.png",
                title: "Yes,your order was successfully",
                subtitle1: "Consult with a doctor,",
                subtitle2: "wherever and wherever you are",
              ),
              SizedBox(height: 80.0),
              ButtonPrimary(
                  text: "BACK TO HOME",
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>MainPages()),
                            (route) => false);
                  }
                  ),
            ],
          ),
        )
    );
  }
}
