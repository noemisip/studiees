import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {

  String text;
  double padding;
  double fontsize;
  Color color;
  FontWeight fontweight;

  @override
  Widget build(BuildContext context) {
   return  Padding(
     padding: EdgeInsets.all(padding),
     child: Text(text,
         style: TextStyle(
             fontSize: fontsize,
             color: Colors.white,
             fontWeight: fontweight)),
   );
  }

  MyText(
      {Key? key,
        this.text = "",
        this.padding = 10,
        this.fontsize = 20,
        this.color = Colors.white,
        this.fontweight = FontWeight.w400}) : super(key: key);

}