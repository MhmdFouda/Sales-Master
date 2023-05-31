// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

@immutable
class Product {
  final String? id;
  final String name;
  final double price;
  final int count;

  const Product({
    this.id,
    required this.name,
    required this.price,
    required this.count,
  });

  Product copyWith({
    String? id,
    String? name,
    double? price,
    int? count,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'count': count,
    };
  }

  factory Product.fromSnapshot(Document doc) {
    return Product(
      id: doc.id,
      name: doc['name'],
      price: doc['price'].toDouble(),
      count: doc['count'].toInt(),
    );
  }
}
