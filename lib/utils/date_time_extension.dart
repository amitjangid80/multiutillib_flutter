// Created by AMIT JANGID on 26/02/21.

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:multiutillib/multiutillib.dart';

extension DurationExtension<T extends String> on String {
  /// [toDuration] extension
  /// this extension will convert a string into [Duration] object
  Duration get toDuration => _parseDuration(this);

  /// [toDateTime] extension
  /// this extension will convert a string into [DateTime] object
  DateTime get toDateTime => DateTime.tryParse(this);

  /// [toTimeOfDay] extension
  /// this extension will convert a string into [TimeOfDay] object
  TimeOfDay get toTimeOfDay => _convertDateTimeString(this);

  /// [formatDateTime] extension method
  /// this extension method will convert a date time string into provided or default date time format string
  String formatDateTime({String newDateTimeFormat}) => _formatDateTime(this, newDateTimeFormat: newDateTimeFormat);

  /// [formatTime] extension method
  /// this extension method will convert a date time string into provided or default time format string
  String formatTime({String newTimeFormat}) => _convertTimeString(this, newTimeFormat: newTimeFormat);
}

extension DateTimeExtension<T extends DateTime> on DateTime {
  /// [toTimeOfDay] extension
  /// this extension will convert a string into [TimeOfDay] object
  TimeOfDay get toTimeOfDay => TimeOfDay.fromDateTime(this);

  /// [formatDateTime] extension method
  /// this extension method will convert a date time into provided or default date time format string
  String formatDateTime({String newDateTimeFormat}) =>
      _formatDateTime(this.toString(), newDateTimeFormat: newDateTimeFormat);
}

extension FromDurationExtension<T extends Duration> on Duration {
  /// [toTimeString] extension method
  /// this method will convert the provided duration into default time String
  String toTimeString({String newTimeString}) => _convertToTimeString(this, newTimeString: newTimeString);
}

extension TimeOfDayExtension<T extends TimeOfDay> on TimeOfDay {
  /// [formatTime] extension method
  /// this extension method will convert a time of day into provided or default time format string
  String formatTime({String newTimeFormat}) => _convertTimeOfDay(this, newTimeFormat: newTimeFormat);
}

/// [_parseDuration] method
/// this method will convert a string into duration and will return duration
Duration _parseDuration(String _timeString) {
  int _hours = 0, _minutes = 0, _seconds = 0;

  /// splitting date time string into parts
  List<String> _parts = _timeString.split(':');

  /// checking length of parts is greater than 2
  if (_parts.length > 2) {
    _hours = int.parse(_parts[_parts.length - 3]);
  }

  /// checking length of parts is greater than 1
  if (_parts.length > 1) {
    _minutes = int.parse(_parts[_parts.length - 2]);
  }

  /// converting remaining or single part of string to int
  _seconds = int.parse(_parts[_parts.length - 1]);

  /// returning duration after getting all the values
  return Duration(hours: _hours, minutes: _minutes, seconds: _seconds);
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

/// [_convertDateTimeString] method
/// this method will convert a date time string into time of day object
TimeOfDay _convertDateTimeString(String _dateTime) {
  List<String> _parts = _dateTime.split(":");
  TimeOfDay _timeOfDay = TimeOfDay(hour: _parts[0].toInt, minute: _parts[1].toInt);

  return _timeOfDay;
}


/// [_convertTimeString] method
/// this method will convert time string to time format passed or default
String _convertTimeString(String _time, {String newTimeFormat}) {
  List<String> _parts = _time.split(":");
  TimeOfDay _timeOfDay = TimeOfDay(hour: _parts[0].toInt, minute: _parts[1].toInt);

  /// calling _convertTimeOfDay method for converting time string
  return _convertTimeOfDay(_timeOfDay, newTimeFormat: newTimeFormat);
}


/// [_convertTimeOfDay] method
/// this method will convert time of day to time format passed or default
String _convertTimeOfDay(TimeOfDay timeOfDay, {String newTimeFormat}) {
  final now = DateTime.now();
  DateTime _dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

  // calling .formatDateTime extension method to convert date time object to string to display time in given format
  return _dateTime.formatDateTime(newDateTimeFormat: newTimeFormat ?? kTimeDisplayFormat);
}

String _convertToTimeString(Duration duration, {String newTimeString}) {
  String _twoDigitHours = duration.inHours.toTwoDigits;
  String _twoDigitMinutes = duration.inMinutes.remainder(60).toTwoDigits;
  String _twoDigitSeconds = duration.inSeconds.remainder(60).toTwoDigits;

  DateTime _now = DateTime.now();

  DateTime _dateTime = DateTime(
    _now.year,
    _now.month,
    _now.day,
    _twoDigitHours.toInt,
    _twoDigitMinutes.toInt,
    _twoDigitSeconds.toInt,
  );

  // calling .formatDateTime extension method to convert date time to string in given format
  return _dateTime.formatDateTime(newDateTimeFormat: newTimeString ?? kTimeDisplayFormat);
}
