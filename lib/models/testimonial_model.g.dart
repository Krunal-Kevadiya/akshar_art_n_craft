// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testimonial_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestimonialModel _$TestimonialModelFromJson(Map<String, dynamic> json) =>
    TestimonialModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      comment: json['comment'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TestimonialModelToJson(TestimonialModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'comment': instance.comment,
      'rating': instance.rating,
    };
