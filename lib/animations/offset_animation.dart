// Created by AMIT JANGID on 02/03/21.

import 'package:flutter/material.dart';

/// [OffsetAnimation] class
/// This class will play an offset animation to the provided widget
class OffsetAnimation extends AnimatedWidget {
  /// Pass the end value if you want to add custom end value
  /// this will add margin to the child horizontally
  final double end;

  /// Pass widget on which the animation will be performed
  final Widget widget;

  /// Pass animation controller to perform animation
  final AnimationController animationController;

  OffsetAnimation({
    Key? key,
    this.end = 15.0,
    required this.animationController,
    required this.widget,
  }) : super(
            key: key,
            listenable:
                Tween(begin: 0.0, end: end).chain(CurveTween(curve: Curves.elasticIn)).animate(animationController)
                  ..addStatusListener((status) {
                    if (status == AnimationStatus.completed) animationController.reverse();
                  }));

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Container(
        padding: EdgeInsets.only(left: animation.value + end, right: end - animation.value),
        child: widget,
      ),
    );
  }
}
