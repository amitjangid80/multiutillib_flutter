// Created by AMIT JANGID on 19/08/20.

import 'package:flutter/material.dart';

/// [MaterialCard] This widget will show a card view widget
class MaterialCard extends StatelessWidget {
  final Color color;
  final Widget child;
  final Function? onTap;
  final Color? shadowColor;
  final double? elevation, borderRadius;
  final EdgeInsetsGeometry margin, padding;
  final BorderRadiusGeometry? borderRadiusGeometry;

  const MaterialCard({
    required this.child,
    this.onTap,
    this.shadowColor,
    this.borderRadius,
    this.elevation = 4,
    this.borderRadiusGeometry,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.only(top: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Material(
          color: color,
          elevation: elevation!,
          type: MaterialType.card,
          clipBehavior: Clip.antiAlias,
          shadowColor: shadowColor ?? Colors.grey[200],
          borderRadius: borderRadius == null ? borderRadiusGeometry : BorderRadius.circular(borderRadius!),
          child: Container(padding: padding, child: child),
        ),
      ),
    );
  }
}
