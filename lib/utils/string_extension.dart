// Created by AMIT JANGID on 26/02/21.

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

extension StringExtension on dynamic {
  /// [toInt] extension
  /// this method can be used on string as an extension to convert a string into integer
  int get toInt => int.tryParse(this);

  /// [toDouble] extension
  /// this method can be used on string as an extension to convert a string into double
  double get toDouble => double.tryParse(this);

  /// [replaceTrueOrFalse] extension
  /// this method will check and replace true/false value with integer value
  int get replaceTrueOrFalse => _replaceTrueOrFalse(this);

  /// [replaceNullWithZero] extension
  /// this method will check and replace null with an integer value
  int get replaceNullWithZero => _replaceNullWithZero(this);

  /// [toTwoDigits] extension
  /// this extension will convert a string to two digits
  String get toTwoDigits => _digitsString(this, lengthOfString: 2);

  /// [toThreeDigits] extension
  /// this extension will convert a string to three digits
  String get toThreeDigits => _digitsString(this, lengthOfString: 3);

  /// [toLengthOfString] extension
  /// this extension will convert a string to the length specified
  String toLengthOfString(lengthOfString) => _digitsString(this, lengthOfString: lengthOfString);

  /// [replaceNullWithEmpty] method
  /// this method will check and replace null with an empty string
  String get replaceNullWithEmpty => _replaceNullWithEmpty(this);

  /// [replaceNullWithDouble] method
  /// this method will check and replace null with an double value
  double get replaceNullWithDouble => _replaceNullWithDouble(this);
}

extension NumberExtension<T extends dynamic> on dynamic {
  /// [formatNumber] method
  /// this method will format the number in default pattern or custom pattern
  String formatNumber({String customPattern}) => _formatNumber(numberToFormat: this, customPattern: customPattern);

  /// [isNumeric] extension
  /// this extension will check if passed string is numeric or not
  bool get isNumeric => double.tryParse(this?.toString() ?? '') != null;
}

/// [_replaceTrueOrFalse] method
/// this method will check and replace true/false value with integer value
int _replaceTrueOrFalse(data) => data?.toString()?.toLowerCase() == 'true' ? 1 : 0;

/// [_replaceNullWithEmpty] method
/// this method will check and replace null with an empty string
String _replaceNullWithEmpty(data) {
  if (data == null) {
    return '';
  } else if (data.toString().toLowerCase() == 'null') {
    return '';
  } else if (data.toString().isEmpty) {
    return '';
  } else {
    return data;
  }
}

/// [_replaceNullWithZero] method
/// this method will check and replace null with an integer value
int _replaceNullWithZero(data) {
  if (data == null) {
    return 0;
  } else if (data.toString().toLowerCase() == 'null') {
    return 0;
  } else if (data.toString().isEmpty) {
    return 0;
  } else {
    return int.parse(data.toString());
  }
}

/// [_replaceNullWithDouble] method
/// this method will check and replace null with an double value
double _replaceNullWithDouble(data) {
  if (data.toString() == null) {
    return 0.0;
  } else if (data.toString().toLowerCase() == 'null') {
    return 0.0;
  } else if (data.toString().isEmpty) {
    return 0.0;
  } else {
    return double.parse(data.toString());
  }
}

/// [_formatNumber] method
/// this method will format the number in default pattern or custom pattern
String _formatNumber({@required var numberToFormat, String customPattern}) {
  if (numberToFormat == null) numberToFormat = 0;
  var _numberToFormat = double.parse(numberToFormat.toString());

  return NumberFormat.currency(decimalDigits: 2, customPattern: customPattern ?? '##,###,###.##')
      .format(_numberToFormat);
}

String _digitsString(dynamic n, {int lengthOfString}) => n.toString().padLeft(lengthOfString ?? 2, "0");
