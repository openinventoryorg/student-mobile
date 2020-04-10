// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_itemset;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsetResponse _$ItemsetResponseFromJson(Map<String, dynamic> json) {
  return ItemsetResponse(
    id: json['id'] as String,
    title: json['title'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$ItemsetResponseToJson(ItemsetResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
    };
