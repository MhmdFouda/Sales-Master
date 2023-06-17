import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/products.dart';

class ProductList extends ConsumerWidget {
  const ProductList({
    required this.isOrder,
    required this.productList,
    Key? key,
  }) : super(key: key);

  final List<Product> productList;
  final bool isOrder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(asyncProductsProvider).asData?.value ?? [];

    int getMax(String id) {
      for (var product in products) {
        if (product.id == id) {
          return product.count;
        }
      }
      return 0;
    }

    List<DataRow> buildDataRows(List<Product> productList) {
      List<DataRow> dataRows = [];
      for (var product in productList) {
        double totalPrice = product.count * product.price;

        dataRows.add(
          DataRow(cells: [
            DataCell(Text(product.name)),
            DataCell(
              isOrder
                  ? Text(product.count.toString())
                  : NumberBox(
                      max: getMax(product.id!),
                      min: 0,
                      clearButton: false,
                      value: product.count,
                      onChanged: (value) {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          ref
                              .read(orderProductListProvider.notifier)
                              .updateProductCount(
                                productId: product.id,
                                count: value,
                              );
                        });
                      },
                      mode: SpinButtonPlacementMode.inline,
                    ),
            ),
            DataCell(Text(product.unitType.toString())),
            DataCell(Text(product.price.toString())),
            DataCell(Text(product.publicPrice.toString())),
            DataCell(Text(totalPrice.toString())),
          ]),
        );
      }
      return dataRows;
    }

    List<DataColumn> columns = [
      DataColumn(label: Text(context.loc.product)),
      DataColumn(label: Text(context.loc.count)),
      DataColumn(label: Text(context.loc.unittype)),
      DataColumn(label: Text(context.loc.price)),
      DataColumn(label: Text(context.loc.public)),
      DataColumn(label: Text(context.loc.totalorderprice)),
    ];

    if (productList.isEmpty) {
      return const Align(
        child: Text(
          'Sales Master',
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      if (Platform.isAndroid) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: columns,
                rows: buildDataRows(productList),
              ),
            ),
          ),
        );
      } else {
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: DataTable(
              columns: columns,
              rows: buildDataRows(productList),
            ),
          ),
        );
      }
    }
  }
}
