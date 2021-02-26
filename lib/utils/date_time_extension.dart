// Created by AMIT JANGID on 26/02/21.

import 'package:flutter/material.dart';

import '../constants.dart';
import 'string_extension.dart';
import 'package:intl/intl.dart';

extension DurationExtension<T extends String> on String {
  /// [toDuration] extension
  /// this extension will convert a string into [Duration] object
  Duration get toDuration => _parseDuration(this);

  /// [toDateTime] extension
  /// this extension will convert a string into [DateTime] object
  DateTime get toDateTime => DateTime.tryParse(this);

  /// [toDisplayDate] extension method
  /// this extension method will convert a date time string into provided or default date time format string
  String toDisplayDate({String newDateTimeFormat}) => _formatDateTime(this, newDateTimeFormat: newDateTimeFormat);

  /// [toDisplayTime] extension method
  /// this extension method will convert a date time string into provided or default time format string
  String toDisplayTime({String newTimeFormat}) => _formatDateTime(this, newDateTimeFormat: newTimeFormat);
}

extension DateTimeExtension<T extends DateTime> on DateTime {
  /// [toDisplayDate] extension method
  /// this extension method will convert a date time into provided or default date time format string
  String toDisplayDate({String newDateTimeFormat}) =>
      _formatDateTime(this.toString(), newDateTimeFormat: newDateTimeFormat);

  /// [toDisplayTime] extension method
  /// this extension method will convert a date time into provided or default time format string
  String toDisplayTime({String newTimeFormat}) => _formatDateTime(this.toString(), newDateTimeFormat: newTimeFormat);
}

extension TimeOfDayExtension<T extends TimeOfDay> on TimeOfDay {
  /// [toDisplayTime] extension method
  /// this extension method will convert a time of day into provided or default time format string
  String toDisplayTime({String newTimeFormat}) => _convertTimeOfDay(this, newTimeFormat: newTimeFormat);
}

/// [_parseDuration] method
/// this method will convert a string into duration and will return duration
Duration _parseDuration(String _datetimeString) {
  int _hours = 0, _minutes = 0, _micros;

  /// splitting date time string into parts
  List<String> _parts = _datetimeString.split(':');

  /// checking length of parts is greater than 2
  if (_parts.length > 2) {
    _hours = int.parse(_parts[_parts.length - 3]);
  }

  /// checking length of parts is greater than 1
  if (_parts.length > 1) {
    _minutes = int.parse(_parts[_parts.length - 2]);
  }

  /// converting remaining or single part of string to int
  _micros = (double.parse(_parts[_parts.length - 1]) * 1000000).round();

  /// returning duration after getting all the values
  return Duration(hours: _hours, minutes: _minutes, microseconds: _micros);
}

/// [_formatDateTime] method
/// this method will format a date string in default or format provided.
String _formatDateTime(String dateTime, {String newDateTimeFormat}) {
  dateTime = dateTime.replaceNullWithEmpty;

  if (dateTime.toString().length > 0) {
    /// formatting date in yyyy-MM-dd HH:mm:ss default format
    dateTime = DateFormat('${newDateTimeFormat ?? kDefaultDateTimeFormat}').format(DateTime.parse(dateTime));
  }

  return dateTime;
}

/// [_convertTimeOfDay] method
/// this method will convert time of day to date time format
String _convertTimeOfDay(TimeOfDay timeOfDay, {String newTimeFormat}) {
  final now = DateTime.now();
  DateTime _dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

  // calling .toDisplayDate extension method to convert date time object to string to display time in given format
  return _dateTime.toDisplayDate(newDateTimeFormat: newTimeFormat);
}
