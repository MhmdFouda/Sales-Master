import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/product_provider.dart';
import 'package:fouda_pharma/resources/extension.dart';
import 'package:fouda_pharma/screens/custom_container.dart';

import 'package:fouda_pharma/widget/Reusable/slider_widget.dart';

class AnalyzeCards extends ConsumerWidget {
  const AnalyzeCards({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(asyncProductsProvider).valueOrNull ?? [];

    final count = products.length;

    double total = 0.0;
    for (var product in products) {
      total += product.count * product.price;
    }

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
                    total.formatAsCurrency(),
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
                    total.formatAsCurrency(),
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
                    count.toString(),
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
 