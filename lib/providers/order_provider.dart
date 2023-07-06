import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:fouda_pharma/models/client.dart';
import 'package:fouda_pharma/models/order.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:nimbostratus/nimbostratus.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_provider.g.dart';

@riverpod
class AsyncOrderProvider extends _$AsyncOrderProvider {
  // get list of all order
  Future<List<Order>> fetchOrders() async {
    final orderCollection =
        firestore.FirebaseFirestore.instance.collection('orders').orderBy(
              'confirmTime',
              descending: true,
            );
    final snap = await Nimbostratus.instance.getDocuments(
      orderCollection,
      fetchPolicy: GetFetchPolicy.cacheFirst,
    );

    return snap.map((doc) => Order.fromSnapshot(doc)).toList();
  }

  // get filter order by client name
  Future<List<Order>> fetchFilterOrders(String clientName) async {
    final orderCollection = firestore.FirebaseFirestore.instance
        .collection('orders')
        .where('clientName', isEqualTo: clientName)
        .orderBy('confirmTime', descending: true);
    final snap = await Nimbostratus.instance.getDocuments(
      orderCollection,
      fetchPolicy: GetFetchPolicy.cacheFirst,
    );
    return snap.map((doc) => Order.fromSnapshot(doc)).toList();
  }

  @override
  FutureOr<List<Order>> build() async {
    return fetchOrders();
  }

  // total price of all order
  double getTotalPrice() {
    double totalPrice = 0;
    for (final order in state.value ?? []) {
      totalPrice += order.totalPrice;
    }
    return totalPrice;
  }

  // get order by id
  Future<Order> getOrderById(String id) async {
    final orderCollection =
        firestore.FirebaseFirestore.instance.collection('orders');
    final snap = await Nimbostratus.instance.getDocument(
      orderCollection.doc(id),
      fetchPolicy: GetFetchPolicy.cacheFirst,
    );
    return Order.fromSnapshot(snap);
  }

  // update list of product inside the order
  Future<void> updateProductInOrder({
    required Order order,
    required String productId,
    required int count,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final orderCollection =
          firestore.FirebaseFirestore.instance.collection('orders');

      final orderSnapshot = await Nimbostratus.instance.getDocument(
        orderCollection.doc(order.id),
        fetchPolicy: GetFetchPolicy.cacheFirst,
      );

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
        await Nimbostratus.instance.updateDocument(
          orderCollection.doc(order.id),
          order.copyWith(products: updatedProductList).toMap(),
          writePolicy: WritePolicy.cacheAndServer,
        );
      }
      return fetchOrders();
    });
    ref.invalidateSelf();
    ref.invalidate(getOrderByIdProvider(id: order.id!));
  }

  // update order with id
  Future<void> updateOrder(Order order) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final collection =
          firestore.FirebaseFirestore.instance.collection('orders');
      await Nimbostratus.instance.updateDocument(
        collection.doc(order.id),
        order.toMap(),
        writePolicy: WritePolicy.cacheAndServer,
      );
      return fetchOrders();
    });

    ref.invalidateSelf();
    ref.invalidate(getOrderByIdProvider(id: order.id!));
  }

  // add new order
  Future<void> addOrder(Order order) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final collection =
          firestore.FirebaseFirestore.instance.collection('orders');
      await Nimbostratus.instance.addDocument(
        collection,
        order.toMap(),
        writePolicy: WritePolicy.cacheAndServer,
      );
      return fetchOrders();
    });
    ref.invalidateSelf();
  }

  // delete order with id
  Future<void> deleteOrder(Order order) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final collection =
          firestore.FirebaseFirestore.instance.collection('orders');
      await Nimbostratus.instance.deleteDocument(
        collection.doc(order.id),
        deletePolicy: DeletePolicy.cacheAndServer,
      );
      return fetchOrders();
    });

    ref.invalidateSelf();
    ref.invalidate(asyncFilterdOrderProvider(order.clientName));
  }
}

@riverpod
class GetOrderById extends _$GetOrderById {
  @override
  Future<Order> build({required String id}) async {
    final order =
        ref.watch(asyncOrderProviderProvider.notifier).getOrderById(id);
    return order;
  }
}

@riverpod
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
class AsyncFilterdOrder extends _$AsyncFilterdOrder {
  @override
  Future<List<Order>> build(String clientName) async {
    final filterOrders = ref
        .watch(asyncOrderProviderProvider.notifier)
        .fetchFilterOrders(clientName);
    return filterOrders;
  }
}
