// Created by AMIT JANGID on 18/08/20.

import 'package:flutter/material.dart';

/// This widget will build a custom shaped Button
class DefaultButton extends StatelessWidget {
  final String? text;
  final Color? btnColor;
  final Function onPressed;
  final OutlinedBorder shape;
  final TextStyle? btnTextStyle;
  final double height, elevation;
  final EdgeInsetsGeometry margin;
  final bool isEnabled, isUpperCase;

  const DefaultButton({
    this.btnColor,
    this.height = 50,
    this.elevation = 4,
    this.isEnabled = true,
    this.isUpperCase = false,
    this.margin = const EdgeInsets.only(top: 10),
    this.shape = const RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(30))),
    this.btnTextStyle = const TextStyle(
      fontSize: 16,
      letterSpacing: 0.27,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        onPressed: isEnabled ? onPressed as void Function()? : null,
        child: Text(isUpperCase ? text!.toUpperCase() : text!, style: btnTextStyle),
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
