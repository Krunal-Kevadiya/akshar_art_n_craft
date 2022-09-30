import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  ProductModel({
    required this.id,
    required this.shortDescription,
    required this.price,
    required this.size,
    required this.createDate,
    required this.catalog,
    required this.piece,
    required this.gst,
    required this.weight,
    required this.fabric,
    required this.fabricDescription,
    required this.photoUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  final String id;
  final String shortDescription;
  final num price;
  final String size;
  final DateTime createDate;
  final String catalog;
  final num piece;
  final num gst;
  final num weight;
  final String fabric;
  final String fabricDescription;
  final String photoUrl;

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
