import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/providers/supplier.dart';
import 'package:fouda_pharma/resources/extension.dart';
import 'package:fouda_pharma/screens/custom_container.dart';

import 'package:fouda_pharma/widget/Reusable/slider_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'analyze_card.g.dart';

class AnalyzeCards extends ConsumerWidget {
  const AnalyzeCards({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(productCountProvider);
    final total = ref.watch(allProductsPriceProvider);
    final profet = ref.watch(profetProvider);
    return SliderWidget(
      pageCount: 3,
      child3: ReusableContainer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'الربح المتوقع ',
                style: TextStyle(fontSize: 28),
              ),
              Center(
                child: ReusableContainer(
                  color: FluentTheme.of(context).accentColor,
                  child: Text(
                    profet.value.formatAsCurrency(),
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                  ),
                ),
              ).expand(),
            ],
          ),
        ),
      ),
      child2: ReusableContainer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'إجمالى سعر جميع النتجات',
                style: TextStyle(fontSize: 28),
              ),
              Center(
                child: ReusableContainer(
                  color: FluentTheme.of(context).accentColor,
                  child: Text(
                    total.value.formatAsCurrency(),
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                  ),
                ),
              ).expand(),
            ],
          ),
        ),
      ),
      child: ReusableContainer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'إجمالى عدد المنتجات',
                style: TextStyle(fontSize: 28),
              ),
              Center(
                child: ReusableContainer(
                  color: FluentTheme.of(context).accentColor,
                  child: Text(
                    count.value.toString(),
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                  ),
                ),
              ).expand(),
            ],
          ),
        ),
      ),
    );
  }
}

@Riverpod(keepAlive: false)
FutureOr<int> productCount(ProductCountRef ref) async {
  final products = await ref.watch(asyncProductsProvider.future);
  final int count = products.length;
  return count;
}

@Riverpod(keepAlive: false)
FutureOr<double> allProductsPrice(AllProductsPriceRef ref) async {
  final products = await ref.watch(asyncProductsProvider.future);
  double total = 0.0;
  for (var product in products) {
    total += product.count * product.price;
  }
  return total;
}

@Riverpod(keepAlive: false)
FutureOr<double> profet(ProfetRef ref) async {
  final suppliers = await ref.watch(asyncSupplierProvider.future);
  final allProductPrices = await ref.watch(allProductsPriceProvider.future);
  double total = 0;
  for (var supplier in suppliers) {
    total += supplier.balance!;
    return total;
  }
  final profet = allProductPrices - total;
  return profet;
}
