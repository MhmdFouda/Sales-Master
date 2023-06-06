import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/date_time_formater.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:fouda_pharma/screens/order_info_page.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderList = ref.watch(asyncOrderProviderProvider);
    return ScaffoldPage(
      header: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
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
      ),
      content: orderList.when(data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 6,
              ),
              child: ListTile(
                onPressed: () {
                  Navigator.of(context).push(FluentPageRoute(
                    builder: (context) => OrderInfoPage(order: data[index]),
                  ));
                },
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: FluentTheme.of(context).borderInputColor,
                      width: 1.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        ref.watch(
                          dateFormaterProvider(data[index].confirmTime),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(ref.watch(
                        timeFormaterProvider(data[index].confirmTime),
                      ))
                    ],
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(data[index].clientName),
                ),
                trailing: Text(
                  data[index].totalPrice.toString(),
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
