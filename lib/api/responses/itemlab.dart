/// ItemLabs information from server
library response_itemlabs;

import 'package:json_annotation/json_annotation.dart';

part 'itemlab.g.dart';

@JsonSerializable(nullable: false)
class ItemLabResponse {
  final String id;
  final String title;
  final String subtitle;
  final String image;

  ItemLabResponse({this.id, this.title, this.subtitle, this.image});

  factory ItemLabResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemLabResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemLabResponseToJson(this);

  @override
  String toString() {
    return '$title: $subtitle';
  }
}
