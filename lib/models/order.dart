// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firedart/firedart.dart';
import 'package:flutter/foundation.dart';

import 'package:fouda_pharma/models/product.dart';

@immutable
class Order {
  final List<Product> products;
  final String? id;
  final String clientName;
  final double totalPrice;

  const Order({
    this.id,
    required this.products,
    required this.clientName,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
      'id': id,
      'clientName': clientName,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromSnapshot(Document doc) {
    final List<Product> products = List<Product>.from(doc['products']
        .map((productData) => Product.fromSnapshot(productData)));

    return Order(
      id: doc.id,
      products: products,
      clientName: doc['clientName'],
      totalPrice: doc['totalPrice'].toDouble(),
    );
  }

  Order copyWith({
    List<Product>? products,
    String? id,
    String? clientName,
    double? totalPrice,
  }) {
    return Order(
      products: products ?? this.products,
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
