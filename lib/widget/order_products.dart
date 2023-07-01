import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/order.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/products.dart';
import 'package:fouda_pharma/resources/extension.dart';
import 'package:fouda_pharma/screens/order_info_page.dart';
import 'package:fouda_pharma/widget/charts/analyze_card.dart';
import 'package:fouda_pharma/widget/charts/price_per_day.dart';

class ProductList extends ConsumerWidget {
  const ProductList({
    required this.orderPage,
    required this.productList,
    this.order,
    Key? key,
  }) : super(key: key);

  final List<Product> productList;
  final bool orderPage;
  final Order? order;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final edite = ref.watch(editModeProvider);

    List<DataRow> buildDataRows(List<Product> productList) {
      List<DataRow> dataRows = [];
      double total = 0.0; // Initialize total to 0

      for (var product in productList) {
        double totalPrice = product.count * product.price;
        total += totalPrice; // Add totalPrice to the total variable

        dataRows.add(
          DataRow(cells: [
            DataCell(Text(product.name)),
            DataCell(
              orderPage
                  ? NumBoxOnline(
                      orderPage: orderPage,
                      total: total,
                      product: product,
                      order: order,
                    )
                  : !edite
                      ? Text(product.count.toString())
                      : NumBoxOnline(
                          orderPage: orderPage,
                          total: total,
                          product: product,
                          order: order,
                        ),
            ),
            DataCell(Text(product.price.toString())),
            DataCell(Text(totalPrice.toString())),
          ]),
        );
      }

      return dataRows;
    }

    List<DataColumn> columns = [
      DataColumn(label: Text(context.loc.product)),
      DataColumn(label: Text(context.loc.count)),
      // DataColumn(label: Text(context.loc.unittype)),
      DataColumn(label: Text(context.loc.price)),
      // DataColumn(label: Text(context.loc.public)),
      DataColumn(label: Text(context.loc.totalorderprice)),
    ];

    if (productList.isEmpty) {
      return Column(
        children: [
          const TimePriceAxis().expand(),
          const AnalyzeCards().expand(),
        ],
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

class NumBoxOnline extends ConsumerWidget {
  const NumBoxOnline({
    super.key,
    required this.orderPage,
    required this.product,
    required this.order,
    required this.total,
  });
  final bool orderPage;
  final Product product;
  final Order? order;
  final double total;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseProduct = ref.watch(getAsyncProductProvider(id: product.id!));
    return firebaseProduct.when(
      data: (data) {
        return NumberBox(
          max: orderPage ? data.count : product.count + data.count,
          min: 0,
          clearButton: false,
          value: product.count,
          onChanged: (value) async {
            if (!orderPage) {
              ref
                  .read(asyncOrderProviderProvider.notifier)
                  .updateProductInOrder(
                    orderId: order!.id!,
                    productId: product.id!,
                    count: value ?? 0,
                  );
              ref
                  .read(asyncOrderProviderProvider.notifier)
                  .updateOrder(order!.copyWith(totalPrice: total));
              final changeamount = value ?? 0 - product.count;
              final count = data.count + (-changeamount);
              ref
                  .read(asyncProductsProvider.notifier)
                  .updateProduct(data.copyWith(
                    count: count,
                  ))
                  .then(
                    (_) => ref.read(editModeProvider.notifier).state = false,
                  )
                  .then((_) => ref.refresh(asyncOrderProviderProvider));
            }
            Future.delayed(
              const Duration(milliseconds: 100),
              () {
                ref.read(orderProductListProvider.notifier).updateProductCount(
                      productId: product.id,
                      count: value ?? 0,
                    );
              },
            );
          },
          mode: orderPage
              ? SpinButtonPlacementMode.inline
              : SpinButtonPlacementMode.none,
        );
      },
      error: (error, stackTrace) {
        return const Text("error");
      },
      loading: () {
        return const ProgressRing();
      },
    );
  }
}
