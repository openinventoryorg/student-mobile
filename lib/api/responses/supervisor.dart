/// Item information from server
library response_supervisor;

import 'package:json_annotation/json_annotation.dart';

part 'supervisor.g.dart';

@JsonSerializable(nullable: false)
class SupervisorResponse {
  final String id;
  final String firstName;
  final String lastName;
  final String bio;
  final bool active;
  final String email;

  SupervisorResponse(
      {this.id,
      this.firstName,
      this.lastName,
      this.bio,
      this.active,
      this.email});

  factory SupervisorResponse.fromJson(Map<String, dynamic> json) =>
      _$SupervisorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupervisorResponseToJson(this);

  @override
  String toString() => '$firstName $lastName';

  @override
  int get hashCode => this.id.hashCode;

  @override
  bool operator ==(other) {
    return other is SupervisorResponse && other.id == this.id;
  }
}
