// Created by AMIT JANGID on 18/08/20.

import 'package:flutter/material.dart';

/// This widget will build a custom shaped Button
class DefaultButton extends StatelessWidget {
  final String? text;
  final Color? btnColor;
  final OutlinedBorder shape;
  final TextStyle? btnTextStyle;
  final VoidCallback? onPressed;
  final double height, elevation;
  final EdgeInsetsGeometry margin;
  final bool isEnabled, isUpperCase;

  const DefaultButton({
    super.key,
    this.btnColor,
    this.height = 48,
    this.elevation = 4,
    this.isEnabled = true,
    this.isUpperCase = false,
    this.margin = const EdgeInsets.only(top: 12),
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
    this.btnTextStyle = const TextStyle(
      fontSize: 18,
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
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          shape: shape,
          elevation: elevation,
          backgroundColor: btnColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        child: Text(isUpperCase ? text!.toUpperCase() : text!, style: btnTextStyle),
      ),
    );
  }
}
