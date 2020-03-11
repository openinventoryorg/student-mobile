import 'package:json_annotation/json_annotation.dart';
import 'package:openinventory_student_app/api/responses/user.dart';

part 'token.g.dart';

@JsonSerializable(nullable: false)
class Token {
  final String token;
  final User user;

  Token({this.token, this.user});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  String toString() {
    return '$user: $token';
  }
}
