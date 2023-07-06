import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fouda_pharma/models/product.dart';
import 'package:nimbostratus/nimbostratus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@riverpod
class AsyncProducts extends _$AsyncProducts {
  Future<List<Product>> _fetchProduct() async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    final snap = await Nimbostratus.instance.getDocuments(
      productCollection,
      fetchPolicy: GetFetchPolicy.cacheFirst,
    );

    return snap.map((doc) => Product.fromSnapshot(doc)).toList();
  }

  @override
  FutureOr<List<Product>> build() async {
    return _fetchProduct();
  }

  Future<Product> getProduct(String id) async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    final snap = await Nimbostratus.instance.getDocument(
      productCollection.doc(id),
      fetchPolicy: GetFetchPolicy.cacheFirst,
    );
    return Product.fromSnapshot(snap);
  }

  Future<void> addProduct(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productCollection =
          FirebaseFirestore.instance.collection('products');
      await Nimbostratus.instance.addDocument(
        productCollection,
        product.toJson(),
        writePolicy: WritePolicy.cacheAndServer,
      );
      return _fetchProduct();
    });

    ref.invalidateSelf();
  }

  Future<void> updateProduct(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productCollection =
          FirebaseFirestore.instance.collection('products');
      await Nimbostratus.instance.updateDocument(
        productCollection.doc(product.id!),
        product.toJson(),
        writePolicy: WritePolicy.cacheAndServer,
      );
      return _fetchProduct();
    });

    ref.invalidateSelf();
    ref.invalidate(
      getAsyncProductProvider(
        id: product.id!,
      ),
    );
  }

  Future<void> deleteProduct(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productCollection =
          FirebaseFirestore.instance.collection('products');
      await Nimbostratus.instance.deleteDocument(
        productCollection.doc(id),
        deletePolicy: DeletePolicy.cacheAndServer,
      );
      return _fetchProduct();
    });

    ref.invalidateSelf();
  }
}

@riverpod
class GetAsyncProduct extends _$GetAsyncProduct {
  @override
  FutureOr<Product> build({required String id}) async {
    final product =
        await ref.watch(asyncProductsProvider.notifier).getProduct(id);
    return product;
  }
}
