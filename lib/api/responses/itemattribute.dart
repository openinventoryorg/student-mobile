/// ItemAttributes information from server
library response_itemattributes;

import 'package:json_annotation/json_annotation.dart';

part 'itemattribute.g.dart';

@JsonSerializable(nullable: false)
class ItemAttributeResponse {
  final String key;
  final String value;

  ItemAttributeResponse({this.key, this.value});

  factory ItemAttributeResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemAttributeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemAttributeResponseToJson(this);

  @override
  String toString() {
    return '$key: $value';
  }
}
