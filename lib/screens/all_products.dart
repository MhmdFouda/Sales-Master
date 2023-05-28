import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/product_provider.dart';

class AllProductList extends ConsumerWidget {
  const AllProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(asyncProductsProvider);
    return ScaffoldPage(
      content: products.when(
        data: (data) {
          List<DataColumn> columns = const <DataColumn>[
            DataColumn(
              label: Text('Name'),
            ),
            DataColumn(
              label: Text('Price'),
            ),
            DataColumn(
              label: Text('Count'),
            ),
          ];
          var rows = data
              .map(
                (product) => DataRow(
                  cells: [
                    DataCell(
                      Text(product.name),
                    ),
                    DataCell(
                      Text(
                        product.price.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        product.count.toString(),
                      ),
                    ),
                  ],
                ),
              )
              .toList();
          return SingleChildScrollView(
              child: DataTable(columns: columns, rows: rows));
        },
        error: (error, stackTrace) => Text(
          error.toString(),
        ),
        loading: () => const ProgressBar(
          strokeWidth: 1.0,
        ),
      ),
    );
  }
}
