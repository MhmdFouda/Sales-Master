import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/models/order.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/date_time_formater.dart';
import 'package:fouda_pharma/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

class OrderInfoPage extends ConsumerWidget {
  const OrderInfoPage({super.key, required this.order});
  final Order order;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Product> orderProducts = order.products;
    return NavigationView(
      appBar: const NavigationAppBar(
        title: DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('Fouda Pharma'),
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
                    order.clientName,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price : ${order.totalPrice}',
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
                  ref.watch(dateFormaterProvider(order.confirmTime)),
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.builder(
            itemCount: orderProducts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(orderProducts[index].name),
                trailing: Text(orderProducts[index].price.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
