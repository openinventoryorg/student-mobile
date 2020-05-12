/// Item information from server
library response_supervisor_list;

import 'package:openinventory_student_app/api/responses/supervisor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supervisorlist.g.dart';

@JsonSerializable(nullable: false)
class SupervisorListResponse {
  final List<SupervisorResponse> supervisors;

  SupervisorListResponse({this.supervisors});

  factory SupervisorListResponse.fromJson(Map<String, dynamic> json) =>
      _$SupervisorListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupervisorListResponseToJson(this);
}
