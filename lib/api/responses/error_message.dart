import 'package:json_annotation/json_annotation.dart';

part 'error_message.g.dart';

@JsonSerializable(nullable: false)
class ErrorMessage {
  final String message;

  ErrorMessage({this.message});

  factory ErrorMessage.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorMessageToJson(this);

  @override
  String toString() {
    return message;
  }
}
