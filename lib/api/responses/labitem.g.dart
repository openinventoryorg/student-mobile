// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_labitem;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabItemResponse _$LabItemResponseFromJson(Map<String, dynamic> json) {
  return LabItemResponse(
    id: json['id'] as String,
    serialNumber: json['serialNumber'] as String,
    labId: json['labId'] as String,
    itemSetId: json['itemSetId'] as String,
    itemSet: ItemsetResponse.fromJson(json['ItemSet'] as Map<String, dynamic>),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$LabItemResponseToJson(LabItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serialNumber': instance.serialNumber,
      'labId': instance.labId,
      'itemSetId': instance.itemSetId,
      'ItemSet': instance.itemSet,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
