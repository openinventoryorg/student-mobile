/// User information response from Server
library response_user;

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class UserResponse {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final List<String> permissions;
  final String role;
  final String roleId;

  UserResponse(
      {this.firstName,
      this.lastName,
      this.email,
      this.permissions,
      this.role,
      this.roleId,
      this.id});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  String get name => '$firstName $lastName';

  @override
  String toString() {
    return email;
  }
}
