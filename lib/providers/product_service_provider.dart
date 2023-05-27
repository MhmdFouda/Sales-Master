import 'dart:async';

import 'package:firedart/firedart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/product.dart';
part 'product_service_provider.g.dart';

@riverpod
class DataBase extends _$DataBase {
  @override
  Future<List<Product>> build() async {
    final productCollection = Firestore.instance.collection('products');
    final product = await productCollection.get();
    return product.map((doc) => Product.fromSnapshot(doc)).toList();
  }

  Future<Document> addProduct(Product product) async {
    final productCollection = Firestore.instance.collection('products');
    return productCollection.add(product.toMap());
  }
}

@riverpod
Stream<List<Product>> streamProduct(StreamProductRef ref, String input) {
  return Firestore.instance
      .collection('products')
      .where('name', arrayContains: input)
      .get()
      .asStream()
      .map(
        (docs) => docs
            .map(
              (doc) => Product.fromSnapshot(doc),
            )
            .toList(),
      );
}

// @riverpod
// Stream<List<Product>> getAllProductIsar(GetAllProductIsarRef ref) {
//   final products = isar!.products.where().findAll();
//   return products.asStream();
// }

// @riverpod
// Future<void> addProduct(AddProductRef ref, Product product) async {
//   return await isar?.writeTxn(
//     () async {
//       await isar?.products.put(product);
//     },
//   );
// }

// @riverpod
// Future<List<Product>> getSearchProducts(
//     GetSearchProductsRef ref, String input) async {
//   final products = isar!.products.filter().nameContains(input).findAll();
//   return products;
// }
