import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/models/product.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/resources/extension.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductChart extends ConsumerWidget {
  final Product product;
  const ProductChart({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref
        .watch(themeDataProvider.notifier)
        .getColor(context, product.colorIndex)!;
    return SfCircularChart(
      legend: Legend(
        isVisible: true,
        isResponsive: true,
      ),
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: [
            ChartData(
              label: 'Remanning',
              count: product.count,
              color: color,
            ),
            ChartData(
              label: 'Sold',
              count: product.intialCount - product.count,
              color: color.generateShade(context, 0.3),
            ),
          ],
          xValueMapper: (ChartData product, _) => product.label,
          yValueMapper: (ChartData product, _) => product.count,
          dataLabelMapper: (ChartData product, _) => '${product.count} ',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          pointColorMapper: (ChartData product, _) => product.color,

          // Set the color mapping based on the colorIndex property of the Product
        ),
      ],
    );
  }
}

class ChartData {
  final String label;
  final int count;
  final Color color;
  ChartData({
    required this.label,
    required this.count,
    required this.color,
  });
}
