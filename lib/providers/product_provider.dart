import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fouda_pharma/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@Riverpod(keepAlive: true)
class AsyncProducts extends _$AsyncProducts {
  Future<List<Product>> _fetchProduct() async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    final documents = await productCollection.get(const GetOptions());
    List<Product> productList = [];
    for (final doc in documents.docs) {
      productList.add(Product.fromSnapshot(doc));
    }
    return productList;
  }

  @override
  FutureOr<List<Product>> build() async {
    return _fetchProduct();
  }

  // git products list length
  Future<int> productCount() async {
    final products = await _fetchProduct();
    final int count = products.length;
    return count;
  }

  Future<Product> getProduct(String id) async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    final product = await productCollection.doc(id).get(const GetOptions());
    return Product.fromSnapshot(product);
  }

  Future<void> addProduct(Product product) async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    await productCollection.add(product.toJson());
  }

  // update product
  Future<void> updateProduct(Product product) async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    await productCollection.doc(product.id!).update(product.toJson());
  }

  // delete product

  Future<void> deleteProduct(String id) async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    await productCollection.doc(id).delete();
  }
}

@riverpod
FutureOr<Product> getAsyncProduct(GetAsyncProductRef ref,
    {required String id}) async {
  final product =
      await ref.watch(asyncProductsProvider.notifier).getProduct(id);
  return product;
}
