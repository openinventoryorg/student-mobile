/// Request which is used to login user
library request_login;

import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable(nullable: false)
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({this.email, this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  String toString() {
    return 'LoginRequest($email:$password)';
  }
}
