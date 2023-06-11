// ignore: file_names
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/products.dart';

class ProductList extends ConsumerWidget {
  const ProductList(
      {required this.isOrder, required this.productList, super.key});
  final List<Product> productList;
  final bool isOrder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int getMax(String id) {
      final products = ref.watch(asyncProductsProvider).asData?.value ?? [];
      for (var product in products) {
        if (product.id == id) {
          return product.count;
        }
      }
      return 0;
    }

    // table rows
    final List<DataRow> dataRows = [];
    // add rows to table method
    for (var product in productList) {
      double totalPrice = product.count * product.price;

      dataRows.add(
        DataRow(cells: [
          DataCell(
            Text(product.name),
          ),
          DataCell(
            isOrder
                ? Text(product.count.toString())
                : NumberBox(
                    max: getMax(product.id!),
                    min: 0,
                    clearButton: false,
                    value: product.count,
                    onChanged: (value) async {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        ref
                            .read(orderProductListProvider.notifier)
                            .updateProductCount(
                                productId: product.id, count: value);
                      });
                    },
                    mode: SpinButtonPlacementMode.inline,
                  ),
          ),
          DataCell(
            Text(product.unitType.toString()),
          ),
          DataCell(
            Text(product.price.toString()),
          ),
          DataCell(
            Text(product.publicPrice.toString()),
          ),
          DataCell(
            Text(totalPrice.toString()),
          ),
        ]),
      );
    }
    // table columns
    List<DataColumn> columns = [
      DataColumn(label: Text(context.loc.product)),
      DataColumn(label: Text(context.loc.count)),
      DataColumn(label: Text(context.loc.unittype)),
      DataColumn(label: Text(context.loc.price)),
      DataColumn(label: Text(context.loc.public)),
      DataColumn(label: Text(context.loc.totalorderprice)),
    ];

    if (productList.isEmpty) {
      return const Center(
        child: Text(
          'Sales Master',
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
            columns: columns,
            rows: dataRows.toList(),
          ),
        ),
      );
    }
  }
}
