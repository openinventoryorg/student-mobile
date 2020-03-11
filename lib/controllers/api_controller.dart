import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './base_url_controller.dart';
import '../api/api.dart';
import './token_controller.dart';

/// Controller which encapsulates [ApiClient]
///
/// This uses [ApiClient] internally and acts as the midddleman.
/// This also takes care of some errors which occur when calling the API.
@immutable
class ApiController {
  /// User role that should be permitted to the app.
  ///
  /// If a user who does not belong to the specified role,
  /// an error message will be shown.
  /// This string effectively locks tha app to a specific role.
  static const permittedRole = 'Student';

  /// This is the object which encapsulates the token required
  /// in order to make an authenticated API call.
  ///
  /// When the [_tokenController] notifies its children,
  /// a new [ApiController] will be created.
  /// The reference is kept in order to change the [Token]
  /// when the user logs in to the system.
  final TokenController _tokenController;

  /// The object which handles network calls.
  final ApiClient _client;

  /// Initializes the object by acting as a proxy for
  /// [TokenController] and [BaseUrlController].
  ///
  /// [TokenController] is required to authenticate the user.
  /// [BaseUrlController] is required to create the [ApiClient]
  /// using the current server url/organization url.
  ///
  /// Use [ApiController.fromContext()] to initialize using the context.
  ApiController({
    @required TokenController tokenController,
    @required BaseUrlController baseUrlController,
  })  : _tokenController = tokenController,
        _client = ApiClient(baseUrlController.baseUrl) {
    _client.setToken(tokenController);
  }

  /// Helper method to make the [ApiController] creation easy.
  ///
  /// This uses `.of()` methods to provide the reference.
  /// *Note: There must be [TokenController] and [BaseUrlController]
  /// objects above the provider of this object.*
  factory ApiController.fromContext({@required BuildContext context}) {
    return ApiController(
      tokenController: TokenController.of(context),
      baseUrlController: BaseUrlController.of(context),
    );
  }

  /// Helper method to make consuming this object easy
  static ApiController of(BuildContext context) {
    return Provider.of<ApiController>(context, listen: false);
  }

  /// Logs the user in using the given credentials.
  ///
  /// Sends a login request and stores the recieved token.
  /// This also enforces the **permitted roles only** requirement for the app.
  Future<void> logIn(String email, String password) async {
    var token = await _client.login(email, password);
    if (token == null) {
      throw Exception('Invalid data recieved. Please check your connection.');
    } else if (token?.user?.role != permittedRole) {
      throw Exception(
          'Only students can use this app. You do not have student credentials.');
    }

    _tokenController.setToken(token);
  }

  /// Sends a demonstration request
  ///
  /// This is just a demo method to make sure the user is authenticated.
  /// Unauthenticated users will get an error.
  Future<void> demoCall() {
    return _client.demo();
  }
}
