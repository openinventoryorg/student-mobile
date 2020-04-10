library response_labitem_list;

import 'package:json_annotation/json_annotation.dart';
import 'package:openinventory_student_app/api/responses/labitem.dart';

part 'labitemlist.g.dart';

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
