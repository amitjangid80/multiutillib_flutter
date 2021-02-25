// Created by AMIT JANGID on 18/08/20.

import 'package:flutter/material.dart';

/// This widget will build a custom shaped Button
class DefaultButton extends StatelessWidget {
  final String text;
  final Color btnColor;
  final Function onPressed;
  final double borderRadius;
  final TextStyle btnTextStyle;
  final EdgeInsetsGeometry margin;
  final bool isEnabled, isUpperCase;

  DefaultButton({
    this.btnColor,
    this.isEnabled = true,
    this.borderRadius = 24,
    this.isUpperCase = true,
    this.margin = const EdgeInsets.only(top: 10),
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
      margin: margin,
      width: double.infinity,
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        child: Text(text, style: btnTextStyle),
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
      ),
    );
  }
}
