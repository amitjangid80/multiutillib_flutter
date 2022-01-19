// Created by AMIT JANGID on 06/07/20.

import 'package:flutter/material.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:multiutillib/animations/animations.dart';
import 'package:multiutillib/widgets/default_button.dart';
import 'package:multiutillib/enums/dialog_animation_type.dart';

/// This method will show a dialog box with custom UI and animation
showCustomDialog(
  BuildContext context, {
  String btnText = kOK,
  Color btnColor = Colors.blue,
  bool barrierDismissible = false,
  Color dividerColor = Colors.blue,
  TextAlign descTextAlign = TextAlign.center,
  TextAlign titleTextAlign = TextAlign.center,
  Duration transitionDuration = const Duration(milliseconds: 400),
  DialogAnimationType dialogAnimationType = DialogAnimationType.grow,
  TextStyle descStyle =
      const TextStyle(fontSize: 16, letterSpacing: 0.27, color: Colors.black),
  TextStyle btnStyle = const TextStyle(
      fontSize: 18, letterSpacing: 0.27, fontWeight: FontWeight.w400),
  TextStyle titleStyle = const TextStyle(
      fontSize: 18, letterSpacing: 0.27, fontWeight: FontWeight.bold),
  required String title,
  required String description,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: barrierDismissible,
    transitionDuration: transitionDuration,
    barrierColor: Colors.black.withOpacity(0.4),
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
      return _CustomDialog(
        title: title,
        btnText: btnText,
        btnColor: btnColor,
        btnStyle: btnStyle,
        descStyle: descStyle,
        titleStyle: titleStyle,
        description: description,
        dividerColor: dividerColor,
        descTextAlign: descTextAlign,
        titleTextAlign: titleTextAlign,
      );
    },
  );
}

class _CustomDialog extends StatelessWidget {
  final Color dividerColor, btnColor;
  final String title, btnText, description;
  final TextAlign titleTextAlign, descTextAlign;
  final TextStyle btnStyle, titleStyle, descStyle;

  const _CustomDialog({
    required this.title,
    required this.btnText,
    required this.btnColor,
    required this.btnStyle,
    required this.descStyle,
    required this.titleStyle,
    required this.description,
    required this.dividerColor,
    required this.descTextAlign,
    required this.titleTextAlign,
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius)),
        child: Stack(
          children: <Widget>[
            Container(
              width: _width,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(
                  top: 24, left: 20, right: 20, bottom: 80),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_borderRadius)),
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
                    child: Text(description,
                        style: descStyle, textAlign: descTextAlign),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 0,
              child: DefaultButton(
                text: btnText,
                btnColor: btnColor,
                btnTextStyle: btnStyle,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
