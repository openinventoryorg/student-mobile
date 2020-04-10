/// Lab List information from server
library response_itemset;

import 'package:json_annotation/json_annotation.dart';

part 'itemset.g.dart';

@JsonSerializable()
class ItemsetResponse {
  final String id;
  final String title;
  final String image;

  ItemsetResponse({this.id, this.title, this.image});

  factory ItemsetResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemsetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsetResponseToJson(this);

  @override
  String toString() {
    return '$title';
  }
}
