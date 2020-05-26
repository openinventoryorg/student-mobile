// GENERATED CODE - DO NOT MODIFY BY HAND

part of request_tempreq;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TempRequest _$TempRequestFromJson(Map<String, dynamic> json) {
  return TempRequest(
    json['studentId'] as String,
    json['serialNumber'] as String,
  );
}

Map<String, dynamic> _$TempRequestToJson(TempRequest instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'serialNumber': instance.serialNumber,
    };
