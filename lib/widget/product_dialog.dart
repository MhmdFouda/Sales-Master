import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';

void productContentDialog({
  required final BuildContext context,
  required final WidgetRef ref,
  required final String title,
  required final String buttonTitle,
  required void Function(Product) onPressed,
  required final bool update,
  final Product? product,
}) async {
  final productNameController = TextEditingController();
  final productUnitTypeController = TextEditingController();
  final productPriceController = TextEditingController();
  final productbublicPriceController = TextEditingController();
  final productCountController = TextEditingController();
  final productMinCountController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBox(
            controller: productNameController,
            placeholder: update ? product!.name : context.loc.name,
          ),
          const SizedBox(
            height: 10,
          ),
          TextBox(
            controller: productUnitTypeController,
            placeholder: context.loc.unittype,
          ),
          const SizedBox(
            height: 10,
          ),
          TextBox(
            keyboardType: TextInputType.number,
            controller: productPriceController,
            placeholder: update ? product!.price.toString() : context.loc.price,
          ),
          const SizedBox(
            height: 10,
          ),
          TextBox(
            keyboardType: TextInputType.number,
            controller: productbublicPriceController,
            placeholder: context.loc.public,
          ),
          const SizedBox(
            height: 10,
          ),
          TextBox(
            keyboardType: TextInputType.number,
            controller: productCountController,
            placeholder: update ? product!.count.toString() : context.loc.count,
          ),
          const SizedBox(
            height: 10,
          ),
          TextBox(
            keyboardType: TextInputType.number,
            controller: productMinCountController,
            placeholder: context.loc.min,
          ),
        ],
      ),
      actions: [
        FilledButton(
          child: Text(buttonTitle),
          onPressed: () {
            onPressed(
              Product(
                name: productNameController.text.isNotEmpty
                    ? productNameController.text
                    : '',
                price: productPriceController.text.isNotEmpty
                    ? double.parse(productPriceController.text)
                    : 0.0,
                count: productCountController.text.isNotEmpty
                    ? int.parse(productCountController.text)
                    : 0,
                minCount: productMinCountController.text.isNotEmpty
                    ? int.parse(productMinCountController.text)
                    : 0,
                bublicPrice: productbublicPriceController.text.isNotEmpty
                    ? double.parse(productbublicPriceController.text)
                    : 0.0,
                unitType: productUnitTypeController.text.isNotEmpty
                    ? productUnitTypeController.text
                    : '',
              ),
            );
            Navigator.pop(context);
          },
        ),
        Button(
          child: Text(context.loc.cansel),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );

  productNameController.dispose();
  productPriceController.dispose();
  productCountController.dispose();
  productMinCountController.dispose();
  productbublicPriceController.dispose();
}
