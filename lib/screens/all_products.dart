import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/product_service_provider.dart';

class AllProductList extends ConsumerWidget {
  const AllProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(dataBaseProvider);
    return ScaffoldPage(
      content: products.when(
        data: (data) {
          List<DataColumn> columns = const <DataColumn>[
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Count')),
          ];
          var rows = data
              .map((product) => DataRow(cells: [
                    DataCell(Text(product.name)),
                    DataCell(Text(product.price.toString())),
                    DataCell(Text(product.count.toString())),
                  ]))
              .toList();
          return SingleChildScrollView(
              child: DataTable(columns: columns, rows: rows));

          // ListView.separated(
          //   padding: const EdgeInsets.all(15),
          //   shrinkWrap: true,
          //   separatorBuilder: (context, index) => const Divider(),
          //   itemBuilder: (context, index) {
          //     return Row(
          //       mainAxisSize: MainAxisSize.max,
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           data[index].name,
          //           style: TextStyle(fontSize: 24),
          //         ),
          //         Text(data[index].price.toString()),
          //         Text(data[index].count.toString()),
          //       ],
          //     );
          //   },
          //   itemCount: products.value!.length,
          // );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const ProgressBar(
          strokeWidth: 1.0,
        ),
      ),
    );
  }
}
