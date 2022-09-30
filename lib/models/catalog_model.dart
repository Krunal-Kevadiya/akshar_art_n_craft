import 'package:json_annotation/json_annotation.dart';

part 'catalog_model.g.dart';

@JsonSerializable()
class CatalogModel {
  CatalogModel({
    required this.id,
    required this.name,
    this.description,
    this.photoUrl,
    required this.delete,
  });

  factory CatalogModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogModelFromJson(json);
  final String id;
  final String name;
  final String? description;
  final String? photoUrl;
  final bool delete;

  Map<String, dynamic> toJson() => _$CatalogModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
