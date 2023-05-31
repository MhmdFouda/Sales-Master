import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/products.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(orderProductListProvider);

    if (productList.isEmpty) {
      return const Center(
        child: Text(
          'Fouda Pharma',
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
              columns: const [
                DataColumn(label: Text('Product')),
                DataColumn(label: Text('Count')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Total Price')),
              ],
              rows: productList.map((product) {
                double totalPrice = product.count * product.price;
                return DataRow(cells: [
                  DataCell(
                    Text(product.name),
                  ),
                  DataCell(
                    NumberBox(
                      clearButton: false,
                      value: product.count,
                      onChanged: (value) {
                        ref
                            .read(orderProductListProvider.notifier)
                            .updateProductCount(
                              productId: product.id,
                              count: value,
                            );
                      },
                      mode: SpinButtonPlacementMode.compact,
                    ),
                  ),
                  DataCell(
                    Text(product.price.toString()),
                  ),
                  DataCell(
                    Text(totalPrice.toString()),
                  ),
                ]);
              }).toList()),
        ),
      );
    }
  }
}
