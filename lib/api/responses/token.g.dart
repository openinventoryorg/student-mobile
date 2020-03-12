// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_token;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) {
  return TokenResponse(
    token: json['token'] as String,
    user: UserResponse.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
