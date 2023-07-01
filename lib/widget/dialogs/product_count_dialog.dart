import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/products.dart';

class CountDialog extends ConsumerWidget {
  const CountDialog({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get the max count of the product avilable on store
    int getMax() {
      final products = ref.watch(asyncProductsProvider).asData?.value ?? [];
      for (final asyncproduct in products) {
        if (asyncproduct.id == product.id) {
          return product.count;
        }
      }
      return 0;
    }

    int count = 0;

    return ContentDialog(
      title: Text(context.loc.count),
      content: NumberBox<int>(
        min: 0,
        max: getMax(),
        clearButton: false,
        value: count,
        onChanged: (value) {
          count = value!;
        },
        mode: SpinButtonPlacementMode.inline,
      ),
      actions: [
        FilledButton(
          onPressed: () {
            ref.read(orderProductListProvider.notifier).addProduct(
                  product.copyWith(count: count),
                  count,
                );

            Navigator.of(context).pop();
          },
          child: Text(context.loc.add),
        ),
        Button(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(context.loc.cansel),
        )
      ],
    );
  }
}
