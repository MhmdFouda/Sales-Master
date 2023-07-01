import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';

void productContentDialog({
  required final BuildContext context,
  required final WidgetRef ref,
  required final String title,
  required final String buttonTitle,
  required void Function(Product) onPressed,
  required final bool update,
  final Product? product,
}) async {
  final productNameController = TextEditingController(
    text: update ? product?.name : null,
  );
  final productUnitTypeController = TextEditingController(
    text: update ? product?.unitType : null,
  );
  final productPriceController = TextEditingController(
    text: update
        ? (product?.price == 0.0 ? '' : product?.price.toString())
        : null,
  );
  final productpublicPriceController = TextEditingController(
    text: update
        ? (product?.publicPrice == 0.0 ? '' : product?.publicPrice.toString())
        : null,
  );
  final productCountController = TextEditingController(
    text: update
        ? (product?.count == 0.0 ? '' : product?.count.toString())
        : null,
  );

  await showDialog(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Text(context.loc.name),
            title: TextBox(
              controller: productNameController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Text(context.loc.unittype),
            title: TextBox(
              controller: productUnitTypeController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Text(context.loc.price),
            title: TextBox(
              keyboardType: TextInputType.number,
              controller: productPriceController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Text(context.loc.public),
            title: TextBox(
              keyboardType: TextInputType.number,
              controller: productpublicPriceController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Text(context.loc.count),
            title: TextBox(
              keyboardType: TextInputType.number,
              controller: productCountController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      actions: [
        FilledButton(
          child: Text(buttonTitle),
          onPressed: () {
            final index = ref.read(getRandomIntProvider);
            onPressed(
              Product(
                colorIndex: index,
                name: productNameController.text.isNotEmpty
                    ? productNameController.text
                    : '',
                price: productPriceController.text.isNotEmpty
                    ? double.parse(productPriceController.text)
                    : 0.0,
                count: productCountController.text.isNotEmpty
                    ? int.parse(productCountController.text)
                    : 0,
                intialCount: productCountController.text.isNotEmpty
                    ? int.parse(productCountController.text)
                    : 0,
                publicPrice: productpublicPriceController.text.isNotEmpty
                    ? double.parse(productpublicPriceController.text)
                    : 0.0,
                unitType: productUnitTypeController.text.isNotEmpty
                    ? productUnitTypeController.text
                    : '',
                minCount: productCountController.text.isNotEmpty
                    ? (int.parse(productCountController.text) / 4).round()
                    : 0,
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

  productpublicPriceController.dispose();
}
