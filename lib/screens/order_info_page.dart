import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/invoice_logic.dart';
import 'package:fouda_pharma/models/order.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/date_time_formater.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:fouda_pharma/widget/order_products.dart';
import 'package:fouda_pharma/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

final editModeProvider = StateProvider<bool>((ref) {
  return false;
});

class OrderInfoPage extends ConsumerWidget {
  const OrderInfoPage({super.key, required this.order, required this.noId});
  final Order order;
  final bool noId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checked = ref.watch(editModeProvider);
    final headerSize = Platform.isWindows ? 42.0 : 24.0;
    final subHeaderSize = Platform.isWindows ? 28.0 : 18.0;
    final List<Product> orderProducts = order.products;
    return NavigationView(
      appBar: NavigationAppBar(
        height: Platform.isAndroid ? 25 : 56,
        title: const DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
          ),
        ),
        actions: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: Platform.isWindows
              ? [
                  const WindowButtons(),
                ]
              : [],
        ),
      ),
      content: ScaffoldPage(
        header: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.clientName,
                    style: TextStyle(
                      fontSize: headerSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${order.totalPrice}  \$',
                    style: TextStyle(
                      fontSize: subHeaderSize,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Text(
                ref.watch(dateFormaterProvider(order.confirmTime)),
                style: TextStyle(
                  fontSize: subHeaderSize,
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("تعديل الطلب "),
                  ToggleSwitch(
                    checked: checked,
                    onChanged: (value) =>
                        ref.read(editModeProvider.notifier).state = value,
                  ),
                ],
              )
            ],
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ProductList(
            orderPage: false,
            productList: orderProducts,
            order: order,
          ),
        ),
        bottomBar: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  child: const Text("print"),
                  onPressed: () => generateInvoice(order, context, ref),
                ),
                const SizedBox(
                  width: 20,
                ),
                !noId
                    ? Button(
                        child: Text(
                          context.loc.delete,
                        ),
                        onPressed: () {
                          ref
                              .read(asyncOrderProviderProvider.notifier)
                              .deleteOrder(order.id!);
                          Navigator.pop(context);
                        },
                      )
                    : const SizedBox(),
              ],
            )),
      ),
    );
  }
}
