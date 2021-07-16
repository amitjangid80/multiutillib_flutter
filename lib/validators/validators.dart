// Created by AMIT JANGID on 25/02/21.

const String _emailIdIsRequired = "* Email Id is required.";
const String _mustBeValidEmailId = "* Must be a valid Email Id.";

/// validation method for validating email id
String? emailValidator(String _value) {
  const Pattern _pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  final RegExp _regex = new RegExp(_pattern as String);

  if (_value.isEmpty) {
    return _emailIdIsRequired;
  } else if (!_regex.hasMatch(_value)) {
    return _mustBeValidEmailId;
  }

  return null;
}
