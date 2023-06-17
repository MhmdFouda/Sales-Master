import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/date_time_formater.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:fouda_pharma/screens/order_info_page.dart';
import 'package:fouda_pharma/widget/rec_widget.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderList = ref.watch(asyncOrderProviderProvider);
    return ScaffoldPage(
      header: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.loc.history,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            AutoSuggestBox.form(items: [])
          ],
        ),
      ),
      content: orderList.when(data: (data) {
        return ListView.builder(
          padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 12.0),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 160,
              child: Padding(
                padding: EdgeInsets.all(Platform.isWindows ? 12.0 : 6.0),
                child: CustomInfoleWidget(
                  colorIndex: data[index].colorIndex,
                  widgetType: WidgetType.order,
                  objectName: data[index].clientName,
                  date: ref.watch(
                    timeFormaterProvider(
                      data[index].confirmTime,
                    ),
                  ),
                  total: data[index].totalPrice.toString(),
                  onPressed: () {
                    Navigator.of(context).push(FluentPageRoute(
                      builder: (context) => OrderInfoPage(order: data[index]),
                    ));
                  },
                ),
              ),
            );
          },
        );
      }, error: (error, stackTrace) {
        return Text(error.toString());
      }, loading: () {
        return const Center(child: ProgressBar());
      }),
    );
  }
}
