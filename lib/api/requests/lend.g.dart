// GENERATED CODE - DO NOT MODIFY BY HAND

part of request_lend;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LendRequest _$LendRequestFromJson(Map<String, dynamic> json) {
  return LendRequest(
    itemIds: (json['itemIds'] as List).map((e) => e as String).toList(),
    labId: json['labId'] as String,
    userId: json['userId'] as String,
    supervisorId: json['supervisorId'] as String,
    reason: json['reason'] as String,
  );
}

Map<String, dynamic> _$LendRequestToJson(LendRequest instance) =>
    <String, dynamic>{
      'itemIds': instance.itemIds,
      'labId': instance.labId,
      'userId': instance.userId,
      'supervisorId': instance.supervisorId,
      'reason': instance.reason,
    };
