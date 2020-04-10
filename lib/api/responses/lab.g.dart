// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_labs;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabResponse _$LabResponseFromJson(Map<String, dynamic> json) {
  return LabResponse(
    id: json['id'] as String,
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    image: json['image'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$LabResponseToJson(LabResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'image': instance.image,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
