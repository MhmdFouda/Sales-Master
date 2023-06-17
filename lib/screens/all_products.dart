import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/screens/product_info_page.dart';
import 'package:fouda_pharma/widget/product_dialog.dart';
import 'package:fouda_pharma/widget/rec_widget.dart';

class AllProductList extends ConsumerWidget {
  const AllProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(asyncProductsProvider);
    return ScaffoldPage(
      header: Padding(
        padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.loc.products,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FilledButton(
                  child: Text(context.loc.add),
                  onPressed: () => productContentDialog(
                    update: false,
                    context: context,
                    ref: ref,
                    title: context.loc.newproduct,
                    buttonTitle: context.loc.add,
                    onPressed: (newProduct) {
                      ref
                          .read(asyncProductsProvider.notifier)
                          .addProduct(newProduct);
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            AutoSuggestBox.form(items: [])
          ],
        ),
      ),
      content: products.when(
        data: (data) {
          return GridView.builder(
            padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 12.0),
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Platform.isAndroid ? 3 : 5,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(Platform.isWindows ? 12.0 : 6.0),
                child: CustomInfoleWidget(
                  colorIndex: data[index].colorIndex,
                  widgetType: WidgetType.product,
                  objectName: data[index].name,
                  count: data[index].count,
                  onPressed: () {
                    Navigator.of(context).push(FluentPageRoute(
                      builder: (context) =>
                          ProductInfoPage(product: data[index]),
                    ));
                  },
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Text(
          error.toString(),
        ),
        loading: () => const Center(
          child: ProgressBar(),
        ),
      ),
    );
  }
}
