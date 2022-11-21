import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catalog_model.g.dart';

@JsonSerializable()
@immutable
// ignore: must_be_immutable
class CatalogModel {
  CatalogModel({
    required this.id,
    required this.name,
    required this.description,
    required this.delete,
    this.photoUrl,
  });

  factory CatalogModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogModelFromJson(json);
  final int id;
  final String name;
  final String description;
  final bool delete;
  String? photoUrl;

  Map<String, dynamic> toJson() => _$CatalogModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }

  @override
  bool operator ==(dynamic other) =>
      other != null && other is CatalogModel && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
