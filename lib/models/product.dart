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

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      price: map['price'] as double,
      count: map['count'] as int,
    );
  }
  factory Product.fromSnapshot(Document doc) {
    return Product(
      id: doc.id,
      name: doc['name'],
      price: doc['price'].toDouble(),
      count: doc['count'].toInt(),
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, count: $count)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ price.hashCode ^ count.hashCode;
  }
}