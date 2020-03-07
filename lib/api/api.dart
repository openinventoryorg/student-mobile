import 'package:dio/dio.dart';

import './requests/login_request.dart';
import './responses/error_message.dart';
import './responses/token.dart';

class ApiClient {
  final String _baseUrl;
  final Dio _dio;

  ApiClient(this._dio, this._baseUrl);

  Exception throwError(dynamic err) {
    if (err is DioError) {
      if (err.response == null) {
        return err;
      } else {
        var errorMessage = ErrorMessage.fromJson(err.response.data);
        return Exception(errorMessage.message);
      }
    } else {
      return err;
    }
  }

  Future<Token> login(String email, String password) async {
    try {
      String endPoint = '$_baseUrl/login';
      var request = LoginRequest(email: email, password: password);
      var response = await _dio.post(endPoint, data: request.toJson());
      return Token.fromJson(response.data);
    } catch (err) {
      throw throwError(err);
    }
  }

  Future<void> demo() async {
    try {
      String endPoint = '$_baseUrl/demo';
      var response = await _dio.get(endPoint);
      print(response);
    } catch (err) {
      throw throwError(err);
    }
  }
}
