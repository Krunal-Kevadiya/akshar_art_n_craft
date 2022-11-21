// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as int,
      subCategory: json['subCategory'] as int,
      brand: json['brand'] as int,
      fabric: json['fabric'] as int,
      price: json['price'] as String,
      piece: json['piece'] as String,
      size: json['size'] as String,
      weight: json['weight'] as String,
      moq: json['moq'] as String,
      gst: json['gst'] as String,
      description: json['description'] as String,
      photoUrl:
          (json['photoUrl'] as List<dynamic>).map((e) => e as String).toList(),
      delete: json['delete'] as bool,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'brand': instance.brand,
      'fabric': instance.fabric,
      'price': instance.price,
      'piece': instance.piece,
      'size': instance.size,
      'weight': instance.weight,
      'moq': instance.moq,
      'gst': instance.gst,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'delete': instance.delete,
    };
