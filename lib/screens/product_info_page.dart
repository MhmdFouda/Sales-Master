import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/widget/product_chart.dart';
import 'package:fouda_pharma/widget/product_dialog.dart';
import 'package:fouda_pharma/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

class ProductInfoPage extends ConsumerWidget {
  const ProductInfoPage({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref
        .watch(themeDataProvider.notifier)
        .getColor(context, product.colorIndex);
    ref.watch(asyncProductsProvider);
    final headerSize = Platform.isWindows ? 42.0 : 24.0;
    final subHeaderSize = Platform.isWindows ? 28.0 : 18.0;
    return NavigationView(
      appBar: NavigationAppBar(
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
        padding: const EdgeInsets.all(0),
        header: Container(
          padding: const EdgeInsets.all(25.0),
          margin: const EdgeInsets.symmetric(horizontal: 25.0),
          decoration: BoxDecoration(
            color: color!,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0,
                    3), // Offset of the shadow (0 horizontally, 4 vertically)
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
          ),
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
                children: [
                  Text(
                    'Price: ${product.price}',
                    style: TextStyle(
                      fontSize: subHeaderSize,
                    ),
                  ),
                  const SizedBox(width: 26),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Count: ${product.count}',
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
        content: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ProductChart(product: product),
          ],
        ),
        bottomBar: Padding(
          padding: const EdgeInsets.all(30.0),
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
                    ref.read(asyncProductsProvider.notifier).updateProduct(
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
  }
}
