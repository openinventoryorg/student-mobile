import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final List<String> permissions;
  final String role;
  final String roleId;

  User(
      {this.firstName,
      this.lastName,
      this.email,
      this.permissions,
      this.role,
      this.roleId,
      this.id});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get name => '$firstName $lastName';

  @override
  String toString() {
    return email;
  }
}
