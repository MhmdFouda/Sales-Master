import 'package:fouda_pharma/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products.g.dart';

@Riverpod(keepAlive: true)
class OrderProductList extends _$OrderProductList {
  @override
  List<Product> build() {
    return [];
  }

  // void close() {
  //   ref.keepAlive().close();
  // }

  double totalPrice() {
    double total = 0;
    for (var product in state) {
      total += product.price * product.count;
    }
    return total;
  }

  double publicTotalPrice() {
    double publicTotal = 0;
    for (var product in state) {
      publicTotal += product.publicPrice * product.count;
    }
    return publicTotal;
  }

  // reset state
  void reset() {
    state = [];
  }

  void addProduct(Product product, int? count) {
    if (count != 0) {
      bool productExists =
          state.any((existingProduct) => existingProduct.id == product.id);
      if (!productExists) {
        state = [...state, product];
      } else {
        state = [
          for (final existingProduct in state)
            if (existingProduct.id == product.id)
              existingProduct.copyWith(count: count!)
            else
              existingProduct,
        ];
      }
    } else {
      removeProduct(product.id!);
    }
  }

  // update product count
  void updateProductCount({required String? productId, required int? count}) {
    count != 0
        ? state = [
            for (var product in state)
              if (product.id == productId)
                product.copyWith(count: count!)
              else
                product,
          ]
        : removeProduct(productId!);
  }

  void removeProduct(String productId) {
    state = state.where((product) => product.id != productId).toList();
  }
}
