import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'package:openinventory_student_app/api/api.dart';

/// Class to keep track of the base url of the app.
/// Base url is the server url that the app is connected to. (Server URL)
class BaseUrlController extends ChangeNotifier {
  /// Key used when storing in the storage
  static const key = 'url';

  /// Storage to be used to store `token`.
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Base URL of the server.
  String _baseUrl;

  /// Initializes and loads base url from storage.
  BaseUrlController() {
    _loadBaseUrl();
  }

  /// Helper class to get `BaseUrlController` instance
  static BaseUrlController of(BuildContext context, [bool listen = false]) {
    return Provider.of<BaseUrlController>(context, listen: listen);
  }

  /// Loads base url from the storage
  Future<void> _loadBaseUrl() async {
    String url = await _storage.read(key: key);
    _baseUrl = url ?? '';
    notifyListeners();
  }

  /// Sets base url to the storage
  Future<void> setBaseUrl(String url) async {
    _baseUrl = url ?? '';
    await _storage.write(key: key, value: _baseUrl);
    notifyListeners();
  }

  /// Getter for base url
  String get baseUrl => _baseUrl ?? '';

  /// Sets the `ApiClient` when the dio object is provided.
  /// This assumes the base url is in http://mysite.com format
  /// and adds /api to the url.
  ApiClient createApiClient(Dio dio) {
    return ApiClient(dio, '$_baseUrl/api');
  }
}
