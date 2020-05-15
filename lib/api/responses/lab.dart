/// Lab List information from server
library response_lab_list;

import 'package:json_annotation/json_annotation.dart';

part 'lab.g.dart';

@JsonSerializable(nullable: false)
class LabListResponse {
  final List<LabResponse> labs;

  LabListResponse({this.labs});

  factory LabListResponse.fromJson(Map<String, dynamic> json) =>
      _$LabListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LabListResponseToJson(this);

  @override
  String toString() {
    return '${labs.length} Labs';
  }
}

@JsonSerializable(nullable: false)
class LabResponse {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  LabResponse(
      {this.id,
      this.title,
      this.subtitle,
      this.image,
      this.createdAt,
      this.updatedAt});

  factory LabResponse.fromJson(Map<String, dynamic> json) =>
      _$LabResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LabResponseToJson(this);

  @override
  String toString() {
    return '$title: $subtitle';
  }
}
