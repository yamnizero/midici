import 'package:flutter/material.dart';
import 'package:medicine_2/constants/theme.dart';
import 'package:medicine_2/network/model/history_model.dart';

class CartHistory extends StatelessWidget {

  final HistoryOrderModel model;

  CartHistory(
      {required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("INV" + model.invoice,style: boldTextStyle.copyWith(fontSize: 16),),
            Icon(Icons.arrow_forward_ios,size: 14,),
          ],
        ),
        Text(model.orderAt),
        SizedBox(
          height: 12.0,
        ),
        Text(model.status == "1"
              ? "Order is being confirmed"
              : "Order successful",),
        Divider(),
      ],
    );
  }
}
