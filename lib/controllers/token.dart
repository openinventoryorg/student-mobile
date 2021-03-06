/// Controller which keeps track of token
library controller_token;

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/responses/token.dart';

/// Class that keeps track of the token of the user.
class TokenController extends ChangeNotifier {
  /// Key used when storing in the storage
  static const storeKey = 'token';

  /// Token header name used when sending the token in headers
  static const apiTokenHeaderName = 'token';

  /// Completer which completes when the token loads.
  ///
  /// This completes with a string if token is loaded.
  /// This completes with null if token loading failed.
  ///
  /// Used by splash screen to navigate to either home or login pages.
  ///
  /// This cannot be final since this has to reset when the user
  /// logs out. In that case, this has to be reset to null.
  Completer<UserResponse> tokenLoadedCompleter = Completer();

  /// Token that is recieved from the site.
  ///
  /// This contains user information as well.
  TokenResponse _token;

  /// Initializes the object and loads the token asyncronously.
  TokenController() {
    _loadToken();
  }

  /// Helper method to make consuming this object easy
  static TokenController of(BuildContext context) {
    return Provider.of<TokenController>(context, listen: false);
  }

  /// Loads the token from the storage.
  ///
  /// This loads token, decode in to a Map(JSON) and notifies listeners.
  /// If this fails to get token, [null] will be emitted through
  /// [tokenLoadedCompleter].
  Future<void> _loadToken() async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    String jwt = _storage.getString(storeKey);
    if (jwt != null) {
      var parsed = json.decode(jwt);
      _token = TokenResponse.fromJson(parsed);
    }
    tokenLoadedCompleter.complete(_token?.user);
    notifyListeners();
  }

  /// Saves the current token in storage.
  ///
  /// Encodes the token as a String and saves the token
  /// in the storage.
  /// The reason to encode in string is that the
  /// secure storage cannot store other datatypes rather than String
  Future<void> _saveToken() async {
    var strJson = json.encode(_token.toJson());
    SharedPreferences _storage = await SharedPreferences.getInstance();
    await _storage.setString(storeKey, strJson);
  }

  /// Deletes the token from storage.
  ///
  /// This also reinitializes the completer and emits [null].
  /// The reason is that a later consumer of the
  /// completer may see the past email address if it is not reset.
  /// Since completers cannot change output after completion,
  /// we have to reinitialize the completer and complete with [null].
  Future<void> _deleteToken() async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    await _storage.remove(storeKey);
    tokenLoadedCompleter = Completer();
    tokenLoadedCompleter.complete(null);
  }

  /// Sets and saves new token.
  Future<void> setToken(TokenResponse newToken) async {
    _token = newToken;
    await _saveToken();
    notifyListeners();
  }

  /// Logs the user out.
  ///
  /// This simply deletes the token since a user without
  /// token is the same as logged out user.
  Future<void> logout(Dio dio) async {
    _token = null;
    dio.options.headers.remove(apiTokenHeaderName);
    await _deleteToken();
    notifyListeners();
  }

  /// Sets header required forauthenticated API calls.
  ///
  /// This is done via a method since `_token` should be private.
  /// So we cannot expose `_token` to outside classes.
  void setHeaders(Dio dio) {
    if (_token != null) {
      dio.options.headers[apiTokenHeaderName] = _token.token;
    }
  }

  /// Information of the current logged in user
  UserResponse get user => _token?.user;

  /// Logged in status of the user
  bool get isLoggedIn => _token != null;

  String get tokenOfStaff =>
      _token?.user?.role != 'student' ? _token?.token : null;
}
