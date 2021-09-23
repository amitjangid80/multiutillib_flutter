// Created by AMIT JANGID on 17/07/20.

import 'package:flutter/material.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:multiutillib/animations/animations.dart';
import 'package:multiutillib/widgets/default_button.dart';
import 'package:multiutillib/enums/dialog_animation_type.dart';

/// This method will show a dialog box with custom UI and animation
showConfirmationDialog(
  BuildContext context, {
  Widget? transitionAnimation,
  String negativeBtnText = kNo,
  String positiveBtnText = kYes,
  bool barrierDismissible = false,
  Color dividerColor = Colors.blue,
  Color negativeBtnColor = Colors.red,
  Color positiveBtnColor = Colors.blue,
  TextAlign descTextAlign = TextAlign.center,
  TextAlign titleTextAlign = TextAlign.center,
  Duration transitionDuration = const Duration(milliseconds: 400),
  DialogAnimationType dialogAnimationType = DialogAnimationType.grow,
  TextStyle descStyle = const TextStyle(fontSize: 16, letterSpacing: 0.27, color: Colors.black),
  TextStyle titleStyle = const TextStyle(fontSize: 18, letterSpacing: 0.27, fontWeight: FontWeight.bold),
  TextStyle positiveBtnStyle = const TextStyle(fontSize: 18, letterSpacing: 0.27, fontWeight: FontWeight.w400),
  TextStyle negativeBtnStyle = const TextStyle(fontSize: 18, letterSpacing: 0.27, fontWeight: FontWeight.w400),
  required String title,
  required String description,
  required VoidCallback onPositivePressed,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: barrierDismissible,
    transitionDuration: transitionDuration,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      switch (dialogAnimationType) {
        case DialogAnimationType.grow:
          return Animations.grow(animation, child);

        case DialogAnimationType.fromTop:
          return Animations.fromTop(animation, child);

        case DialogAnimationType.fromLeft:
          return Animations.fromLeft(animation, child);

        case DialogAnimationType.fromRight:
          return Animations.fromRight(animation, child);

        case DialogAnimationType.fromBottom:
          return Animations.fromBottom(animation, child);

        default:
          return Animations.grow(animation, child);
      }
    },
    pageBuilder: (BuildContext context, animation, secondaryAnimation) {
      return _CustomConfirmDialog(
        title: title,
        descStyle: descStyle,
        titleStyle: titleStyle,
        description: description,
        dividerColor: dividerColor,
        descTextAlign: descTextAlign,
        titleTextAlign: titleTextAlign,
        positiveBtnText: positiveBtnText,
        negativeBtnText: negativeBtnText,
        positiveBtnColor: positiveBtnColor,
        negativeBtnColor: negativeBtnColor,
        positiveBtnStyle: positiveBtnStyle,
        negativeBtnStyle: negativeBtnStyle,
        onPositivePressed: onPositivePressed,
      );
    },
  );
}

class _CustomConfirmDialog extends StatelessWidget {
  final VoidCallback onPositivePressed;
  final TextAlign titleTextAlign, descTextAlign;
  final Color dividerColor, positiveBtnColor, negativeBtnColor;
  final String title, description, negativeBtnText, positiveBtnText;
  final TextStyle titleStyle, descStyle, positiveBtnStyle, negativeBtnStyle;

  const _CustomConfirmDialog({
    required this.title,
    required this.descStyle,
    required this.titleStyle,
    required this.description,
    required this.dividerColor,
    required this.descTextAlign,
    required this.titleTextAlign,
    required this.negativeBtnText,
    required this.positiveBtnText,
    required this.positiveBtnColor,
    required this.negativeBtnColor,
    required this.positiveBtnStyle,
    required this.negativeBtnStyle,
    required this.onPositivePressed,
  });

  @override
  Widget build(BuildContext context) {
    const double _borderRadius = 20;
    final double _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
        child: Stack(
          children: <Widget>[
            Container(
              width: _width,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 80),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(_borderRadius)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(title, style: titleStyle, textAlign: titleTextAlign),
                  Container(
                    height: 1.5,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        12,
                        (index) => Container(
                          width: 6,
                          height: 1.5,
                          color: dividerColor,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(description, style: descStyle, textAlign: descTextAlign),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DefaultButton(
                      text: negativeBtnText,
                      btnColor: negativeBtnColor,
                      btnTextStyle: negativeBtnStyle,
                      onPressed: () => Navigator.pop(context, ""),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DefaultButton(
                      text: positiveBtnText,
                      btnColor: positiveBtnColor,
                      onPressed: onPositivePressed,
                      btnTextStyle: positiveBtnStyle,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
