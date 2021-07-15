import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/theme.dart';

class WidgetIlustraion extends StatelessWidget {

  final Widget? child;
  final String? image;
  final String? title;
  final String? subtitle1;
  final String? subtitle2;

  WidgetIlustraion({
     this.child, this.image, this.title, this.subtitle1, this.subtitle2,
});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
         image!,
          width: 280,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          title!,
          style: regulerTextStyle.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16,),
        Column(
          children: [
            Text(
               subtitle1!,
              style: regulerTextStyle.copyWith(fontSize: 22,color: greyLightColor),

            ),
            SizedBox(height: 9,),
            Text(
                subtitle2!,
              style: regulerTextStyle.copyWith(fontSize: 22,color: greyLightColor),

            ),
            SizedBox(height: 75),

            child ?? SizedBox(),
          ],
        )
      ],
    );
  }
}
