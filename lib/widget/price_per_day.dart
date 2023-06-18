import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TimePriceAxis extends ConsumerWidget {
  const TimePriceAxis({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(asyncOrderProviderProvider);
    return orders.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
          child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(dateFormat: DateFormat.yMd()),
            primaryYAxis: NumericAxis(),
            series: <CartesianSeries>[
              LineSeries<ChartData, DateTime>(
                dataSource: [
                  for (final order in data)
                    ChartData(
                      order.confirmTime,
                      order.totalPrice,
                    ),
                ],
                xValueMapper: (ChartData data, _) => data.date,
                yValueMapper: (ChartData data, _) => data.totalPrice,
              ),
            ],
            trackballBehavior: TrackballBehavior(
              enable: true,
              lineType: TrackballLineType.none,
              activationMode: ActivationMode.singleTap,
              tooltipSettings:
                  const InteractiveTooltip(format: 'point.x : point.y'),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ChartData {
  final DateTime date;
  final double totalPrice;

  ChartData(this.date, this.totalPrice);
}
