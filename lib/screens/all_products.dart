import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/screens/custom_container.dart';
import 'package:fouda_pharma/screens/product_info_page.dart';
import 'package:fouda_pharma/widget/dialogs/product_dialog.dart';
import 'package:fouda_pharma/widget/Reusable/rec_widget.dart';
import 'package:fouda_pharma/widget/search_bar.dart';

class AllProductList extends ConsumerWidget {
  const AllProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(asyncProductsProvider);
    return ScaffoldPage(
      resizeToAvoidBottomInset: false,
      header: ReusableContainer(
        child: Padding(
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
              const SerchBar(
                isHome: false,
              )
            ],
          ),
        ),
      ),
      content: products.when(
        data: (data) {
          return ReusableContainer(
            child: material.RefreshIndicator(
              onRefresh: () => ref.refresh(asyncProductsProvider.future),
              child: GridView.builder(
                padding: EdgeInsets.all(Platform.isWindows ? 25.0 : 12.0),
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Platform.isAndroid ? 3 : 6,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return CustomInfoleWidget(
                    colorIndex: data[index].colorIndex,
                    objectName: data[index].name,
                    count: data[index].count,
                    onPressed: () {
                      Navigator.of(context).push(FluentPageRoute(
                        builder: (context) =>
                            ProductInfoPage(productId: data[index].id!),
                      ));
                    },
                  );
                },
              ),
            ),
          );
        },
        error: (error, stackTrace) => Text(
          error.toString(),
        ),
        loading: () => const Center(
          child: ProgressBar(),
        ),
      ),
      bottomBar: const SizedBox(
        height: 10,
      ),
    );
  }
}
