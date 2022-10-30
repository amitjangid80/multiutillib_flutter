// Created by AMIT JANGID on 26/12/20.

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// [getAppVersion] method
/// this method will return the current version of the app
Future<String> getAppVersion() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

/// [getDeviceName] method
/// this method will get device or model name of the device
Future<String?> getDeviceName() async {
  String? deviceName;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    deviceName = androidDeviceInfo.model;
  } else if (Platform.isIOS) {
    final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    deviceName = iosDeviceInfo.name;
  }

  return deviceName;
}

/// [getDeviceId] method
/// this method will get device info like model name and device id
Future<String> getDeviceId() async {
  String deviceId;
  final DeviceInfoPlugin deviceInfoPlugin1 = DeviceInfoPlugin();
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final deviceInfo1 = await deviceInfoPlugin1.deviceInfo;
  final deviceData = deviceInfo1.data;
  debugPrint('device data is: $deviceData');

  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.id;
  } else {
    final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor!;
  }

  return deviceId;
}

/// [getSingleDigitRandomNumber] method
/// this method will return a single digit random number
String getSingleDigitRandomNumber() {
  const int min = 1, max = 9;
  final Random rnd = Random.secure();

  final int number = min + rnd.nextInt(max - min);
  debugPrint('generated random single digit number is: $number');

  return number.toString();
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

  final rnd = Random.secure();
  final number = min + rnd.nextInt(max - min);
  debugPrint('generated random number between $min & $max is: $number');

  return number.toString();
}

/// [getRandomMobileNumber] method
/// this method will return randomly generated mobile number
String getRandomMobileNumber() {
  const min = 700000000, max = 999999999;

  /// calling get random number method
  return getRandomNumber(min: min, max: max);
}

/// [getCharFromString] method
/// this method will return characters from string passed
String getCharFromString({required String stringToExtract}) {
  if (stringToExtract.isEmpty) {
    return 'String passed cannot be empty';
  }

  const Pattern pattern = '[^A-Za-z]';
  final RegExp regex = RegExp(pattern as String);

  return stringToExtract.replaceAll(regex, ' ');
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

  const Pattern pattern = r'\d+';
  final RegExp regex = RegExp(pattern as String);

  return regex.stringMatch(stringToExtract);
}

Future<String?> convertImageToBase64({required String imagePath}) async {
  try {
    if (imagePath.isEmpty) return null;

    final File file = File(imagePath);
    final Uint8List imageBytes = await file.readAsBytes();
    final String base64 = base64Encode(imageBytes);

    return base64;
  } catch (e, s) {
    debugPrint('exception while converting image path to byte array: ${e.toString()}');
    debugPrint('exception while converting image path to byte array: ${s.toString()}');

    return null;
  }
}

Future<Uint8List?> convertBase64ToImage({required String base64}) async {
  try {
    if (base64.isEmpty) return null;

    final Uint8List imageBytes = base64Decode(base64);

    return imageBytes;
  } catch (e, s) {
    debugPrint('exception while converting image to byte array: ${e.toString()}');
    debugPrint('exception while converting image to byte array: ${s.toString()}');

    return null;
  }
}
