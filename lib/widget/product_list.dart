import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/products.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(orderProductListProvider);

    if (productList.isEmpty) {
      return Center(
        child: Text(
          'Fouda Pharma',
          style: GoogleFonts.lora(fontSize: 80),
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productList[index].name),
                  subtitle: Text(productList[index].price.toString()),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
