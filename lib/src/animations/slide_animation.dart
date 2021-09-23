// Created by AMIT JANGID on 26/05/20.

import 'package:flutter/material.dart';

import 'package:multiutillib/src/enums/slide_animation_type.dart';

class SlideAnimation extends StatefulWidget {
  final Widget child;
  final int itemCount, position;
  final SlideDirection slideDirection;
  final AnimationController animationController;

  const SlideAnimation({
    required this.position,
    required this.itemCount,
    required this.animationController,
    required this.child,
    this.slideDirection = SlideDirection.fromRight,
  });

  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation> with SingleTickerProviderStateMixin {
  /// Animates a widget to slide from either direction.
  /// Using [AnimatedBuilder] for animation
  @override
  Widget build(BuildContext context) {
    var _yTranslation = 0.0, _xTranslation = 0.0;

    final _slideAnimation = Tween(begin: 0.0, end: 1.0).animate(
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
          _yTranslation = -50 * (1.0 - _slideAnimation.value);
        } else if (widget.slideDirection == SlideDirection.fromBottom) {
          _yTranslation = 50 * (1.0 - _slideAnimation.value);
        } else if (widget.slideDirection == SlideDirection.fromRight) {
          _xTranslation = 400 * (1.0 - _slideAnimation.value);
        } else {
          _xTranslation = -400 * (1.0 - _slideAnimation.value);
        }

        return FadeTransition(
          opacity: _slideAnimation,
          child: Transform(
            transform: Matrix4.translationValues(_xTranslation, _yTranslation, 0.0),
            child: widget.child,
          ),
        );
      },
    );
  }
}
