/// Lab List information from server
library response_lab_list;

import 'package:json_annotation/json_annotation.dart';
import 'package:openinventory_student_app/api/responses/lab.dart';

part 'lablist.g.dart';

@JsonSerializable(nullable: false)
class LabListResponse {
  final List<LabResponse> labs;

  LabListResponse({this.labs});

  factory LabListResponse.fromJson(Map<String, dynamic> json) =>
      _$LabListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LabListResponseToJson(this);

  @override
  String toString() {
    return '${labs.length} Labs';
  }
}
