/// Users past history requests
library response_history;

import 'package:json_annotation/json_annotation.dart';
import 'package:openinventory_student_app/api/responses/itemset.dart';
import 'package:openinventory_student_app/helpers.dart';

part 'history.g.dart';

@JsonSerializable(nullable: false)
class HistoryListResponse {
  final List<HistoryResponse> requests;

  HistoryListResponse({this.requests});

  factory HistoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryListResponseToJson(this);
}

@JsonSerializable(nullable: false)
class HistoryResponse {
  final String supervisorId;
  final String status;
  @JsonKey(name: 'RequestItems')
  final List<HistoryRequestItemResponse> requestItems;
  @JsonKey(name: 'Lab')
  final HistoryLabResponse lab;
  final DateTime updatedAt;

  HistoryResponse({
    this.supervisorId,
    this.status,
    this.requestItems,
    this.lab,
    this.updatedAt,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryResponseToJson(this);

  String get capitalizedStatus => Helpers.capitalize(status);
}

@JsonSerializable()
class HistoryRequestItemResponse {
  final DateTime returnedDate;
  final DateTime dueDate;
  final DateTime borrowedDate;
  final String status;
  @JsonKey(name: 'Item')
  final HistoryItemResponse item;

  HistoryRequestItemResponse({
    this.returnedDate,
    this.dueDate,
    this.borrowedDate,
    this.status,
    this.item,
  });

  factory HistoryRequestItemResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryRequestItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryRequestItemResponseToJson(this);
}

@JsonSerializable(nullable: false)
class HistoryLabResponse {
  String id;
  String title;

  HistoryLabResponse({this.id, this.title});

  factory HistoryLabResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryLabResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryLabResponseToJson(this);
}

@JsonSerializable(nullable: false)
class HistoryItemResponse {
  String id;
  String serialNumber;
  @JsonKey(name: 'ItemSet')
  ItemsetResponse itemSet;

  HistoryItemResponse({this.id, this.serialNumber});

  factory HistoryItemResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryItemResponseToJson(this);
}
