// Created By Amit Jangid 13/07/21

import 'dart:io';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? centerTitle;
  final double elevation;
  final bool isHomeScreen;
  final TextStyle titleStyle;
  final List<Widget> actions;
  final VoidCallback? onBackButtonPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle,
    this.elevation = 4,
    this.actions = const [],
    this.onBackButtonPressed,
    this.isHomeScreen = false,
    this.titleStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      elevation: elevation,
      centerTitle: centerTitle,
      title: Text(title, style: titleStyle),
      leading: IconButton(
        onPressed: onBackButtonPressed ?? () => isHomeScreen ? exit(0) : Navigator.pop(context),
        icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
