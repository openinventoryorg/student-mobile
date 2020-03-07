import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api.dart';
import './token_controller.dart';

class ApiController {
  static const studentRole = 'Student';
  final TokenController _tokenController;
  final String baseUrl;
  final Dio _dio;
  ApiClient _client;

  ApiController({this.baseUrl, TokenController tokenController})
      : _dio = Dio(),
        _tokenController = tokenController {
    _tokenController.setHeaders(_dio);
    _dio.options.headers["Content-Type"] = "application/json";
    _client = ApiClient(_dio, baseUrl);
  }

  factory ApiController.fromContext({BuildContext context, String baseUrl}) {
    return ApiController(
      baseUrl: baseUrl,
      tokenController: TokenController.of(context),
    );
  }

  static ApiController of(BuildContext context) {
    return Provider.of<ApiController>(context, listen: false);
  }

  Future<void> logIn(String email, String password) async {
    var token = await _client.login(email, password);
    if (token == null) {
      throw Exception('Invalid data recieved. Please check your connection.');
    } else {
      if (token?.user?.role != studentRole) {
        throw Exception(
            'Only students can use this app. You do not have student credentials.');
      }
    }

    _tokenController.setToken(token);
  }

  Future<void> demoCall() {
    return _client.demo();
  }
}
