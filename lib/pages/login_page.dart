import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medicine_2/network/api/url_api.dart';
import 'package:medicine_2/network/model/pref_profile.dart';
import 'package:medicine_2/widget/button_primery.dart';
import 'package:medicine_2/widget/general_logo_space.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/theme.dart';
import 'main_page.dart';
import 'regiater_page.dart';

class LoginPages extends StatefulWidget {
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }


submitLogin() async {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
    final response = await http.post(urlLogin,body: {
      "email" : emailController.text,
      "password" : passwordController.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String idUser = data['user_id'];
    String name = data['name'];
    String email = data['email'];
    String phone = data['phone'];
    String address = data['address'];
    String createdAt = data['created_at'];
    if(value == 1){
      savePref(
          idUser,
          name,
          email,
          phone,
          address,
          createdAt);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Information"),
            content: Text(message),
            actions: [TextButton(onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>MainPages()),
                      (route) => false);
            }, child: Text("ok"))],
          )
      );
      setState(() {});
    }else{
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Information"),
            content: Text(message),
            actions: [TextButton(onPressed: () {
              Navigator.pop(context);
            },
                child: Text("ok"))],
          ));
      setState(() {});

    }
}

savePref(
  String idUser ,
  String name ,
   String email ,
   String phone ,
   String address,
   String createdAt,
    ) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  setState(() {
    sharedPreferences.setString(PrefProfile.idUser,idUser);
    sharedPreferences.setString(PrefProfile.name,name);
    sharedPreferences.setString(PrefProfile.email,email);
    sharedPreferences.setString(PrefProfile.phone,phone);
    sharedPreferences.setString(PrefProfile.address,address);
    sharedPreferences.setString(PrefProfile.createdAt,createdAt);

  });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: GeneralLogoSpace(),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:100,),
                Text(
                  "LOGIN",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Login into your account",
                  style: regulerTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                SizedBox(
                  height: 30,
                ),

                // NOTE :: TEXTFIELD
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: witheColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email Address',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: witheColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: passwordController,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: _secureText
                            ? Icon(
                          Icons.visibility_off,
                          color: greenColor,
                          size: 20,
                        )
                            : Icon(
                          Icons.visibility,
                          color: greenColor,
                          size: 20,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    text: "Login",
                    onTap: () {
                      if (
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Warning !!"),
                              content: Text("Please, enter the fields"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("ok"))
                              ],
                            ));
                      } else {
                       submitLogin();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: lightTextStyle.copyWith(
                          color: greyLightColor, fontSize: 15),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context)=> RegisterPage()),
                                (route) => false);
                      },
                      child: Text(
                        "Create account",
                        style: boldTextStyle.copyWith(
                            color: greenColor, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
