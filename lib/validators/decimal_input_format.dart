// Created by AMIT JANGID on 19/08/20.

import 'dart:math' as math;

import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  DecimalInputFormatter({this.decimalRange}) : assert(decimalRange == null || decimalRange > 0);

  final int? decimalRange;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String truncated = newValue.text;
    TextSelection newSelection = newValue.selection;

    if (decimalRange != null) {
      final String value = newValue.text;

      if (value.contains(".") && value.substring(value.indexOf(".") + 1).length > decimalRange!) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(text: truncated, selection: newSelection);
    }

    return newValue;
  }
}
