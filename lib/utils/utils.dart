// Created by AMIT JANGID on 26/12/20.

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

/// [getAppVersion] method
/// this method will return the current version of the app
Future<String> getAppVersion() async {
  final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
  return _packageInfo.version;
}

/// [getDeviceName] method
/// this method will get device or model name of the device
Future<String?> getDeviceName() async {
  String? _deviceName;
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final AndroidDeviceInfo _androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
    _deviceName = _androidDeviceInfo.model;
  } else if (Platform.isIOS) {
    final IosDeviceInfo _iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
    _deviceName = _iosDeviceInfo.name;
  }

  return _deviceName;
}

/// [getDeviceId] method
/// this method will get device info like model name and device id
Future<String> getDeviceId() async {
  String _deviceId;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final AndroidDeviceInfo _androidInfo = await _deviceInfo.androidInfo;
    _deviceId = _androidInfo.androidId;
  } else {
    final IosDeviceInfo _iosDeviceInfo = await _deviceInfo.iosInfo;
    _deviceId = _iosDeviceInfo.identifierForVendor;
  }

  return _deviceId;
}

/// [replaceNullWithEmpty] method
/// this method will check and replace null with an empty string
@Deprecated('You can use .replaceNullWithEmpty extension.')
String replaceNullWithEmpty(String? data) {
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

/// [replaceNullWithZero] method
/// this method will check and replace null with an integer value
@Deprecated('You can use .replaceNullWithZero extension.')
int replaceNullWithZero(String? data) {
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

/// [replaceNullWithDouble] method
/// this method will check and replace null with an double value
@Deprecated('You can use .replaceNullWithDouble extension.')
double replaceNullWithDouble(String? data) {
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

/// [replaceTrueOrFalse] method
/// this method will check and replace true/false value with integer value
@Deprecated('You can use .replaceTrueOrFalse extension.')
int replaceTrueOrFalse(data) => data.toString().toLowerCase() == 'true' ? 1 : 0;

/// [formatNumber] method
/// this method will format the number in default pattern or custom pattern
@Deprecated('You can use .formatNumber extension method.')
String formatNumber({required String numberToFormat, String customPattern = '##,###,###.##'}) {
  return NumberFormat.currency(decimalDigits: 2, customPattern: customPattern).format(numberToFormat);
}

/// [isNumeric] method
/// this method will check if passed string is numeric or not
@Deprecated('You can use .isNumeric extension.')
bool isNumeric(String s) {
  return double.tryParse(s) != null;
}

/// [getSingleDigitRandomNumber] method
/// this method will return a single digit random number
String getSingleDigitRandomNumber() {
  const int _min = 1, _max = 9;
  final Random _rnd = Random.secure();

  final int _number = _min + _rnd.nextInt(_max - _min);
  debugPrint('generated random single digit number is: $_number');

  return _number.toString();
}

/// [getRandomNumber] method
/// this method will return a random number between min and max number passed
String getRandomNumber({required int min, required int max}) {
  if (min <= 0 || max <= 0) {
    return 'min or max value cannot be less than or equal to zero';
  }

  if (max < min) {
    return 'min value cannot be greater than max value';
  }

  final _rnd = Random.secure();
  final _number = min + _rnd.nextInt(max - min);
  debugPrint('generated random number between $min & $max is: $_number');

  return _number.toString();
}

/// [getRandomMobileNumber] method
/// this method will return randomly generated mobile number
String getRandomMobileNumber() {
  const _min = 700000000, _max = 999999999;

  /// calling get random number method
  return getRandomNumber(min: _min, max: _max);
}

/// [getCharFromString] method
/// this method will return characters from string passed
String getCharFromString({required String stringToExtract}) {
  if (stringToExtract.isEmpty) {
    return 'String passed cannot be empty';
  }

  const Pattern _pattern = r'[^A-Za-z]';
  final RegExp _regex = RegExp(_pattern as String);

  return stringToExtract.replaceAll(_regex, ' ');
}

/// [getNumbersFromString] method
/// this method will return all the digits from string passed
String? getNumbersFromString({String? stringToExtract}) {
  if (stringToExtract == null) {
    return 'String passed cannot be null';
  }

  if (stringToExtract.isEmpty) {
    return 'String passed cannot be empty';
  }

  const Pattern _pattern = r'\d+';
  final RegExp _regex = RegExp(_pattern as String);

  return _regex.stringMatch(stringToExtract);
}
