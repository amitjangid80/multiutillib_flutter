// Created by AMIT JANGID on 26/05/20.

import 'package:flutter/material.dart';

import 'package:multiutillib/enums/slide_animation_type.dart';

class SlideAnimation extends StatefulWidget {
  final Widget child;
  final int itemCount, position;
  final SlideDirection slideDirection;
  final AnimationController animationController;

  const SlideAnimation({
    Key? key,
    required this.position,
    required this.itemCount,
    required this.animationController,
    required this.child,
    this.slideDirection = SlideDirection.fromRight,
  }) : super(key: key);

  @override
  SlideAnimationState createState() => SlideAnimationState();
}

class SlideAnimationState extends State<SlideAnimation> with SingleTickerProviderStateMixin {
  /// Animates a widget to slide from either direction.
  /// Using [AnimatedBuilder] for animation
  @override
  Widget build(BuildContext context) {
    var yTranslation = 0.0, xTranslation = 0.0;

    final slideAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval((1 / widget.itemCount) * widget.position, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    widget.animationController.forward();

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        if (widget.slideDirection == SlideDirection.fromTop) {
          yTranslation = -50 * (1.0 - slideAnimation.value);
        } else if (widget.slideDirection == SlideDirection.fromBottom) {
          yTranslation = 50 * (1.0 - slideAnimation.value);
        } else if (widget.slideDirection == SlideDirection.fromRight) {
          xTranslation = 400 * (1.0 - slideAnimation.value);
        } else {
          xTranslation = -400 * (1.0 - slideAnimation.value);
        }

        return FadeTransition(
          opacity: slideAnimation,
          child: Transform(
            transform: Matrix4.translationValues(xTranslation, yTranslation, 0.0),
            child: widget.child,
          ),
        );
      },
    );
  }
}
