import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:fouda_pharma/models/client.dart';
import 'package:fouda_pharma/models/order.dart';
import 'package:fouda_pharma/models/product.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_provider.g.dart';

@Riverpod(keepAlive: true)
class AsyncOrderProvider extends _$AsyncOrderProvider {
  Future<List<Order>> getFirebaseOrderList() async {
    final orderCollection =
        firestore.FirebaseFirestore.instance.collection('orders');
    final documents = await orderCollection.get(const firestore.GetOptions());
    final List<Order> orderList = [];
    for (final doc in documents.docs) {
      orderList.add(Order.fromSnapshot(doc));
    }
    // Sort the data offline
    orderList.sort((a, b) => b.confirmTime.compareTo(a.confirmTime));

    // Access the sorted data
    final List<Order> sortedOrders = orderList;
    // Use sortedDocs for further processing or display

    return sortedOrders;
  }

  @override
  FutureOr<List<Order>> build() async {
    return getFirebaseOrderList();
  }

  Future<void> updateProductInOrder({
    required String orderId,
    required String productId,
    required int count,
  }) async {
    final orderCollection =
        firestore.FirebaseFirestore.instance.collection('orders');
    final orderDoc = orderCollection.doc(orderId);
    final orderSnapshot = await orderDoc.get();

    if (orderSnapshot.exists) {
      final orderData = orderSnapshot.data();
      final productList = (orderData?['products'] as List<dynamic>)
          .map((item) => Product.fromJson(item))
          .toList();

      final updatedProductList = productList.map((product) {
        if (product.id == productId) {
          return product.copyWith(count: count);
        } else {
          return product;
        }
      }).toList();

      await orderDoc.update({
        'products':
            updatedProductList.map((product) => product.toJson()).toList(),
      });
    }
  }

  Future<List<Order>> getFilterdOrderList(String clientName) async {
    final orderCollection =
        firestore.FirebaseFirestore.instance.collection('orders');
    final documents = await orderCollection
        .orderBy('confirmTime', descending: true)
        .where('clientName', isEqualTo: clientName)
        .get(const firestore.GetOptions());
    List<Order> filterdOrderList = [];
    for (final doc in documents.docs) {
      filterdOrderList.add(Order.fromSnapshot(doc));
    }
    return filterdOrderList;
  }

  // update order with id
  Future<void> updateOrder(Order order) async {
    final collection =
        firestore.FirebaseFirestore.instance.collection('orders');
    await collection.doc(order.id).update(order.toMap());
  }

  Future<void> addOrder(Order order) async {
    final collection =
        firestore.FirebaseFirestore.instance.collection('orders');
    final docRef = await collection.add(order.toMap());
    await docRef.update({'id': docRef.id});
  }

  // delete order with id
  Future<void> deleteOrder(String id) async {
    final collection =
        firestore.FirebaseFirestore.instance.collection('orders');
    await collection.doc(id).delete();
  }
}

@Riverpod(keepAlive: true)
class ClientName extends _$ClientName {
  @override
  Client? build() {
    return null;
  }

  // change state
  void changeClientName(Client client) {
    state = client;
  }
}

@riverpod
FutureOr<List<Order>> asyncFilterdOrder(
    AsyncFilterdOrderRef ref, String clientName) async {
  final orderCollection =
      firestore.FirebaseFirestore.instance.collection('orders');
  final documents = await orderCollection
      .where('clientName', isEqualTo: clientName)
      .orderBy('confirmTime', descending: true)
      .get(const firestore.GetOptions());
  List<Order> filterdOrderList = [];
  for (final doc in documents.docs) {
    filterdOrderList.add(Order.fromSnapshot(doc));
  }

  return filterdOrderList;
}
