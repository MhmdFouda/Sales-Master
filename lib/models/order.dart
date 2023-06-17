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
  final double publicTotalPrice;
  final DateTime confirmTime;
  final int colorIndex;

  Order({
    DateTime? confirmTime,
    required this.products,
    this.id,
    required this.clientName,
    required this.totalPrice,
    required this.publicTotalPrice,
    required this.colorIndex,
  }) : confirmTime = confirmTime ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toJson()).toList(),
      'id': id,
      'clientName': clientName,
      'totalPrice': totalPrice,
      'publicTotalPrice': publicTotalPrice,
      'confirmTime': confirmTime.millisecondsSinceEpoch,
      'colorIndex': colorIndex,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      products: List<Product>.from(
        (map['products'] as List<int>).map<Product>(
          (x) => Product.fromJson(x as Map<String, dynamic>),
        ),
      ),
      id: map['id'] != null ? map['id'] as String : null,
      clientName: map['clientName'] as String,
      totalPrice: map['totalPrice'] as double,
      publicTotalPrice: map['publicTotalPrice'] as double,
      confirmTime:
          DateTime.fromMillisecondsSinceEpoch(map['confirmTime'] as int),
      colorIndex: map['colorIndex'] as int,
    );
  }

  factory Order.fromSnapshot(Document doc) {
    final List<Product> products = List<Product>.from(
        (doc['products']).map((product) => Product.fromJson(product)));

    final int confirmTimeMillis = doc['confirmTime'] as int;
    final DateTime confirmTime =
        DateTime.fromMillisecondsSinceEpoch(confirmTimeMillis);

    return Order(
      id: doc.id,
      products: products,
      clientName: doc['clientName'],
      totalPrice: doc['totalPrice'].toDouble(),
      publicTotalPrice: doc['publicTotalPrice'].toDouble(),
      confirmTime: confirmTime,
      colorIndex: doc['colorIndex'].toInt(),
    );
  }

  Order copyWith({
    List<Product>? products,
    String? id,
    String? clientName,
    double? totalPrice,
    double? publicTotalPrice,
    DateTime? confirmTime,
    int? colorIndex,
  }) {
    return Order(
      products: products ?? this.products,
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      totalPrice: totalPrice ?? this.totalPrice,
      publicTotalPrice: publicTotalPrice ?? this.publicTotalPrice,
      confirmTime: confirmTime ?? this.confirmTime,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }
}
