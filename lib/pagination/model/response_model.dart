import 'package:json_annotation/json_annotation.dart';
part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel{
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;

  ResponseModel({this.id, this.title, this.description, this.images});

  factory ResponseModel.fromJson(Map<String, dynamic> json) => _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

}