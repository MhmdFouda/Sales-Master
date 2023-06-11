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
    final documents = await productCollection.get();
    List<Product> productList = [];
    for (final doc in documents) {
      productList.add(Product.fromSnapshot(doc));
    }
    return productList;
  }

  Future<Product> getProduct(String id) async {
    final productCollection = Firestore.instance.collection('products');
    final product = await productCollection.document(id).get();
    return Product.fromSnapshot(product);
  }

  Future<void> addProduct(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final productCollection = Firestore.instance.collection('products');
        await productCollection.add(product.toMap());
        return _fetchProduct();
      },
    );
  }

  // update product
  Future<void> updateProduct(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final productCollection = Firestore.instance.collection('products');
        await productCollection.document(product.id!).update(product.toMap());
        return _fetchProduct();
      },
    );
  }

  Future<int> getProductCount(String id) async {
    final productCollection = Firestore.instance.collection('products');
    final product = await productCollection.document(id).get();
    return Product.fromSnapshot(product).count;
  }

  // delete product

  Future<void> deleteProduct(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productCollection = Firestore.instance.collection('products');
      await productCollection.document(id).delete();
      return _fetchProduct();
    });
  }
}
