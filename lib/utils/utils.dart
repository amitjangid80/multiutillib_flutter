// Created by AMIT JANGID on 26/12/20.

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:device_info/device_info.dart';

/*
 * 2020 December 23 - Saturday
 * get device name method
 *
 * this method will get device or model name of the device
**/
Future<String> getDeviceName() async {
  String _deviceName;
  DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo _androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
    _deviceName = _androidDeviceInfo.model;
  } else {
    IosDeviceInfo _iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
    _deviceName = _iosDeviceInfo.name;
  }

  return _deviceName;
}

/*
 * 2020 December 23 - Saturday
 * get device info method
 *
 * this method will get device info like model name and device id
**/
Future<String> getDeviceId() async {
  String _deviceId;
  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo _androidInfo = await _deviceInfo.androidInfo;
    _deviceId = _androidInfo.androidId;
  } else {
    IosDeviceInfo _iosDeviceInfo = await _deviceInfo.iosInfo;
    _deviceId = _iosDeviceInfo.identifierForVendor;
  }

  return _deviceId;
}

/*
 * 2020 December 23 - Saturday
 * replace null with empty method
 *
 * this method will check and replace null with an empty string
**/
String replaceNullWithEmpty(data) {
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

/*
 * 2020 December 23 - Saturday
 * replace null with zero method
 *
 * this method will check and replace null with an integer value
**/
int replaceNullWithZero(data) {
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

/*
 * 2020 December 23 - Saturday
 * replace null with double method
 *
 * this method will check and replace null with an double value
**/
double replaceNullWithDouble(data) {
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

/*
 * 2020 December 23 - Saturday
 * replace true or false method
 *
 * this method will check and replace true/false value with integer value
**/
int replaceTrueOrFalse(data) {
  return data.toString().toLowerCase() == 'true' ? 1 : 0;
}

formatNumber({@required var numberToFormat, String customPattern = '##,###,###.##'}) {
  if (numberToFormat == null) {
    numberToFormat = 0;
  }

  return NumberFormat.currency(decimalDigits: 2, customPattern: customPattern).format(numberToFormat);
}
