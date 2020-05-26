/// Request which is used to lend/recieve items temproarily
library request_tempreq;

import 'package:json_annotation/json_annotation.dart';

part 'tempreq.g.dart';

@JsonSerializable(nullable: false)
class TempRequest {
  final String studentId;
  final String serialNumber;

  TempRequest(this.studentId, this.serialNumber);

  factory TempRequest.fromJson(Map<String, dynamic> json) =>
      _$TempRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TempRequestToJson(this);
}
