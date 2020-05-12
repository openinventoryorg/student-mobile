// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_supervisor_list;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupervisorListResponse _$SupervisorListResponseFromJson(
    Map<String, dynamic> json) {
  return SupervisorListResponse(
    supervisors: (json['supervisors'] as List)
        .map((e) => SupervisorResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SupervisorListResponseToJson(
        SupervisorListResponse instance) =>
    <String, dynamic>{
      'supervisors': instance.supervisors,
    };
