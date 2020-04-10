// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_itemlabs;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemLabResponse _$ItemLabResponseFromJson(Map<String, dynamic> json) {
  return ItemLabResponse(
    id: json['id'] as String,
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$ItemLabResponseToJson(ItemLabResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'image': instance.image,
    };
