/// Error response from Server
library response_error_message;

import 'package:json_annotation/json_annotation.dart';

part 'error_message.g.dart';

@JsonSerializable(nullable: false)
class ErrorMessageResponse {
  final String message;

  ErrorMessageResponse({this.message});

  factory ErrorMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorMessageResponseToJson(this);

  @override
  String toString() {
    return message;
  }
}
