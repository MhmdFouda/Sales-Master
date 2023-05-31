import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final countController = TextEditingController();
  @override
  void dispose() {
    countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Count'),
      content: TextBox(
        controller: countController,
        placeholder: '1',
      ),
      actions: [
        Button(
          onPressed: () {
            ref.read(orderProductListProvider.notifier).addProduct(
                  widget.product
                      .copyWith(count: int.parse(countController.text)),
                  int.parse(countController.text),
                );

            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
