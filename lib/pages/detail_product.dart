import 'package:flutter/material.dart';
import 'package:medicine_2/network/model/product_model.dart';

import '../theme.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  DetailProduct(this.productModel);
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
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
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 InkWell(
                     onTap:(){
                       Navigator.pop(context);
                     },
                     child: Icon(Icons.arrow_back_rounded,size: 32,color: greenColor,)),
                 Text(
                     "Detail Product",
                   style: regulerTextStyle.copyWith(fontSize: 24),
                 )
               ],
             ),
           ),
         ],
       ),
     ),
    );
  }
}
