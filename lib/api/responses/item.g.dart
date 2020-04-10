// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_item;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) {
  return ItemResponse(
    ItemLabResponse.fromJson(json['Lab'] as Map<String, dynamic>),
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
