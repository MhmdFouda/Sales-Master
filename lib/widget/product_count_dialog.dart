import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/products.dart';

class CountDialog extends ConsumerStatefulWidget {
  const CountDialog({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  ConsumerState<CountDialog> createState() => _DialogState();
}

class _DialogState extends ConsumerState<CountDialog> {
  //* cant define var insid build method of statfuel widget
  //* because when we call setState(){} the widget rebuild
  //* and then our var like [count] here well get the intial value again
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // get the max count of the product avilable on store
    int getMax() {
      final products = ref.watch(asyncProductsProvider).asData?.value ?? [];
      for (var product in products) {
        if (product.id == widget.product.id) {
          return product.count;
        }
      }
      return 0;
    }

    return ContentDialog(
      title: Text(context.loc.count),
      content: NumberBox(
        min: 0,
        max: getMax(),
        clearButton: false,
        value: count,
        onChanged: (value) {
          setState(() {
            count = value!;
          });
        },
        mode: SpinButtonPlacementMode.inline,
      ),
      actions: [
        Button(
          onPressed: () {
            ref.read(orderProductListProvider.notifier).addProduct(
                  widget.product.copyWith(count: count),
                  count,
                );

            Navigator.of(context).pop();
          },
          child: Text(context.loc.add),
        ),
      ],
    );
  }
}
