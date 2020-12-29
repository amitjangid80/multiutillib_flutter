// Created by AMIT JANGID on 08/05/20.

import 'package:flutter/material.dart';

class Animations {
  // Slide animation, from right to left (SlideTransition)
  static fromRight(Animation<double> animation, Widget child) {
    return SlideTransition(
      child: child,
      position: Tween<Offset>(end: Offset.zero, begin: const Offset(1.0, 0.0)).animate(animation),
    );
  }

  // Slide animation, from left to right (SlideTransition)
  static fromLeft(Animation<double> animation, Widget child) {
    return SlideTransition(
      child: child,
      position: Tween<Offset>(end: Offset.zero, begin: const Offset(-1.0, 0.0)).animate(animation),
    );
  }

  // Slide animation, from top to bottom (SlideTransition)
  static fromTop(Animation<double> animation, Widget child) {
    return SlideTransition(
      child: child,
      position: Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, -1.0)).animate(animation),
    );
  }

  // Slide animation, from top to bottom (SlideTransition)
  static fromBottom(Animation<double> animation, Widget child) {
    return SlideTransition(
      child: child,
      position: Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 1.0)).animate(animation),
    );
  }

  // Scale animation, from in to out (ScaleTransition)
  static grow(Animation<double> animation, Widget child) {
    return ScaleTransition(
      child: child,
      scale: Tween<double>(end: 1.0, begin: 0.0)
          .animate(CurvedAnimation(parent: animation, curve: const Interval(0.00, 0.50, curve: Curves.linear))),
    );
  }

  // Scale animation, from out to in (ScaleTransition)
  static shrink(Animation<double> animation, Widget child) {
    return ScaleTransition(
      child: child,
      scale: Tween<double>(end: 1.0, begin: 1.2)
          .animate(CurvedAnimation(parent: animation, curve: const Interval(0.50, 1.00, curve: Curves.linear))),
    );
  }
}
