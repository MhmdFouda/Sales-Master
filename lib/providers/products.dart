import 'package:fouda_pharma/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products.g.dart';

@riverpod
class OrderProductList extends _$OrderProductList {
  @override
  List<Product> build() {
    ref.keepAlive();
    return [];
  }

  double totalPrice() {
    double total = 0;
    for (var product in state) {
      total += product.price * product.count;
    }
    return total;
  }

  // reset state
  void reset() {
    state = [];
  }

  void addProduct(Product product) {
    state = [...state, product];
  }

  void removeProduct(String productId) {
    state = [
      for (final product in state)
        if (product.id != productId) product,
    ];
  }
}
