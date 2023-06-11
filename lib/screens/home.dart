import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/client.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/products.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/widget/client_dialog.dart';
import 'package:fouda_pharma/widget/order_products.dart';
import 'package:fouda_pharma/widget/search_bar.dart';
import '../widget/drop_down_client.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(orderProductListProvider);
    final totalPrice =
        ref.watch(orderProductListProvider.notifier).totalPrice();
    final publicTotalPrice =
        ref.watch(orderProductListProvider.notifier).publicTotalPrice();
    return ScaffoldPage(
      header: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SerchBar(),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: ProductList(isOrder: false, productList: productList),
      ),
      bottomBar: (productList.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                    //confirm order
                    child: Text(context.loc.confirmorder),
                    onPressed: () {
                      confirmDialog(context, ref, productList);
                    },
                  ),
                  const SizedBox(width: 20),
                  Button(
                    // reset order
                    child: Text(context.loc.resetorder),
                    onPressed: () {
                      if (productList.isNotEmpty) {
                        ref.read(orderProductListProvider.notifier).reset();
                        ref.read(orderProductListProvider.notifier).close();
                      }
                    },
                  ),
                  const Spacer(flex: 3),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        width: 1.5,
                        color: ref
                            .watch(themeDataProvider.notifier)
                            .systemAccentColor()
                            .lighter,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${context.loc.totalorderprice}  :   $totalPrice  ${context.loc.egp}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          " ${context.loc.public}  :   $publicTotalPrice  ${context.loc.egp}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
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
          title: Text(context.loc.confirmorder),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.loc.choseclient),
              const SizedBox(
                height: 10,
              ),
              const DropDownClient(),
              const SizedBox(
                height: 10,
              ),
              Text(context.loc.newclient),
              const SizedBox(
                height: 10,
              ),
              FilledButton(
                child: Text(context.loc.add),
                onPressed: () => clientContentDialog(
                  context: context,
                  ref: ref,
                  title: context.loc.newclient,
                  buttonTitle: context.loc.add,
                  update: false,
                  onPressed: (newClient) {
                    ref.read(asyncClientProvider.notifier).addClient(newClient);
                  },
                ),
              )
            ],
          ),
          actions: [
            FilledButton(
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
              child: Text(context.loc.confirm),
            ),
            Button(
              //
              child: Text(context.loc.cansel),
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
