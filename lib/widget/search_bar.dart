import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';

import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/widget/product_list_tile.dart';

class SerchBar extends ConsumerWidget {
  const SerchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get all the products from the provider
    final allProducts = ref.watch(asyncProductsProvider);

    // Get the products from the provider based on the search input
    Iterable<Widget> getFilteredProducts(SearchController controller) {
      final String input = controller.value.text.toLowerCase();
      return allProducts.when(
        data: (data) {
          // Create a list of tiles based on the filtered products
          List<Widget> filterdProductListTiles = [];
          // Filter the products based on the search input
          List<Product> filteredProducts = data
              .where((Product product) =>
                  product.name.toLowerCase().contains(input))
              .toList();
          for (final product in filteredProducts) {
            filterdProductListTiles.add(
              ProductListTile(
                controller: controller,
                product: product,
              ),
            );
          }
          // Return the list of tiles filtered by the search input
          return filterdProductListTiles;
        },
        error: (error, stackTrace) {
          return [Text(error.toString())];
        },
        loading: () {
          return [const LinearProgressIndicator()];
        },
      );
    }

    // Get the products from the provider based on the search input
    Iterable<Widget> getAllProducts(SearchController controller) {
      // If the search input is empty return all the products & first time open the search bar

      return allProducts.when(
        data: (data) {
          // Create unfiltredlist of all the products as tiles
          List<Widget> productListTiles = [];
          for (final product in data) {
            productListTiles.add(
              ProductListTile(
                controller: controller,
                product: product,
              ),
            );
          }
          return productListTiles;
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
            const LinearProgressIndicator(),
          ];
        },
      );
    }

    return SearchAnchor.bar(
      viewElevation: 3,
      viewShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      barHintText: context.loc.search,
      barElevation: const MaterialStatePropertyAll(0),
      barShape: const MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
      constraints: const BoxConstraints(),
      viewConstraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.4,
      ),
      suggestionsBuilder: (
        BuildContext context,
        SearchController controller,
      ) {
        return controller.text.isEmpty
            ? getAllProducts(controller)
            : getFilteredProducts(controller);
      },
    );
  }
}
