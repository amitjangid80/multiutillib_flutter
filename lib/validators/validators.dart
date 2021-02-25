// Created by AMIT JANGID on 25/02/21.

const String _enterValidEmailId = "* Enter a valid email.";

// validation method for validating email id
String emailValidator(String value) {
  Pattern _pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp _regex = new RegExp(_pattern);

  if (value.isEmpty) return _enterValidEmailId;

  return (!_regex.hasMatch(value)) ? _enterValidEmailId : null;
}
