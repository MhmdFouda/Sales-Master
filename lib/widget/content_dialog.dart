import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';
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
  @override
  Widget build(BuildContext context) {
    int count = 1;
    return ContentDialog(
      title: Text(context.loc.count),
      content: NumberBox(
        clearButton: false,
        value: count,
        onChanged: (value) {
          setState(() {
            count = value!;
          });
        },
        mode: SpinButtonPlacementMode.compact,
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
