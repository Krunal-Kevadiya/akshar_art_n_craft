import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.brand,
    required this.fabric,
    required this.price,
    required this.piece,
    required this.size,
    required this.weight,
    required this.moq,
    required this.gst,
    required this.description,
    required this.photoUrl,
    required this.delete,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  final int id;
  final String name;
  final int category;
  final int subCategory;
  final int brand;
  final int fabric;
  final String price;
  final String piece;
  final String size;
  final String weight;
  final String moq;
  final String gst;
  final String description;
  late List<String> photoUrl;
  final bool delete;

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
