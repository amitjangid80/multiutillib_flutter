// Created by AMIT JANGID on 18/08/20.

import 'package:flutter/material.dart';

/// This widget will build a custom shaped Button
class DefaultButton extends StatelessWidget {
  final String text;
  final Color btnColor;
  final Function onPressed;
  final OutlinedBorder shape;
  final TextStyle btnTextStyle;
  final double height, elevation;
  final EdgeInsetsGeometry margin;
  final bool isEnabled, isUpperCase;

  DefaultButton({
    this.btnColor,
    this.height = 50,
    this.elevation = 4,
    this.isEnabled = true,
    this.isUpperCase = true,
    this.margin = const EdgeInsets.only(top: 10),
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
    this.btnTextStyle = const TextStyle(
      fontSize: 16,
      letterSpacing: 0.27,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        child: Text(text, style: btnTextStyle),
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          shape: shape,
          primary: btnColor,
          elevation: elevation,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
