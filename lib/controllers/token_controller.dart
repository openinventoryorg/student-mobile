import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../api/responses/token.dart';
import '../api/responses/user.dart';

/// Class that keeps track of the token of the user.
class TokenController extends ChangeNotifier {
  /// Key used when storing in the storage
  static const key = 'token';

  /// Token header name used when storing in headers
  static const apiTokenHeaderName = 'token';

  /// Completer which completes when the token loads.
  /// This completes with a string if token is loaded.
  /// This completes with null if token loading failed. (Not saved)
  ///
  /// Used by splash screen to navigate to either home or login pages.
  ///
  /// This cannot be final since this has to reset when the user
  /// logs out. In that case, this has to be reset to null.
  Completer<String> tokenLoadedCompleter;

  /// Storage to be used to store `token`.
  /// We have to use a secure storage since `token` is a
  /// sensitive information.
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Token that is recieved from the site.
  Token _token;

  TokenController() {
    tokenLoadedCompleter = Completer();
    _loadToken();
  }

  /// Helper method to get the `TokenController` with the use of
  /// `BuildContext`.
  static TokenController of(BuildContext context) {
    return Provider.of<TokenController>(context, listen: false);
  }

  /// Reads token from storage,
  /// decode in to JSON and notifies listeners
  Future<void> _loadToken() async {
    String jwt = await _storage.read(key: key);
    tokenLoadedCompleter.complete(_token?.user?.email);
    if (jwt != null) {
      var parsed = json.decode(jwt);
      _token = Token.fromJson(parsed);
    }
    notifyListeners();
  }

  /// Encodes the token as a String and
  /// saves the token in the storage
  Future<void> _saveToken() async {
    var strJson = json.encode(_token.toJson());
    await _storage.write(key: key, value: strJson);
  }

  /// Deletes the token
  Future<void> _deleteToken() async {
    await _storage.delete(key: key);
  }

  /// Sets and saves the token
  Future<void> setToken(Token newToken) async {
    _token = newToken;
    await _saveToken();
    notifyListeners();
  }

  /// Deletes the token and sets the `tokenLoadedCompleter` to null.
  Future<void> logout() async {
    _token = null;
    await _deleteToken();
    tokenLoadedCompleter = Completer();
    tokenLoadedCompleter.complete(null);
    notifyListeners();
  }

  /// Sets header required for `Dio`.
  /// This is done via a method since `_token` should be private.
  void setHeaders(Dio dio) {
    if (_token != null) {
      dio.options.headers[apiTokenHeaderName] = _token.token;
      print(_token);
    }
  }

  /// Get user information from token.
  User get user => _token?.user;

  /// Logged in status of the user
  bool get isLoggedIn => _token != null;
}
