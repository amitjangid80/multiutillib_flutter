// Created By Amit Jangid on 21/01/22

import 'package:flutter/material.dart';

class Arc extends CustomPainter {
  final Color _color;
  final double _strokeWidth;
  final double _sweepAngle;
  final double _startAngle;

  Arc._(this._color, this._strokeWidth, this._startAngle, this._sweepAngle);

  static Widget draw({
    required Color color,
    required double size,
    required double endAngle,
    required double startAngle,
    required double strokeWidth,
  }) =>
      SizedBox(width: size, height: size, child: CustomPaint(painter: Arc._(color, strokeWidth, startAngle, endAngle)));

  @override
  void paint(Canvas canvas, Size size) {
    const bool _useCenter = false;
    final Rect _rect = Rect.fromCircle(radius: size.height / 2, center: Offset(size.width / 2, size.height / 2));

    final Paint _paint = Paint()
      ..color = _color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = _strokeWidth;

    canvas.drawArc(_rect, _startAngle, _sweepAngle, _useCenter, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
