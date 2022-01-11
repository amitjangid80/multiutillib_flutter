// Created by AMIT JANGID on 19/08/20.

import 'package:flutter/material.dart';

import 'package:multiutillib/utils/constants.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';

/// This widget is used to show messages for network operations
/// This widget uses [ConnectivityWidgetWrapper] from [connectivity_wrapper] package
@Deprecated('Connectivity Layout is deprecated and will be removed in future version.')
class ConnectivityLayout extends StatelessWidget {
  final bool stacked;
  final Widget child;
  final Color bgColor;
  final String message;
  final TextStyle messageStyle;
  final bool disableInteraction;
  final AlignmentGeometry alignment;

  const ConnectivityLayout({
    Key? key,
    required this.child,
    this.stacked = false,
    this.bgColor = Colors.red,
    this.disableInteraction = false,
    this.message = kInternetNotAvailable,
    this.alignment = Alignment.bottomCenter,
    this.messageStyle = const TextStyle(color: Colors.white),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ConnectivityWidgetWrapper(
        color: bgColor,
        message: message,
        stacked: stacked,
        alignment: alignment,
        messageStyle: messageStyle,
        disableInteraction: disableInteraction,
        child: child,
      ),
    );
  }
}
