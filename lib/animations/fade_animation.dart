// Created by AMIT JANGID on 26/05/20.

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum _AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({Key? key, required this.delay, required this.child})
      : super(key: key);

  /// Animates a widget to show fade transition.
  /// [PlayAnimation] from [simple_animations] package
  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(_AniProps.translateY, Tween(begin: -30.0, end: 0.0),
          const Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation(
      tween: _tween,
      duration: _tween.duration,
      delay: Duration(milliseconds: (500 * delay).round()),
      builder: (context, _child, dynamic _value) {
        return Opacity(
          opacity: _value.get(_AniProps.opacity),
          child: Transform.translate(
              offset: Offset(0, _value.get(_AniProps.translateY)),
              child: _child),
        );
      },
      child: child,
    );
  }
}
