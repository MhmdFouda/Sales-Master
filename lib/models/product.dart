// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firedart/firedart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product({
    String? id,
    required String name,
    required double price,
    required double publicPrice,
    required String unitType,
    required int count,
    required int minCount,
    required int intialCount,
    required int colorIndex,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  factory Product.fromSnapshot(Document doc) {
    return Product(
      id: doc.id,
      name: doc['name'],
      price: doc['price'].toDouble(),
      publicPrice: doc['publicPrice'].toDouble(),
      unitType: doc['unitType'],
      count: doc['count'].toInt(),
      minCount: doc['minCount'].toInt(),
      intialCount: doc['intialCount'].toInt(),
      colorIndex: doc['colorIndex'].toInt(),
    );
  }
}
