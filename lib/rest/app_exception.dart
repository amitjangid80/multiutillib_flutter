// Created By Amit Jangid on 13/01/22

class AppException implements Exception {
  final dynamic _message, _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() => "$_prefix$_message";
}

class FetchDataException extends AppException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
