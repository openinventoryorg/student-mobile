// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_error_message;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorMessageResponse _$ErrorMessageResponseFromJson(Map<String, dynamic> json) {
  return ErrorMessageResponse(
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ErrorMessageResponseToJson(
        ErrorMessageResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
