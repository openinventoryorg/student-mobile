library response_labitem;

import 'package:json_annotation/json_annotation.dart';
import 'package:openinventory_student_app/api/responses/itemset.dart';

part 'labitem.g.dart';

@JsonSerializable(nullable: false)
class LabItemListResponse {
  final List<LabItemResponse> labItems;

  LabItemListResponse({this.labItems});

  factory LabItemListResponse.fromJson(Map<String, dynamic> json) =>
      _$LabItemListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LabItemListResponseToJson(this);

  @override
  String toString() {
    return '${labItems.length} Lab Items';
  }
}

@JsonSerializable(nullable: false)
class LabItemResponse {
  final String id;
  final String serialNumber;
  final String labId;
  final String itemSetId;
  @JsonKey(name: 'ItemSet')
  final ItemsetResponse itemSet;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  LabItemResponse(
      {this.id,
      this.status,
      this.serialNumber,
      this.labId,
      this.itemSetId,
      this.itemSet,
      this.createdAt,
      this.updatedAt});

  factory LabItemResponse.fromJson(Map<String, dynamic> json) =>
      _$LabItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LabItemResponseToJson(this);

  bool get isAvailable => this.status == 'AVAILABLE';

  @override
  String toString() {
    return '$serialNumber';
  }
}
