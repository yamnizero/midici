

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_2/network/api/url_api.dart';
import 'package:medicine_2/network/model/pref_profile.dart';
import 'package:medicine_2/network/model/product_model.dart';
import 'package:medicine_2/widget/button_primery.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../constants/theme.dart';
import 'main_page.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  DetailProduct(this.productModel);
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final priceFormat =NumberFormat ("#,##0","EN_US");
  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
       child: ListView(
         children: [
           Container(
             padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
             height: 70,
             child: Row(
               children: [
                 InkWell(
                     onTap:(){
                       Navigator.pop(context);
                     },
                     child: Icon(Icons.arrow_back_rounded,size: 32,color: greenColor,)),
                 SizedBox(width: 30,),
                 Text(
                     "Detail Product",
                   style: regulerTextStyle.copyWith(fontSize: 24),
                 ),
               ],
             ),

           ),
           SizedBox(height: 24,),
           Container(
             height: 200,
             color: witheColor,
             child: Image.network(widget.productModel.imageProduct),
           ),
           Padding(
             padding: const EdgeInsets.all(24.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(widget.productModel.nameProduct,
                   style:regulerTextStyle.copyWith(fontSize:24) ,
                 ),
                 SizedBox(height: 16,),
                 Text(widget.productModel.description,
                   style:regulerTextStyle.copyWith(
                       fontSize:14,
                   color: Colors.grey
                   ) ,
                   textAlign: TextAlign.justify,
                 ),
                 SizedBox(height: 90,),
                 Row(
                   children: [
                     Spacer(),
                     Text(
                      "\$ " + priceFormat.format(int.parse(widget.productModel.price)),
                       style: boldTextStyle.copyWith(fontSize: 20),
                     ),
                   ],
                 ),
                 SizedBox(height: 24,),
                 Container(
                   width: MediaQuery.of(context).size.width,
                   child: ButtonPrimary(
                     onTap: (){
                       addToCart();
                     },
                     text: "ADD TO CART",
                   ),
                 )
               ],
             ),
           ),

         ],
       ),
     ),
    );
  }
String? userID;
  getPref()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  setState(() {
    userID = sharedPreferences.getString(PrefProfile.idUser);
  });
  }
  addToCart() async {
   var urlAddToCart = Uri.parse(BASEURL.addToCArt);
   final response = await http.post(urlAddToCart,body: {
     "id_user" : userID,
     "id_product":widget.productModel.idProduct,
   });
   final data = jsonDecode(response.body);
   int value = data['value'];
   String message = data['message'];
   if(value == 1){
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
   setState(() {

   });
   }else{
     showDialog(
         barrierDismissible: false,
         context: context,
         builder: (context) => AlertDialog(
           title: Text("Information"),
           content: Text(message),
           actions: [TextButton(onPressed: () {
             Navigator.pop(context);
           }, child: Text("ok"))],
         )
     );
     setState(() {

     });
   }
  }

}
