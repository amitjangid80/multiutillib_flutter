// Created by AMIT JANGID on 25/02/21.

const String _emailIdIsRequired = "* Email Id is required.";
const String _mustBeValidEmailId = "* Must be a valid Email Id.";

/// validation method for validating email id
String? emailValidator(String? value) {
  if (value == null) {
    return _emailIdIsRequired;
  }

  const Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  final RegExp regex = RegExp(pattern as String);

  if (value.isEmpty) {
    return _emailIdIsRequired;
  } else if (!regex.hasMatch(value)) {
    return _mustBeValidEmailId;
  }

  return null;
}
