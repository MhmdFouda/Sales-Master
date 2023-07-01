import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';

import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/screens/product_info_page.dart';
import 'package:fouda_pharma/widget/dialogs/product_count_dialog.dart';

final searchTextProvider = StateProvider<String>((ref) => '');

class SerchBar extends ConsumerWidget {
  final bool isHome;
  const SerchBar({
    super.key,
    required this.isHome,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(asyncProductsProvider);
    final searchText = ref.watch(searchTextProvider);

    List<AutoSuggestBoxItem<Product>> items() {
      List<AutoSuggestBoxItem<Product>> items = [];

      if (searchText.isNotEmpty) {
        allProducts.when(
          data: (data) {
            // Filter the products based on the search text
            final filteredProducts = data.where((product) =>
                product.name.toLowerCase().contains(searchText.toLowerCase()));

            // Create list of filtered products as tiles
            for (final product in filteredProducts) {
              items.add(
                AutoSuggestBoxItem<Product>(
                  value: product,
                  label: product.name,
                  onSelected: () {
                    isHome
                        ? showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CountDialog(product: product);
                            },
                          )
                        : Navigator.of(context).push(
                            FluentPageRoute(
                              builder: (context) => ProductInfoPage(
                                productId: product.id!,
                              ),
                            ),
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
      }

      return items;
    }

    return AutoSuggestBox.form(
      onChanged: (value, reason) {
        ref.read(searchTextProvider.notifier).state = value;
      },
      decoration: BoxDecoration(
        border: Border.all(
          color: FluentTheme.of(context).accentColor,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      placeholder: context.loc.search,
      items: items(),
    );
  }
}
