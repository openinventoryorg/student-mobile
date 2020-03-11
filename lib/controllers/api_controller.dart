import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './base_url_controller.dart';
import '../api/api.dart';
import './token_controller.dart';

/// Main Controller which controls access to the API.
/// Uses `ApiClient` internally and acts as the midddleman.
/// This also takes care of some errors.
class ApiController {
  /// Role that is permitted in the App
  static const permittedRole = 'Student';

  /// Token controller associated with this api controller
  final TokenController _tokenController;

  /// Dio client used to send requests
  final Dio _dio;

  /// API client which manages internal requests
  ApiClient _client;

  /// Initialized `ApiController`.
  /// Uses `TokenController` and `BaseUrlController` to set token headers and base url.
  ///
  /// Also important headers are also set here.
  ApiController({
    @required TokenController tokenController,
    @required BaseUrlController baseUrlController,
  })  : _dio = Dio(),
        _tokenController = tokenController {
    // Set token and header.
    _tokenController.setHeaders(_dio);
    _dio.options.headers["Content-Type"] = "application/json";

    // Create client
    _client = baseUrlController.createApiClient(_dio);
  }

  /// Creates `ApiController` using context - helper method
  factory ApiController.fromContext({@required BuildContext context}) {
    return ApiController(
      tokenController: TokenController.of(context),
      baseUrlController: BaseUrlController.of(context),
    );
  }

  /// Get reference to `ApiController` - helper method
  static ApiController of(BuildContext context) {
    return Provider.of<ApiController>(context, listen: false);
  }

  /// # LOGIN REQUEST
  ///
  /// Sends a login request and stored the recieved token.
  /// This also enforces the **permitted roles only** requirement for the app.
  Future<void> logIn(String email, String password) async {
    var token = await _client.login(email, password);
    if (token == null) {
      throw Exception('Invalid data recieved. Please check your connection.');
    } else {
      if (token?.user?.role != permittedRole) {
        throw Exception(
            'Only students can use this app. You do not have student credentials.');
      }
    }

    _tokenController.setToken(token);
  }

  /// # DEMO REQUEST
  ///
  /// Demo request to make sure that user is logged in
  Future<void> demoCall() {
    return _client.demo();
  }
}
