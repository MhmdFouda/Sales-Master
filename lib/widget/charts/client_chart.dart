import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/models/order.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrderChart extends ConsumerWidget {
  const OrderChart({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(asyncOrderProviderProvider);
    return orders.when(
      data: (orders) {
        // Sort the orders in descending order based on total price
        orders.sort((a, b) => b.totalPrice.compareTo(a.totalPrice));
        // Get the top five clients based on total price
        List<Order> topFiveClients = orders.take(5).toList();
        return SfCartesianChart(
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
          ),
          enableAxisAnimation: true,
          isTransposed: true,
          primaryXAxis: CategoryAxis(
            labelStyle: const TextStyle(
              fontSize: 10, // Set the desired font size for client names
            ),
          ),
          series: <ChartSeries>[
            BarSeries<Order, String>(
              color: FluentTheme.of(context).accentColor,
              dataSource:
                  topFiveClients, // Use the filtered list of top five clients
              xValueMapper: (Order order, _) => order.clientName,
              yValueMapper: (Order order, _) => order.totalPrice,
            ),
          ],
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () {
        return const Center(child: ProgressRing());
      },
    );
  }
}
