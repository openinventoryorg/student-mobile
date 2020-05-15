// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_item;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) {
  return ItemResponse(
    lab: ItemLabResponse.fromJson(json['Lab'] as Map<String, dynamic>),
    id: json['id'] as String,
    serialNumber: json['serialNumber'] as String,
    itemSet: ItemsetResponse.fromJson(json['ItemSet'] as Map<String, dynamic>),
    itemAttributes: (json['ItemAttributes'] as List)
        .map((e) => ItemAttributeResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serialNumber': instance.serialNumber,
      'Lab': instance.lab,
      'ItemSet': instance.itemSet,
      'ItemAttributes': instance.itemAttributes,
    };

ItemAttributeResponse _$ItemAttributeResponseFromJson(
    Map<String, dynamic> json) {
  return ItemAttributeResponse(
    key: json['key'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$ItemAttributeResponseToJson(
        ItemAttributeResponse instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };

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
