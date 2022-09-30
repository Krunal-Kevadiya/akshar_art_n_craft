import 'package:json_annotation/json_annotation.dart';

part 'rationale_model.g.dart';

@JsonSerializable()
class RationaleModel {
  RationaleModel({
    required this.title,
    required this.message,
    required this.buttonPositive,
    this.buttonNegative,
    this.svg,
  });

  factory RationaleModel.fromJson(Map<String, dynamic> json) =>
      _$RationaleModelFromJson(json);
  String title;
  String message;
  String buttonPositive;
  String? buttonNegative;
  String? svg;

  Map<String, dynamic> toJson() => _$RationaleModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
