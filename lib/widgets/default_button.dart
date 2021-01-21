// Created by AMIT JANGID on 18/08/20.

import 'package:flutter/material.dart';

/// This widget will build a custom shaped Button
class DefaultButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final bool isEnabled, isUpperCase;

  DefaultButton({
    this.isEnabled = true,
    this.borderRadius = 24,
    this.isUpperCase = true,
    this.margin = const EdgeInsets.only(top: 10),
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      child: RaisedButton(
        onPressed: isEnabled ? onPressed : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        child: Text(isUpperCase ? text.toUpperCase() : text, style: Theme.of(context).textTheme.button),
      ),
    );
  }
}
