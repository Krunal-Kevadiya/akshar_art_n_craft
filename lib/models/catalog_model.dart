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
  final int id;
  final String name;
  final String? description;
  String? photoUrl;
  final bool delete;

  Map<String, dynamic> toJson() => _$CatalogModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }

  @override
  bool operator ==(dynamic other) =>
      other != null && other is CatalogModel && id == other.id;
}
