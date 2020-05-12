/// Request which is used to lend item
library request_lend;

import 'package:json_annotation/json_annotation.dart';

part 'lend.g.dart';

@JsonSerializable(nullable: false)
class LendRequest {
  final List<String> itemIds;
  final String labId;
  final String userId;
  final String supervisorId;
  final String reason;

  LendRequest(
      {this.itemIds, this.labId, this.userId, this.supervisorId, this.reason});

  factory LendRequest.fromJson(Map<String, dynamic> json) =>
      _$LendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LendRequestToJson(this);

  @override
  String toString() {
    return 'LendRequest($reason)';
  }
}
