import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/screens/product_info_page.dart';
import 'package:fouda_pharma/widget/product_dialog.dart';

class AllProductList extends ConsumerWidget {
  const AllProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(asyncProductsProvider);
    return ScaffoldPage(
      header: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.loc.products,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FilledButton(
                  child: Text(context.loc.add),
                  onPressed: () => productContentDialog(
                    update: false,
                    context: context,
                    ref: ref,
                    title: context.loc.newproduct,
                    buttonTitle: context.loc.add,
                    onPressed: (newProduct) {
                      ref
                          .read(asyncProductsProvider.notifier)
                          .addProduct(newProduct);
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
      content: products.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 28,
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: FluentTheme.of(context).borderInputColor,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(FluentPageRoute(
                      builder: (context) =>
                          ProductInfoPage(product: data[index]),
                    ));
                  },
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(data[index].name),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      data[index].count.toString(),
                    ),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Text(
          error.toString(),
        ),
        loading: () => const Center(
          child: ProgressBar(),
        ),
      ),
    );
  }
}
