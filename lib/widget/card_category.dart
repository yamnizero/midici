import 'package:flutter/material.dart';
import 'package:medicine_2/theme.dart';

class CardCategory extends StatelessWidget {
  //
  final String imageCatrgory;
  final String nameCatrgory;

   CardCategory({required this.imageCatrgory, required this.nameCatrgory}) ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
         imageCatrgory,
          width: 65,
        ),
        SizedBox(height: 10,),
        Text(nameCatrgory,style: mediumTextStyle.copyWith(fontSize: 10),),
      ],
    );
  }
}
