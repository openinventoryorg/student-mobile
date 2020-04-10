/// Item information from server
library response_item;

import 'package:json_annotation/json_annotation.dart';
import 'package:openinventory_student_app/api/responses/itemattribute.dart';
import 'package:openinventory_student_app/api/responses/itemlab.dart';
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

  ItemResponse(this.lab,
      {this.id, this.serialNumber, this.itemSet, this.itemAttributes});

  factory ItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);

  @override
  String toString() {
    return '$serialNumber';
  }

  String get capitalizedTitle => Helpers.capitalize(itemSet.title);
}
