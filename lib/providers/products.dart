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

  void addProduct(Product product, int? count) {
    // Check if the product already exists
    bool productExists =
        state.any((existingProduct) => existingProduct.id == product.id);
    // int existingProductIndex =
    //     state.indexWhere((existingProduct) => existingProduct.id == product.id);

    if (!productExists) {
      state = [...state, product];
    } else {
      // Product already exists,update it with new count

      // List<Product> updatedState = [...state];
      // updatedState[existingProductIndex] =
      //     updatedState[existingProductIndex].copyWith(count: count);
      state = [
        for (final existingProduct in state)
          if (existingProduct.id == product.id)
            existingProduct.copyWith(count: count)
          else
            existingProduct,
      ];
    }
  }

  // update product count
  void updateProductCount({required String? productId, required int? count}) {
    state = [
      for (final product in state)
        if (product.id == productId)
          product.copyWith(count: count)
        else
          product,
    ];
  }

  void removeProduct(String productId) {
    state = [
      for (final product in state)
        if (product.id != productId) product,
    ];
  }
}
