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
        borderRadius: BorderRadius.circular(this.cornerRadius),
        color: this.backgroundColor,
        boxShadow: [
           BoxShadow(
              color: Colors.black.withAlpha((this.shadowOpacity * 255).toInt()),
              blurRadius: this.shadowRadius,
              offset: this.shadowOffset)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(this.cornerRadius)),
        child: this.child == null ? Container() : this.child,
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
