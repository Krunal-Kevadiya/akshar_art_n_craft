// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String,
      shortDescription: json['shortDescription'] as String,
      price: json['price'] as num,
      size: json['size'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
      catalog: json['catalog'] as String,
      piece: json['piece'] as num,
      gst: json['gst'] as num,
      weight: json['weight'] as num,
      fabric: json['fabric'] as String,
      fabricDescription: json['fabricDescription'] as String,
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shortDescription': instance.shortDescription,
      'price': instance.price,
      'size': instance.size,
      'createDate': instance.createDate.toIso8601String(),
      'catalog': instance.catalog,
      'piece': instance.piece,
      'gst': instance.gst,
      'weight': instance.weight,
      'fabric': instance.fabric,
      'fabricDescription': instance.fabricDescription,
      'photoUrl': instance.photoUrl,
    };
