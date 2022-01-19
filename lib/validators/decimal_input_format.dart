// Created by AMIT JANGID on 19/08/20.

import 'dart:math' as math;

import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  DecimalInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int? decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String _truncated = newValue.text;
    TextSelection _newSelection = newValue.selection;

    if (decimalRange != null) {
      final String _value = newValue.text;

      if (_value.contains(".") &&
          _value.substring(_value.indexOf(".") + 1).length > decimalRange!) {
        _truncated = oldValue.text;
        _newSelection = oldValue.selection;
      } else if (_value == ".") {
        _truncated = "0.";

        _newSelection = newValue.selection.copyWith(
          baseOffset: math.min(_truncated.length, _truncated.length + 1),
          extentOffset: math.min(_truncated.length, _truncated.length + 1),
        );
      }

      return TextEditingValue(text: _truncated, selection: _newSelection);
    }

    return newValue;
  }
}
