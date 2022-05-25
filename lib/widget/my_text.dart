import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {

  String text;
  double padding;
  double fontSize;
  Color color;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
   return  Padding(
     padding: EdgeInsets.all(padding),
     child: Text(text,
         style: TextStyle(
             fontSize: fontSize,
             color: Colors.white,
             fontWeight: fontWeight)),
   );
  }

  MyText(
      {Key? key,
        this.text = "",
        this.padding = 10,
        this.fontSize = 20,
        this.color = Colors.white,
        this.fontWeight = FontWeight.w400}) : super(key: key);

}