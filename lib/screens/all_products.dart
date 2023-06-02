import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/screens/product_info_page.dart';
import 'package:fouda_pharma/widget/add_product_button.dart';

class AllProductList extends ConsumerWidget {
  const AllProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(asyncProductsProvider);
    return ScaffoldPage(
      header: const Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AddProductButton(),
              ],
            ),
            SizedBox(
              height: 28,
            ),
            // AutoSuggestBox<Product>.form(
            //     items: products.value!.map((product) {
            //   return AutoSuggestBoxItem<Product>(
            //       onSelected: () {
            //         Navigator.of(context).push(FluentPageRoute(
            //           builder: (context) => ProductInfoPage(product: product),
            //         ));
            //       },
            //       value: product,
            //       label: product.name);
            // }).toList())
          ],
        ),
      ),
      content: products.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 28),
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
                    child: Text(data[index].count.toString()),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Text(
          error.toString(),
        ),
        loading: () => const Center(child: ProgressBar()),
      ),
    );
  }
}
