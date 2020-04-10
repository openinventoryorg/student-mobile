// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_lab_list;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabListResponse _$LabListResponseFromJson(Map<String, dynamic> json) {
  return LabListResponse(
    labs: (json['labs'] as List)
        .map((e) => LabResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LabListResponseToJson(LabListResponse instance) =>
    <String, dynamic>{
      'labs': instance.labs,
    };
