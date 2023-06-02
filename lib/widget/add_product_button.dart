import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/product_provider.dart';

class AddProductButton extends ConsumerStatefulWidget {
  const AddProductButton({
    super.key,
  });

  @override
  ConsumerState<AddProductButton> createState() => _AddProductButton();
}

class _AddProductButton extends ConsumerState<AddProductButton> {
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productCountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Button(
      child: Text(context.loc.add),
      onPressed: () => showContentDialog(context),
    );
  }

  void showContentDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(context.loc.newproduct),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBox(
              controller: productNameController,
              placeholder: context.loc.name,
            ),
            const SizedBox(
              height: 10,
            ),
            TextBox(
              keyboardType: TextInputType.number,
              controller: productPriceController,
              placeholder: context.loc.price,
            ),
            const SizedBox(
              height: 10,
            ),
            TextBox(
              keyboardType: TextInputType.number,
              controller: productCountController,
              placeholder: context.loc.count,
            ),
          ],
        ),
        actions: [
          Button(
            child: Text(context.loc.add),
            onPressed: () {
              ref.read(asyncProductsProvider.notifier).addProduct(
                    Product(
                      name: productNameController.text,
                      price: double.parse(productPriceController.text),
                      count: int.parse(productCountController.text),
                    ),
                  );
              Navigator.pop(context);
              // Delete file here
            },
          ),
          FilledButton(
            child: Text(context.loc.cansel),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
