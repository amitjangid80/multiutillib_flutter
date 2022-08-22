// Created by AMIT JANGID on 26/12/20.

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:multiutillib/multiutillib.dart';

/// [getCurrentDate] method
/// this method will get current date in format provided.
String getCurrentDate({String? newDateTimeFormat}) {
  if (newDateTimeFormat != null && newDateTimeFormat.isNotEmpty) {
    return DateFormat(newDateTimeFormat).format(DateTime.now());
  } else {
    return DateFormat(kDefaultDateTimeFormat).format(DateTime.now());
  }
}

/// [formatDateTime] method
/// this method will format a date string in default or format provided.
@Deprecated('Use .toDisplayDate extension instead.')
String formatDateTime(String dateTime, {String? newDateTimeFormat}) {
  dateTime = dateTime.replaceNullWithEmpty;

  if (dateTime.toString().isNotEmpty) {
    /// formatting date in yyyy-MM-dd HH:mm:ss format
    dateTime = DateFormat(newDateTimeFormat ?? kDefaultDateTimeFormat).format(DateTime.parse(dateTime));
  }

  return dateTime;
}

/// [convertTimeOfDay] method
/// this method will convert time of day to date time format
@Deprecated('Use .toDisplayTime extension instead.')
String convertTimeOfDay(TimeOfDay timeOfDay, {String? timeFormat}) {
  final now = DateTime.now();
  final DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

  /// calling format date time method to convert time of day for display
  return formatDateTime(dateTime.toString(), newDateTimeFormat: timeFormat ?? kTimeDisplayFormat);
}
