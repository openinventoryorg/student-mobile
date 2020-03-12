// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_user;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    permissions: (json['permissions'] as List).map((e) => e as String).toList(),
    role: json['role'] as String,
    roleId: json['roleId'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'permissions': instance.permissions,
      'role': instance.role,
      'roleId': instance.roleId,
    };
