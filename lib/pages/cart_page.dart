import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_2/constants/theme.dart';
import 'package:medicine_2/network/api/url_api.dart';
import 'package:medicine_2/network/model/cart_model.dart';
import 'package:medicine_2/network/model/pref_profile.dart';
import 'package:medicine_2/pages/main_page.dart';
import 'package:medicine_2/pages/success.checkout.dart';
import 'package:medicine_2/widget/button_primery.dart';
import 'package:medicine_2/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final VoidCallback method;
  CartPage(this.method);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final price =NumberFormat("#,##0","EN_US");
  late String userID, fullName, address, phone;
  int delivery = 0;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser)!;
      fullName = sharedPreferences.getString(PrefProfile.name)!;
      address = sharedPreferences.getString(PrefProfile.address)!;
      phone = sharedPreferences.getString(PrefProfile.phone)!;
    });
    getCart();
    cartTotalPrice();
  }

  List<CartModel> listCart = [];
   Future getCart() async {
    listCart.clear();
    var urlGetCart = Uri.parse(BASEURL.getProductCart + userID);
    final response = await http.get(urlGetCart);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listCart.add(CartModel.fromJson(item));
        }
      });
    }
  }



  Future updateQuantity(String model,String write) async {
    var urlUpdateQuantity = Uri.parse(BASEURL.updateQuantityProductCart);
      final  response = await http.post(urlUpdateQuantity,body:{
        "cartID" : model,
        "write" : write
      } );
      final data = jsonDecode(response.body);
      int value = data['value'];
      String message = data['message'];
      if(value == 1){
        print(message);
        setState(() {
            getPref();
            widget.method();
        });
      }else{
        print(message);
        setState(() {

          getPref();
        });
      }


  }

  var sumPrice = "0";
  int totalPayment = 0;
  Future  cartTotalPrice() async {
    var urlTotalPrice = Uri.parse(BASEURL.totalPriceCart + userID);
    final response = await http.get(urlTotalPrice);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      String total = data['Total'];
      setState(() {
        sumPrice = total;
        totalPayment = sumPrice == null ? 0: int.parse(sumPrice) + delivery;
      });
    }

   }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: listCart.length == 0
          ? SizedBox()
      :
      Container(
        padding: EdgeInsets.all(24),
        height: 220,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xfffcfcfc),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Item",
                  style: regulerTextStyle.copyWith(
                      fontSize: 16, color: Colors.grey),
                ),
                Text(
                  "\$ " + price.format(int.parse(sumPrice)),
                  style:
                      boldTextStyle.copyWith(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Free",
                  style: regulerTextStyle.copyWith(
                      fontSize: 16, color: Colors.grey),
                ),
                Text(
                  delivery == 0 ? "FREE" : delivery.toString(),
                  style:
                      boldTextStyle.copyWith(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Payment",
                  style: regulerTextStyle.copyWith(
                      fontSize: 16, color: Colors.grey),
                ),
                Text(
                  "\$" + price.format(totalPayment),
                  style:
                      boldTextStyle.copyWith(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ButtonPrimary(text: "CHECKOUT NOW",
                  onTap: () {
                     checkout();
                  }),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 32,
                        color: greenColor,
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "My Cart ",
                    style: regulerTextStyle.copyWith(fontSize: 25),
                  ),
                ],
              ),
            ),
            listCart.length == 0 || listCart.length == null
                ? Container(
              padding: EdgeInsets.all(24),
                  margin: EdgeInsets.only(top: 45),
                  child: WidgetIlustraion(
              image:"assets/empty_cart_ilustration.png" ,
              title: "Sorry , there are no product in your cart",
              subtitle1: "Your Cart is still empty, browse the",
              subtitle2: " attractive product from MEDICINE",
                    child: Container(
                      margin: EdgeInsets.only(top: 65),
                      width: MediaQuery.of(context).size.width,
                      child: ButtonPrimary(
                        text: "SHOPPING NOW",
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context)=> MainPages()),
                                  (route) => false);
                        },
                      ),
                    ),
              ),
                )
                : Container(
              height: 166,
              child: Padding(
                padding:  EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Destination",
                      style: regulerTextStyle.copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name",
                          style: regulerTextStyle.copyWith(
                              fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          "$fullName",
                          style: regulerTextStyle.copyWith(
                              fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address",
                          style: regulerTextStyle.copyWith(
                              fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          "$address",
                          style: regulerTextStyle.copyWith(
                              fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone",
                          style: regulerTextStyle.copyWith(
                              fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          "$phone",
                          style: regulerTextStyle.copyWith(
                              fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
                itemCount: listCart.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, i) {
                  final x = listCart[i];
                  return Container(
                    padding: EdgeInsets.all(24),
                    color: witheColor,
                    child: Column(

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              x.image!,
                              width: 115,
                              height: 100,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    x.name!,
                                  overflow: TextOverflow.clip,
                                    style:
                                        regulerTextStyle.copyWith(fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            updateQuantity(
                                              x.idCart!,
                                                'add',
                                                );
                                          },
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: greenColor,
                                          )),
                                      Text(x.quantity!),
                                      IconButton(
                                          onPressed: () {
                                            updateQuantity(
                                              x.idCart!, 'less',
                                                );
                                          },
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color: Colors.red.shade300,
                                          )),
                                    ],
                                  ),
                                  Text(
                                    "\$"+ price.format(int.parse(x.price!)),
                                    style: boldTextStyle.copyWith(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider()
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }


  Future checkout() async{
    var uriChekout =Uri.parse(BASEURL.checkout);
    final response =await http.post(uriChekout,body: {
      "idUser" : userID,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if(value == 1) {
         Navigator.pushAndRemoveUntil(
             context, MaterialPageRoute(builder: (context)=>SuccessCheckout()),
                 (route) => false);
    }else{

    }
  }



}
