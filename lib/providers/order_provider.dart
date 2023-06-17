import 'package:firedart/firedart.dart';
import 'package:fouda_pharma/models/order.dart';
import 'package:fouda_pharma/providers/products.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
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
    final publicTotalPrice =
        ref.watch(orderProductListProvider.notifier).publicTotalPrice();
    final index = ref.watch(getRandomIntProvider);
    final order = Order(
      products: products,
      clientName: clientName ?? '',
      totalPrice: totalprice,
      publicTotalPrice: publicTotalPrice,
      colorIndex: index,
    );
    final collection = Firestore.instance.collection('orders');
    final docRef = await collection.add(order.toMap());
    await docRef.reference.update({'id': docRef.id});
  }

  // delete order with id
  Future<void> deleteOrder(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final collection = Firestore.instance.collection('orders');
        await collection.document(id).delete();
        return getFirebaseOrderList();
      },
    );
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
