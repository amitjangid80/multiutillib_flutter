// Created By Amit Jangid on 12/11/21

import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  Timer? _timer;
  final int milliseconds;

  Debounce({this.milliseconds = 500});

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer?.cancel();

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() => _timer?.cancel();
}
