// GENERATED CODE - DO NOT MODIFY BY HAND

part of response_history;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryListResponse _$HistoryListResponseFromJson(Map<String, dynamic> json) {
  return HistoryListResponse(
    requests: (json['requests'] as List)
        .map((e) => HistoryResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HistoryListResponseToJson(
        HistoryListResponse instance) =>
    <String, dynamic>{
      'requests': instance.requests,
    };

HistoryResponse _$HistoryResponseFromJson(Map<String, dynamic> json) {
  return HistoryResponse(
    supervisorId: json['supervisorId'] as String,
    status: json['status'] as String,
    requestItems: (json['RequestItems'] as List)
        .map((e) =>
            HistoryRequestItemResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
    lab: HistoryLabResponse.fromJson(json['Lab'] as Map<String, dynamic>),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$HistoryResponseToJson(HistoryResponse instance) =>
    <String, dynamic>{
      'supervisorId': instance.supervisorId,
      'status': instance.status,
      'RequestItems': instance.requestItems,
      'Lab': instance.lab,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

HistoryRequestItemResponse _$HistoryRequestItemResponseFromJson(
    Map<String, dynamic> json) {
  return HistoryRequestItemResponse(
    returnedDate: json['returnedDate'] == null
        ? null
        : DateTime.parse(json['returnedDate'] as String),
    dueDate: json['dueDate'] == null
        ? null
        : DateTime.parse(json['dueDate'] as String),
    borrowedDate: json['borrowedDate'] == null
        ? null
        : DateTime.parse(json['borrowedDate'] as String),
    status: json['status'] as String,
    item: json['Item'] == null
        ? null
        : HistoryItemResponse.fromJson(json['Item'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HistoryRequestItemResponseToJson(
        HistoryRequestItemResponse instance) =>
    <String, dynamic>{
      'returnedDate': instance.returnedDate?.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'borrowedDate': instance.borrowedDate?.toIso8601String(),
      'status': instance.status,
      'Item': instance.item,
    };

HistoryLabResponse _$HistoryLabResponseFromJson(Map<String, dynamic> json) {
  return HistoryLabResponse(
    id: json['id'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$HistoryLabResponseToJson(HistoryLabResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

HistoryItemResponse _$HistoryItemResponseFromJson(Map<String, dynamic> json) {
  return HistoryItemResponse(
    id: json['id'] as String,
    serialNumber: json['serialNumber'] as String,
  )..itemSet =
      ItemsetResponse.fromJson(json['ItemSet'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HistoryItemResponseToJson(
        HistoryItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serialNumber': instance.serialNumber,
      'ItemSet': instance.itemSet,
    };
