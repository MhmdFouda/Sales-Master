import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/products.dart';
import 'package:fouda_pharma/widget/product_list.dart';
import 'package:fouda_pharma/widget/search.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(orderProductListProvider);
    final totalPrice =
        ref.watch(orderProductListProvider.notifier).totalPrice();
    return ScaffoldPage(
      header: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SerchBar(),
      ),
      content: const ProductList(),
      bottomBar: (productList.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    child: const Text("Confirm Order"),
                    onPressed: () {
                      for (var product in productList) {
                        ref
                            .read(asyncProductsProvider.notifier)
                            .getProduct(product.id!)
                            .then(
                              (asyncProduct) => ref
                                  .read(asyncProductsProvider.notifier)
                                  .updateProduct(
                                    product.copyWith(
                                      count: asyncProduct.count - product.count,
                                    ),
                                  ),
                            );
                      }
                      ref.read(asyncOrderProviderProvider.notifier).addOrder();
                      ref.read(orderProductListProvider.notifier).reset();
                      confirmDialog(context);
                    },
                  ),
                  Button(
                    child: const Text("Reset Order"),
                    onPressed: () {
                      if (productList.isNotEmpty) {
                        ref.read(orderProductListProvider.notifier).reset();
                      }
                    },
                  ),
                  Text(
                    "Total Price :    $totalPrice  EGP",
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            )
          : const Row(),
    );
  }

  Future<String?> confirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: const Text("Order Confirmed"),
          content: const Text("Your order has been confirmed"),
          actions: [
            Button(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }
}
