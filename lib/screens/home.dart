import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/products.dart';
import 'package:fouda_pharma/widget/add_client_button.dart';
import 'package:fouda_pharma/widget/product_inorder_list.dart';
import 'package:fouda_pharma/widget/search.dart';

import '../widget/drop_down_client.dart';

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
                      confirmDialog(context, ref, productList);
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

  Future<String?> confirmDialog(
      BuildContext context, WidgetRef ref, List<Product> productList) {
    return showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: const Text("Confirm Order"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Choese client"),
              SizedBox(
                height: 10,
              ),
              DropDownClient(),
              SizedBox(
                height: 10,
              ),
              Text("Or add New "),
              SizedBox(
                height: 10,
              ),
              AddClientButton(),
            ],
          ),
          actions: [
            Button(
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
                Navigator.of(context).pop();
              },
              child: const Text("Confirm"),
            ),
            Button(
              child: const Text("Cansel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
