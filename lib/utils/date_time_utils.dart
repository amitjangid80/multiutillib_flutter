// Created by AMIT JANGID on 26/12/20.

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
