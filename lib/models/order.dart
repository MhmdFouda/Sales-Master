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

  double get price {
    double total = 0;
    for (var product in products) {
      total += product.price * product.count;
    }
    return total;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
      'id': id,
      'clientName': clientName,
      'totalPrice': price,
    };
  }

  factory Order.fromSnapshot(Document doc) {
    final List<Product> products = List<Product>.from(doc['products']
        .map((productData) => Product.fromSnapshot(productData)));

    return Order(
      id: doc.id,
      products: products,
      clientName: doc['clientName'],
      totalPrice: doc['totalPrice'],
    );
  }
}
