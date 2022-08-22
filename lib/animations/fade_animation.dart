// Created by AMIT JANGID on 26/05/20.

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum _AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({Key? key, required this.delay, required this.child}) : super(key: key);

  /// Animates a widget to show fade transition.
  /// [PlayAnimation] from [simple_animations] package
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(_AniProps.translateY, Tween(begin: -30.0, end: 0.0), const Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation(
      tween: tween,
      duration: tween.duration,
      delay: Duration(milliseconds: (500 * delay).round()),
      builder: (context, child, dynamic value) {
        return Opacity(
          opacity: value.get(_AniProps.opacity),
          child: Transform.translate(offset: Offset(0, value.get(_AniProps.translateY)), child: child),
        );
      },
      child: child,
    );
  }
}
