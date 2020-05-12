/// Class that handles all API calls (requests and responses)
library api_client;

import 'package:dio/dio.dart';
import 'package:openinventory_student_app/api/requests/lend.dart';
import 'package:openinventory_student_app/api/responses/item.dart';
import 'package:openinventory_student_app/api/responses/labitem.dart';
import 'package:openinventory_student_app/api/responses/supervisorlist.dart';

import '../controllers/token.dart';
import './requests/login.dart';
import './responses/error_message.dart';
import './responses/token.dart';
import './responses/labitemlist.dart';
import './responses/lablist.dart';
import './responses/lab.dart';

/// Class that handles all API calls (requests and responses)
class ApiClient {
  /// Base url for all the api calls
  final String _baseUrl;

  /// Dio object used to make API calls
  final Dio _dio;

  /// Initializer for client.
  ApiClient(this._baseUrl) : _dio = Dio() {
    _dio.options.headers["Content-Type"] = "application/json";
  }

  void setToken(TokenController tokenController) {
    tokenController.setHeaders(_dio);
  }

  /// Handler for the errors, returns the handled error
  Exception throwError(dynamic err) {
    if (err is DioError) {
      if (err.response == null) {
        return err;
      } else {
        var errorMessage = ErrorMessageResponse.fromJson(err.response.data);
        return Exception(errorMessage.message);
      }
    } else {
      return err;
    }
  }

  /// # POST /login
  Future<TokenResponse> login(String email, String password) async {
    try {
      String endPoint = '$_baseUrl/api/login';
      var request = LoginRequest(email: email, password: password);
      var response = await _dio.post(endPoint, data: request.toJson());
      return TokenResponse.fromJson(response.data);
    } catch (err) {
      if ((err is DioError && (err.response?.statusCode ?? 404) == 404) ||
          err is RangeError) {
        throw Exception('Invalid Server address. Server connection failed.');
      }
      throw throwError(err);
    }
  }

  /// # Get /labs/list
  Future<List<LabResponse>> labsList() async {
    try {
      String endPoint = '$_baseUrl/api/labs/list';
      var response = await _dio.get(endPoint);
      return LabListResponse.fromJson(response.data).labs;
    } catch (err) {
      throw throwError(err);
    }
  }

  /// # Get /labs/list
  Future<List<LabItemResponse>> labItemsList(String labId) async {
    try {
      String endPoint = '$_baseUrl/api/labs/$labId/items';
      var response = await _dio.get(endPoint);
      return LabItemListResponse.fromJson(response.data).labItems;
    } catch (err) {
      throw throwError(err);
    }
  }

  /// # Get /items/:ID
  Future<ItemResponse> item(String itemId) async {
    try {
      String endPoint = '$_baseUrl/api/items/$itemId';
      var response = await _dio.get(endPoint);
      return ItemResponse.fromJson(response.data);
    } catch (err) {
      throw throwError(err);
    }
  }

  /// # Get /supervisors
  Future<SupervisorListResponse> supervisors() async {
    try {
      String endPoint = '$_baseUrl/api/supervisors';
      var response = await _dio.get(endPoint);
      return SupervisorListResponse.fromJson(response.data);
    } catch (err) {
      throw throwError(err);
    }
  }

  Future<void> sendRequest(LendRequest request) async {
    try {
      String endPoint = '$_baseUrl/api/requestitems/create';
      var response = await _dio.post(endPoint, data: request.toJson());
      if (response.statusCode != 200) {
        throw Exception('Something went wrong! Please try again');
      }
    } catch (err) {
      throw throwError(err);
    }
  }
}
