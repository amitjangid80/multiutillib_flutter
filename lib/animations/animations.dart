// Created by AMIT JANGID on 08/05/20.

import 'package:flutter/material.dart';

class Animations {
  /// [fromRight] Slide animation, from right to left
  /// This method uses [SlideTransition] widget
  static Widget fromRight(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(end: Offset.zero, begin: const Offset(1.0, 0.0))
          .animate(animation),
      child: child,
    );
  }

  /// [fromLeft] Slide animation, from left to right
  /// This method uses [SlideTransition] widget
  static Widget fromLeft(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(end: Offset.zero, begin: const Offset(-1.0, 0.0))
          .animate(animation),
      child: child,
    );
  }

  /// [fromTop] Slide animation, from top to bottom
  /// This method uses [SlideTransition] widget
  static Widget fromTop(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, -1.0))
          .animate(animation),
      child: child,
    );
  }

  /// [fromBottom] Slide animation, from top to bottom
  /// This method uses [SlideTransition] widget
  static Widget fromBottom(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 1.0))
          .animate(animation),
      child: child,
    );
  }

  /// [grow] Scale animation, from in to out
  /// This method uses [ScaleTransition] widget
  static Widget grow(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(end: 1.0, begin: 0.0).animate(CurvedAnimation(
          parent: animation, curve: const Interval(0.00, 0.50))),
      child: child,
    );
  }
}
