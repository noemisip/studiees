import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
        this.controller,
        this.hintText,
        this.obscureText = false,
        this.inputType = TextInputType.text,
        this.maxLines = 1,
        this.enabled = true,
        this.rightIcon,
        this.validator,
        this.margin = EdgeInsets.zero,
        this.onChanged})
      : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType inputType;
  final bool enabled;
  final int maxLines;
  final EdgeInsets margin;
  final Widget? rightIcon;
  final String Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Stack(
          alignment: Alignment.center,
          children: [
      Container(
      child: Container(height: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white)),
    ),
  ],
  ),
  );
}
}
