import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/screens/custom_container.dart';
import 'package:fouda_pharma/widget/charts/product_chart.dart';
import 'package:fouda_pharma/widget/dialogs/product_dialog.dart';
import 'package:fouda_pharma/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

class ProductInfoPage extends ConsumerWidget {
  const ProductInfoPage({
    super.key,
    required this.productId,
  });
  final String productId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProduct = ref.watch(
      getAsyncProductProvider(
        id: productId,
      ),
    );

    final headerSize = Platform.isWindows ? 42.0 : 24.0;
    final subHeaderSize = Platform.isWindows ? 28.0 : 18.0;
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
        content: asyncProduct.when(
          data: (product) {
            return ScaffoldPage(
              padding: const EdgeInsets.all(0.0),
              header: ReusableContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: headerSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${context.loc.price} : ${product.price}',
                          style: TextStyle(
                            fontSize: subHeaderSize,
                          ),
                        ),
                        const SizedBox(width: 26),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${context.loc.public} : ${product.publicPrice}',
                            style: TextStyle(
                              fontSize: subHeaderSize,
                            ),
                          ),
                        ),
                        const SizedBox(width: 26),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${context.loc.count} : ${product.count}',
                            style: TextStyle(
                              fontSize: subHeaderSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              content: ReusableContainer(
                child: Row(
                  mainAxisAlignment: Platform.isWindows
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.center,
                  children: [
                    ProductChart(product: product),
                  ],
                ),
              ),
              bottomBar: ReusableContainer(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Button(
                        onPressed: () => productContentDialog(
                          product: product,
                          update: true,
                          context: context,
                          ref: ref,
                          title: context.loc.updateproduct,
                          buttonTitle: context.loc.update,
                          onPressed: (updatedProduct) {
                            ref
                                .read(asyncProductsProvider.notifier)
                                .updateProduct(
                                  updatedProduct.copyWith(id: product.id),
                                );
                          },
                        ),
                        child: Text(context.loc.edite),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      FilledButton(
                        onPressed: () {
                          ref
                              .read(asyncProductsProvider.notifier)
                              .deleteProduct(product.id!);
                          Navigator.of(context).pop();
                        },
                        child: Text(context.loc.delete),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return const Center(
              child: ProgressRing(),
            );
          },
        ));
  }
}
