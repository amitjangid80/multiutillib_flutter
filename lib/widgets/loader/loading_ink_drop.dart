// Created By Amit Jangid on 21/01/22

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:multiutillib/widgets/loader/draw_arc.dart';

class LoadingInkDrop extends StatefulWidget {
  final double size;
  final Color color;
  final Color ringColor;

  const LoadingInkDrop({Key? key, required this.size, required this.color, this.ringColor = const Color(0x1A000000)})
      : super(key: key);

  @override
  _LoadingInkDropState createState() => _LoadingInkDropState();
}

class _LoadingInkDropState extends State<LoadingInkDrop> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color;
    final Color ringColor = widget.ringColor;

    final double size = widget.size;
    final double strokeWidth = size / 5;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Arc.draw(
              size: size,
              color: ringColor,
              endAngle: 2 * math.pi,
              startAngle: math.pi / 2,
              strokeWidth: strokeWidth,
            ),
            Visibility(
              visible: _animationController.value <= 0.9,
              child: Transform.translate(
                offset: Tween<Offset>(end: Offset.zero, begin: Offset(0, -size))
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.05, 0.4, curve: Curves.easeInCubic),
                      ),
                    )
                    .value,
                child: Arc.draw(
                  strokeWidth: strokeWidth,
                  size: size,
                  color: color,
                  startAngle: -3 * math.pi / 2,
                  // endAngle: math.pi / (size * size),
                  endAngle: Tween<double>(end: math.pi / 1.13, begin: math.pi / (size * size))
                      .animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.38, 0.9)))
                      .value,
                ),
              ),
            ),
            Visibility(
              visible: _animationController.value <= 0.9,
              child: Transform.translate(
                offset: Tween<Offset>(end: Offset.zero, begin: Offset(0, -size))
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.05, 0.4, curve: Curves.easeInCubic),
                      ),
                    )
                    .value,
                child: Arc.draw(
                  strokeWidth: strokeWidth,
                  size: size,
                  color: color,
                  startAngle: -3 * math.pi / 2,
                  endAngle: Tween<double>(end: -math.pi / 1.13, begin: math.pi / (size * size))
                      .animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.38, 0.9)))
                      .value,
                ),
              ),
            ),

            /// Right
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: -math.pi / 4,
                endAngle: Tween<double>(end: -math.pi / 4, begin: -math.pi / 7.4)
                    .animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.9, 0.96)))
                    .value,
              ),
            ),
            // Left
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: -3 * math.pi / 4,
                // endAngle: math.pi / 4
                // endAngle: math.pi / 7.4
                endAngle: Tween<double>(end: math.pi / 4, begin: math.pi / 7.4)
                    .animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.9, 0.96)))
                    .value,
              ),
            ),

            /// Right
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: -math.pi / 3.5,
                // endAngle: math.pi / 28,
                endAngle: Tween<double>(end: math.pi / 28, begin: math.pi / 1.273)
                    .animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.9, 1.0)))
                    .value,
              ),
            ),

            /// Left
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: math.pi / 0.778,
                // endAngle: -math.pi / 1.273
                // endAngle: -math.pi / 27

                endAngle: Tween<double>(end: -math.pi / 27, begin: -math.pi / 1.273)
                    .animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.9, 1.0)))
                    .value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}
