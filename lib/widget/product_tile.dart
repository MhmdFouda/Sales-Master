import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/widget/content_dialog.dart';

class ProductListTile extends ConsumerWidget {
  const ProductListTile({
    super.key,
    required this.product,
    required this.controller,
  });
  final Product product;

  final SearchController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(product.name),
      onTap: () {
        showContentDialog(context);
        // handleSelection(filteredProduct);
      },
    );
  }

  void showContentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CountDialog(product: product);
      },
    ).then((_) => controller.closeView(product.name));
  }
}
