import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/widget/product_dialog.dart';
import 'package:fouda_pharma/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

class ProductInfoPage extends ConsumerWidget {
  const ProductInfoPage({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
          ),
        ),
        actions: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          WindowButtons(),
        ]),
      ),
      content: ScaffoldPage(
        header: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price : ${product.price}',
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Count : ${product.count}',
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomBar: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                onPressed: () => productContentDialog(
                  product: product,
                  update: true,
                  context: context,
                  ref: ref,
                  title: context.loc.updateproduct,
                  buttonTitle: context.loc.update,
                  onPressed: (updatedProduct) {
                    ref.read(asyncProductsProvider.notifier).updateProduct(
                          updatedProduct.copyWith(id: product.id),
                        );
                  },
                ),
                child: Text(context.loc.edite),
              ),
              const SizedBox(
                width: 20,
              ),
              FilledButton(
                onPressed: () {
                  ref
                      .read(asyncProductsProvider.notifier)
                      .deleteProduct(product.id!);
                  Navigator.of(context).pop();
                },
                child: Text(context.loc.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
