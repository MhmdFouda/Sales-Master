import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/models/product.dart';

import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/products.dart';
import 'package:fouda_pharma/widget/product_tile.dart';

class SerchBar extends ConsumerStatefulWidget {
  const SerchBar({
    super.key,
  });

  @override
  ConsumerState<SerchBar> createState() => _SerchBarState();
}

class _SerchBarState extends ConsumerState<SerchBar> {
  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text.toLowerCase();
    final products = ref.watch(asyncProductsProvider);

    return products.when(
      data: (data) {
        return data
            .where(
                (Product product) => product.name.toLowerCase().contains(input))
            .toList()
            .map(
              (product) => ProductListTile(
                controller: controller,
                product: product,
              ),
            );
      },
      error: (error, stackTrace) {
        return [Text(error.toString())];
      },
      loading: () {
        return [const LinearProgressIndicator()];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = ref.watch(asyncProductsProvider);
    return SearchAnchor.bar(
      viewElevation: 3,
      viewShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      barHintText: 'Search for products...',
      barElevation: const MaterialStatePropertyAll(0),
      barShape: const MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
      constraints: const BoxConstraints(),
      suggestionsBuilder: (
        BuildContext context,
        SearchController controller,
      ) {
        if (controller.text.isEmpty) {
          return allProducts.when(
            data: (data) {
              return data.map(
                (product) => ProductListTile(
                  controller: controller,
                  product: product,
                ),
              );
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
        return getSuggestions(controller);
      },
    );
  }
}
