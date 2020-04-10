// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_itemattributes;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
