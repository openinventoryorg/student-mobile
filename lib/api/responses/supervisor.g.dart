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

SupervisorResponse _$SupervisorResponseFromJson(Map<String, dynamic> json) {
  return SupervisorResponse(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    bio: json['bio'] as String,
    active: json['active'] as bool,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$SupervisorResponseToJson(SupervisorResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'bio': instance.bio,
      'active': instance.active,
      'email': instance.email,
    };
