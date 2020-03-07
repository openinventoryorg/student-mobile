import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../api/responses/token.dart';
import '../api/responses/user.dart';

class TokenController extends ChangeNotifier {
  /// Completer which completes when the token loads.
  /// This completes with a string if token is loaded.
  /// This completes with null if token loading failed. (Not saved)
  /// Used by splash screen to navigate to either home or login pages.
  final Completer<String> emailNotificationCompleter = Completer();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Token _token;

  TokenController() {
    loadToken();
  }

  static TokenController of(BuildContext context) {
    return Provider.of<TokenController>(context, listen: false);
  }

  Future<void> loadToken() async {
    String jwt = await storage.read(key: 'token');
    if (jwt != null) {
      var parsed = json.decode(jwt);
      _token = Token.fromJson(parsed);
      emailNotificationCompleter.complete(_token?.user?.email);
      notifyListeners();
    } else {
      emailNotificationCompleter.complete(null);
    }
  }

  Future<void> saveToken() async {
    var strJson = json.encode(_token.toJson());
    await storage.write(key: 'token', value: strJson);
  }

  Future<void> setToken(Token newToken) async {
    _token = newToken;
    notifyListeners();
    if (_token == null) {
      await storage.deleteAll();
    } else {
      await saveToken();
    }
  }

  Future<void> logout() async {
    await setToken(null);
  }

  void setHeaders(Dio dio) {
    if (_token != null) {
      dio.options.headers['token'] = _token.token;
      print(_token);
    }
  }

  User get user => _token?.user;
}
