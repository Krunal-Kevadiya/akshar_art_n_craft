import 'package:json_annotation/json_annotation.dart';

part 'testimonial_model.g.dart';

@JsonSerializable()
class TestimonialModel {
  TestimonialModel({
    required this.id,
    required this.name,
    this.phone,
    this.comment,
    this.rating,
  });

  factory TestimonialModel.fromJson(Map<String, dynamic> json) =>
      _$TestimonialModelFromJson(json);
  final int id;
  final String name;
  final String? phone;
  final String? comment;
  final double? rating;

  Map<String, dynamic> toJson() => _$TestimonialModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
