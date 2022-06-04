// Created By Amit Jangid on 13/01/22

import 'package:multiutillib/enums/api_status.dart';

class ApiResponse<T> {
  late T data;
  late String message;
  late ApiStatus status;

  ApiResponse.error(this.message) : status = ApiStatus.error;

  ApiResponse.success(this.data) : status = ApiStatus.success;

  ApiResponse.loading(this.message) : status = ApiStatus.loading;
}
