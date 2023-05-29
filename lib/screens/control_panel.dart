import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/product_provider.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [AddButton(), AddButton()],
          )
        ],
      ),
    );
  }
}

class AddButton extends ConsumerStatefulWidget {
  const AddButton({
    super.key,
  });

  @override
  ConsumerState<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends ConsumerState<AddButton> {
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productCountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Button(
      child: const Text('Add Product'),
      onPressed: () => showContentDialog(context),
    );
  }

  void showContentDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Add New Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBox(
              controller: productNameController,
              placeholder: 'Product Name',
            ),
            const SizedBox(
              height: 10,
            ),
            TextBox(
              keyboardType: TextInputType.number,
              controller: productPriceController,
              placeholder: 'Product Price',
            ),
            const SizedBox(
              height: 10,
            ),
            TextBox(
              keyboardType: TextInputType.number,
              controller: productCountController,
              placeholder: 'Product Count',
            ),
          ],
        ),
        actions: [
          Button(
            child: const Text('Save'),
            onPressed: () {
              ref.read(asyncProductsProvider.notifier).addProduct(
                    Product(
                      name: productNameController.text,
                      price: double.parse(productPriceController.text),
                      count: int.parse(productCountController.text),
                    ),
                  );
              Navigator.pop(context, 'User deleted file');
              // Delete file here
            },
          ),
          FilledButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
  }
}
