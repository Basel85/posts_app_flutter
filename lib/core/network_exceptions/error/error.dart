import 'package:json_annotation/json_annotation.dart';
part 'error.g.dart';
@JsonSerializable()
class ErrorModel {
  @JsonKey(name: "field")
  String field;
  @JsonKey(name: "message")
  String message;
  ErrorModel({this.field = "",  this.message = ""});
  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
