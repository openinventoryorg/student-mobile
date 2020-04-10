/// Labs information from server
library response_labitem;

import 'package:json_annotation/json_annotation.dart';
import 'package:openinventory_student_app/api/responses/itemset.dart';

part 'labitem.g.dart';

@JsonSerializable(nullable: false)
class LabItemResponse {
  final String id;
  final String serialNumber;
  final String labId;
  final String itemSetId;
  @JsonKey(name: 'ItemSet')
  final ItemsetResponse itemSet;
  final DateTime createdAt;
  final DateTime updatedAt;

  LabItemResponse(
      {this.id,
      this.serialNumber,
      this.labId,
      this.itemSetId,
      this.itemSet,
      this.createdAt,
      this.updatedAt});

  factory LabItemResponse.fromJson(Map<String, dynamic> json) =>
      _$LabItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LabItemResponseToJson(this);

  @override
  String toString() {
    return '$serialNumber';
  }
}
