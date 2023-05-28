import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 15),
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
                    onPressed: () {},
                  ),
                  Button(
                    child: const Text("Reset Order"),
                    onPressed: () {
                      ref.read(orderProductListProvider.notifier).reset();
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
}
