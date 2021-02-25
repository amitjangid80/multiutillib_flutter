// Created by AMIT JANGID on 26/12/20.

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:multiutillib/utils/utils.dart';

const String kDateDisplayFormat = 'dd/MM/yyyy';
const String kFullMonthYearFormat = 'MMMM-yyyy';
const String kFullDateDisplayFormat = 'dd MMMM, yyyy';
const String kDefaultDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

/// [getCurrentDate] method
/// this method will get current date in format provided.
String getCurrentDate({String newDateTimeFormat}) {
  if (newDateTimeFormat != null && newDateTimeFormat.isNotEmpty) {
    return DateFormat('$newDateTimeFormat').format(DateTime.now());
  } else {
    return DateFormat('$kDefaultDateTimeFormat').format(DateTime.now());
  }
}

/// [formatDateTime] method
/// this method will format a date string in default or format provided.
String formatDateTime(dateTime, {String newDateTimeFormat}) {
  dateTime = replaceNullWithEmpty(dateTime);

  if (dateTime.toString().length > 0) {
    /// formatting date in yyyy-MM-dd HH:mm:ss format
    dateTime = DateFormat('${newDateTimeFormat ?? kDefaultDateTimeFormat}').format(DateTime.parse(dateTime));
  }

  return dateTime;
}

/// [convertTimeOfDay] method
/// this method will convert time of day to date time format
String convertTimeOfDay(TimeOfDay timeOfDay, {String timeFormat}) {
  final now = new DateTime.now();
  DateTime _dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

  /// calling format date time method to convert time of day for display
  return formatDateTime(_dateTime.toString(), newDateTimeFormat: timeFormat ?? 'hh:mm a');
}

extension ParseDurationExtension<T extends String> on String {
  Duration get toDuration => _parseDuration();

  Duration _parseDuration() {
    List<String> _parts = this.split(':');
    int _hours = 0, _minutes = 0, _micros;

    if (_parts.length > 2) {
      _hours = int.parse(_parts[_parts.length - 3]);
    }

    if (_parts.length > 1) {
      _minutes = int.parse(_parts[_parts.length - 2]);
    }

    _micros = (double.parse(_parts[_parts.length - 1]) * 1000000).round();
    return Duration(hours: _hours, minutes: _minutes, microseconds: _micros);
  }
}

/*
extension TimeExtension<T extends Duration> on Duration {
  /// calling convert min to hours method
  String get toHours => this.inHours.toString();

  /// [_convertMinToHours] method
  /// this method will convert minutes into hours
  String _convertMinToHours(int minutes) {
    var _duration = Duration(minutes: minutes);
    List<String> _parts = _duration.toString().split(":");
    return '${_parts[0].padLeft(2, '0')}:${_parts[1].padLeft(2, '0')}';
  }
}
*/
