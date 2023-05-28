import 'dart:async';

import 'package:firedart/firedart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/product.dart';
part 'product_provider.g.dart';

@riverpod
class AsyncProducts extends _$AsyncProducts {
  @override
  FutureOr<List<Product>> build() async {
    return _fetchProduct();
  }

  Future<List<Product>> _fetchProduct() async {
    final productCollection = Firestore.instance.collection('products');
    final product = await productCollection.get();
    return product.map((doc) => Product.fromSnapshot(doc)).toList();
  }

  Future<Document> addProduct(Product product) async {
    final productCollection = Firestore.instance.collection('products');
    return productCollection.add(product.toMap());
  }
}
