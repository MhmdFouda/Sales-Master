// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

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
    int? minCount,
    required int intialCount,
    required int colorIndex,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  factory Product.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'],
      price: (data['price']).toDouble(),
      publicPrice: (data['publicPrice']).toDouble(),
      unitType: data['unitType'],
      count: (data['count']).toInt(),
      minCount: (data['minCount']).toInt(),
      intialCount: (data['intialCount']).toInt(),
      colorIndex: (data['colorIndex']).toInt(),
    );
  }
}
