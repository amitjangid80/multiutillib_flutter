// Created by AMIT JANGID on 26/02/21.

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:multiutillib/utils/string_extension.dart';

extension DurationExtension<T extends String> on String {
  /// [toDuration] extension
  /// this extension will convert a string into [Duration] object
  Duration get toDuration => _parseDuration(this);

  /// [toDateTime] extension
  /// this extension will convert a string into [DateTime] object
  DateTime? get toDateTime => DateTime.tryParse(this);

  /// [toTimeOfDay] extension
  /// this extension will convert a string into [TimeOfDay] object
  TimeOfDay get toTimeOfDay => _convertDateTimeString(this);

  /// [formatDateTime] extension method
  /// this extension method will convert a date time string into provided or default date time format string
  String formatDateTime({String? newDateTimeFormat}) => _formatDateTime(this, newDateTimeFormat: newDateTimeFormat);

  /// [formatTime] extension method
  /// this extension method will convert a date time string into provided or default time format string
  String formatTime({String? newTimeFormat}) => _convertTimeString(this, newTimeFormat: newTimeFormat);
}

extension DateTimeExtension<T extends DateTime> on DateTime {
  /// [toTimeOfDay] extension
  /// this extension will convert a string into [TimeOfDay] object
  TimeOfDay get toTimeOfDay => TimeOfDay.fromDateTime(this);

  /// [formatDateTime] extension method
  /// this extension method will convert a date time into provided or default date time format string
  String formatDateTime({String? newDateTimeFormat}) => _formatDateTime(this, newDateTimeFormat: newDateTimeFormat);
}

extension FromDurationExtension<T extends Duration> on Duration {
  /// [toTimeString] extension method
  /// this method will convert the provided duration into default time String
  String toTimeString({String? newTimeString}) => _convertToTimeString(this, newTimeString: newTimeString);
}

extension TimeOfDayExtension<T extends TimeOfDay> on TimeOfDay {
  /// [formatTime] extension method
  /// this extension method will convert a time of day into provided or default time format string
  String formatTime({String? newTimeFormat}) => _convertTimeOfDay(this, newTimeFormat: newTimeFormat);
}

/// [_parseDuration] method
/// this method will convert a string into duration and will return duration
Duration _parseDuration(String timeString) {
  int hours = 0, minutes = 0, seconds = 0;

  /// splitting date time string into parts
  final List<String> parts = timeString.split(':');

  /// checking length of parts is greater than 2
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }

  /// checking length of parts is greater than 1
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }

  /// converting remaining or single part of string to int
  seconds = int.parse(parts[parts.length - 1]);

  /// returning duration after getting all the values
  return Duration(hours: hours, minutes: minutes, seconds: seconds);
}

/// [_formatDateTime] method
/// this method will format a date string in default or format provided.
String _formatDateTime(dateTime, {String? newDateTimeFormat}) {
  dateTime = dateTime.toString().replaceNullWithEmpty;

  if (dateTime.toString().isNotEmpty) {
    /// formatting date in yyyy-MM-dd HH:mm:ss default format
    dateTime = DateFormat(newDateTimeFormat ?? kDefaultDateTimeFormat).format(DateTime.parse(dateTime));
  }

  return dateTime.toString();
}

/// [_convertDateTimeString] method
/// this method will convert a date time string into time of day object
TimeOfDay _convertDateTimeString(String dateTime) {
  final List<String> parts = dateTime.split(":");
  final TimeOfDay timeOfDay = TimeOfDay(hour: parts[0].toInt!, minute: parts[1].toInt!);

  return timeOfDay;
}

/// [_convertTimeString] method
/// this method will convert time string to time format passed or default
String _convertTimeString(String time, {String? newTimeFormat}) {
  final List<String> parts = time.split(":");
  final TimeOfDay timeOfDay = TimeOfDay(hour: parts[0].toInt!, minute: parts[1].toInt!);

  /// calling _convertTimeOfDay method for converting time string
  return _convertTimeOfDay(timeOfDay, newTimeFormat: newTimeFormat);
}

/// [_convertTimeOfDay] method
/// this method will convert time of day to time format passed or default
String _convertTimeOfDay(TimeOfDay timeOfDay, {String? newTimeFormat}) {
  final now = DateTime.now();
  final DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

  // calling .formatDateTime extension method to convert date time object to string to display time in given format
  return dateTime.formatDateTime(newDateTimeFormat: newTimeFormat ?? kTimeDisplayFormat);
}

String _convertToTimeString(Duration duration, {String? newTimeString}) {
  final String twoDigitHours = "${duration.inHours}".toTwoDigits;
  final String twoDigitMinutes = "${duration.inMinutes.remainder(60)}".toTwoDigits;
  final String twoDigitSeconds = "${duration.inSeconds.remainder(60)}".toTwoDigits;

  final DateTime now = DateTime.now();

  final DateTime dateTime = DateTime(
    now.year,
    now.month,
    now.day,
    twoDigitHours.toInt!,
    twoDigitMinutes.toInt!,
    twoDigitSeconds.toInt!,
  );

  // calling .formatDateTime extension method to convert date time to string in given format
  return dateTime.formatDateTime(newDateTimeFormat: newTimeString ?? kTimeDisplayFormat);
}
