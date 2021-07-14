import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class CardProduct extends StatelessWidget {
final String imageProduct;
final String nameProduct;
final String price;

   CardProduct({ required this.imageProduct, required this.nameProduct, required this.price});
  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat("#,##0","EN_US");
    return Container(
      decoration:BoxDecoration(
        color: witheColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
        Image.network(
          imageProduct,
           width: 115,
           height: 70,
        ),
          SizedBox(height: 16,),
          Text(
            nameProduct,
            style: regulerTextStyle,textAlign: TextAlign.center,),
          SizedBox(height: 14,),
          Text(
           priceFormat.format(int.parse(price)),
            style: boldTextStyle,)
       ],
      ),
    );
  }
}
