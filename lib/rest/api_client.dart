// Created By Amit Jangid on 14/01/22

import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:multiutillib/rest/api_response.dart';
import 'package:multiutillib/enums/request_type.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiClient extends BaseClient {
  late final String _baseUrl;

  ApiClient._();

  static ApiClient? _instance;

  static ApiClient get to => _instance ??= ApiClient._();

  set baseUrl(String value) => _baseUrl = value;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll({'Content-type': 'application/json', 'Accept': 'application/json'});

    return request.send();
  }

  Future<dynamic> request({RequestType requestType = RequestType.get, required String path, dynamic body}) async {
    try {
      Response _response;
      dynamic _responseBody;

      final String _api = '$_baseUrl$path';
      debugPrint('request: api is: $_api');

      // calling check connectivity method
      final bool _isConnected = await _checkConnectivity();

      if (!_isConnected) {
        return ApiResponse.error(kInternetNotAvailable);
      }

      switch (requestType) {
        case RequestType.get:
          // calling get method from http package for making get api call
          _response = await get(Uri.parse(_api));
          break;
        case RequestType.post:
          // calling post method from http package for making post api call
          _response = await post(Uri.parse(_api), body: jsonEncode(body));
          break;
        case RequestType.put:
          // calling put method from http package for making put api call
          _response = await put(Uri.parse(_api), body: jsonEncode(body));
          break;
        case RequestType.delete:
          // calling delete method from http package for making delete api call
          _response = await delete(Uri.parse(_api), body: jsonEncode(body));
          break;

        default:
          // calling get method from http package for making get api call
          _response = await get(Uri.parse(_api));
          break;
      }

      debugPrint('request: status code is: ${_response.statusCode}');
      debugPrint('request: response body is: ${_response.body}');

      // calling return response method
      _responseBody = _returnResponse(_response);

      return _responseBody;
    } on SocketException {
      return ApiResponse.error('exception while requesting for api');
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        final _responseBody = jsonDecode(response.body);

        return _responseBody;

      default:
        return response;
    }
  }

  Future<bool> _checkConnectivity() async {
    final _connectivityResult = await (Connectivity().checkConnectivity());

    if (_connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (_connectivityResult == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }
}
