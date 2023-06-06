// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

@immutable
class Product {
  final String? id;
  final String name;
  final double price;
  final double bublicPrice;
  final String unitType;
  final int count;
  final int minCount;

  const Product({
    this.id,
    required this.name,
    required this.price,
    required this.bublicPrice,
    required this.unitType,
    required this.count,
    required this.minCount,
  });

  Product copyWith({
    String? id,
    String? name,
    double? price,
    double? bublicPrice,
    String? unitType,
    int? count,
    int? minCount,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      bublicPrice: bublicPrice ?? this.bublicPrice,
      unitType: unitType ?? this.unitType,
      count: count ?? this.count,
      minCount: minCount ?? this.minCount,
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      price: map['price'] as double,
      bublicPrice: map['bublicPrice'] as double,
      unitType: map['unitType'] as String,
      count: map['count'] as int,
      minCount: map['minCount'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'bublicPrice': bublicPrice,
      'unitType': unitType,
      'count': count,
      'minCount': minCount,
    };
  }

  factory Product.fromSnapshot(Document doc) {
    return Product(
      id: doc.id,
      name: doc['name'],
      price: doc['price'].toDouble(),
      bublicPrice: doc['bublicPrice'].toDouble(),
      unitType: doc['unitType'],
      count: doc['count'].toInt(),
      minCount: doc['minCount'].toInt(),
    );
  }
}
