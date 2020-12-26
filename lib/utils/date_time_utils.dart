// Created by AMIT JANGID on 26/12/20.

import 'package:intl/intl.dart';
import 'package:multiutillib/utils/utils.dart';

const String kDateDisplayFormat = 'dd/MM/yyyy';
const String kFullMonthYearFormat = 'MMMM-yyyy';
const String kFullDateDisplayFormat = 'dd MMMM, yyyy';
const String kDefaultDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

/*
 * 2020 December 26 - Saturday
 * get current date method
 *
 * this method will get current date in format provided
**/
String getCurrentDate({String newDateTimeFormat}) {
  if (newDateTimeFormat != null && newDateTimeFormat.isNotEmpty) {
    return DateFormat('$newDateTimeFormat').format(DateTime.now());
  } else {
    return DateFormat('$kDefaultDateTimeFormat').format(DateTime.now());
  }
}

String formatDateTime(dateTime, {String newDateTimeFormat}) {
  dateTime = replaceNullWithEmpty(dateTime);

  if (dateTime.toString().length > 0) {
    // formatting date in yyyy-MM-dd HH:mm:ss format
    dateTime = DateFormat('${newDateTimeFormat ?? kDefaultDateTimeFormat}').format(DateTime.parse(dateTime));
  }

  return dateTime;
}
