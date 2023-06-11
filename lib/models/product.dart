// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

@immutable
class Product {
  final String? id;
  final String name;
  final double price;
  final double publicPrice;
  final String unitType;
  final int count;
  final int minCount;
  final int intialCount;

  const Product({
    this.id,
    required this.name,
    required this.price,
    required this.publicPrice,
    required this.unitType,
    required this.count,
    required this.minCount,
    required this.intialCount,
  });

  Product copyWith({
    String? id,
    String? name,
    double? price,
    double? publicPrice,
    String? unitType,
    int? count,
    int? minCount,
    int? intialCount,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      publicPrice: publicPrice ?? this.publicPrice,
      unitType: unitType ?? this.unitType,
      count: count ?? this.count,
      minCount: minCount ?? this.minCount,
      intialCount: intialCount ?? this.intialCount,
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      price: map['price'] as double,
      publicPrice: map['publicPrice'] as double,
      unitType: map['unitType'] as String,
      count: map['count'] as int,
      minCount: map['minCount'] as int,
      intialCount: map['intialCount'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'publicPrice': publicPrice,
      'unitType': unitType,
      'count': count,
      'minCount': minCount,
      'intialCount': intialCount,
    };
  }

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
    );
  }
}
