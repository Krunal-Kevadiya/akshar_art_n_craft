// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogModel _$CatalogModelFromJson(Map<String, dynamic> json) => CatalogModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      delete: json['delete'] as bool,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$CatalogModelToJson(CatalogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'delete': instance.delete,
      'photoUrl': instance.photoUrl,
    };
