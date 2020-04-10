// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_labitem_list;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabItemListResponse _$LabItemListResponseFromJson(Map<String, dynamic> json) {
  return LabItemListResponse(
    labItems: (json['labItems'] as List)
        .map((e) => LabItemResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LabItemListResponseToJson(
        LabItemListResponse instance) =>
    <String, dynamic>{
      'labItems': instance.labItems,
    };
