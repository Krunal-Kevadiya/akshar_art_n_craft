// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rationale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RationaleModel _$RationaleModelFromJson(Map<String, dynamic> json) =>
    RationaleModel(
      title: json['title'] as String,
      message: json['message'] as String,
      buttonPositive: json['buttonPositive'] as String,
      buttonNegative: json['buttonNegative'] as String?,
      svg: json['svg'] as String?,
    );

Map<String, dynamic> _$RationaleModelToJson(RationaleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'buttonPositive': instance.buttonPositive,
      'buttonNegative': instance.buttonNegative,
      'svg': instance.svg,
    };
