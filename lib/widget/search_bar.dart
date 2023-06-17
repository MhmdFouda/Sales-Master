import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';

import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/widget/product_count_dialog.dart';

final searchTextProvider = StateProvider<String>((ref) => '');

class SerchBar extends ConsumerWidget {
  const SerchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(asyncProductsProvider);

    List<AutoSuggestBoxItem<Product>> items() {
      List<AutoSuggestBoxItem<Product>> items = [];

      allProducts.when(
        data: (data) {
          // Create unfiltredlist of all the products as tiles
          for (final product in data) {
            items.add(
              AutoSuggestBoxItem<Product>(
                value: product,
                label: product.name,
                onSelected: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CountDialog(product: product);
                    },
                  );
                },
              ),
            );
          }
        },
        error: (error, stackTrace) {
          return [
            Text(
              error.toString(),
            ),
          ];
        },
        loading: () {
          return [
            const ProgressBar(),
          ];
        },
      );
      return items;
    }

    return AutoSuggestBox.form(
      placeholder: context.loc.search,
      items: items(),
    );
  }
}
