import 'package:firedart/firedart.dart';
import 'package:fouda_pharma/models/order.dart';
import 'package:fouda_pharma/providers/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_provider.g.dart';

@riverpod
class AsyncOrderProvider extends _$AsyncOrderProvider {
  @override
  FutureOr<List<Order>> build() async {
    return getFirebaseOrderList();
  }

  Future<List<Order>> getFirebaseOrderList() async {
    final orderCollection = Firestore.instance.collection('orders');
    final documents =
        await orderCollection.orderBy('confirmTime', descending: true).get();
    List<Order> orderList = [];
    for (final doc in documents) {
      orderList.add(Order.fromSnapshot(doc));
    }
    return orderList;
  }

  Future<void> addOrder() async {
    final clientName = ref.watch(clientNameProvider);
    final products = ref.watch(orderProductListProvider);
    final totalprice =
        ref.watch(orderProductListProvider.notifier).totalPrice();
    final order = Order(
        products: products,
        clientName: clientName ?? '',
        totalPrice: totalprice);
    final collection = Firestore.instance.collection('orders');
    final orderData = order.toMap();
    final docRef = await collection.add(orderData);
    final orderId = docRef.id;
    await docRef.reference.update({'id': orderId});
  }
}

@riverpod
class ClientName extends _$ClientName {
  @override
  String? build() {
    return null;
  }

  // change state
  void changeClientName(String name) {
    state = name;
  }
}
