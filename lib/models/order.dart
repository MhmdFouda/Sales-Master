import 'package:firedart/firedart.dart';
import 'package:flutter/foundation.dart';
import 'package:fouda_pharma/models/product.dart';

@immutable
class Order {
  final List<Product> products;
  final String? id;
  final String clientName;
  final double totalPrice;
  final DateTime confirmTime;

  Order({
    this.id,
    required this.products,
    required this.clientName,
    required this.totalPrice,
    DateTime? confirmTime,
  }) : confirmTime = confirmTime ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((product) => product.toMap()).toList(),
      'id': id,
      'clientName': clientName,
      'totalPrice': totalPrice,
      'confirmTime': confirmTime.toUtc().toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      products: List<Product>.from(
        (map['products'] as List<int>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      id: map['id'] != null ? map['id'] as String : null,
      clientName: map['clientName'] as String,
      totalPrice: map['totalPrice'] as double,
      confirmTime:
          DateTime.fromMillisecondsSinceEpoch(map['confirmTime'] as int),
    );
  }

  factory Order.fromSnapshot(Document doc) {
    final List<Product> products = List<Product>.from(
        (doc['products']).map((product) => Product.fromMap(product)));

    return Order(
      id: doc.id,
      products: products,
      clientName: doc['clientName'],
      totalPrice: doc['totalPrice'].toDouble(),
      confirmTime: DateTime.parse(doc['confirmTime']),
    );
  }

  Order copyWith({
    List<Product>? products,
    String? id,
    String? clientName,
    double? totalPrice,
    DateTime? confirmTime,
  }) {
    return Order(
      products: products ?? this.products,
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      totalPrice: totalPrice ?? this.totalPrice,
      confirmTime: confirmTime ?? this.confirmTime,
    );
  }
}
