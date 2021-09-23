// Created by AMIT JANGID on 26/02/21.

import 'package:intl/intl.dart';

extension StringExtension<T extends String> on String {
  /// [toInt] extension
  /// this method can be used on string as an extension to convert a string into integer
  int? get toInt => int.tryParse(this);

  /// [toDouble] extension
  /// this method can be used on string as an extension to convert a string into double
  double? get toDouble => double.tryParse(this);

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

extension NumberExtension<T extends String> on String {
  /// [formatNumberToCompact] method
  /// this method will format the number in compact view i.e. 1K, 2K etc
  String get formatNumberToCompact => _formatNumberToCompact(numberToFormat: this);

  /// [formatNumber] method
  /// this method will format the number in default pattern or custom pattern
  String formatNumber({String? customPattern}) => _formatNumber(numberToFormat: this, customPattern: customPattern);

  /// [isNumeric] extension
  /// this extension will check if passed string is numeric or not
  bool get isNumeric => double.tryParse(this) != null;
}

/// [_replaceTrueOrFalse] method
/// this method will check and replace true/false value with integer value
int _replaceTrueOrFalse(data) => data?.toString().toLowerCase() == 'true' ? 1 : 0;

/// [_replaceNullWithEmpty] method
/// this method will check and replace null with an empty string
String _replaceNullWithEmpty(String data) {
  if (data.isEmpty) {
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
  if (data == null) {
    return 0.0;
  } else if (data.toString().toLowerCase() == 'null') {
    return 0.0;
  } else if (data.toString().isEmpty) {
    return 0.0;
  } else {
    return double.parse(data.toString());
  }
}

String _formatNumberToCompact({String? numberToFormat}) {
  numberToFormat ??= '0';
  final _numberToFormat = double.parse(numberToFormat);

  return NumberFormat.compactCurrency(symbol: '', decimalDigits: 2).format(_numberToFormat);
}

/// [_formatNumber] method
/// this method will format the number in default pattern or custom pattern
String _formatNumber({required var numberToFormat, String? customPattern}) {
  numberToFormat ??= 0;
  final _numberToFormat = double.parse(numberToFormat.toString());

  return NumberFormat.currency(decimalDigits: 2, customPattern: customPattern ?? '##,###,###.##')
      .format(_numberToFormat);
}

String _digitsString(dynamic n, {int? lengthOfString}) => n.toString().padLeft(lengthOfString ?? 2, "0");
