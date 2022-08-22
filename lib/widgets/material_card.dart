// Created by AMIT JANGID on 19/08/20.

import 'package:flutter/material.dart';

/// [MaterialCard] This widget will show a card view widget
class MaterialCard extends StatelessWidget {
  final Color color;
  final Widget child;
  final Color? shadowColor;
  final GestureTapCallback? onTap;
  final double? elevation, borderRadius;
  final EdgeInsetsGeometry margin, padding;
  final BorderRadiusGeometry? borderRadiusGeometry;

  const MaterialCard({
    Key? key,
    required this.child,
    this.onTap,
    this.shadowColor,
    this.borderRadius,
    this.elevation = 4,
    this.borderRadiusGeometry,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.only(top: 12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: InkWell(
        onTap: onTap,
        child: Material(
          color: color,
          elevation: elevation!,
          type: MaterialType.card,
          clipBehavior: Clip.antiAlias,
          shadowColor: shadowColor ?? Colors.grey[200],
          borderRadius: borderRadius == null ? borderRadiusGeometry : BorderRadius.circular(borderRadius!),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
