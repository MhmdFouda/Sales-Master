import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:fouda_pharma/screens/custom_container.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TimePriceAxis extends ConsumerStatefulWidget {
  const TimePriceAxis({super.key});

  @override
  ConsumerState<TimePriceAxis> createState() => _TimePriceAxisState();
}

class _TimePriceAxisState extends ConsumerState<TimePriceAxis> {
  @override
  Widget build(BuildContext context) {
    final asyncOrders = ref.watch(asyncOrderProviderProvider);

    return asyncOrders.when(
      data: (orders) {
        final chartDataList = [
          for (final order in orders)
            ChartData(
              order.confirmTime,
              order.totalPrice,
            ),
        ];
        return ReusableContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
            child: SfCartesianChart(
              zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true,
                zoomMode: ZoomMode.x,
                enablePanning: true,
                enableMouseWheelZooming: true,
              ),
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat.Md(),
              ),
              primaryYAxis: NumericAxis(),
              series: <ChartSeries<ChartData, DateTime>>[
                AreaSeries<ChartData, DateTime>(
                  color: FluentTheme.of(context).accentColor.withOpacity(.7),
                  dataSource: chartDataList,
                  xValueMapper: (ChartData data, _) => data.date,
                  yValueMapper: (ChartData data, _) => data.totalPrice,
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
              ],
              trackballBehavior: TrackballBehavior(
                enable: true,
                lineType: TrackballLineType.none,
                activationMode: ActivationMode.singleTap,
                tooltipSettings:
                    const InteractiveTooltip(format: ' point.x  :  point.y '),
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(child: ProgressRing());
      },
    );
  }
}

class ChartData {
  final DateTime date;
  final double totalPrice;

  ChartData(this.date, this.totalPrice);
}
