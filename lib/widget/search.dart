import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/models/product.dart';

import 'package:fouda_pharma/providers/product_service_provider.dart';

class SerchBar extends ConsumerStatefulWidget {
  const SerchBar({
    super.key,
  });

  @override
  ConsumerState<SerchBar> createState() => _SerchBarState();
}

class _SerchBarState extends ConsumerState<SerchBar> {
  List<Product> searchHistory = <Product>[];

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (Product product) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(product.name),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = product.name;
            controller.selection =
                TextSelection.collapsed(offset: controller.text.length);
          },
        ),
      ),
    );
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text.toLowerCase();
    final products = ref.watch(dataBaseProvider);

    return products.when(
      data: (data) {
        return data
            .where(
                (Product product) => product.name.toLowerCase().contains(input))
            .toList()
            .map(
              (e) => ListTile(
                title: Text(e.name),
                onTap: () {
                  controller.closeView(e.name);
                  // handleSelection(filteredProduct);
                },
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
    final allProducts = ref.watch(dataBaseProvider);
    return SearchAnchor.bar(
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
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        if (controller.text.isEmpty) {
          if (searchHistory.isNotEmpty) {
            return getHistoryList(controller);
          }
          return allProducts.when(
            data: (data) {
              return data.map(
                (e) => ListTile(
                  title: Text(e.name),
                  onTap: () {
                    controller.closeView(e.name);
                    // handleSelection(filteredProduct);
                  },
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
        return getSuggestions(controller);
      },
    );
  }
}
