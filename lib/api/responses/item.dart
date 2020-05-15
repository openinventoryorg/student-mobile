/// Item information from server
library response_item;

import 'package:json_annotation/json_annotation.dart';
import 'package:openinventory_student_app/api/responses/itemset.dart';
import 'package:openinventory_student_app/helpers.dart';

part 'item.g.dart';

@JsonSerializable(nullable: false)
class ItemResponse {
  final String id;
  final String serialNumber;
  @JsonKey(name: 'Lab')
  final ItemLabResponse lab;
  @JsonKey(name: 'ItemSet')
  final ItemsetResponse itemSet;
  @JsonKey(name: 'ItemAttributes')
  final List<ItemAttributeResponse> itemAttributes;

  ItemResponse(
      {this.lab,
      this.id,
      this.serialNumber,
      this.itemSet,
      this.itemAttributes});

  factory ItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);

  @override
  String toString() {
    return '$serialNumber';
  }

  String get capitalizedTitle => Helpers.capitalize(itemSet.title);
}

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
