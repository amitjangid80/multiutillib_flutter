// Created By Amit Jangid on 21/01/22

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:multiutillib/widgets/loader/draw_dots.dart';

class ThreeRotatingDots extends StatefulWidget {
  final double size;
  final Color color;

  const ThreeRotatingDots({Key? key, required this.color, required this.size}) : super(key: key);

  @override
  _ThreeRotatingDotsState createState() => _ThreeRotatingDotsState();
}

class _ThreeRotatingDotsState extends State<ThreeRotatingDots> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color;
    final double size = widget.size;
    final double dotSize = size / 3;
    final double edgeOffset = (size - dotSize) / 2;

    const Interval firstDotsInterval = Interval(0.0, 0.50, curve: Curves.easeInOutCubic);
    const Interval secondDotsInterval = Interval(0.50, 1.0, curve: Curves.easeInOutCubic);

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Transform.translate(
          offset: Offset(0, size / 12),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _BuildDot.first(
                endAngle: 0,
                color: color,
                size: dotSize,
                beginAngle: math.pi,
                dotOffset: edgeOffset,
                interval: firstDotsInterval,
                controller: _animationController,
              ),

              _BuildDot.first(
                color: color,
                size: dotSize,
                dotOffset: edgeOffset,
                endAngle: 2 * math.pi / 3,
                interval: firstDotsInterval,
                beginAngle: 5 * math.pi / 3,
                controller: _animationController,
              ),

              _BuildDot.first(
                color: color,
                size: dotSize,
                dotOffset: edgeOffset,
                endAngle: 4 * math.pi / 3,
                beginAngle: 7 * math.pi / 3,
                interval: firstDotsInterval,
                controller: _animationController,
              ),

              /// Next 3 dots
              _BuildDot.second(
                color: color,
                beginAngle: 0,
                size: dotSize,
                endAngle: -math.pi,
                dotOffset: edgeOffset,
                interval: secondDotsInterval,
                controller: _animationController,
              ),

              _BuildDot.second(
                color: color,
                size: dotSize,
                dotOffset: edgeOffset,
                endAngle: -math.pi / 3,
                beginAngle: 2 * math.pi / 3,
                interval: secondDotsInterval,
                controller: _animationController,
              ),

              _BuildDot.second(
                color: color,
                size: dotSize,
                endAngle: math.pi / 3,
                dotOffset: edgeOffset,
                interval: secondDotsInterval,
                beginAngle: 4 * math.pi / 3,
                controller: _animationController,
              ),
            ],
          ),
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

class _BuildDot extends StatelessWidget {
  final AnimationController controller;
  final double beginAngle;
  final double endAngle;
  final Interval interval;
  final double dotOffset;
  final Color color;
  final double size;
  final bool first;

  const _BuildDot.first({
    Key? key,
    required this.controller,
    required this.beginAngle,
    required this.endAngle,
    required this.interval,
    required this.dotOffset,
    required this.color,
    required this.size,
  })  : first = true,
        super(key: key);

  const _BuildDot.second({
    Key? key,
    required this.controller,
    required this.beginAngle,
    required this.endAngle,
    required this.interval,
    required this.dotOffset,
    required this.color,
    required this.size,
  })  : first = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: first ? controller.value <= interval.end : controller.value >= interval.begin,
      child: Transform.rotate(
        angle: Tween<double>(end: endAngle, begin: beginAngle)
            .animate(CurvedAnimation(parent: controller, curve: interval))
            .value,
        child: Transform.translate(
          offset: Tween<Offset>(
            end: first ? Offset(0, -dotOffset) : Offset.zero,
            begin: first ? Offset.zero : Offset(0, -dotOffset),
          ).animate(CurvedAnimation(curve: interval, parent: controller)).value,
          child: DrawDot.circular(color: color, dotSize: size),
        ),
      ),
    );
  }
}
