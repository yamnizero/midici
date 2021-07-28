import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicine_2/network/api/url_api.dart';
import 'package:medicine_2/network/model/history_model.dart';
import 'package:medicine_2/network/model/pref_profile.dart';
import 'package:medicine_2/widget/cart_history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryOrderModel> list = [];
 late String userID;
 getProf() async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   setState(() {
     userID = sharedPreferences.getString(PrefProfile.idUser)!;
   });
   getHistory();
 }
  getHistory() async {
    list.clear();
    var uriHistory = Uri.parse(BASEURL.historyOrder + userID);
    final response = await http.get(uriHistory);
    if(response.statusCode == 200){
      setState(() {
        final data =jsonDecode(response.body);
        for(Map<String,dynamic> item in data ){
            list.add(HistoryOrderModel.fromJson(item));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Container(
              padding: EdgeInsets.all(24 ),
              child: ListView.builder(
                itemCount: list.length,
                  itemBuilder: (context,i){
                  final x = list[i];
                  return CartHistory(
                      model: x,
                  );
                  }
              )
            ),
        ),
      ),
    );
  }
}
