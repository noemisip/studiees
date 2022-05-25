import 'package:flutter/material.dart';

class RoundedShadowView extends StatelessWidget {
  Widget? child;
  double cornerRadius;
  double shadowRadius;
  Offset shadowOffset;
  double shadowOpacity;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius),
        color: backgroundColor,
        boxShadow: [
           BoxShadow(
              color: Colors.black.withAlpha((shadowOpacity * 255).toInt()),
              blurRadius: shadowRadius,
              offset: shadowOffset)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
        child: child ?? Container(),
      ),
    );
  }

  RoundedShadowView(
      {this.child,
        this.cornerRadius = 20,
        this.shadowRadius = 20,
        this.shadowOffset = const Offset(0, 2),
        this.shadowOpacity = 0.3,
        this.backgroundColor = Colors.white});
}
