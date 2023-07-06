import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/date_time_formater.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:fouda_pharma/resources/extension.dart';
import 'package:fouda_pharma/screens/custom_container.dart';
import 'package:fouda_pharma/screens/order_info_page.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldPage(
      resizeToAvoidBottomInset: false,
      header: ReusableContainer(
        child: Padding(
          padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 12.0),
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
                  ReusableContainer(
                    color: FluentTheme.of(context).accentColor,
                    hight: 40,
                    child: FittedBox(
                      child: Text(
                        ref
                            .watch(asyncOrderProviderProvider.notifier)
                            .getTotalPrice()
                            .formatAsCurrency(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              AutoSuggestBox.form(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: FluentTheme.of(context).accentColor,
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  items: const [])
            ],
          ),
        ),
      ),
      content: const ReusableContainer(
          child: OrdersList(
        isAll: true,
      )),
      bottomBar: const SizedBox(
        height: 10,
      ),
    );
  }
}

class OrdersList extends ConsumerWidget {
  final bool isAll;
  final String? clientName;
  const OrdersList({
    super.key,
    required this.isAll,
    this.clientName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderList = isAll
        ? ref.watch(asyncOrderProviderProvider)
        : ref.watch(asyncFilterdOrderProvider(clientName!));
    return orderList.when(data: (orders) {
      return material.RefreshIndicator(
        onRefresh: () => ref.refresh(asyncOrderProviderProvider.future),
        child: ListView.separated(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return ListTile(
              onPressed: () {
                Navigator.of(context).push(
                  FluentPageRoute(
                    builder: (context) => OrderInfoPage(
                      noId: false,
                      orderId: orders[index].id!,
                    ),
                  ),
                );
              },
              trailing: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text("${orders[index].totalPrice} EGP"),
              ),
              title: Text(
                orders[index].clientName,
                style: const TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                ref.watch(
                  dateFormaterProvider(
                    orders[index].confirmTime,
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      );
    }, error: (error, stackTrace) {
      return Text(error.toString());
    }, loading: () {
      return const Center(child: ProgressBar());
    });
  }
}

final totalPayMentProvider = StateProvider<double>((ref) {
  return 0.0;
});
