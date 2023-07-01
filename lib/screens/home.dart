import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/order.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/client.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/products.dart';
import 'package:fouda_pharma/screens/custom_container.dart';
import 'package:fouda_pharma/screens/order_info_page.dart';
import 'package:fouda_pharma/widget/dialogs/client_dialog.dart';
import 'package:fouda_pharma/widget/order_products.dart';
import 'package:fouda_pharma/widget/search_bar.dart';
import '../widget/Reusable/drop_down_client.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(orderProductListProvider);
    final totalPrice =
        ref.watch(orderProductListProvider.notifier).totalPrice();
    // final publicTotalPrice =
    //     ref.watch(orderProductListProvider.notifier).publicTotalPrice();
    final List<Widget> children = [
      FilledButton(
        //confirm order
        child: Platform.isWindows
            ? Text(context.loc.confirmorder)
            : const Icon(
                FluentIcons.check_mark,
                size: 16,
              ),
        onPressed: () {
          confirmDialog(context, ref, productList);
        },
      ),
      const SizedBox(width: 40),
      Button(
        // reset order
        child: Platform.isWindows
            ? Text(context.loc.resetorder)
            : const Icon(
                FluentIcons.delete,
                size: 16,
              ),
        onPressed: () {
          if (productList.isNotEmpty) {
            ref.read(orderProductListProvider.notifier).reset();
            // ref.read(orderProductListProvider.notifier).close();
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
            color: FluentTheme.of(context).accentColor,
          ),
        ),
        child: Text(
          "${context.loc.totalorderprice}  :   $totalPrice  ${context.loc.egp}",
          style: const TextStyle(fontSize: 14),
        ),
      )
    ];
    return ScaffoldPage(
      resizeToAvoidBottomInset: false,
      header: ReusableContainer(
        child: Padding(
          padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 6.0),
          child: const SerchBar(
            isHome: true,
          ),
        ),
      ),
      content: ProductList(
        orderPage: true,
        productList: productList,
      ),
      bottomBar: (productList.isNotEmpty)
          ? ReusableContainer(
              child: Padding(
                padding: Platform.isWindows
                    ? const EdgeInsets.all(10)
                    : const EdgeInsets.all(4),
                child: Platform.isWindows
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: children,
                      )
                    : Row(
                        children: children.reversed.toList(),
                      ),
              ),
            )
          : const SizedBox(
              height: 20,
            ),
    );
  }

  Future<String?> confirmDialog(
    BuildContext context,
    WidgetRef ref,
    List<Product> productList,
  ) {
    DateTime? selected;
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
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
                      ref
                          .read(asyncClientsProvider.notifier)
                          .addClient(newClient);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DatePicker(
                  header: 'أدخل تاريخ غير الأن',
                  selected: selected,
                  onChanged: (time) => setState(() => selected = time),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  final client = ref.watch(clientNameProvider);
                  final clientName = ref.watch(clientNameProvider)?.name;
                  final products = ref.watch(orderProductListProvider);
                  final totalprice =
                      ref.watch(orderProductListProvider.notifier).totalPrice();
                  final publicTotalPrice = ref
                      .watch(orderProductListProvider.notifier)
                      .publicTotalPrice();

                  final order = Order(
                    confirmTime: selected,
                    products: products,
                    clientName: clientName ?? 'Unknown Name',
                    totalPrice: totalprice,
                    publicTotalPrice: publicTotalPrice,
                  );

                  for (var product in productList) {
                    // update the count for all product inside orderproductlist
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
                  // add order to database then refr
                  ref.read(asyncOrderProviderProvider.notifier).addOrder(order);
                  // update client balance and credit then refresh orderproductlist
                  ref
                      .read(asyncClientsProvider.notifier)
                      .updateClient(
                        client!.copyWith(
                          balance: totalprice + client.balance!,
                          credit: totalprice + client.credit!,
                        ),
                      )
                      .then((value) => ref.refresh(asyncOrderProviderProvider));
                  // reset orderproductlist state provider
                  ref.read(orderProductListProvider.notifier).reset();
                  //
                  Navigator.pushReplacement(
                    context,
                    FluentPageRoute(
                      builder: (context) => OrderInfoPage(
                        noId: true,
                        order: order,
                      ),
                    ),
                  );
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
        });
      },
    );
  }
}
